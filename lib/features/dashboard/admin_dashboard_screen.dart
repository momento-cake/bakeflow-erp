import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/themes/app_theme.dart';
import '../../core/models/user_model.dart';
import '../auth/services/auth_service.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

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
    // Security check: Only admin users can access this dashboard
    if (!currentUser.role.isAdmin) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.security,
                size: 64,
                color: AppTheme.errorColor,
              ),
              const SizedBox(height: 16),
              Text(
                'Acesso Negado',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Você não tem permissão para acessar esta área.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.neutralGray,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

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
                _buildAdminFeatureCards(context, currentUser),
              ),
            ),
          ),

          // Admin Stats Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Estatísticas do Sistema',
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
                    'Total de Empresas',
                    '0',
                    Icons.business,
                    AppTheme.primaryColor,
                  ),
                  const SizedBox(width: 16),
                  _buildStatCard(
                    context,
                    'Usuários Ativos',
                    '0',
                    Icons.people,
                    AppTheme.successColor,
                  ),
                  const SizedBox(width: 16),
                  _buildStatCard(
                    context,
                    'Empresas Ativas',
                    '0',
                    Icons.business_center,
                    AppTheme.accentColor,
                  ),
                  const SizedBox(width: 16),
                  _buildStatCard(
                    context,
                    'Novos Registros',
                    '0',
                    Icons.trending_up,
                    AppTheme.warningColor,
                  ),
                ],
              ),
            ),
          ),
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
                      Icons.admin_panel_settings,
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
                          'BakeFlow ERP - Admin',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                              ),
                        ),
                        // Show subtitle only on desktop
                        if (isDesktop)
                          Text(
                            'Painel de administração do sistema',
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
                  label: const Text('0'),
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
                          user.displayName?.substring(0, 1).toUpperCase() ?? 'A',
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
                              user.displayName ?? 'Administrador',
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

  List<Widget> _buildAdminFeatureCards(BuildContext context, UserModel currentUser) {
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
          () => context.go('/admin/users'),
        ),
        _buildFeatureCard(
          context,
          'Empresas',
          'Gerenciar empresas do sistema',
          Icons.business,
          Colors.blue,
          () => context.go('/admin/companies'),
        ),
        _buildFeatureCard(
          context,
          'Configurações',
          'Configurações do sistema',
          Icons.settings,
          Colors.grey,
          () => _showComingSoon(context, 'Configurações do Sistema'),
        ),
        _buildFeatureCard(
          context,
          'Relatórios',
          'Relatórios administrativos',
          Icons.analytics,
          Colors.indigo,
          () => _showComingSoon(context, 'Relatórios Administrativos'),
        ),
        _buildFeatureCard(
          context,
          'Logs do Sistema',
          'Auditoria e logs',
          Icons.list_alt,
          Colors.orange,
          () => _showComingSoon(context, 'Logs do Sistema'),
        ),
        _buildFeatureCard(
          context,
          'Backup & Restore',
          'Gestão de dados',
          Icons.backup,
          Colors.green,
          () => _showComingSoon(context, 'Backup & Restore'),
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
                _showComingSoon(context, 'Perfil do Administrador');
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
      const SnackBar(content: Text('Notificações administrativas em breve')),
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
