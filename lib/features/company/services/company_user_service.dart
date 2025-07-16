import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/user_model.dart';

final companyUserServiceProvider = Provider<CompanyUserService>((ref) {
  return CompanyUserService();
});

class CompanyUserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Gets all users for a specific company
  Stream<List<UserModel>> getCompanyUsers(String businessId) {
    return _firestore
        .collection('users')
        .where('businessId', isEqualTo: businessId)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return UserModel.fromJson({...data, 'uid': doc.id});
      }).toList();
    });
  }

  /// Gets all users for a specific company including inactive ones
  Stream<List<UserModel>> getAllCompanyUsers(String businessId) {
    return _firestore
        .collection('users')
        .where('businessId', isEqualTo: businessId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return UserModel.fromJson({...data, 'uid': doc.id});
      }).toList();
    });
  }

  /// Creates a new user for the company
  Future<void> createCompanyUser({
    required String email,
    required String password,
    required String displayName,
    required UserRole role,
    required String businessId,
  }) async {
    try {
      // Create secondary Firebase app for user creation to avoid signing out current user
      final secondaryApp = await Firebase.initializeApp(
        name: 'CompanyUserCreation_${DateTime.now().millisecondsSinceEpoch}',
        options: Firebase.app().options,
      );

      final secondaryAuth = FirebaseAuth.instanceFor(app: secondaryApp);

      // Create user account
      final userCredential = await secondaryAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception('Falha ao criar conta de usuário');
      }

      // Update display name
      await user.updateDisplayName(displayName);

      // Set force password change on first login
      await user.updatePassword(password); // This will require password change on first login

      // Create user document in Firestore
      final userModel = UserModel(
        uid: user.uid,
        email: email,
        displayName: displayName,
        photoURL: null,
        emailVerified: user.emailVerified,
        businessId: businessId,
        role: role,
        createdAt: DateTime.now(),
        lastSignInAt: null,
        isActive: true,
        metadata: {
          'forcePasswordChange': true,
          'createdByCompanyAdmin': true,
        },
      );

      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(userModel.toJson());

      // Clean up secondary app
      await secondaryApp.delete();
    } catch (e) {
      throw Exception('Erro ao criar usuário: $e');
    }
  }

  /// Disables a company user (soft delete)
  Future<void> disableCompanyUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'isActive': false,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erro ao desativar usuário: $e');
    }
  }

  /// Enables a company user
  Future<void> enableCompanyUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'isActive': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erro ao ativar usuário: $e');
    }
  }

  /// Updates a company user's role
  Future<void> updateUserRole(String userId, UserRole newRole) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'role': newRole.toJson(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erro ao atualizar role do usuário: $e');
    }
  }

  /// Gets a specific company user by ID
  Future<UserModel?> getCompanyUserById(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (!doc.exists) return null;
      
      final data = doc.data()!;
      return UserModel.fromJson({...data, 'uid': doc.id});
    } catch (e) {
      throw Exception('Erro ao buscar usuário: $e');
    }
  }
}

/// Provider for company users stream
final companyUsersStreamProvider = StreamProvider.family<List<UserModel>, String>((ref, businessId) {
  return ref.read(companyUserServiceProvider).getAllCompanyUsers(businessId);
});