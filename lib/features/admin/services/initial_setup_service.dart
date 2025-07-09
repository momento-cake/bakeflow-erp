import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/user_model.dart';

final initialSetupServiceProvider = Provider<InitialSetupService>((ref) {
  return InitialSetupService();
});

final hasAdminUsersProvider = StreamProvider<bool>((ref) {
  return ref.read(initialSetupServiceProvider).hasAdminUsers();
});

class InitialSetupService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Check if there are any admin users in the system
  Stream<bool> hasAdminUsers() {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'admin')
        .limit(1)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty);
  }

  /// Setup the initial admin user
  Future<UserModel> setupInitialAdmin({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      // First check if any admin users already exist
      final adminExists = await _checkAdminExists();
      if (adminExists) {
        throw Exception('Sistema já foi configurado');
      }

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

      // Create admin user document in Firestore
      final adminUser = UserModel(
        uid: user.uid,
        email: email,
        displayName: displayName,
        emailVerified: user.emailVerified,
        role: const UserRole.admin(),
        createdAt: DateTime.now(),
        metadata: const {'isInitialAdmin': true},
      );

      await _firestore.collection('users').doc(user.uid).set(adminUser.toJson());

      // Create system configuration document
      await _createSystemConfig(user.uid);

      return adminUser;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception('Este email já está em uso');
        case 'invalid-email':
          throw Exception('Email inválido');
        case 'weak-password':
          throw Exception('Senha muito fraca');
        default:
          throw Exception('Erro na configuração: ${e.message}');
      }
    } catch (e) {
      throw Exception('Erro inesperado na configuração: $e');
    }
  }

  /// Check if any admin users exist
  Future<bool> _checkAdminExists() async {
    try {
      final snapshot =
          await _firestore.collection('users').where('role', isEqualTo: 'admin').limit(1).get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      // If there's an error checking, assume no admins exist
      return false;
    }
  }

  /// Create initial system configuration
  Future<void> _createSystemConfig(String adminUserId) async {
    try {
      final systemConfig = {
        'version': '1.0.0',
        'initialAdminId': adminUserId,
        'setupDate': FieldValue.serverTimestamp(),
        'features': {
          'userManagement': true,
          'businessManagement': false, // To be enabled later
          'inventoryManagement': false, // To be enabled later
          'reporting': false, // To be enabled later
        },
        'settings': {
          'allowUserRegistration': false,
          'requireEmailVerification': false,
          'sessionTimeoutMinutes': 480, // 8 hours
        },
      };

      await _firestore.collection('system').doc('config').set(systemConfig);
    } catch (e) {
      rethrow;
    }
  }

  /// Get system configuration
  Future<Map<String, dynamic>?> getSystemConfig() async {
    try {
      final doc = await _firestore.collection('system').doc('config').get();

      if (!doc.exists) {
        return null;
      }

      return doc.data();
    } catch (e) {
      throw Exception('Erro ao buscar configuração do sistema: $e');
    }
  }

  /// Update system configuration
  Future<void> updateSystemConfig(Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('system').doc('config').update({
        ...updates,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erro ao atualizar configuração: $e');
    }
  }

  /// Check if system is properly configured
  Future<bool> isSystemConfigured() async {
    try {
      // Check if admin users exist
      final adminExists = await _checkAdminExists();
      if (!adminExists) {
        return false;
      }

      // Check if system config exists
      final config = await getSystemConfig();
      return config != null;
    } catch (e) {
      return false;
    }
  }

  /// Reset system (dangerous operation - only for development)
  Future<void> resetSystem() async {
    try {
      // This is a dangerous operation and should only be used in development
      // In production, this should be heavily restricted or removed entirely

      // Delete all users (except the current one if authenticated)
      final currentUser = _auth.currentUser;
      final usersSnapshot = await _firestore.collection('users').get();

      for (final doc in usersSnapshot.docs) {
        if (currentUser == null || doc.id != currentUser.uid) {
          await doc.reference.delete();
        }
      }

      // Delete system config
      await _firestore.collection('system').doc('config').delete();
    } catch (e) {
      throw Exception('Erro ao resetar sistema: $e');
    }
  }
}
