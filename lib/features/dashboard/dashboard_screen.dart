import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/themes/app_theme.dart';
import '../../core/models/user_model.dart';
import '../auth/services/auth_service.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

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
    final screenWidth = MediaQuery.of(context).size.width;
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
                childAspectRatio: 1.1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildListDelegate(
                _buildFeatureCards(context, currentUser),
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
                margin: const EdgeInsets.all(24),
                child: ListView(
                  scrollDirection: Axis.horizontal,
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
                      Text(
                        'Gestão inteligente para confeitarias',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.neutralGray,
                            ),
                      ),
                    ],
                  ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  ),
                  child: Row(
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
                      if (isDesktop) ...[
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

  List<Widget> _buildFeatureCards(BuildContext context, UserModel currentUser) {
    final cards = <Widget>[];

    // Admin-only features
    if (currentUser.role.isAdmin) {
      cards.addAll([
        _buildFeatureCard(
          context,
          'Usuários',
          'Gerenciar usuários do sistema',
          Icons.people,
          AppTheme.primaryColor,
          () => context.push('/admin/users'),
        ),
        _buildFeatureCard(
          context,
          'Empresas',
          'Gerenciar empresas (Em breve)',
          Icons.business,
          Colors.blue,
          () => _showComingSoon(context, 'Gerenciamento de Empresas'),
        ),
        _buildFeatureCard(
          context,
          'Configurações',
          'Configurações do sistema (Em breve)',
          Icons.settings,
          Colors.grey,
          () => _showComingSoon(context, 'Configurações do Sistema'),
        ),
      ]);
    } else {
      // Business user features
      cards.addAll([
        _buildFeatureCard(
          context,
          'Produtos',
          'Catálogo e preços',
          Icons.cake,
          AppTheme.primaryColor,
          () => _showComingSoon(context, 'Produtos'),
        ),
        _buildFeatureCard(
          context,
          'Receitas',
          'Fichas técnicas',
          Icons.receipt_long,
          Colors.orange,
          () => _showComingSoon(context, 'Receitas'),
        ),
        _buildFeatureCard(
          context,
          'Ingredientes',
          'Estoque e custos',
          Icons.inventory,
          Colors.green,
          () => _showComingSoon(context, 'Ingredientes'),
        ),
        _buildFeatureCard(
          context,
          'Pedidos',
          'Vendas e entregas',
          Icons.shopping_cart,
          Colors.purple,
          () => _showComingSoon(context, 'Pedidos'),
        ),
      ]);

      // Additional features for managers and owners
      if (currentUser.role.canViewReports) {
        cards.addAll([
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

      // Features for all business users
      cards.addAll([
        _buildFeatureCard(
          context,
          'Fornecedores',
          'Contatos e compras',
          Icons.local_shipping,
          Colors.brown,
          () => _showComingSoon(context, 'Fornecedores'),
        ),
        _buildFeatureCard(
          context,
          'Configurações',
          'Preferências',
          Icons.settings,
          Colors.grey,
          () => _showComingSoon(context, 'Configurações'),
        ),
      ]);
    }

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
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: color.withAlpha(26),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
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
}
