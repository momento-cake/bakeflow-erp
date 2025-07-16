import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth_state.dart';
import '../utils/auth_validators.dart';
import 'auth_view_model.dart';

final loginFormViewModelProvider = StateNotifierProvider<LoginFormViewModel, LoginFormState>((ref) {
  return LoginFormViewModel(
    authViewModel: ref.watch(authViewModelProvider.notifier),
  );
});

class LoginFormViewModel extends StateNotifier<LoginFormState> {
  final AuthViewModel _authViewModel;

  LoginFormViewModel({required AuthViewModel authViewModel})
      : _authViewModel = authViewModel,
        super(const LoginFormState());

  void updateEmail(String email) {
    state = state.copyWith(
      email: email,
      emailError: null,
      generalError: null,
    );
  }

  void updatePassword(String password) {
    state = state.copyWith(
      password: password,
      passwordError: null,
      generalError: null,
    );
  }

  void togglePasswordVisibility() {
    state = state.copyWith(
      obscurePassword: !state.obscurePassword,
    );
  }

  void toggleRememberMe() {
    state = state.copyWith(
      rememberMe: !state.rememberMe,
    );
  }

  bool _validateForm() {
    final emailError = AuthValidators.validateEmail(state.email);
    final passwordError = AuthValidators.validatePassword(state.password);

    state = state.copyWith(
      emailError: emailError,
      passwordError: passwordError,
    );

    return emailError == null && passwordError == null;
  }

  Future<bool> signIn() async {
    if (!_validateForm()) {
      return false;
    }

    state = state.copyWith(isLoading: true, generalError: null);

    try {
      await _authViewModel.signInWithEmailAndPassword(
        email: state.email.trim(),
        password: state.password,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        generalError: e.toString(),
      );
      return false;
    }
  }

  void clearForm() {
    state = const LoginFormState();
  }

  void clearError() {
    state = state.copyWith(generalError: null);
  }
}
