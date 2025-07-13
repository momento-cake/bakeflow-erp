import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/themes/app_theme.dart';
import '../../../../../core/models/business_model.dart';
import '../../../../../core/models/company_user_model.dart';
import '../../../../../core/models/user_model.dart';
import '../providers/companies_providers.dart';
import '../widgets/company_user_card.dart';

class CompanyUsersTab extends ConsumerStatefulWidget {
  final String companyId;
  final Business company;
  final bool canEdit;

  const CompanyUsersTab({
    super.key,
    required this.companyId,
    required this.company,
    required this.canEdit,
  });

  @override
  ConsumerState<CompanyUsersTab> createState() => _CompanyUsersTabState();
}

class _CompanyUsersTabState extends ConsumerState<CompanyUsersTab> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _statusFilter = 'Ativo'; // Default to 'Ativo' as specified
  int _itemsPerPage = 10;
  int _currentPage = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usersAsync = ref.watch(companyUsersProvider(widget.companyId));

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 16),
          _buildSearchAndFilters(),
          const SizedBox(height: 16),
          Expanded(
            child: usersAsync.when(
              data: (users) => _buildUsersList(context, users),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => _buildError(context, error.toString()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width <= 768;
    final isSoloEntrepreneur = !widget.company.type.allowsMultipleUsers;
    
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Usuários da Empresa',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            isSoloEntrepreneur 
                ? 'Empreendedores individuais geralmente têm apenas um usuário'
                : 'Gerencie os usuários com acesso à empresa',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.neutralGray,
            ),
          ),
          if (isSoloEntrepreneur) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.warningColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: AppTheme.warningColor.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: AppTheme.warningColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Empresa: ${widget.company.type.displayName}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.warningColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      );
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Usuários da Empresa',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                isSoloEntrepreneur 
                    ? 'Empreendedores individuais geralmente têm apenas um usuário'
                    : 'Gerencie os usuários com acesso à empresa',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.neutralGray,
                ),
              ),
              if (isSoloEntrepreneur) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.warningColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: AppTheme.warningColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: AppTheme.warningColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Empresa: ${widget.company.type.displayName}',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.warningColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        if (widget.canEdit) ...[
          ElevatedButton.icon(
            onPressed: () => context.go('/admin/companies/${widget.companyId}/users/create'),
            icon: const Icon(Icons.person_add, color: Colors.white),
            label: const Text('Adicionar Usuário'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSearchAndFilters() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Status Filter Tabs
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.neutralGray.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _statusFilter = 'Ativo';
                                _currentPage = 0;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: _statusFilter == 'Ativo' 
                                    ? AppTheme.primaryColor 
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(7),
                                  bottomLeft: Radius.circular(7),
                                ),
                              ),
                              child: Text(
                                'Ativo',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _statusFilter == 'Ativo' 
                                      ? Colors.white 
                                      : AppTheme.neutralGray,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _statusFilter = 'Inativo';
                                _currentPage = 0;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: _statusFilter == 'Inativo' 
                                    ? AppTheme.primaryColor 
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(7),
                                  bottomRight: Radius.circular(7),
                                ),
                              ),
                              child: Text(
                                'Inativo',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _statusFilter == 'Inativo' 
                                      ? Colors.white 
                                      : AppTheme.neutralGray,
                                  fontWeight: FontWeight.w500,
                                ),
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
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Buscar por nome, email ou função...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value.toLowerCase();
                        _currentPage = 0;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButton<int>(
                  value: _itemsPerPage,
                  items: [10, 25, 50].map((count) {
                    return DropdownMenuItem(
                      value: count,
                      child: Text(
                        MediaQuery.sizeOf(context).width <= 768 
                            ? '$count' 
                            : '$count por página'
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _itemsPerPage = value;
                        _currentPage = 0;
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsersList(BuildContext context, List<CompanyUser> allUsers) {
    // Filter users based on status and search query
    final filteredUsers = allUsers.where((user) {
      // Apply status filter
      final statusMatch = _statusFilter == 'Ativo' ? user.isActive : !user.isActive;
      
      // Apply search filter
      final searchMatch = _searchQuery.isEmpty || 
          user.name.toLowerCase().contains(_searchQuery) ||
          user.email.toLowerCase().contains(_searchQuery) ||
          user.role.displayName.toLowerCase().contains(_searchQuery);
      
      return statusMatch && searchMatch;
    }).toList();

    // Pagination
    final totalPages = (filteredUsers.length / _itemsPerPage).ceil();
    final startIndex = _currentPage * _itemsPerPage;
    final endIndex = (startIndex + _itemsPerPage).clamp(0, filteredUsers.length);
    final currentPageUsers = filteredUsers.sublist(startIndex, endIndex);

    if (filteredUsers.isEmpty) {
      return _buildEmptyState(context);
    }

    return Column(
      children: [
        _buildStatsCard(allUsers, filteredUsers.length),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: currentPageUsers.length,
            itemBuilder: (context, index) {
              final user = currentPageUsers[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CompanyUserCard(
                  user: user,
                  onTap: () => context.go('/admin/companies/${widget.companyId}/users/${user.id}'),
                  onDelete: widget.canEdit ? () => _confirmDeleteUser(context, user) : null,
                ),
              );
            },
          ),
        ),
        if (totalPages > 1) ...[
          const SizedBox(height: 16),
          _buildPagination(totalPages),
        ],
      ],
    );
  }

  Widget _buildStatsCard(List<CompanyUser> allUsers, int filteredUsers) {
    final activeUsers = allUsers.where((user) => user.isActive).length;
    final inactiveUsers = allUsers.length - activeUsers;
    final statusLabel = _statusFilter == 'Ativo' ? 'ativos' : 'inativos';
    
    return Card(
      color: AppTheme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.people,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(width: 12),
                Text(
                  'Usuários $statusLabel: $filteredUsers',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.neutralGray,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Total: ${allUsers.length}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.neutralGray.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Ativos: $activeUsers',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.successColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Inativos: $inactiveUsers',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.errorColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination(int totalPages) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Página ${_currentPage + 1} de $totalPages',
              style: const TextStyle(color: AppTheme.neutralGray),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _currentPage > 0 ? () {
                    setState(() {
                      _currentPage--;
                    });
                  } : null,
                  icon: const Icon(Icons.chevron_left),
                ),
                IconButton(
                  onPressed: _currentPage < totalPages - 1 ? () {
                    setState(() {
                      _currentPage++;
                    });
                  } : null,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _searchQuery.isNotEmpty ? Icons.search_off : Icons.people_outline,
            size: 64,
            color: AppTheme.neutralGray,
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isNotEmpty 
                ? 'Nenhum usuário encontrado para "$_searchQuery"'
                : 'Nenhum usuário cadastrado',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.neutralGray,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty
                ? 'Tente ajustar sua busca'
                : 'Adicione o primeiro usuário à empresa',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.neutralGray,
            ),
            textAlign: TextAlign.center,
          ),
          if (widget.canEdit && _searchQuery.isEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'Use o menu ⋮ no canto superior direito para adicionar o primeiro usuário',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.neutralGray,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String error) {
    return Center(
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
            'Erro ao carregar usuários',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.errorColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.neutralGray,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => ref.invalidate(companyUsersProvider(widget.companyId)),
            icon: const Icon(Icons.refresh),
            label: const Text('Tentar Novamente'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteUser(BuildContext context, CompanyUser user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text(
          'Tem certeza que deseja excluir o usuário "${user.name}"?\n\n'
          'Esta ação desativará o usuário, impedindo seu acesso à empresa.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              
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
              
              await _deleteUser(scaffoldContext, user);
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

  Future<void> _deleteUser(BuildContext scaffoldContext, CompanyUser user) async {
    try {
      // Perform soft delete with timeout
      await ref.read(companiesRepositoryProvider).deleteCompanyUser(widget.companyId, user.id).timeout(
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
            content: Text('Usuário "${user.name}" excluído com sucesso'),
            backgroundColor: AppTheme.successColor,
            duration: const Duration(seconds: 3),
          ),
        );
        
        // Refresh the users list
        ref.invalidate(companyUsersProvider(widget.companyId));
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
}