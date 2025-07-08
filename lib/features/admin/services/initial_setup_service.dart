import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/user_model.dart';

final initialSetupServiceProvider = Provider<InitialSetupService>((ref) {
  return InitialSetupService(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
});

final hasAdminUsersProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(initialSetupServiceProvider);
  return service.hasAdminUsers();
});

class InitialSetupService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  InitialSetupService({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  Future<bool> hasAdminUsers() async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('role.type', isEqualTo: 'admin')
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      // If the query fails, we assume no admins exist
      return false;
    }
  }

  Future<UserCredential> createInitialAdmin({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      // Check if admins already exist
      final adminExists = await hasAdminUsers();
      if (adminExists) {
        throw Exception('Admin users already exist in the system');
      }

      // Create the user in Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception('Failed to create user');
      }

      // Update display name
      await user.updateDisplayName(displayName);

      // Create the user document in Firestore with admin role
      final userModel = UserModel(
        uid: user.uid,
        email: email,
        displayName: displayName,
        photoURL: null,
        emailVerified: false,
        businessId: null, // Admin users don't belong to a specific business
        role: const UserRole.admin(),
        createdAt: DateTime.now(),
        lastSignInAt: DateTime.now(),
        isActive: true,
        metadata: {
          'isInitialAdmin': true,
          'createdAt': DateTime.now().toIso8601String(),
        },
      );

      await _firestore.collection('users').doc(user.uid).set(userModel.toJson());

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(_getErrorMessage(e.code));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Este e-mail já está em uso';
      case 'weak-password':
        return 'A senha deve ter pelo menos 6 caracteres';
      case 'invalid-email':
        return 'E-mail inválido';
      default:
        return 'Erro ao criar conta de administrador';
    }
  }
}