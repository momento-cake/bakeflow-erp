import 'dart:developer' as developer;
import 'dart:html' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/user_model.dart';

final adminUserServiceProvider = Provider<AdminUserService>((ref) {
  return AdminUserService();
});

final allUsersProvider = StreamProvider<List<UserModel>>((ref) {
  return ref.read(adminUserServiceProvider).getAllUsers();
});

class AdminUserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Helper method to log to browser console
  void _log(String message) {
    // Log to browser console
    html.window.console.log('AdminUserService: $message');
    // Also log to developer console
    developer.log(message, name: 'AdminUserService');
  }

  /// Get all users in the system
  Stream<List<UserModel>> getAllUsers() {
    return _firestore
        .collection('users')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        try {
          final data = doc.data();
          // Ensure isActive field exists with default value
          final userData = {
            'uid': doc.id,
            'isActive': data['isActive'] ?? true, // Default to active if not set
            ...data,
          };
          return UserModel.fromJson(userData);
        } catch (e) {
          // If parsing fails, create a minimal user model
          return UserModel(
            uid: doc.id,
            email: doc.data()['email'] ?? '',
            displayName: doc.data()['displayName'],
            emailVerified: doc.data()['emailVerified'] ?? false,
            role: const UserRole.employee(),
            createdAt: DateTime.now(),
            isActive: doc.data()['isActive'] ?? true, // Default to active
          );
        }
      }).toList();
    });
  }

  /// Create a new user with admin privileges
  Future<UserModel> createUser({
    required String email,
    required String password,
    required String displayName,
    required UserRole role,
  }) async {
    try {
      // Store current admin user credentials to restore session
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('Admin user must be authenticated to create users');
      }

      final currentUserEmail = currentUser.email;
      final currentUserId = currentUser.uid;

      // Create a temporary Firebase App instance for user creation
      // This prevents the main app session from being affected
      final secondaryApp = await Firebase.initializeApp(
        name: 'tempUserCreation${DateTime.now().millisecondsSinceEpoch}',
        options: Firebase.app().options,
      );

      try {
        final secondaryAuth = FirebaseAuth.instanceFor(app: secondaryApp);

        // Create user in the secondary Firebase Auth instance
        final userCredential = await secondaryAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final user = userCredential.user;
        if (user == null) {
          throw Exception('Failed to create user in Firebase Auth');
        }

        // Update the user's display name
        await user.updateDisplayName(displayName);

        // Create user document in Firestore with proper timestamp
        final userModel = UserModel(
          uid: user.uid,
          email: email,
          displayName: displayName,
          emailVerified: user.emailVerified,
          role: role,
          createdAt: DateTime.now(),
          metadata: {
            'requiresPasswordChange': true,
            'createdByAdmin': true,
            'createdByAdminEmail': currentUserEmail,
            'createdByAdminId': currentUserId,
          },
        );

        // Sign out from the secondary auth instance
        await secondaryAuth.signOut();

        // Save to Firestore using the main app's Firestore instance
        // Manually handle the role serialization to avoid freezed issues
        final userJson = userModel.toJson();
        userJson['role'] = userModel.role.toJson(); // Ensure proper role serialization
        await _firestore.collection('users').doc(user.uid).set(userJson);

        // Verify the user was created in Firestore
        final createdDoc = await _firestore.collection('users').doc(user.uid).get();

        if (!createdDoc.exists) {
          throw Exception('Falha ao salvar usuário no Firestore');
        }

        return userModel;
      } finally {
        // Clean up the temporary Firebase app
        await secondaryApp.delete();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception('Este email já está em uso');
        case 'invalid-email':
          throw Exception('Email inválido');
        case 'weak-password':
          throw Exception('Senha muito fraca');
        default:
          throw Exception('Erro ao criar usuário: ${e.message}');
      }
    } catch (e) {
      throw Exception('Erro inesperado ao criar usuário: $e');
    }
  }

  /// Update user role
  Future<void> updateUserRole(String userId, UserRole newRole) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'role': newRole.toJson(),
        'lastSignInAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erro ao atualizar perfil do usuário: $e');
    }
  }

  /// Update user information
  Future<void> updateUser({
    required String userId,
    String? displayName,
    UserRole? role,
  }) async {
    try {
      final updates = <String, dynamic>{
        'lastSignInAt': FieldValue.serverTimestamp(),
      };

      if (displayName != null) {
        updates['displayName'] = displayName;
      }

      if (role != null) {
        updates['role'] = role.toJson();
      }

      await _firestore.collection('users').doc(userId).update(updates);
    } catch (e) {
      throw Exception('Erro ao atualizar usuário: $e');
    }
  }

  /// Deactivate user (mark as inactive, don't delete)
  Future<void> deactivateUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'isActive': false,
        'lastSignInAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erro ao desativar usuário: $e');
    }
  }

  /// Reactivate user
  Future<void> reactivateUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'isActive': true,
        'lastSignInAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erro ao reativar usuário: $e');
    }
  }

  /// Reset user password (send password reset email)
  Future<void> resetUserPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('Usuário não encontrado');
        case 'invalid-email':
          throw Exception('Email inválido');
        default:
          throw Exception('Erro ao enviar email de redefinição: ${e.message}');
      }
    } catch (e) {
      throw Exception('Erro inesperado ao redefinir senha: $e');
    }
  }

  /// Get user by ID
  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();

      if (!doc.exists) {
        return null;
      }

      return UserModel.fromJson({
        'uid': doc.id,
        ...doc.data()!,
      });
    } catch (e) {
      throw Exception('Erro ao buscar usuário: $e');
    }
  }

  /// Check if user has admin privileges
  Future<bool> isUserAdmin(String userId) async {
    try {
      final user = await getUserById(userId);
      return user?.role.isAdmin ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Count total users by role
  Future<Map<String, int>> getUserCountByRole() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      final counts = <String, int>{
        'admin': 0,
        'owner': 0,
        'manager': 0,
        'employee': 0,
        'viewer': 0,
      };

      for (final doc in snapshot.docs) {
        try {
          final user = UserModel.fromJson({
            'uid': doc.id,
            ...doc.data(),
          });
          final roleName = user.role.name;
          counts[roleName] = (counts[roleName] ?? 0) + 1;
        } catch (e) {
          // Skip invalid user documents
          continue;
        }
      }

      return counts;
    } catch (e) {
      throw Exception('Erro ao contar usuários: $e');
    }
  }

  /// Disable a user (soft deletion) in Firestore only
  Future<void> disableUser(String userId) async {
    try {
      // Store current admin user credentials
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('Admin user must be authenticated to disable users');
      }

      _log('Starting user disabling for userId: $userId');
      _log('Current admin user: ${currentUser.uid}');

      // Get user data before disabling for logging and validation
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) {
        throw Exception('Usuário não encontrado');
      }

      final userData = userDoc.data()!;
      final userEmail = userData['email'] as String?;
      
      _log('User data to disable: $userEmail - ${userData['role']}');

      // Check if user is trying to disable themselves
      if (userId == currentUser.uid) {
        throw Exception('Você não pode desativar sua própria conta');
      }

      // Check if target user is initial admin
      if (userData['metadata']?['isInitialAdmin'] == true) {
        throw Exception('Não é possível desativar o administrador inicial');
      }

      if (userEmail == null) {
        throw Exception('Email do usuário não encontrado');
      }

      // Check if user is already disabled
      final isCurrentlyActive = userData['isActive'] ?? true; // Default to active if not set
      if (!isCurrentlyActive) {
        throw Exception('Usuário já está desativado');
      }

      _log('Attempting to update Firestore document (soft delete)...');
      
      // Soft delete: Update the user document to mark as inactive
      await _firestore.collection('users').doc(userId).update({
        'isActive': false,
        'disabledAt': FieldValue.serverTimestamp(),
        'disabledBy': currentUser.uid,
        'lastSignInAt': FieldValue.serverTimestamp(),
      });
      
      _log('Firestore document updated successfully (user disabled)');
      _log('User disabling completed successfully');

    } on FirebaseException catch (e) {
      _log('Firebase error during disabling: ${e.code} - ${e.message}');
      switch (e.code) {
        case 'permission-denied':
          throw Exception('Permissão negada para desativar este usuário');
        case 'not-found':
          throw Exception('Usuário não encontrado');
        default:
          throw Exception('Erro do Firebase: ${e.message}');
      }
    } catch (e) {
      _log('General error during disabling: $e');
      throw Exception('Erro ao desativar usuário: $e');
    }
  }

  /// Enable a previously disabled user in Firestore only
  Future<void> enableUser(String userId) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('Admin user must be authenticated to enable users');
      }

      _log('Starting user enabling for userId: $userId');

      // Get user data before enabling for validation
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) {
        throw Exception('Usuário não encontrado');
      }

      final userData = userDoc.data()!;
      final userEmail = userData['email'] as String?;
      
      _log('User data to enable: $userEmail - ${userData['role']}');

      // Check if user is already active
      final isCurrentlyActive = userData['isActive'] ?? true; // Default to active if not set
      if (isCurrentlyActive) {
        throw Exception('Usuário já está ativo');
      }

      _log('Attempting to update Firestore document (enable user)...');
      
      // Enable: Update the user document to mark as active
      await _firestore.collection('users').doc(userId).update({
        'isActive': true,
        'enabledAt': FieldValue.serverTimestamp(),
        'enabledBy': currentUser.uid,
        'lastSignInAt': FieldValue.serverTimestamp(),
      });
      
      _log('Firestore document updated successfully (user enabled)');
      _log('User enabling completed successfully');

    } on FirebaseException catch (e) {
      _log('Firebase error during enabling: ${e.code} - ${e.message}');
      switch (e.code) {
        case 'permission-denied':
          throw Exception('Permissão negada para ativar este usuário');
        case 'not-found':
          throw Exception('Usuário não encontrado');
        default:
          throw Exception('Erro do Firebase: ${e.message}');
      }
    } catch (e) {
      _log('General error during enabling: $e');
      throw Exception('Erro ao ativar usuário: $e');
    }
  }
}
