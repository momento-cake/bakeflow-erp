import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/themes/app_theme.dart';
import '../../../../../core/models/business_model.dart';
import '../../../../../core/models/company_user_model.dart';
import '../../../../../core/models/user_model.dart';
import '../../../../../shared/utils/brazilian_validators.dart';
import '../../../../../shared/widgets/brazilian_form_fields.dart';
import '../../../../../shared/widgets/shared_header.dart';
import '../../../../auth/services/auth_service.dart';
import '../providers/companies_providers.dart';

class CreateCompanyUserScreen extends ConsumerStatefulWidget {
  final String companyId;

  const CreateCompanyUserScreen({
    super.key,
    required this.companyId,
  });

  @override
  ConsumerState<CreateCompanyUserScreen> createState() => _CreateCompanyUserScreenState();
}

class _CreateCompanyUserScreenState extends ConsumerState<CreateCompanyUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Form controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  UserRole _selectedRole = const UserRole.companyEmployee();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _scrollController.dispose();
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
    if (!currentUser.role.canManageCompanies) {
      return _buildAccessDenied(context);
    }

    final businessAsync = ref.watch(businessProvider(widget.companyId));

    return businessAsync.when(
      data: (business) {
        if (business == null) {
          return _buildNotFound(context);
        }

        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          body: Column(
            children: [
              ScreenHeader(
                user: currentUser,
                title: 'Adicionar Usuário',
                subtitle: 'Criar novo usuário para ${business.name}',
                onProfileTap: () => _showComingSoon(context, 'Menu do usuário'),
                onNotificationTap: () => _showComingSoon(context, 'Notificações'),
                showBackButton: true,
                fallbackRoute: '/admin/companies/${widget.companyId}',
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  child: _buildForm(context, business),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => _buildError(context, error.toString()),
    );
  }

  Widget _buildForm(BuildContext context, Business business) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informações do Usuário',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 24),

              // Name
              BrazilianFormFields.textField(
                controller: _nameController,
                labelText: 'Nome Completo *',
                hintText: 'Nome e sobrenome do usuário',
                prefixIcon: Icons.person,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  if (value.trim().length < 3) {
                    return 'Nome deve ter pelo menos 3 caracteres';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Email
              BrazilianFormFields.emailField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'E-mail é obrigatório';
                  }
                  if (!BrazilianValidators.isValidEmail(value)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Phone
              BrazilianFormFields.phoneField(
                controller: _phoneController,
              ),

              const SizedBox(height: 24),

              // Role Selection
              Text(
                'Função na Empresa',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<UserRole>(
                value: _selectedRole,
                decoration: const InputDecoration(
                  labelText: 'Função *',
                  hintText: 'Selecione a função do usuário',
                  prefixIcon: Icon(Icons.work),
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(
                    value: const UserRole.companyAdmin(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(const UserRole.companyAdmin().displayName),
                        Text(
                          'Acesso completo à empresa',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.neutralGray,
                              ),
                        ),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: const UserRole.companyManager(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(const UserRole.companyManager().displayName),
                        Text(
                          'Gerenciamento de operações',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.neutralGray,
                              ),
                        ),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: const UserRole.companyEmployee(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(const UserRole.companyEmployee().displayName),
                        Text(
                          'Acesso básico às funcionalidades',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.neutralGray,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
                onChanged: (role) {
                  if (role != null) {
                    setState(() {
                      _selectedRole = role;
                    });
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione uma função';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Password Configuration
              Text(
                'Configuração de Senha',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 16),

              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha *',
                  hintText: 'Mínimo 6 caracteres - será exigida alteração no primeiro login',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Senha é obrigatória';
                  }
                  if (value.length < 6) {
                    return 'Senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  if (!_isLoading) {
                    _createUser();
                  }
                },
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

              const SizedBox(height: 16),

              // Required fields note
              Text(
                '* Campos obrigatórios',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.neutralGray,
                      fontStyle: FontStyle.italic,
                    ),
              ),

              const SizedBox(height: 16),

              // Info Card
              Card(
                color: AppTheme.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppTheme.primaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Informações Importantes',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '• O usuário será obrigado a alterar a senha no primeiro login\n'
                        '• O acesso será limitado apenas a esta empresa\n'
                        '• As permissões podem ser alteradas posteriormente\n'
                        '• O usuário pode ser desativado a qualquer momento',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.neutralGray,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createUser() async {
    if (!_formKey.currentState!.validate()) {
      // Scroll to first error
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final password = _passwordController.text;

      final companyUser = CompanyUser(
        id: '', // Will be set by Firestore
        businessId: widget.companyId,
        email: _emailController.text.trim(),
        name: _nameController.text.trim(),
        phone: _phoneController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        role: _selectedRole,
        isActive: true,
        createdAt: DateTime.now(),
        createdBy: '', // Will be set by service
      );

      final result = await ref.read(companiesRepositoryProvider).createCompanyUser(
            businessId: widget.companyId,
            user: companyUser,
            password: password,
          );

      if (mounted) {
        // Store success message before navigation
        final successMessage = 'Usuário "${result.name}" criado com sucesso';

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
        ref.invalidate(companyUsersProvider(widget.companyId));

        // Navigate back to company details screen with users tab selected
        context.go('/admin/companies/${widget.companyId}?tab=users');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao criar usuário: $e'),
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

  Widget _buildNotFound(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empresa Não Encontrada'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: AppTheme.neutralGray,
            ),
            const SizedBox(height: 16),
            Text(
              'A empresa solicitada não foi encontrada',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go('/admin/companies'),
              child: const Text('Voltar para Empresas'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String error) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Erro'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppTheme.errorColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Erro ao carregar empresa',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go('/admin/companies'),
              child: const Text('Voltar para Empresas'),
            ),
          ],
        ),
      ),
    );
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
