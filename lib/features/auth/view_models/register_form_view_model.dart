import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_state.dart';
import '../utils/auth_validators.dart';
import 'auth_view_model.dart';

final registerFormViewModelProvider = StateNotifierProvider<RegisterFormViewModel, RegisterFormState>((ref) {
  return RegisterFormViewModel(
    authViewModel: ref.watch(authViewModelProvider.notifier),
  );
});

class RegisterFormViewModel extends StateNotifier<RegisterFormState> {
  final AuthViewModel _authViewModel;

  RegisterFormViewModel({required AuthViewModel authViewModel})
      : _authViewModel = authViewModel,
        super(const RegisterFormState());

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
      confirmPasswordError: null,
      generalError: null,
    );
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(
      confirmPassword: confirmPassword,
      confirmPasswordError: null,
      generalError: null,
    );
  }

  void updateDisplayName(String displayName) {
    state = state.copyWith(
      displayName: displayName,
      displayNameError: null,
      generalError: null,
    );
  }

  void updateBusinessName(String businessName) {
    state = state.copyWith(
      businessName: businessName,
      businessNameError: null,
      generalError: null,
    );
  }

  void updateCNPJ(String cnpj) {
    state = state.copyWith(
      cnpj: cnpj,
      cnpjError: null,
      generalError: null,
    );
  }

  void updatePhone(String phone) {
    state = state.copyWith(
      phone: phone,
      phoneError: null,
      generalError: null,
    );
  }

  void updateAddress(String address) {
    state = state.copyWith(
      address: address,
      generalError: null,
    );
  }

  void togglePasswordVisibility() {
    state = state.copyWith(
      obscurePassword: !state.obscurePassword,
    );
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      obscureConfirmPassword: !state.obscureConfirmPassword,
    );
  }

  void toggleAcceptTerms() {
    state = state.copyWith(
      acceptTerms: !state.acceptTerms,
    );
  }

  bool _validateForm() {
    final emailError = AuthValidators.validateEmail(state.email);
    final passwordError = AuthValidators.validatePassword(state.password);
    final confirmPasswordError = AuthValidators.validateConfirmPassword(
      state.confirmPassword,
      state.password,
    );
    final displayNameError = AuthValidators.validateDisplayName(state.displayName);
    final businessNameError = AuthValidators.validateBusinessName(state.businessName);
    final cnpjError = AuthValidators.validateCNPJ(state.cnpj);
    final phoneError = AuthValidators.validatePhone(state.phone);

    state = state.copyWith(
      emailError: emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      displayNameError: displayNameError,
      businessNameError: businessNameError,
      cnpjError: cnpjError,
      phoneError: phoneError,
    );

    final isFormValid = emailError == null &&
        passwordError == null &&
        confirmPasswordError == null &&
        displayNameError == null &&
        businessNameError == null &&
        cnpjError == null &&
        phoneError == null;

    if (!state.acceptTerms) {
      state = state.copyWith(
        generalError: 'Você deve aceitar os termos de uso',
      );
      return false;
    }

    return isFormValid;
  }

  Future<bool> register() async {
    if (!_validateForm()) {
      return false;
    }

    state = state.copyWith(isLoading: true, generalError: null);

    try {
      await _authViewModel.createUserWithEmailAndPassword(
        email: state.email.trim(),
        password: state.password,
        displayName: state.displayName.trim(),
        businessName: state.businessName.trim(),
        cnpj: state.cnpj.trim().isEmpty ? null : state.cnpj.trim(),
        phone: state.phone.trim().isEmpty ? null : state.phone.trim(),
        address: state.address.trim().isEmpty ? null : state.address.trim(),
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
    state = const RegisterFormState();
  }

  void clearError() {
    state = state.copyWith(generalError: null);
  }
}