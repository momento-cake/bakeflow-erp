import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/themes/app_theme.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/permission_service.dart';
import '../../../shared/widgets/shared_header.dart';
import '../services/company_user_service.dart';

class CompanyUsersScreen extends ConsumerStatefulWidget {
  final String companyId; // For ERP admins accessing specific company

  const CompanyUsersScreen({super.key, required this.companyId});

  @override
  ConsumerState<CompanyUsersScreen> createState() => _CompanyUsersScreenState();
}

class _CompanyUsersScreenState extends ConsumerState<CompanyUsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _searchTimer;
  String _searchQuery = '';
  String _selectedFilter = 'todos';
  int _pageSize = 20;
  int _currentPage = 0;

  final List<String> _filters = [
    'todos',
    'administradores',
    'gerentes',
    'funcionarios',
    'ativos',
    'desativados'
  ];
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
    // Cancel previous timer
    _searchTimer?.cancel();

    // Start new timer with 300ms delay (throttling)
    _searchTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _searchQuery = _searchController.text.toLowerCase();
          _currentPage = 0; // Reset to first page when searching
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userPermissions = ref.watch(currentUserPermissionsProvider);

    if (userPermissions == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Check if user can manage company users using the permission service
    if (!userPermissions.canManageCompanyUsers) {
      return _buildAccessDenied(context, userPermissions.user);
    }

    return _buildScreen(context, userPermissions);
  }

  Widget _buildScreen(BuildContext context, UserPermissions userPermissions) {
    final currentUser = userPermissions.user;

    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth <= 600;

    // Use the current user's businessId, or allow admin to see this is a demo/error
    final usersAsync = ref.watch(companyUsersStreamProvider(widget.companyId));

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          ScreenHeader(
            user: currentUser,
            title: 'Usuários da Empresa',
            subtitle: 'Gerencie usuários da sua empresa',
            onProfileTap: () => _showComingSoon(context, 'Menu do usuário'),
            onNotificationTap: () => _showComingSoon(context, 'Notificações'),
            showBackButton: true,
            fallbackRoute: '/',
            actions: [
              // Add User Button - responsive design
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: isMobile
                    ? IconButton(
                        onPressed: () => context.go('/company/${widget.companyId}/users/create'),
                        icon: const Icon(Icons.add, color: Colors.white),
                        style: IconButton.styleFrom(
                          backgroundColor: AppTheme.accentColor,
                          padding: const EdgeInsets.all(12),
                        ),
                        tooltip: 'Adicionar Usuário',
                      )
                    : ElevatedButton.icon(
                        onPressed: () => context.go('/company/${widget.companyId}/users/create'),
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Adicionar Usuário',
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
            child: usersAsync.when(
              data: (allUsers) => _buildUsersList(context, allUsers, widget.companyId),
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
                      'Erro ao carregar usuários',
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
                      onPressed: () => ref.invalidate(companyUsersStreamProvider(widget.companyId)),
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

  Widget _buildUsersList(BuildContext context, List<UserModel> allUsers, String businessId) {
    // Apply filters and search
    List<UserModel> filteredUsers = _applyFilters(allUsers);

    // Apply pagination
    final totalUsers = filteredUsers.length;
    final totalPages = (totalUsers / _pageSize).ceil();
    final startIndex = _currentPage * _pageSize;
    final endIndex = (startIndex + _pageSize).clamp(0, totalUsers);

    final paginatedUsers = filteredUsers.sublist(
      startIndex.clamp(0, totalUsers),
      endIndex,
    );

    return Column(
      children: [
        // Search and Filter Section
        _buildSearchAndFilters(),

        // Users List
        Expanded(
          child: paginatedUsers.isEmpty
              ? _buildEmptyState(context, businessId)
              : RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(companyUsersStreamProvider);
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: paginatedUsers.length,
                    itemBuilder: (context, index) {
                      final user = paginatedUsers[index];
                      return _buildUserCard(context, user);
                    },
                  ),
                ),
        ),

        // Pagination Controls
        if (totalPages > 1) _buildPaginationControls(totalPages, totalUsers),
      ],
    );
  }

  List<UserModel> _applyFilters(List<UserModel> users) {
    List<UserModel> filtered = users;

    // Apply role filter
    switch (_selectedFilter) {
      case 'administradores':
        filtered = filtered.where((user) => user.role == const UserRole.companyAdmin()).toList();
        break;
      case 'gerentes':
        filtered = filtered.where((user) => user.role == const UserRole.companyManager()).toList();
        break;
      case 'funcionarios':
        filtered = filtered.where((user) => user.role == const UserRole.companyEmployee()).toList();
        break;
      case 'ativos':
        filtered = filtered.where((user) => user.isActive).toList();
        break;
      case 'desativados':
        filtered = filtered.where((user) => !user.isActive).toList();
        break;
      case 'todos':
      default:
        // No filter, show all
        break;
    }

    // Apply search
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((user) {
        final name = user.displayName?.toLowerCase() ?? '';
        final email = user.email.toLowerCase();
        return name.contains(_searchQuery) || email.contains(_searchQuery);
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
          // Search Bar
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar por nome ou email',
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

          // Horizontally scrollable filters and page size selector
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Filter chips
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

                // Page size selector styled as a card
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
        return 'Todos';
      case 'administradores':
        return 'Administradores';
      case 'gerentes':
        return 'Gerentes';
      case 'funcionarios':
        return 'Funcionários';
      case 'ativos':
        return 'Ativos';
      case 'desativados':
        return 'Desativados';
      default:
        return filter;
    }
  }

  Widget _buildEmptyState(BuildContext context, String businessId) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: AppTheme.neutralGray,
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isNotEmpty
                ? 'Nenhum usuário encontrado para "$_searchQuery"'
                : 'Nenhum usuário encontrado',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty
                ? 'Tente uma busca diferente ou ajuste os filtros'
                : 'Adicione o primeiro usuário para começar',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.neutralGray,
                ),
            textAlign: TextAlign.center,
          ),
          if (_searchQuery.isEmpty) ...[
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.go('/company/${widget.companyId}/users/create'),
              icon: const Icon(Icons.add),
              label: const Text('Adicionar Usuário'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaginationControls(int totalPages, int totalUsers) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total: $totalUsers usuários',
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

  Widget _buildUserCard(BuildContext context, UserModel user) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getRoleColor(user.role),
          child: Text(
            user.displayName?.substring(0, 1).toUpperCase() ?? 'U',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          user.displayName ?? 'Usuário sem nome',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getRoleColor(user.role).withAlpha(26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    user.role.displayName,
                    style: TextStyle(
                      fontSize: 12,
                      color: _getRoleColor(user.role),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Show status badge (active/disabled)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: user.isActive ? Colors.green.withAlpha(26) : Colors.red.withAlpha(26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    user.isActive ? 'Ativo' : 'Desativado',
                    style: TextStyle(
                      fontSize: 12,
                      color: user.isActive ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Show company icon for company users
                const SizedBox(width: 8),
                Icon(
                  Icons.business,
                  size: 16,
                  color: AppTheme.primaryColor,
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handleUserAction(context, user, value),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('Editar'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'reset_password',
              child: ListTile(
                leading: Icon(Icons.lock_reset),
                title: Text('Redefinir Senha'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            PopupMenuItem(
              value: user.isActive ? 'disable' : 'enable',
              child: ListTile(
                leading: Icon(
                  user.isActive ? Icons.block : Icons.check_circle,
                  color: user.isActive ? AppTheme.errorColor : Colors.green,
                ),
                title: Text(
                  user.isActive ? 'Desativar' : 'Ativar',
                  style: TextStyle(
                    color: user.isActive ? AppTheme.errorColor : Colors.green,
                  ),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _buildAccessDenied(BuildContext context, UserModel user) {
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
              user.businessId == null
                  ? 'Nenhuma empresa associada'
                  : 'Você não tem permissão para gerenciar usuários',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              user.businessId == null
                  ? 'Seu usuário não está associado a nenhuma empresa. Entre em contato com o administrador.'
                  : 'Apenas administradores da empresa podem gerenciar usuários.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.neutralGray,
                  ),
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

  Color _getRoleColor(UserRole role) {
    return role.when(
      admin: () => AppTheme.errorColor,
      viewer: () => AppTheme.neutralGray,
      companyAdmin: () => AppTheme.primaryColor,
      companyManager: () => Colors.blue,
      companyEmployee: () => Colors.green,
    );
  }

  void _handleUserAction(BuildContext context, UserModel user, String action) {
    switch (action) {
      case 'edit':
        _showComingSoon(context, 'Edição de usuário');
        break;
      case 'reset_password':
        _showComingSoon(context, 'Redefinição de senha');
        break;
      case 'disable':
        _showDisableConfirmation(context, user);
        break;
      case 'enable':
        _showEnableConfirmation(context, user);
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

  void _showDisableConfirmation(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Desativação'),
        content: Text(
          'Tem certeza que deseja desativar o usuário ${user.displayName ?? user.email}?\n\n'
          'O usuário não conseguirá mais fazer login no sistema até ser reativado.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
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
                      Text('Desativando usuário...'),
                    ],
                  ),
                ),
              );

              try {
                developer.log('UI: Starting user disabling for ${user.uid}');

                // Disable user with timeout
                await ref.read(companyUserServiceProvider).disableCompanyUser(user.uid).timeout(
                  const Duration(seconds: 30),
                  onTimeout: () {
                    throw Exception('Operação expirou. Tente novamente.');
                  },
                );

                developer.log('UI: User disabling completed successfully');

                // Close loading dialog safely
                if (scaffoldContext.mounted) {
                  Navigator.of(scaffoldContext, rootNavigator: true).pop();
                }

                // Show success message
                if (scaffoldContext.mounted) {
                  ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                    const SnackBar(
                      content: Text('Usuário desativado com sucesso'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }

                // Stream should auto-update
              } catch (e) {
                developer.log('UI: Error during user disabling: $e');

                // Close loading dialog safely
                if (scaffoldContext.mounted) {
                  Navigator.of(scaffoldContext, rootNavigator: true).pop();
                }

                // Show error message with more details
                if (scaffoldContext.mounted) {
                  final errorMessage = e.toString().replaceFirst('Exception: ', '');
                  ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao desativar usuário: $errorMessage'),
                      backgroundColor: AppTheme.errorColor,
                      duration: const Duration(seconds: 5),
                      action: SnackBarAction(
                        label: 'Detalhes',
                        textColor: Colors.white,
                        onPressed: () {
                          showDialog(
                            context: scaffoldContext,
                            builder: (context) => AlertDialog(
                              title: const Text('Erro de Desativação'),
                              content: Text('Erro completo:\n$e'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.errorColor,
            ),
            child: const Text('Desativar'),
          ),
        ],
      ),
    );
  }

  void _showEnableConfirmation(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Ativação'),
        content: Text(
          'Tem certeza que deseja reativar o usuário ${user.displayName ?? user.email}?\n\n'
          'O usuário poderá fazer login no sistema novamente.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
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
                      Text('Ativando usuário...'),
                    ],
                  ),
                ),
              );

              try {
                developer.log('UI: Starting user enabling for ${user.uid}');

                // Enable user with timeout
                await ref.read(companyUserServiceProvider).enableCompanyUser(user.uid).timeout(
                  const Duration(seconds: 30),
                  onTimeout: () {
                    throw Exception('Operação expirou. Tente novamente.');
                  },
                );

                developer.log('UI: User enabling completed successfully');

                // Close loading dialog safely
                if (scaffoldContext.mounted) {
                  Navigator.of(scaffoldContext, rootNavigator: true).pop();
                }

                // Show success message
                if (scaffoldContext.mounted) {
                  ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                    const SnackBar(
                      content: Text('Usuário ativado com sucesso'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }

                // Stream should auto-update
              } catch (e) {
                developer.log('UI: Error during user enabling: $e');

                // Close loading dialog safely
                if (scaffoldContext.mounted) {
                  Navigator.of(scaffoldContext, rootNavigator: true).pop();
                }

                // Show error message with more details
                if (scaffoldContext.mounted) {
                  final errorMessage = e.toString().replaceFirst('Exception: ', '');
                  ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao ativar usuário: $errorMessage'),
                      backgroundColor: AppTheme.errorColor,
                      duration: const Duration(seconds: 5),
                      action: SnackBarAction(
                        label: 'Detalhes',
                        textColor: Colors.white,
                        onPressed: () {
                          showDialog(
                            context: scaffoldContext,
                            builder: (context) => AlertDialog(
                              title: const Text('Erro de Ativação'),
                              content: Text('Erro completo:\n$e'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.green,
            ),
            child: const Text('Ativar'),
          ),
        ],
      ),
    );
  }
}
