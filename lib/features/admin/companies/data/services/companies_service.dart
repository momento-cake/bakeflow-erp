import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../../../../core/models/business_model.dart';
import '../../../../../core/models/company_user_model.dart';

class CompaniesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection references
  CollectionReference get _businessesRef => _firestore.collection('businesses');

  // Helper method to convert Firestore Timestamps to DateTime strings
  Map<String, dynamic> _convertTimestampsToStrings(Map<String, dynamic> data) {
    final converted = Map<String, dynamic>.from(data);
    
    for (final entry in converted.entries.toList()) {
      if (entry.value is Timestamp) {
        converted[entry.key] = (entry.value as Timestamp).toDate().toIso8601String();
      } else if (entry.value is Map<String, dynamic>) {
        converted[entry.key] = _convertTimestampsToStrings(entry.value);
      }
    }
    
    return converted;
  }

  // Companies CRUD operations
  
  /// Get all businesses (platform admin only)
  Stream<List<Business>> getAllBusinesses() {
    return _businessesRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) {
              final data = _convertTimestampsToStrings(doc.data()! as Map<String, dynamic>);
              return Business.fromJson({
                'id': doc.id,
                ...data,
              });
            })
            .toList());
  }

  /// Get business by ID
  Future<Business?> getBusinessById(String businessId) async {
    try {
      final doc = await _businessesRef.doc(businessId).get();
      if (doc.exists) {
        final data = _convertTimestampsToStrings(doc.data() as Map<String, dynamic>);
        return Business.fromJson({
          'id': doc.id,
          ...data,
        });
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get business: $e');
    }
  }

  /// Create new business
  Future<Business> createBusiness(Business business) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      final businessData = business
          .copyWith(
            id: '', // Will be set by Firestore
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            createdBy: currentUser.uid,
          )
          .toJson();

      // Remove the empty id before sending to Firestore
      businessData.remove('id');
      
      // Convert enums to strings for Firestore
      businessData['type'] = business.type.name;
      businessData['status'] = business.status.name;

      final docRef = await _businessesRef.add(businessData);
      
      return business.copyWith(
        id: docRef.id,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        createdBy: currentUser.uid,
      );
    } catch (e) {
      throw Exception('Failed to create business: $e');
    }
  }

  /// Update business
  Future<Business> updateBusiness(Business business) async {
    try {
      final updatedBusiness = business.copyWith(updatedAt: DateTime.now());
      final businessData = updatedBusiness.toJson();
      businessData.remove('id'); // Remove id from the data
      
      // Convert enums to strings for Firestore
      businessData['type'] = business.type.name;
      businessData['status'] = business.status.name;

      await _businessesRef.doc(business.id).update(businessData);
      
      return updatedBusiness;
    } catch (e) {
      throw Exception('Failed to update business: $e');
    }
  }

  /// Delete business and all its data
  Future<void> deleteBusiness(String businessId) async {
    try {
      final batch = _firestore.batch();

      // Delete all company users in this business
      final usersSnapshot = await _businessesRef
          .doc(businessId)
          .collection('users')
          .get();

      for (final userDoc in usersSnapshot.docs) {
        batch.delete(userDoc.reference);
      }

      // Delete all other business data (products, recipes, etc.)
      final collections = [
        'products',
        'recipes', 
        'ingredients',
        'suppliers',
        'purchases',
        'reports'
      ];

      for (final collection in collections) {
        final snapshot = await _businessesRef
            .doc(businessId)
            .collection(collection)
            .get();
        
        for (final doc in snapshot.docs) {
          batch.delete(doc.reference);
        }
      }

      // Finally delete the business document
      batch.delete(_businessesRef.doc(businessId));

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to delete business: $e');
    }
  }

  // Company Users CRUD operations

  /// Get all users for a specific business
  Stream<List<CompanyUser>> getCompanyUsers(String businessId) {
    return _businessesRef
        .doc(businessId)
        .collection('users')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) {
              final rawData = doc.data()! as Map<String, dynamic>;
              final data = _convertTimestampsToStrings(rawData);
              // Ensure isActive field exists with default value
              return CompanyUser.fromJson({
                'id': doc.id,
                'isActive': data['isActive'] ?? true, // Default to active if not set
                ...data,
              });
            })
            .toList());
  }

  /// Get company user by ID
  Future<CompanyUser?> getCompanyUserById(String businessId, String userId) async {
    try {
      final doc = await _businessesRef
          .doc(businessId)
          .collection('users')
          .doc(userId)
          .get();
      
      if (doc.exists) {
        final rawData = doc.data() as Map<String, dynamic>;
        final data = _convertTimestampsToStrings(rawData);
        // Ensure isActive field exists with default value
        return CompanyUser.fromJson({
          'id': doc.id,
          'isActive': data['isActive'] ?? true, // Default to active if not set
          ...data,
        });
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get company user: $e');
    }
  }

  /// Create company user (requires Firebase Auth account creation)
  Future<CompanyUser> createCompanyUser({
    required String businessId,
    required CompanyUser user,
    required String password,
  }) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      final currentUserEmail = currentUser.email;
      final currentUserId = currentUser.uid;

      // Create a temporary Firebase App instance for user creation
      // This prevents the main app session from being affected
      final secondaryApp = await Firebase.initializeApp(
        name: 'tempCompanyUserCreation${DateTime.now().millisecondsSinceEpoch}',
        options: Firebase.app().options,
      );

      try {
        final secondaryAuth = FirebaseAuth.instanceFor(app: secondaryApp);

        // Create user in the secondary Firebase Auth instance
        final userCredential = await secondaryAuth.createUserWithEmailAndPassword(
          email: user.email,
          password: password,
        );

        final firebaseUser = userCredential.user;
        if (firebaseUser == null) {
          throw Exception('Failed to create user in Firebase Auth');
        }

        // Update display name
        await firebaseUser.updateDisplayName(user.name);

        // Sign out from the secondary auth instance
        await secondaryAuth.signOut();

        // Create user document in company's users subcollection
        final userModel = user.copyWith(
          id: firebaseUser.uid,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          createdBy: currentUserId,
          metadata: {
            'requiresPasswordChange': true,
            'createdByAdmin': true,
            'createdByAdminEmail': currentUserEmail,
            'createdByAdminId': currentUserId,
          },
        );

        // Manually handle the role serialization to avoid freezed issues
        final userData = userModel.toJson();
        userData['role'] = userModel.role.toJson(); // Ensure proper role serialization
        userData.remove('id'); // Remove id from the data

        await _businessesRef
            .doc(businessId)
            .collection('users')
            .doc(firebaseUser.uid)
            .set(userData);

        // Add user to business authorized users list
        await _businessesRef.doc(businessId).update({
          'authorizedUsers': FieldValue.arrayUnion([firebaseUser.uid]),
        });

        return user.copyWith(
          id: firebaseUser.uid,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          createdBy: currentUserId,
          metadata: {
            'requiresPasswordChange': true,
            'createdByAdmin': true,
            'createdByAdminEmail': currentUserEmail,
            'createdByAdminId': currentUserId,
          },
        );
      } finally {
        // Clean up the temporary Firebase app
        await secondaryApp.delete();
      }
    } catch (e) {
      throw Exception('Failed to create company user: $e');
    }
  }

  /// Update company user
  Future<CompanyUser> updateCompanyUser(String businessId, CompanyUser user) async {
    try {
      final updatedUser = user.copyWith(updatedAt: DateTime.now());
      final userData = updatedUser.toJson();
      userData.remove('id'); // Remove id from the data

      await _businessesRef
          .doc(businessId)
          .collection('users')
          .doc(user.id)
          .update(userData);

      // Update display name in Firebase Auth if name changed
      final firebaseUser = _auth.currentUser;
      if (firebaseUser?.uid == user.id && firebaseUser?.displayName != user.name) {
        await firebaseUser?.updateDisplayName(user.name);
      }

      return updatedUser;
    } catch (e) {
      throw Exception('Failed to update company user: $e');
    }
  }

  /// Reset company user password
  Future<void> resetCompanyUserPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Failed to send password reset email: $e');
    }
  }

  /// Delete company user (soft delete - marks as inactive)
  Future<void> deleteCompanyUser(String businessId, String userId) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      // Get user data before soft deleting
      final userDoc = await _businessesRef
          .doc(businessId)
          .collection('users')
          .doc(userId)
          .get();
      
      if (!userDoc.exists) {
        throw Exception('Usuário não encontrado');
      }
      
      final userData = userDoc.data()!;
      
      // Check if user is already inactive
      final isCurrentlyActive = userData['isActive'] as bool? ?? true;
      if (!isCurrentlyActive) {
        throw Exception('Usuário já está desativado');
      }

      // Soft delete: Mark user as inactive instead of deleting
      await _businessesRef
          .doc(businessId)
          .collection('users')
          .doc(userId)
          .update({
        'isActive': false,
        'disabledAt': FieldValue.serverTimestamp(),
        'disabledBy': currentUser.uid,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Note: User remains in Firebase Auth but cannot login due to isActive check in AuthService
      // The login is blocked in the signInWithEmailAndPassword method
    } catch (e) {
      throw Exception('Falha ao desativar usuário: $e');
    }
  }

  /// Toggle user active status
  Future<void> toggleUserActiveStatus(String businessId, String userId, bool isActive) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }
      
      final updates = <String, dynamic>{
        'isActive': isActive,
        'updatedAt': FieldValue.serverTimestamp(),
      };
      
      if (isActive) {
        // Re-enabling user
        updates['enabledAt'] = FieldValue.serverTimestamp();
        updates['enabledBy'] = currentUser.uid;
      } else {
        // Disabling user
        updates['disabledAt'] = FieldValue.serverTimestamp();
        updates['disabledBy'] = currentUser.uid;
      }
      
      await _businessesRef
          .doc(businessId)
          .collection('users')
          .doc(userId)
          .update(updates);
    } catch (e) {
      throw Exception('Failed to toggle user status: $e');
    }
  }

  // Search and filtering methods

  /// Search businesses by name, CNPJ, or city
  Stream<List<Business>> searchBusinesses(String query) {
    if (query.isEmpty) {
      return getAllBusinesses();
    }

    return _businessesRef
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) {
              final data = _convertTimestampsToStrings(doc.data()! as Map<String, dynamic>);
              return Business.fromJson({
                'id': doc.id,
                ...data,
              });
            })
            .toList());
  }

  /// Get businesses by type
  Stream<List<Business>> getBusinessesByType(BusinessType type) {
    return _businessesRef
        .where('type.type', isEqualTo: type.name)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) {
              final data = _convertTimestampsToStrings(doc.data()! as Map<String, dynamic>);
              return Business.fromJson({
                'id': doc.id,
                ...data,
              });
            })
            .toList());
  }

  /// Get businesses by status
  Stream<List<Business>> getBusinessesByStatus(BusinessStatus status) {
    return _businessesRef
        .where('status.type', isEqualTo: status.name)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) {
              final data = _convertTimestampsToStrings(doc.data()! as Map<String, dynamic>);
              return Business.fromJson({
                'id': doc.id,
                ...data,
              });
            })
            .toList());
  }

  /// Search company users by name or email
  Stream<List<CompanyUser>> searchCompanyUsers(String businessId, String query) {
    if (query.isEmpty) {
      return getCompanyUsers(businessId);
    }

    return _businessesRef
        .doc(businessId)
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) {
              final rawData = doc.data()! as Map<String, dynamic>;
              final data = _convertTimestampsToStrings(rawData);
              return CompanyUser.fromJson({
                'id': doc.id,
                'isActive': data['isActive'] ?? true, // Default to active if not set
                ...data,
              });
            })
            .toList());
  }
}