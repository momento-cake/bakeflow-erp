import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/themes/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../view_models/register_form_view_model.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final success = await ref.read(registerFormViewModelProvider.notifier).register();

    if (success && mounted) {
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(registerFormViewModelProvider);
    final formNotifier = ref.watch(registerFormViewModelProvider.notifier);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isDesktop = screenWidth >= 768;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 32.0 : 24.0,
              vertical: 24.0,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 500 : double.infinity,
                minWidth: isDesktop ? 400 : double.infinity,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: isDesktop ? 60 : 40),

                    // Logo and title
                    Icon(
                      Icons.cake,
                      size: isDesktop ? 56 : 48,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),
                    Text(
                      'Criar conta',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacingSmall),
                    Text(
                      'Comece a usar o BakeFlow ERP hoje',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.neutralGray,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacingXLarge),

                    // Personal information section
                    Text(
                      'Informações pessoais',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),

                    AppTextField(
                      labelText: 'Nome completo',
                      value: formState.displayName,
                      onChanged: formNotifier.updateDisplayName,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      errorText: formState.displayNameError,
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),

                    AppTextField(
                      labelText: 'E-mail',
                      value: formState.email,
                      onChanged: formNotifier.updateEmail,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      errorText: formState.emailError,
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),

                    AppTextField(
                      labelText: 'Senha',
                      value: formState.password,
                      onChanged: formNotifier.updatePassword,
                      obscureText: formState.obscurePassword,
                      textInputAction: TextInputAction.next,
                      errorText: formState.passwordError,
                      suffixIcon: IconButton(
                        icon: Icon(
                          formState.obscurePassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: formNotifier.togglePasswordVisibility,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),

                    AppTextField(
                      labelText: 'Confirmar senha',
                      value: formState.confirmPassword,
                      onChanged: formNotifier.updateConfirmPassword,
                      obscureText: formState.obscureConfirmPassword,
                      textInputAction: TextInputAction.next,
                      errorText: formState.confirmPasswordError,
                      suffixIcon: IconButton(
                        icon: Icon(
                          formState.obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: formNotifier.toggleConfirmPasswordVisibility,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingLarge),

                    // Business information section
                    Text(
                      'Informações da empresa',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),

                    AppTextField(
                      labelText: 'Nome da empresa',
                      value: formState.businessName,
                      onChanged: formNotifier.updateBusinessName,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      errorText: formState.businessNameError,
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),

                    // CNPJ and Phone row for desktop
                    if (isDesktop) ...[
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              labelText: 'CNPJ (opcional)',
                              value: formState.cnpj,
                              onChanged: formNotifier.updateCNPJ,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              errorText: formState.cnpjError,
                              hintText: '00.000.000/0000-00',
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacingMedium),
                          Expanded(
                            child: AppTextField(
                              labelText: 'Telefone (opcional)',
                              value: formState.phone,
                              onChanged: formNotifier.updatePhone,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              errorText: formState.phoneError,
                              hintText: '(00) 00000-0000',
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      // Mobile layout - stacked fields
                      AppTextField(
                        labelText: 'CNPJ (opcional)',
                        value: formState.cnpj,
                        onChanged: formNotifier.updateCNPJ,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        errorText: formState.cnpjError,
                        hintText: '00.000.000/0000-00',
                      ),
                      const SizedBox(height: AppTheme.spacingMedium),

                      AppTextField(
                        labelText: 'Telefone (opcional)',
                        value: formState.phone,
                        onChanged: formNotifier.updatePhone,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        errorText: formState.phoneError,
                        hintText: '(00) 00000-0000',
                      ),
                    ],
                    const SizedBox(height: AppTheme.spacingMedium),

                    AppTextField(
                      labelText: 'Endereço (opcional)',
                      value: formState.address,
                      onChanged: formNotifier.updateAddress,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.done,
                      maxLines: 2,
                    ),
                    const SizedBox(height: AppTheme.spacingLarge),

                    // Terms and conditions
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: formState.acceptTerms,
                          onChanged: (_) => formNotifier.toggleAcceptTerms(),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => formNotifier.toggleAcceptTerms(),
                            child: Text(
                              'Eu aceito os termos de uso e política de privacidade',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),

                    // Error message
                    if (formState.generalError != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.errorColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppTheme.errorColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          formState.generalError!,
                          style: TextStyle(
                            color: AppTheme.errorColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    if (formState.generalError != null)
                      const SizedBox(height: AppTheme.spacingMedium),

                    // Register button
                    AppButton(
                      text: 'Criar conta',
                      onPressed: formState.isLoading ? null : _register,
                      isLoading: formState.isLoading,
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),

                    // Back to login
                    TextButton(
                      onPressed: () => context.go('/login'),
                      child: const Text('Já tem conta? Fazer login'),
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
