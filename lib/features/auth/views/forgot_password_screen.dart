import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/themes/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../view_models/forgot_password_form_view_model.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(forgotPasswordFormViewModelProvider.notifier).sendResetEmail();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(forgotPasswordFormViewModelProvider);
    final formNotifier = ref.watch(forgotPasswordFormViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    
                    // Logo and title
                    Icon(
                      Icons.lock_reset,
                      size: 64,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),
                    Text(
                      'Esqueci minha senha',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacingSmall),
                    
                    if (!formState.emailSent) ...[
                      Text(
                        'Digite seu e-mail para receber as instruções de redefinição de senha',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.neutralGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppTheme.spacingXLarge),
                      
                      AppTextField(
                        labelText: 'E-mail',
                        value: formState.email,
                        onChanged: formNotifier.updateEmail,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        errorText: formState.emailError,
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
                      
                      AppButton(
                        text: 'Enviar instruções',
                        onPressed: formState.isLoading ? null : _sendResetEmail,
                        isLoading: formState.isLoading,
                      ),
                    ] else ...[
                      // Success message
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.successColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppTheme.successColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: AppTheme.successColor,
                              size: 48,
                            ),
                            const SizedBox(height: AppTheme.spacingMedium),
                            Text(
                              'E-mail enviado!',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppTheme.successColor,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppTheme.spacingSmall),
                            Text(
                              'Verifique sua caixa de entrada e siga as instruções para redefinir sua senha.',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.neutralGray,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingLarge),
                      
                      AppButton(
                        text: 'Tentar novamente',
                        onPressed: formNotifier.reset,
                      ),
                    ],
                    
                    const SizedBox(height: AppTheme.spacingMedium),
                    
                    // Back to login
                    TextButton(
                      onPressed: () => context.go('/login'),
                      child: const Text('Voltar ao login'),
                    ),
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