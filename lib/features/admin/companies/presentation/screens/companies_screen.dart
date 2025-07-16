import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/themes/app_theme.dart';
import '../../../../../core/models/business_model.dart';
import '../../../../../core/models/user_model.dart';
import '../../../../../shared/widgets/company_card.dart';
import '../../../../../shared/widgets/shared_header.dart';
import '../../../../auth/services/auth_service.dart';
import '../providers/companies_providers.dart';

class CompaniesScreen extends ConsumerStatefulWidget {
  const CompaniesScreen({super.key});

  @override
  ConsumerState<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends ConsumerState<CompaniesScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _searchTimer;
  String _searchQuery = '';
  String _selectedFilter = 'todos';
  int _pageSize = 20;
  int _currentPage = 0;

  final List<String> _filters = ['todos', 'empresas_formais', 'empreendedores'];
  final List<int> _pageSizes = [20, 50, 100];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    _searchTimer?.cancel();
    _searchTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _searchQuery = _searchController.text.toLowerCase();
          _currentPage = 0;
        });
      }
    });
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

    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth <= 600;
    final businessesAsync = ref.watch(allBusinessesProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          ScreenHeader(
            user: currentUser,
            title: 'Gerenciar Empresas',
            subtitle: 'Administre empresas do sistema',
            onProfileTap: () => _showComingSoon(context, 'Menu do usuário'),
            onNotificationTap: () => _showComingSoon(context, 'Notificações'),
            showBackButton: true,
            fallbackRoute: '/admin/dashboard',
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: isMobile
                    ? IconButton(
                        onPressed: () => context.go('/admin/companies/create'),
                        icon: const Icon(Icons.add, color: Colors.white),
                        style: IconButton.styleFrom(
                          backgroundColor: AppTheme.accentColor,
                          padding: const EdgeInsets.all(12),
                        ),
                        tooltip: 'Adicionar Empresa',
                      )
                    : ElevatedButton.icon(
                        onPressed: () => context.go('/admin/companies/create'),
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Adicionar Empresa',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                        ),
                      ),
              ),
            ],
          ),
          Expanded(
            child: businessesAsync.when(
              data: (allBusinesses) => _buildCompaniesList(context, allBusinesses),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
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
                      'Erro ao carregar empresas',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.neutralGray,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => ref.invalidate(allBusinessesProvider),
                      child: const Text('Tentar Novamente'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompaniesList(BuildContext context, List<Business> allBusinesses) {
    final filteredBusinesses = _applyFilters(allBusinesses);

    final totalBusinesses = filteredBusinesses.length;
    final totalPages = (totalBusinesses / _pageSize).ceil();
    final startIndex = _currentPage * _pageSize;
    final endIndex = (startIndex + _pageSize).clamp(0, totalBusinesses);

    final paginatedBusinesses = filteredBusinesses.sublist(
      startIndex.clamp(0, totalBusinesses),
      endIndex,
    );

    return Column(
      children: [
        _buildSearchAndFilters(),
        Expanded(
          child: paginatedBusinesses.isEmpty
              ? _buildEmptyState(context)
              : RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(allBusinessesProvider);
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: paginatedBusinesses.length,
                    itemBuilder: (context, index) {
                      final business = paginatedBusinesses[index];
                      return CompanyCard(
                        business: business,
                        onTap: () => context.go('/company/${business.id}'),
                        onEdit: () => context.go('/company/${business.id}/details'),
                        onDelete: () => _showDeleteConfirmation(context, business),
                        canEdit: true,
                        canDelete: true,
                      );
                    },
                  ),
                ),
        ),
        if (totalPages > 1) _buildPaginationControls(totalPages, totalBusinesses),
      ],
    );
  }

  List<Business> _applyFilters(List<Business> businesses) {
    List<Business> filtered = businesses;

    switch (_selectedFilter) {
      case 'empresas_formais':
        filtered = filtered
            .where((business) => business.type == const BusinessType.formalCompany())
            .toList();
        break;
      case 'empreendedores':
        filtered = filtered
            .where((business) => business.type == const BusinessType.soloEntrepreneur())
            .toList();
        break;
      case 'todos':
      default:
        break;
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((business) {
        final name = business.name.toLowerCase();
        final city = business.city.toLowerCase();
        final cnpj = business.cnpj?.toLowerCase() ?? '';
        final fantasyName = business.fantasyName?.toLowerCase() ?? '';

        return name.contains(_searchQuery) ||
            city.contains(_searchQuery) ||
            cnpj.contains(_searchQuery) ||
            fantasyName.contains(_searchQuery);
      }).toList();
    }

    return filtered;
  }

  Widget _buildSearchAndFilters() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar por nome, cidade ou CNPJ',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                          _currentPage = 0;
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              filled: true,
              fillColor: AppTheme.backgroundColor,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ..._filters.map((filter) {
                  final isSelected = _selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(_getFilterDisplayName(filter)),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilter = filter;
                          _currentPage = 0;
                        });
                      },
                      backgroundColor: isSelected ? AppTheme.primaryColor : Colors.grey.shade200,
                      selectedColor: AppTheme.primaryColor,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                  );
                }),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppTheme.neutralGray.withAlpha(77)),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.view_list,
                        size: 16,
                        color: AppTheme.neutralGray,
                      ),
                      const SizedBox(width: 6),
                      DropdownButton<int>(
                        value: _pageSize,
                        items: _pageSizes.map((size) {
                          return DropdownMenuItem(
                            value: size,
                            child: Text(
                              '$size por página',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.neutralGray,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _pageSize = value;
                              _currentPage = 0;
                            });
                          }
                        },
                        underline: Container(),
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.neutralGray,
                        ),
                        isDense: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getFilterDisplayName(String filter) {
    switch (filter) {
      case 'todos':
        return 'Todas';
      case 'empresas_formais':
        return 'Empresas Formais';
      case 'empreendedores':
        return 'Empreendedores';
      default:
        return filter;
    }
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.business_outlined,
            size: 64,
            color: AppTheme.neutralGray,
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isNotEmpty
                ? 'Nenhuma empresa encontrada para "$_searchQuery"'
                : 'Nenhuma empresa encontrada',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty
                ? 'Tente uma busca diferente ou ajuste os filtros'
                : 'Adicione a primeira empresa para começar',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.neutralGray,
                ),
            textAlign: TextAlign.center,
          ),
          if (_searchQuery.isEmpty) ...[
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.go('/admin/companies/create'),
              icon: const Icon(Icons.add),
              label: const Text('Adicionar Empresa'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaginationControls(int totalPages, int totalBusinesses) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total: $totalBusinesses empresas',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.neutralGray,
                ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: _currentPage > 0 ? () => setState(() => _currentPage--) : null,
                icon: const Icon(Icons.chevron_left),
              ),
              Text(
                '${_currentPage + 1} de $totalPages',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              IconButton(
                onPressed:
                    _currentPage < totalPages - 1 ? () => setState(() => _currentPage++) : null,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ],
      ),
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
              onPressed: () => context.go('/admin/dashboard'),
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

  void _showDeleteConfirmation(BuildContext context, Business business) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text(
          'Tem certeza que deseja excluir a empresa "${business.name}"?\n\n'
          'Esta ação irá remover todos os dados da empresa, incluindo usuários, '
          'produtos, receitas e relatórios. Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteBusiness(business);
            },
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.errorColor,
            ),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteBusiness(Business business) async {
    try {
      await ref.read(companiesRepositoryProvider).deleteBusiness(business.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Empresa "${business.name}" excluída com sucesso'),
            backgroundColor: AppTheme.successColor,
          ),
        );
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
    }
  }
}
