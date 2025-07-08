import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_state.dart';
import '../utils/auth_validators.dart';
import 'auth_view_model.dart';

final forgotPasswordFormViewModelProvider = StateNotifierProvider<ForgotPasswordFormViewModel, ForgotPasswordFormState>((ref) {
  return ForgotPasswordFormViewModel(
    authViewModel: ref.watch(authViewModelProvider.notifier),
  );
});

class ForgotPasswordFormViewModel extends StateNotifier<ForgotPasswordFormState> {
  final AuthViewModel _authViewModel;

  ForgotPasswordFormViewModel({required AuthViewModel authViewModel})
      : _authViewModel = authViewModel,
        super(const ForgotPasswordFormState());

  void updateEmail(String email) {
    state = state.copyWith(
      email: email,
      emailError: null,
      generalError: null,
    );
  }

  bool _validateForm() {
    final emailError = AuthValidators.validateEmail(state.email);

    state = state.copyWith(
      emailError: emailError,
    );

    return emailError == null;
  }

  Future<void> sendResetEmail() async {
    if (!_validateForm()) {
      return;
    }

    state = state.copyWith(isLoading: true, generalError: null);

    try {
      await _authViewModel.sendPasswordResetEmail(state.email.trim());
      state = state.copyWith(
        isLoading: false,
        emailSent: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        generalError: e.toString(),
      );
    }
  }

  void reset() {
    state = const ForgotPasswordFormState();
  }

  void clearError() {
    state = state.copyWith(generalError: null);
  }
}