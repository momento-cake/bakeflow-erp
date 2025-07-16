import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/themes/app_theme.dart';
import '../../../../../core/models/business_model.dart';
import '../../../../../core/models/user_model.dart';
import '../../../../../shared/utils/brazilian_validators.dart';
import '../../../../../shared/widgets/brazilian_form_fields.dart';
import '../../../../../shared/widgets/shared_header.dart';
import '../../../../auth/services/auth_service.dart';
import '../providers/companies_providers.dart';

class CompanyDetailsScreen extends ConsumerStatefulWidget {
  final String companyId;

  const CompanyDetailsScreen({
    super.key,
    required this.companyId,
  });

  @override
  ConsumerState<CompanyDetailsScreen> createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends ConsumerState<CompanyDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Form controllers
  final _nameController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _fantasyNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  BusinessType? _businessType;
  BusinessStatus? _businessStatus;
  String? _selectedState;
  bool _isLoading = false;
  bool _isEditing = false;
  Business? _originalBusiness;

  @override
  void dispose() {
    _nameController.dispose();
    _cnpjController.dispose();
    _fantasyNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _populateForm(Business business) {
    _originalBusiness = business;
    _nameController.text = business.name;
    _cnpjController.text = business.cnpj ?? '';
    _fantasyNameController.text = business.fantasyName ?? '';
    _addressController.text = business.address;
    _cityController.text = business.city;
    _zipCodeController.text = business.zipCode;
    _phoneController.text = business.phone;
    _emailController.text = business.email ?? '';
    _businessType = business.type;
    _businessStatus = business.status;
    _selectedState = business.state;
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

    final businessAsync = ref.watch(businessProvider(widget.companyId));

    return businessAsync.when(
      data: (business) {
        if (business == null) {
          return _buildNotFound(context);
        }

        // Populate form on first load
        if (_originalBusiness == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _populateForm(business);
          });
        }

        final canEdit = currentUser.role.canManageCompanies;

        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          body: Column(
            children: [
              ScreenHeader(
                user: currentUser,
                title: 'Detalhes da Empresa',
                subtitle: business.name,
                onProfileTap: () => _showComingSoon(context, 'Menu do usuário'),
                onNotificationTap: () => _showComingSoon(context, 'Notificações'),
                showBackButton: true,
                fallbackRoute: '/admin/companies',
                actions: MediaQuery.sizeOf(context).width <= 768 && canEdit
                    ? [_buildMobileActionsMenu(context, business)]
                    : null,
              ),
              Expanded(
                child: _buildDetailsContent(context, currentUser, business),
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

  Widget _buildDetailsContent(BuildContext context, UserModel currentUser, Business business) {
    final canEdit = currentUser.role.canManageCompanies;

    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Informações da Empresa',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        if (canEdit && MediaQuery.sizeOf(context).width > 768) ...[
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
                                  icon: const Icon(Icons.edit, color: Colors.white),
                                  label: const Text('Editar'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryColor,
                                    foregroundColor: Colors.white,
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
                  ],
                ),
                const SizedBox(height: 24),

                // Business Type Selection
                BrazilianFormFields.businessTypeField(
                  value: _businessType ?? business.type,
                  onChanged: _isEditing
                      ? (type) {
                          setState(() {
                            _businessType = type;
                            if (!type.requiresCnpj) {
                              _cnpjController.clear();
                              _fantasyNameController.clear();
                            }
                          });
                        }
                      : (_) {},
                ),

                const SizedBox(height: 24),

                // Company Name
                BrazilianFormFields.textField(
                  controller: _nameController,
                  labelText: 'Nome da Empresa *',
                  hintText: 'Nome oficial ou razão social',
                  prefixIcon: Icons.business,
                  enabled: _isEditing,
                  validator: _isEditing
                      ? (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nome da empresa é obrigatório';
                          }
                          if (value.trim().length < 3) {
                            return 'Nome deve ter pelo menos 3 caracteres';
                          }
                          return null;
                        }
                      : null,
                ),

                const SizedBox(height: 16),

                // CNPJ (only for formal companies)
                if ((_businessType ?? business.type).requiresCnpj) ...[
                  BrazilianFormFields.cnpjField(
                    controller: _cnpjController,
                    enabled: _isEditing,
                    validator: _isEditing
                        ? (value) {
                            if ((_businessType ?? business.type).requiresCnpj) {
                              if (value == null || value.isEmpty) {
                                return 'CNPJ é obrigatório para empresas formais';
                              }
                              if (!BrazilianValidators.isValidCnpj(value)) {
                                return 'CNPJ inválido';
                              }
                            }
                            return null;
                          }
                        : null,
                  ),
                  const SizedBox(height: 16),
                ],

                // Fantasy Name (only for formal companies)
                if ((_businessType ?? business.type).requiresCnpj) ...[
                  BrazilianFormFields.textField(
                    controller: _fantasyNameController,
                    labelText: 'Nome Fantasia',
                    hintText: 'Nome comercial da empresa',
                    prefixIcon: Icons.storefront,
                    enabled: _isEditing,
                  ),
                  const SizedBox(height: 16),
                ],

                // Contact Information
                Text(
                  'Informações de Contato',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 16),

                // Phone
                BrazilianFormFields.phoneField(
                  controller: _phoneController,
                  enabled: _isEditing,
                ),

                const SizedBox(height: 16),

                // Email
                BrazilianFormFields.emailField(
                  controller: _emailController,
                  enabled: _isEditing,
                  validator: _isEditing
                      ? (value) {
                          if (value != null && value.isNotEmpty) {
                            if (!BrazilianValidators.isValidEmail(value)) {
                              return 'E-mail inválido';
                            }
                          }
                          return null;
                        }
                      : null,
                ),

                const SizedBox(height: 24),

                // Address Information
                Text(
                  'Endereço',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 16),

                // ZIP Code
                BrazilianFormFields.zipCodeField(
                  controller: _zipCodeController,
                  enabled: _isEditing,
                ),

                const SizedBox(height: 16),

                // Address
                BrazilianFormFields.textField(
                  controller: _addressController,
                  labelText: 'Endereço *',
                  hintText: 'Rua, número, bairro',
                  prefixIcon: Icons.location_on,
                  maxLines: 2,
                  enabled: _isEditing,
                  validator: _isEditing
                      ? (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Endereço é obrigatório';
                          }
                          return null;
                        }
                      : null,
                ),

                const SizedBox(height: 16),

                // City and State Row - Mobile responsive
                MediaQuery.sizeOf(context).width <= 768
                    ? Column(
                        children: [
                          BrazilianFormFields.textField(
                            controller: _cityController,
                            labelText: 'Cidade *',
                            hintText: 'Nome da cidade',
                            prefixIcon: Icons.location_city,
                            enabled: _isEditing,
                            validator: _isEditing
                                ? (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Cidade é obrigatória';
                                    }
                                    return null;
                                  }
                                : null,
                          ),
                          const SizedBox(height: 16),
                          BrazilianFormFields.stateDropdownField(
                            value: _selectedState,
                            onChanged: _isEditing
                                ? (value) {
                                    setState(() {
                                      _selectedState = value;
                                    });
                                  }
                                : (_) {},
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: BrazilianFormFields.textField(
                              controller: _cityController,
                              labelText: 'Cidade *',
                              hintText: 'Nome da cidade',
                              prefixIcon: Icons.location_city,
                              enabled: _isEditing,
                              validator: _isEditing
                                  ? (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return 'Cidade é obrigatória';
                                      }
                                      return null;
                                    }
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: BrazilianFormFields.stateDropdownField(
                              value: _selectedState,
                              onChanged: _isEditing
                                  ? (value) {
                                      setState(() {
                                        _selectedState = value;
                                      });
                                    }
                                  : (_) {},
                            ),
                          ),
                        ],
                      ),

                const SizedBox(height: 24),

                // Status (for admins only)
                if (canEdit && _isEditing) ...[
                  Text(
                    'Status da Empresa',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<BusinessStatus>(
                    value: _businessStatus ?? business.status,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      prefixIcon: Icon(Icons.toggle_on),
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: const BusinessStatus.active(),
                        child: Text(const BusinessStatus.active().displayName),
                      ),
                      DropdownMenuItem(
                        value: const BusinessStatus.inactive(),
                        child: Text(const BusinessStatus.inactive().displayName),
                      ),
                      DropdownMenuItem(
                        value: const BusinessStatus.suspended(),
                        child: Text(const BusinessStatus.suspended().displayName),
                      ),
                    ],
                    onChanged: (status) {
                      setState(() {
                        _businessStatus = status;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                ],

                // Metadata
                _buildMetadata(context, business),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetadata(BuildContext context, Business business) {
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
            _buildMetadataRow('ID:', business.id),
            _buildMetadataRow('Criado em:', _formatDate(business.createdAt)),
            if (business.updatedAt != null)
              _buildMetadataRow('Atualizado em:', _formatDate(business.updatedAt!)),
            _buildMetadataRow('Criado por:', business.createdBy),
            _buildMetadataRow('Status:', business.status.displayName),
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
      if (_originalBusiness != null) {
        _populateForm(_originalBusiness!);
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
      final updatedBusiness = _originalBusiness!.copyWith(
        name: _nameController.text.trim(),
        cnpj: (_businessType ?? _originalBusiness!.type).requiresCnpj
            ? _cnpjController.text.replaceAll(RegExp(r'[^0-9]'), '')
            : null,
        fantasyName: _fantasyNameController.text.trim().isNotEmpty
            ? _fantasyNameController.text.trim()
            : null,
        address: _addressController.text.trim(),
        city: _cityController.text.trim(),
        state: _selectedState!,
        zipCode: _zipCodeController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        phone: _phoneController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        email: _emailController.text.trim().isNotEmpty ? _emailController.text.trim() : null,
        type: _businessType ?? _originalBusiness!.type,
        status: _businessStatus ?? _originalBusiness!.status,
      );

      await ref.read(companiesRepositoryProvider).updateBusiness(updatedBusiness);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Empresa "${updatedBusiness.name}" atualizada com sucesso'),
            backgroundColor: AppTheme.successColor,
          ),
        );

        setState(() {
          _isEditing = false;
        });

        // Refresh the business data
        ref.invalidate(businessProvider(widget.companyId));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao atualizar empresa: $e'),
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
          'Tem certeza que deseja excluir a empresa "${_originalBusiness?.name}"?\n\n'
          'Esta ação não pode ser desfeita e todos os dados relacionados serão removidos.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteBusiness();
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

  Future<void> _deleteBusiness() async {
    if (_originalBusiness == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await ref.read(companiesRepositoryProvider).deleteBusiness(_originalBusiness!.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Empresa "${_originalBusiness!.name}" excluída com sucesso'),
            backgroundColor: AppTheme.successColor,
          ),
        );

        context.go('/admin/companies');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao excluir empresa: $e'),
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
              onPressed: () => context.go('/'),
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

  Widget _buildMobileActionsMenu(BuildContext context, Business business) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) => _handleMenuAction(value, context),
      itemBuilder: (context) {
        List<PopupMenuEntry<String>> items = [];

        // Company Details actions only
        if (_isEditing) {
          items.addAll([
            const PopupMenuItem(
              value: 'save',
              child: ListTile(
                leading: Icon(Icons.save),
                title: Text('Salvar'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'cancel',
              child: ListTile(
                leading: Icon(Icons.cancel),
                title: Text('Cancelar'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ]);
        } else {
          items.addAll([
            const PopupMenuItem(
              value: 'edit',
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('Editar'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: ListTile(
                leading: Icon(Icons.delete_outline, color: AppTheme.errorColor),
                title: Text('Excluir', style: TextStyle(color: AppTheme.errorColor)),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ]);
        }

        return items;
      },
    );
  }

  void _handleMenuAction(String action, BuildContext context) {
    switch (action) {
      case 'edit':
        setState(() => _isEditing = true);
        break;
      case 'save':
        _saveChanges();
        break;
      case 'cancel':
        _cancelEdit();
        break;
      case 'delete':
        _confirmDelete(context);
        break;
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
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
