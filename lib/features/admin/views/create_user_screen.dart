import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/themes/app_theme.dart';
import '../../../core/models/user_model.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/shared_header.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/utils/auth_validators.dart';
import '../services/admin_user_service.dart';

class CreateUserScreen extends ConsumerStatefulWidget {
  const CreateUserScreen({super.key});

  @override
  ConsumerState<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends ConsumerState<CreateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  UserRole _selectedRole = const UserRole.viewer();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _displayNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);

    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final firestoreUser = ref.watch(firestoreUserProvider(currentUser.uid));

    return firestoreUser.when(
      data: (user) => _buildScreen(context, user ?? currentUser),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => _buildScreen(context, currentUser),
    );
  }

  Widget _buildScreen(BuildContext context, UserModel currentUser) {
    if (!currentUser.role.isAdmin) {
      return _buildAccessDenied(context);
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          ScreenHeader(
            user: currentUser,
            title: 'Criar Usuário',
            subtitle: 'Adicione um novo usuário ao sistema',
            onProfileTap: () => _showComingSoon(context, 'Menu do usuário'),
            onNotificationTap: () => _showComingSoon(context, 'Notificações'),
            showBackButton: true,
            fallbackRoute: '/admin/users',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Informações Básicas',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 20),
                            AppTextField(
                              controller: _displayNameController,
                              labelText: 'Nome Completo',
                              hintText: 'Digite o nome completo do usuário',
                              prefixIcon: const Icon(Icons.person_outline),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Nome é obrigatório';
                                }
                                if (value.trim().length < 2) {
                                  return 'Nome deve ter pelo menos 2 caracteres';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            AppTextField(
                              controller: _emailController,
                              labelText: 'Email',
                              hintText: 'Digite o email do usuário',
                              prefixIcon: const Icon(Icons.email_outlined),
                              keyboardType: TextInputType.emailAddress,
                              validator: AuthValidators.validateEmail,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Perfil de Acesso',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            DropdownButtonFormField<UserRole>(
                              value: _selectedRole,
                              decoration: InputDecoration(
                                labelText: 'Tipo de Usuário',
                                prefixIcon: const Icon(Icons.security),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                                  borderSide: const BorderSide(color: AppTheme.neutralGray),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              isExpanded: true,
                              items: [
                                DropdownMenuItem(
                                  value: const UserRole.viewer(),
                                  child: _buildRoleItem(const UserRole.viewer(),
                                      'Apenas visualização de relatórios do sistema'),
                                ),
                                DropdownMenuItem(
                                  value: const UserRole.admin(),
                                  child: _buildRoleItem(
                                      const UserRole.admin(), 'Controle total do sistema'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedRole = value;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Senha de Acesso',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            AppTextField(
                              controller: _passwordController,
                              labelText: 'Senha',
                              hintText: 'Digite uma senha segura',
                              prefixIcon: const Icon(Icons.lock_outline),
                              obscureText: _obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _obscurePassword ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              validator: AuthValidators.validatePassword,
                            ),
                            const SizedBox(height: 16),
                            AppTextField(
                              controller: _confirmPasswordController,
                              labelText: 'Confirmar Senha',
                              hintText: 'Digite a senha novamente',
                              prefixIcon: const Icon(Icons.lock_outline),
                              obscureText: _obscureConfirmPassword,
                              onFieldSubmitted: (_) => _createUser(),
                              suffixIcon: IconButton(
                                icon: Icon(_obscureConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword = !_obscureConfirmPassword;
                                  });
                                },
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Confirmação de senha é obrigatória';
                                }
                                if (value != _passwordController.text) {
                                  return 'As senhas não coincidem';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _createUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Criar Usuário',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleItem(UserRole role, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          role.displayName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.neutralGray,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildAccessDenied(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acesso Negado'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.block,
              size: 64,
              color: AppTheme.errorColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Você não tem permissão para acessar esta área',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Voltar ao Dashboard'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ref.read(adminUserServiceProvider).createUser(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            displayName: _displayNameController.text.trim(),
            role: _selectedRole,
          );

      if (mounted) {
        // Store success message before navigation
        final successMessage = 'Usuário "${_displayNameController.text.trim()}" criado com sucesso';

        // Show success snackbar first
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(successMessage),
            backgroundColor: AppTheme.successColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 3),
          ),
        );

        // Invalidate users list to refresh data
        ref.invalidate(allUsersProvider);

        // Navigate back to admin users screen using go_router
        context.go('/admin/users');
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao criar usuário: $error'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showComingSoon(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Em Desenvolvimento'),
        content: Text('$feature estará disponível em breve.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
