import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/themes/app_theme.dart';
import '../../../../../core/models/user_model.dart';
import '../../../../../core/models/business_model.dart';
import '../../../../../core/models/company_user_model.dart';
import '../../../../../shared/widgets/shared_header.dart';
import '../../../../../shared/widgets/brazilian_form_fields.dart';
import '../../../../../shared/utils/brazilian_validators.dart';
import '../../../../auth/services/auth_service.dart';
import '../providers/companies_providers.dart';

class CompanyUserDetailsScreen extends ConsumerStatefulWidget {
  final String companyId;
  final String userId;
  
  const CompanyUserDetailsScreen({
    super.key,
    required this.companyId,
    required this.userId,
  });

  @override
  ConsumerState<CompanyUserDetailsScreen> createState() => _CompanyUserDetailsScreenState();
}

class _CompanyUserDetailsScreenState extends ConsumerState<CompanyUserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  
  // Form controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  
  UserRole? _selectedRole;
  bool? _isActive;
  bool _isLoading = false;
  bool _isEditing = false;
  CompanyUser? _originalUser;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _populateForm(CompanyUser user) {
    _originalUser = user;
    _nameController.text = user.name;
    _emailController.text = user.email;
    _phoneController.text = user.phone ?? '';
    _selectedRole = user.role;
    _isActive = user.isActive;
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
    if (!currentUser.role.canViewCompanies) {
      return _buildAccessDenied(context);
    }

    final userAsync = ref.watch(companyUserProvider((businessId: widget.companyId, userId: widget.userId)));
    final businessAsync = ref.watch(businessProvider(widget.companyId));

    return userAsync.when(
      data: (companyUser) {
        if (companyUser == null) {
          return _buildNotFound(context);
        }

        // Populate form on first load
        if (_originalUser == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _populateForm(companyUser);
          });
        }

        return businessAsync.when(
          data: (business) => _buildContent(context, currentUser, companyUser, business),
          loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (error, _) => _buildError(context, error.toString()),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => _buildError(context, error.toString()),
    );
  }

  Widget _buildContent(BuildContext context, UserModel currentUser, CompanyUser companyUser, Business? business) {
    final canEdit = currentUser.role.canManageCompanies;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          ScreenHeader(
            user: currentUser,
            title: 'Detalhes do Usuário',
            subtitle: '${companyUser.name} - ${business?.name ?? 'Empresa'}',
            onProfileTap: () => _showComingSoon(context, 'Menu do usuário'),
            onNotificationTap: () => _showComingSoon(context, 'Notificações'),
            showBackButton: true,
            fallbackRoute: '/admin/companies/${widget.companyId}',
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              child: _buildForm(context, currentUser, companyUser, canEdit),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context, UserModel currentUser, CompanyUser companyUser, bool canEdit) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Informações do Usuário',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (canEdit) ...[
                    Row(
                      children: [
                        if (_isEditing) ...[
                          OutlinedButton(
                            onPressed: _cancelEdit,
                            child: const Text('Cancelar'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _saveChanges,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : const Text('Salvar'),
                          ),
                        ] else ...[
                          ElevatedButton.icon(
                            onPressed: () => setState(() => _isEditing = true),
                            icon: const Icon(Icons.edit),
                            label: const Text('Editar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton.icon(
                            onPressed: () => _showPasswordResetDialog(context),
                            icon: const Icon(Icons.lock_reset),
                            label: const Text('Reset Senha'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.warningColor,
                              side: BorderSide(color: AppTheme.warningColor),
                            ),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton.icon(
                            onPressed: () => _confirmDelete(context),
                            icon: const Icon(Icons.delete_outline),
                            label: const Text('Excluir'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.errorColor,
                              side: BorderSide(color: AppTheme.errorColor),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 24),

              // Name
              BrazilianFormFields.textField(
                controller: _nameController,
                labelText: 'Nome Completo *',
                hintText: 'Nome e sobrenome do usuário',
                prefixIcon: Icons.person,
                enabled: _isEditing,
                validator: _isEditing ? (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  if (value.trim().length < 3) {
                    return 'Nome deve ter pelo menos 3 caracteres';
                  }
                  return null;
                } : null,
              ),

              const SizedBox(height: 16),

              // Email
              BrazilianFormFields.emailField(
                controller: _emailController,
                enabled: _isEditing,
                validator: _isEditing ? (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'E-mail é obrigatório';
                  }
                  if (!BrazilianValidators.isValidEmail(value)) {
                    return 'E-mail inválido';
                  }
                  return null;
                } : null,
              ),

              const SizedBox(height: 16),

              // Phone
              BrazilianFormFields.phoneField(
                controller: _phoneController,
                enabled: _isEditing,
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
                value: _selectedRole ?? companyUser.role,
                decoration: const InputDecoration(
                  labelText: 'Função *',
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
                onChanged: _isEditing ? (role) {
                  if (role != null) {
                    setState(() {
                      _selectedRole = role;
                    });
                  }
                } : null,
              ),

              const SizedBox(height: 24),

              // Status Toggle
              if (canEdit && _isEditing) ...[
                Text(
                  'Status do Usuário',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                
                SwitchListTile(
                  value: _isActive ?? companyUser.isActive,
                  onChanged: (value) {
                    setState(() {
                      _isActive = value;
                    });
                  },
                  title: Text(_isActive ?? companyUser.isActive ? 'Usuário Ativo' : 'Usuário Inativo'),
                  subtitle: Text(
                    (_isActive ?? companyUser.isActive) 
                        ? 'O usuário pode acessar a empresa'
                        : 'O usuário não pode acessar a empresa',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.neutralGray,
                    ),
                  ),
                  activeColor: AppTheme.successColor,
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 24),
              ],

              // Metadata
              _buildMetadata(context, companyUser),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetadata(BuildContext context, CompanyUser user) {
    return Card(
      color: AppTheme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informações do Sistema',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppTheme.neutralGray,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _buildMetadataRow('ID:', user.id),
            _buildMetadataRow('Empresa:', user.businessId),
            _buildMetadataRow('Criado em:', _formatDate(user.createdAt)),
            if (user.lastLogin != null)
              _buildMetadataRow('Último acesso:', _formatDate(user.lastLogin!)),
            _buildMetadataRow('Criado por:', user.createdBy),
            _buildMetadataRow('Status:', user.isActive ? 'Ativo' : 'Inativo'),
            _buildMetadataRow('Função:', user.role.displayName),
          ],
        ),
      ),
    );
  }

  Widget _buildMetadataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: AppTheme.neutralGray,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: AppTheme.neutralGray),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _cancelEdit() {
    setState(() {
      _isEditing = false;
      if (_originalUser != null) {
        _populateForm(_originalUser!);
      }
    });
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) {
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
      final updatedUser = _originalUser!.copyWith(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        role: _selectedRole ?? _originalUser!.role,
        isActive: _isActive ?? _originalUser!.isActive,
      );

      await ref.read(companiesRepositoryProvider).updateCompanyUser(widget.companyId, updatedUser);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Usuário "${updatedUser.name}" atualizado com sucesso'),
            backgroundColor: AppTheme.successColor,
          ),
        );
        
        setState(() {
          _isEditing = false;
        });
        
        // Refresh the user data
        ref.invalidate(companyUserProvider((businessId: widget.companyId, userId: widget.userId)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao atualizar usuário: $e'),
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

  void _showPasswordResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset de Senha'),
        content: Text(
          'Tem certeza que deseja resetar a senha do usuário "${_originalUser?.name}"?\n\n'
          'Uma nova senha será gerada e enviada por e-mail.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _resetPassword();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.warningColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Reset Senha'),
          ),
        ],
      ),
    );
  }

  Future<void> _resetPassword() async {
    if (_originalUser == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await ref.read(companiesRepositoryProvider).resetCompanyUserPassword(_originalUser!.email);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Nova senha enviada para ${_originalUser!.email}'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao resetar senha: $e'),
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

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text(
          'Tem certeza que deseja excluir o usuário "${_originalUser?.name}"?\n\n'
          'Esta ação desativará o usuário, impedindo seu acesso à empresa.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteUser();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteUser() async {
    if (_originalUser == null) return;

    // Use a stable context reference
    final scaffoldContext = context;
    
    // Show loading dialog with timeout protection
    showDialog(
      context: scaffoldContext,
      barrierDismissible: false,
      builder: (dialogContext) => const AlertDialog(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Excluindo usuário...'),
          ],
        ),
      ),
    );

    try {
      // Perform soft delete with timeout
      await ref.read(companiesRepositoryProvider).deleteCompanyUser(widget.companyId, _originalUser!.id).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Operação expirou. Tente novamente.');
        },
      );
      
      // Close loading dialog safely
      if (scaffoldContext.mounted) {
        Navigator.of(scaffoldContext, rootNavigator: true).pop();
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Usuário "${_originalUser!.name}" excluído com sucesso'),
            backgroundColor: AppTheme.successColor,
            duration: const Duration(seconds: 3),
          ),
        );
        
        context.go('/admin/companies/${widget.companyId}');
      }
    } catch (e) {
      // Close loading dialog safely
      if (scaffoldContext.mounted) {
        Navigator.of(scaffoldContext, rootNavigator: true).pop();
      }
      
      if (mounted) {
        final errorMessage = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao excluir usuário: $errorMessage'),
            backgroundColor: AppTheme.errorColor,
            duration: const Duration(seconds: 5),
          ),
        );
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
        title: const Text('Usuário Não Encontrado'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_off,
              size: 64,
              color: AppTheme.neutralGray,
            ),
            const SizedBox(height: 16),
            Text(
              'O usuário solicitado não foi encontrado',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go('/admin/companies/${widget.companyId}'),
              child: const Text('Voltar para Empresa'),
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
              'Erro ao carregar usuário',
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
              onPressed: () => context.go('/admin/companies/${widget.companyId}'),
              child: const Text('Voltar para Empresa'),
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
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}