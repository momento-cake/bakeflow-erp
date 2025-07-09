import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  /// Get all users in the system
  Stream<List<UserModel>> getAllUsers() {
    return _firestore
        .collection('users')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        try {
          return UserModel.fromJson({
            'uid': doc.id,
            ...doc.data(),
          });
        } catch (e) {
          // If parsing fails, create a minimal user model
          return UserModel(
            uid: doc.id,
            email: doc.data()['email'] ?? '',
            displayName: doc.data()['displayName'],
            emailVerified: doc.data()['emailVerified'] ?? false,
            role: const UserRole.employee(),
            createdAt: DateTime.now(),
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
      // Create user in Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception('Failed to create user in Firebase Auth');
      }

      // Update the user's display name
      await user.updateDisplayName(displayName);

      // Create user document in Firestore
      final userModel = UserModel(
        uid: user.uid,
        email: email,
        displayName: displayName,
        emailVerified: user.emailVerified,
        role: role,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(userModel.toJson());

      return userModel;
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
}