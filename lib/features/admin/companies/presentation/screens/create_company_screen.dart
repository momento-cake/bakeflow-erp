import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/themes/app_theme.dart';
import '../../../../../core/models/user_model.dart';
import '../../../../../core/models/business_model.dart';
import '../../../../../shared/widgets/shared_header.dart';
import '../../../../../shared/widgets/brazilian_form_fields.dart';
import '../../../../../shared/utils/brazilian_validators.dart';
import '../../../../auth/services/auth_service.dart';
import '../providers/companies_providers.dart';

class CreateCompanyScreen extends ConsumerStatefulWidget {
  const CreateCompanyScreen({super.key});

  @override
  ConsumerState<CreateCompanyScreen> createState() => _CreateCompanyScreenState();
}

class _CreateCompanyScreenState extends ConsumerState<CreateCompanyScreen> {
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
  
  BusinessType _businessType = const BusinessType.soloEntrepreneur();
  String? _selectedState;
  bool _isLoading = false;

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

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          ScreenHeader(
            user: currentUser,
            title: 'Adicionar Empresa',
            subtitle: 'Cadastre uma nova empresa no sistema',
            onProfileTap: () => _showComingSoon(context, 'Menu do usuário'),
            onNotificationTap: () => _showComingSoon(context, 'Notificações'),
            showBackButton: true,
            fallbackRoute: '/admin/companies',
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              child: _buildForm(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
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
                'Informações da Empresa',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),

              // Business Type Selection
              BrazilianFormFields.businessTypeField(
                value: _businessType,
                onChanged: (type) {
                  setState(() {
                    _businessType = type;
                    if (!type.requiresCnpj) {
                      _cnpjController.clear();
                      _fantasyNameController.clear();
                    }
                  });
                },
              ),

              const SizedBox(height: 24),

              // Company Name
              BrazilianFormFields.textField(
                controller: _nameController,
                labelText: 'Nome da Empresa *',
                hintText: 'Nome oficial ou razão social',
                prefixIcon: Icons.business,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome da empresa é obrigatório';
                  }
                  if (value.trim().length < 3) {
                    return 'Nome deve ter pelo menos 3 caracteres';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // CNPJ (only for formal companies)
              if (_businessType.requiresCnpj) ...[
                BrazilianFormFields.cnpjField(
                  controller: _cnpjController,
                  validator: (value) {
                    if (_businessType.requiresCnpj) {
                      if (value == null || value.isEmpty) {
                        return 'CNPJ é obrigatório para empresas formais';
                      }
                      if (!BrazilianValidators.isValidCnpj(value)) {
                        return 'CNPJ inválido';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
              ],

              // Fantasy Name (only for formal companies)
              if (_businessType.requiresCnpj) ...[
                BrazilianFormFields.textField(
                  controller: _fantasyNameController,
                  labelText: 'Nome Fantasia',
                  hintText: 'Nome comercial da empresa',
                  prefixIcon: Icons.storefront,
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
              ),

              const SizedBox(height: 16),

              // Email
              BrazilianFormFields.emailField(
                controller: _emailController,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!BrazilianValidators.isValidEmail(value)) {
                      return 'E-mail inválido';
                    }
                  }
                  return null;
                },
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
              ),

              const SizedBox(height: 16),

              // Address
              BrazilianFormFields.textField(
                controller: _addressController,
                labelText: 'Endereço *',
                hintText: 'Rua, número, bairro',
                prefixIcon: Icons.location_on,
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Endereço é obrigatório';
                  }
                  return null;
                },
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
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Cidade é obrigatória';
                            }
                            return null;
                          },
                          onFieldSubmitted: () {
                            if (!_isLoading) {
                              _createCompany();
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        BrazilianFormFields.stateDropdownField(
                          value: _selectedState,
                          onChanged: (value) {
                            setState(() {
                              _selectedState = value;
                            });
                          },
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
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Cidade é obrigatória';
                              }
                              return null;
                            },
                            onFieldSubmitted: () {
                              if (!_isLoading) {
                                _createCompany();
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: BrazilianFormFields.stateDropdownField(
                            value: _selectedState,
                            onChanged: (value) {
                              setState(() {
                                _selectedState = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

              const SizedBox(height: 32),

              // Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _createCompany,
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
                          'Criar Empresa',
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createCompany() async {
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
      final business = Business(
        id: '', // Will be set by Firestore
        name: _nameController.text.trim(),
        cnpj: _businessType.requiresCnpj ? BrazilianFormatters.removeFormatting(_cnpjController.text) : null,
        fantasyName: _fantasyNameController.text.trim().isNotEmpty ? _fantasyNameController.text.trim() : null,
        address: _addressController.text.trim(),
        city: _cityController.text.trim(),
        state: _selectedState!,
        zipCode: BrazilianFormatters.removeFormatting(_zipCodeController.text),
        phone: BrazilianFormatters.removeFormatting(_phoneController.text),
        email: _emailController.text.trim().isNotEmpty ? _emailController.text.trim() : null,
        type: _businessType,
        status: const BusinessStatus.active(),
        authorizedUsers: [],
        createdAt: DateTime.now(),
        createdBy: '', // Will be set by service
      );

      final result = await ref.read(companiesRepositoryProvider).createBusiness(business);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Empresa "${result.name}" criada com sucesso'),
            backgroundColor: AppTheme.successColor,
          ),
        );
        
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao criar empresa: $e'),
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