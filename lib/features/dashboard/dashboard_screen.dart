import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/themes/app_theme.dart';
import '../../core/models/user_model.dart';
import '../admin/companies/presentation/providers/companies_providers.dart';
import '../auth/services/auth_service.dart';

class DashboardScreen extends ConsumerWidget {
  final String companyId;

  const DashboardScreen({super.key, required this.companyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basicUser = ref.watch(currentUserProvider);

    if (basicUser == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final firestoreUser = ref.watch(firestoreUserProvider(basicUser.uid));

    return firestoreUser.when(
      data: (currentUser) => _buildDashboard(context, ref, currentUser ?? basicUser),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => _buildDashboard(context, ref, basicUser),
    );
  }

  Widget _buildDashboard(BuildContext context, WidgetRef ref, UserModel currentUser) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isDesktop = screenWidth > 1200;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: _buildHeader(context, ref, currentUser, isDesktop),
          ),

          // Feature Grid
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: _getMaxCardWidth(screenWidth),
                childAspectRatio: screenWidth <= 600 ? 1.2 : 1.0,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildListDelegate(
                _buildFeatureCards(context, currentUser, ref),
              ),
            ),
          ),

          // Quick Stats Section (for owners and managers)
          if (currentUser.role.canViewReports) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Resumo Rápido',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 120,
                margin: const EdgeInsets.only(top: 16, bottom: 24),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    _buildStatCard(
                      context,
                      'Vendas Hoje',
                      'R\$ 0,00',
                      Icons.attach_money,
                      AppTheme.successColor,
                    ),
                    const SizedBox(width: 16),
                    _buildStatCard(
                      context,
                      'Pedidos Pendentes',
                      '0',
                      Icons.pending_actions,
                      AppTheme.warningColor,
                    ),
                    const SizedBox(width: 16),
                    _buildStatCard(
                      context,
                      'Produtos Ativos',
                      '0',
                      Icons.inventory_2,
                      AppTheme.accentColor,
                    ),
                    const SizedBox(width: 16),
                    _buildStatCard(
                      context,
                      'Estoque Baixo',
                      '0',
                      Icons.warning,
                      AppTheme.errorColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref, UserModel user, bool isDesktop) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth <= 600;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 32 : 16,
            vertical: 16,
          ),
          child: Row(
            children: [
              // Logo and Brand
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                    ),
                    child: const Icon(
                      Icons.cake,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  // Show brand name and subtitle only on tablet and desktop
                  if (!isMobile) ...[
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'BakeFlow ERP',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                              ),
                        ),
                        // Show subtitle only on desktop
                        if (isDesktop)
                          Text(
                            'Gestão inteligente para confeitarias',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.neutralGray,
                                ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),

              const Spacer(),

              // Notifications
              IconButton(
                icon: Badge(
                  label: const Text('3'),
                  child: const Icon(Icons.notifications_outlined),
                ),
                onPressed: () => _showNotifications(context),
              ),

              const SizedBox(width: 8),

              // User Profile
              InkWell(
                onTap: () => _showProfileMenu(context, ref),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 8 : 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppTheme.primaryColor,
                        child: Text(
                          user.displayName?.substring(0, 1).toUpperCase() ?? 'U',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Show user details only on desktop
                      if (!isMobile) ...[
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              user.displayName ?? 'Usuário',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              user.role.displayName,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.neutralGray,
                                    fontSize: 11,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.expand_more,
                          size: 16,
                          color: AppTheme.neutralGray,
                        ),
                      ],
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

  List<Widget> _buildFeatureCards(BuildContext context, UserModel currentUser, WidgetRef ref) {
    final cards = <Widget>[];

    // Core business features
    cards.addAll([
      _buildFeatureCard(
        context,
        'Vendas',
        'Pedidos e vendas',
        Icons.point_of_sale,
        AppTheme.primaryColor,
        () => _showComingSoon(context, 'Vendas'),
      ),
      _buildFeatureCard(
        context,
        'Clientes',
        'Gestão de clientes',
        Icons.people_outline,
        Colors.blue,
        () => _showComingSoon(context, 'Clientes'),
      ),
      _buildFeatureCard(
        context,
        'Produtos',
        'Catálogo e preços',
        Icons.cake,
        Colors.orange,
        () => _showComingSoon(context, 'Produtos'),
      ),
    ]);

    // Management features (Admin de empresa and Gerente de empresa only)
    if (currentUser.role.canViewReports) {
      cards.addAll([
        // Users management - only for company admins/managers with formal companies
        if (_canManageUsers(currentUser, ref))
          _buildFeatureCard(
            context,
            'Usuários',
            'Usuários da empresa',
            Icons.people,
            Colors.purple,
            () => context.go('/company/$companyId/users'),
          ),
        _buildFeatureCard(
          context,
          'Configurações',
          'Configurações da empresa',
          Icons.settings,
          Colors.grey,
          () => _showComingSoon(context, 'Configurações da Empresa'),
        ),
        _buildFeatureCard(
          context,
          'Relatórios',
          'Análises e métricas',
          Icons.analytics,
          Colors.indigo,
          () => _showComingSoon(context, 'Relatórios'),
        ),
        _buildFeatureCard(
          context,
          'Financeiro',
          'Receitas e despesas',
          Icons.attach_money,
          Colors.teal,
          () => _showComingSoon(context, 'Financeiro'),
        ),
      ]);
    }

    // Additional operational features
    cards.addAll([
      _buildFeatureCard(
        context,
        'Receitas',
        'Fichas técnicas',
        Icons.receipt_long,
        Colors.green,
        () => _showComingSoon(context, 'Receitas'),
      ),
      _buildFeatureCard(
        context,
        'Ingredientes',
        'Estoque e custos',
        Icons.inventory,
        Colors.amber,
        () => _showComingSoon(context, 'Ingredientes'),
      ),
      _buildFeatureCard(
        context,
        'Fornecedores',
        'Contatos e compras',
        Icons.local_shipping,
        Colors.brown,
        () => _showComingSoon(context, 'Fornecedores'),
      ),
    ]);

    return cards;
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth <= 600;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: isMobile ? 48 : 64,
                height: isMobile ? 48 : 64,
                decoration: BoxDecoration(
                  color: color.withAlpha(26),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: isMobile ? 24 : 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 16 : 18,
                      height: 1.2,
                    ),
                textAlign: TextAlign.center,
                maxLines: isMobile ? 2 : 1,
                overflow: TextOverflow.ellipsis,
              ),
              // Only show subtitle on larger screens
              if (!isMobile) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.neutralGray,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Icon(
                Icons.trending_up,
                color: AppTheme.successColor,
                size: 16,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.neutralGray,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _getMaxCardWidth(double screenWidth) {
    if (screenWidth < 600) {
      return 160; // Mobile: 2 columns
    } else if (screenWidth < 900) {
      return 180; // Tablet: 3 columns
    } else if (screenWidth < 1200) {
      return 200; // Small desktop: 4 columns
    } else if (screenWidth < 1600) {
      return 220; // Large desktop: 5 columns
    } else {
      return 240; // Extra large desktop: 6 columns
    }
  }

  void _showProfileMenu(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Meu Perfil'),
              onTap: () {
                Navigator.pop(context);
                _showComingSoon(context, 'Perfil do Usuário');
              },
            ),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Alterar Senha'),
              onTap: () {
                Navigator.pop(context);
                _showComingSoon(context, 'Alteração de Senha');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: AppTheme.errorColor),
              title: const Text('Sair', style: TextStyle(color: AppTheme.errorColor)),
              onTap: () async {
                Navigator.pop(context);
                await ref.read(authServiceProvider).signOut();
                if (context.mounted) {
                  context.go('/login');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notificações em breve')),
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

  bool _canManageUsers(UserModel currentUser, WidgetRef ref) {
    // Only company admins can manage users (based on existing extension)
    if (!currentUser.role.canManageCompanyUsers) {
      return false;
    }

    // Must have a business ID assigned for company users (ERP admins don't need this)
    if (currentUser.businessId == null && !currentUser.role.isAdmin) {
      return false;
    }

    // For ERP admins, always allow (they manage all users)
    if (currentUser.role.isAdmin) {
      return true;
    }

    // For company admins, check if the business allows multiple users
    final businessAsync = ref.watch(businessProvider(currentUser.businessId!));

    return businessAsync.when(
      data: (business) => business?.type.allowsMultipleUsers ?? false,
      loading: () => false,
      error: (_, __) => false,
    );
  }
}
