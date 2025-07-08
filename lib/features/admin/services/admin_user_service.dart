import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/user_model.dart';
import '../../../core/models/business_model.dart';

final adminUserServiceProvider = Provider<AdminUserService>((ref) {
  return AdminUserService(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
});

class AdminUserService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AdminUserService({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  }) : _firestore = firestore,
        _auth = auth;

  Future<void> createUser({
    required String email,
    required String displayName,
    required String businessId,
    required UserRole role,
    required String temporaryPassword,
    required bool requirePasswordReset,
  }) async {
    try {
      // Create user with temporary password
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: temporaryPassword,
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception('Failed to create user');
      }

      // Create user document in Firestore
      final userModel = UserModel(
        uid: user.uid,
        email: email,
        displayName: displayName,
        photoURL: null,
        emailVerified: false,
        businessId: businessId,
        role: role,
        createdAt: DateTime.now(),
        lastSignInAt: null,
        isActive: true,
        metadata: {
          'requirePasswordReset': requirePasswordReset,
          'temporaryPassword': requirePasswordReset,
          'createdBy': _auth.currentUser?.uid,
          'createdAt': DateTime.now().toIso8601String(),
        },
      );

      await _firestore.collection('users').doc(user.uid).set(userModel.toJson());

      // Add user to business authorized users
      await _firestore.collection('businesses').doc(businessId).update({
        'authorizedUsers': FieldValue.arrayUnion([user.uid]),
      });

      // Send password reset email if required
      if (requirePasswordReset) {
        await _auth.sendPasswordResetEmail(email: email);
      }

    } catch (e) {
      throw Exception('Failed to create user: ${e.toString()}');
    }
  }

  Future<void> createBusiness({
    required String name,
    required String cnpj,
    required String address,
    required String phone,
    required String email,
    required String ownerId,
  }) async {
    try {
      final businessId = _firestore.collection('businesses').doc().id;
      
      final business = Business(
        id: businessId,
        name: name,
        cnpj: cnpj,
        address: address,
        phone: phone,
        email: email,
        ownerId: ownerId,
        authorizedUsers: [ownerId],
        createdAt: DateTime.now(),
        isActive: true,
        settings: {
          'createdBy': _auth.currentUser?.uid,
          'createdAt': DateTime.now().toIso8601String(),
        },
      );

      await _firestore.collection('businesses').doc(businessId).set(business.toJson());

      // Update owner's business reference
      await _firestore.collection('users').doc(ownerId).update({
        'businessId': businessId,
      });

    } catch (e) {
      throw Exception('Failed to create business: ${e.toString()}');
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch users: ${e.toString()}');
    }
  }

  Future<List<Business>> getAllBusinesses() async {
    try {
      final snapshot = await _firestore.collection('businesses').get();
      return snapshot.docs
          .map((doc) => Business.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch businesses: ${e.toString()}');
    }
  }

  Future<void> resetUserPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Failed to send password reset email: ${e.toString()}');
    }
  }

  Future<void> deactivateUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'isActive': false,
        'deactivatedAt': DateTime.now().toIso8601String(),
        'deactivatedBy': _auth.currentUser?.uid,
      });
    } catch (e) {
      throw Exception('Failed to deactivate user: ${e.toString()}');
    }
  }

  Future<void> activateUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'isActive': true,
        'activatedAt': DateTime.now().toIso8601String(),
        'activatedBy': _auth.currentUser?.uid,
      });
    } catch (e) {
      throw Exception('Failed to activate user: ${e.toString()}');
    }
  }

  Future<void> updateUserRole(String userId, UserRole newRole) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'role': newRole.toJson(),
        'roleUpdatedAt': DateTime.now().toIso8601String(),
        'roleUpdatedBy': _auth.currentUser?.uid,
      });
    } catch (e) {
      throw Exception('Failed to update user role: ${e.toString()}');
    }
  }

  String generateTemporaryPassword() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    var result = '';
    for (var i = 0; i < 12; i++) {
      result += chars[(random + i) % chars.length];
    }
    return result;
  }
}