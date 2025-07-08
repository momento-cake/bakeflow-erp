import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/themes/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../services/initial_setup_service.dart';
import '../../auth/utils/auth_validators.dart';

class InitialSetupScreen extends ConsumerStatefulWidget {
  const InitialSetupScreen({super.key});

  @override
  ConsumerState<InitialSetupScreen> createState() => _InitialSetupScreenState();
}

class _InitialSetupScreenState extends ConsumerState<InitialSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _displayName = '';
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _errorMessage;

  Future<void> _createAdmin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final setupService = ref.read(initialSetupServiceProvider);
      await setupService.createInitialAdmin(
        email: _email.trim(),
        password: _password,
        displayName: _displayName.trim(),
      );

      if (mounted) {
        // Admin created successfully, redirect to admin dashboard
        context.go('/admin');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    
                    // Logo and title
                    Icon(
                      Icons.admin_panel_settings,
                      size: isDesktop ? 72 : 64,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),
                    Text(
                      'Configuração Inicial',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacingSmall),
                    Text(
                      'Crie a primeira conta de administrador',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.neutralGray,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacingXLarge),

                    // Form fields
                    AppTextField(
                      labelText: 'Nome completo',
                      value: _displayName,
                      onChanged: (value) => _displayName = value,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      errorText: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nome é obrigatório';
                        }
                        if (value.length < 2) {
                          return 'Nome deve ter pelo menos 2 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),
                    
                    AppTextField(
                      labelText: 'E-mail',
                      value: _email,
                      onChanged: (value) => _email = value,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      errorText: null,
                      validator: AuthValidators.validateEmail,
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),
                    
                    AppTextField(
                      labelText: 'Senha',
                      value: _password,
                      onChanged: (value) => _password = value,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.next,
                      errorText: null,
                      validator: AuthValidators.validatePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),
                    
                    AppTextField(
                      labelText: 'Confirmar senha',
                      value: _confirmPassword,
                      onChanged: (value) => _confirmPassword = value,
                      obscureText: _obscureConfirmPassword,
                      textInputAction: TextInputAction.done,
                      errorText: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirmação de senha é obrigatória';
                        }
                        if (value != _password) {
                          return 'As senhas não coincidem';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingLarge),

                    // Info box
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppTheme.primaryColor.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppTheme.primaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Esta conta terá acesso total ao sistema e poderá criar outras contas de usuário.',
                              style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),

                    // Error message
                    if (_errorMessage != null)
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
                          _errorMessage!,
                          style: TextStyle(
                            color: AppTheme.errorColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    if (_errorMessage != null)
                      const SizedBox(height: AppTheme.spacingMedium),

                    // Create button
                    AppButton(
                      text: 'Criar Administrador',
                      onPressed: _isLoading ? null : _createAdmin,
                      isLoading: _isLoading,
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