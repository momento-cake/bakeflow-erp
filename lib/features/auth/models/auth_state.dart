import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/models/user_model.dart';
import '../../../core/models/business_model.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated({
    required UserModel user,
    Business? business,
  }) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}

@freezed
class LoginFormState with _$LoginFormState {
  const factory LoginFormState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isLoading,
    @Default(false) bool obscurePassword,
    @Default(false) bool rememberMe,
    String? emailError,
    String? passwordError,
    String? generalError,
  }) = _LoginFormState;
}

@freezed
class RegisterFormState with _$RegisterFormState {
  const factory RegisterFormState({
    @Default('') String email,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default('') String displayName,
    @Default('') String businessName,
    @Default('') String cnpj,
    @Default('') String phone,
    @Default('') String address,
    @Default(false) bool isLoading,
    @Default(false) bool obscurePassword,
    @Default(false) bool obscureConfirmPassword,
    @Default(false) bool acceptTerms,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    String? displayNameError,
    String? businessNameError,
    String? cnpjError,
    String? phoneError,
    String? generalError,
  }) = _RegisterFormState;
}

@freezed
class ForgotPasswordFormState with _$ForgotPasswordFormState {
  const factory ForgotPasswordFormState({
    @Default('') String email,
    @Default(false) bool isLoading,
    @Default(false) bool emailSent,
    String? emailError,
    String? generalError,
  }) = _ForgotPasswordFormState;
}