import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_state.dart';
import '../services/auth_service.dart';
import '../services/business_service.dart';
import '../../../core/models/user_model.dart';
import '../../../core/models/business_model.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(
    authService: ref.watch(authServiceProvider),
    businessService: ref.watch(businessServiceProvider),
  );
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthService _authService;
  final BusinessService _businessService;

  AuthViewModel({
    required AuthService authService,
    required BusinessService businessService,
  })  : _authService = authService,
        _businessService = businessService,
        super(const AuthState.initial()) {
    _init();
  }

  void _init() {
    _authService.authStateChanges.listen((user) async {
      if (user != null) {
        final userModel = UserModel.fromFirebaseUser(user);
        try {
          final business = await _businessService.getBusinessByUserId(user.uid);
          state = AuthState.authenticated(user: userModel, business: business);
        } catch (e) {
          state = AuthState.authenticated(user: userModel);
        }
      } else {
        state = const AuthState.unauthenticated();
      }
    });
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();
    try {
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // State will be updated by the auth stream listener
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
    required String businessName,
    String? cnpj,
    String? phone,
    String? address,
  }) async {
    state = const AuthState.loading();
    try {
      final userCredential = await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Update display name
        await _authService.updateDisplayName(displayName);

        // Create business profile
        final business = Business(
          id: _businessService.generateBusinessId(),
          name: businessName,
          cnpj: cnpj,
          address: address ?? '',
          city: '', // TODO: Add city field to registration form
          state: '', // TODO: Add state field to registration form
          zipCode: '', // TODO: Add zipCode field to registration form
          phone: phone ?? '',
          email: email,
          type: cnpj != null ? const BusinessType.formalCompany() : const BusinessType.soloEntrepreneur(),
          status: const BusinessStatus.active(),
          authorizedUsers: [userCredential.user!.uid],
          createdAt: DateTime.now(),
          createdBy: userCredential.user!.uid,
          settings: const {},
        );

        await _businessService.createBusiness(business);

        // Send email verification
        await _authService.sendEmailVerification();
      }
      // State will be updated by the auth stream listener
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signOut() async {
    state = const AuthState.loading();
    try {
      await _authService.signOut();
      // State will be updated by the auth stream listener
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email: email);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _authService.sendEmailVerification();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  void clearError() {
    state = const AuthState.unauthenticated();
  }
}