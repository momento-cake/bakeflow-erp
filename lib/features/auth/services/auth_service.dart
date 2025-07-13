import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/user_model.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

// Simple provider that just returns the Firebase user converted to UserModel
final currentUserProvider = Provider<UserModel?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (user) => user != null ? UserModel.fromFirebaseUser(user) : null,
    loading: () => null,
    error: (_, __) => null,
  );
});

// Provider for getting full user data from Firestore when needed
final firestoreUserProvider = FutureProvider.family<UserModel?, String>((ref, uid) async {
  try {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists) {
      final userData = doc.data()!;
      final userModel = UserModel.fromJson(userData);
      
      // Check if user account is disabled and sign them out if so
      if (!userModel.isActive) {
        final authService = ref.read(authServiceProvider);
        await authService.signOut();
        throw AuthException(
          code: 'user-disabled',
          message: 'Esta conta foi desativada. Entre em contato com o administrador.',
        );
      }
      
      return userModel;
    }
  } catch (e) {
    rethrow;
  }
  return null;
});

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Check if user account is disabled in Firestore
      if (credential.user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .get();
            
        if (userDoc.exists) {
          final userData = userDoc.data()!;
          final isActive = userData['isActive'] as bool? ?? true;
          
          if (!isActive) {
            // Sign out the user immediately
            await _auth.signOut();
            throw AuthException(
              code: 'user-disabled',
              message: 'Esta conta foi desativada. Entre em contato com o administrador.',
            );
          }
        }
      }
      
      return credential;
    } on FirebaseAuthException catch (e) {
      throw AuthException._fromFirebaseAuthException(e);
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException(
        code: 'unknown',
        message: 'Erro inesperado durante o login: $e',
      );
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw AuthException._fromFirebaseAuthException(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException._fromFirebaseAuthException(e);
    }
  }

  Future<void> sendEmailVerification() async {
    final user = currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<void> updateDisplayName(String displayName) async {
    final user = currentUser;
    if (user != null) {
      await user.updateDisplayName(displayName);
    }
  }
}

class AuthException implements Exception {
  final String message;
  final String code;

  AuthException({required this.message, required this.code});

  factory AuthException._fromFirebaseAuthException(FirebaseAuthException e) {
    return AuthException(
      message: _getErrorMessage(e.code),
      code: e.code,
    );
  }

  static String _getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Usuário não encontrado';
      case 'wrong-password':
        return 'Senha incorreta';
      case 'email-already-in-use':
        return 'Este e-mail já está em uso';
      case 'weak-password':
        return 'A senha é muito fraca';
      case 'invalid-email':
        return 'E-mail inválido';
      case 'user-disabled':
        return 'Esta conta foi desativada. Entre em contato com o administrador.';
      case 'too-many-requests':
        return 'Muitas tentativas. Tente novamente mais tarde';
      case 'operation-not-allowed':
        return 'Operação não permitida';
      case 'invalid-credential':
        return 'Credenciais inválidas';
      default:
        return 'Erro de autenticação';
    }
  }

  @override
  String toString() => message;
}
