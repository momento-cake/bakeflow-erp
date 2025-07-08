import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/themes/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../view_models/login_form_view_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(loginFormViewModelProvider.notifier).signIn();
    
    if (success && mounted) {
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(loginFormViewModelProvider);
    final formNotifier = ref.watch(loginFormViewModelProvider.notifier);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 768;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                    Icon(
                      Icons.cake,
                      size: isDesktop ? 72 : 64,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),
                    Text(
                      'BakeFlow ERP',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacingSmall),
                    Text(
                      'Gestão inteligente para confeitarias',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.neutralGray,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacingXLarge * 2),
                    
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
                      textInputAction: TextInputAction.done,
                      errorText: formState.passwordError,
                      suffixIcon: IconButton(
                        icon: Icon(
                          formState.obscurePassword 
                              ? Icons.visibility 
                              : Icons.visibility_off,
                        ),
                        onPressed: formNotifier.togglePasswordVisibility,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),
                    
                    // Remember me checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: formState.rememberMe,
                          onChanged: (_) => formNotifier.toggleRememberMe(),
                        ),
                        GestureDetector(
                          onTap: () => formNotifier.toggleRememberMe(),
                          child: const Text('Lembrar-me'),
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
                    
                    AppButton(
                      text: 'Entrar',
                      onPressed: formState.isLoading ? null : _signIn,
                      isLoading: formState.isLoading,
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),
                    
                    TextButton(
                      onPressed: () => context.go('/register'),
                      child: const Text('Não tem conta? Criar conta'),
                    ),
                    const SizedBox(height: AppTheme.spacingSmall),
                    
                    TextButton(
                      onPressed: () => context.go('/forgot-password'),
                      child: const Text('Esqueci minha senha'),
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