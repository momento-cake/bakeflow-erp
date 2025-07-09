import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/themes/app_theme.dart';
import '../../core/models/user_model.dart';

class SharedHeader extends StatelessWidget {
  final UserModel user;
  final String? title;
  final String? subtitle;
  final VoidCallback onProfileTap;
  final VoidCallback onNotificationTap;
  final bool showBackButton;
  final bool showSearch;
  final List<Widget>? actions;
  final bool isDashboard;
  final String? fallbackRoute;

  const SharedHeader({
    super.key,
    required this.user,
    this.title,
    this.subtitle,
    required this.onProfileTap,
    required this.onNotificationTap,
    this.showBackButton = false,
    this.showSearch = false,
    this.actions,
    this.isDashboard = false,
    this.fallbackRoute,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 600;
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
              // Back button or Brand
              if (showBackButton)
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          // If can't pop, navigate to fallback route or dashboard
                          context.go(fallbackRoute ?? '/dashboard');
                        }
                      },
                    ),
                    if (!isMobile) const SizedBox(width: 8),
                  ],
                )
              else if (isMobile && !isDashboard)
                // Mobile navigation for non-dashboard screens
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),

              // Brand (only show on dashboard)
              if (isDashboard) _buildBrand(context, isDesktop, isTablet),

              // Title section for non-dashboard screens
              if (!isDashboard && title != null) ...[
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title!,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                      ),
                      if (subtitle != null && !isMobile)
                        Text(
                          subtitle!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.neutralGray,
                              ),
                        ),
                    ],
                  ),
                ),
              ],

              if (isDashboard) const Spacer(),

              // Custom actions
              if (actions != null) ...actions!,

              // Search bar (desktop only)
              if (showSearch && isDesktop) ...[
                Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
                      hintStyle: TextStyle(color: AppTheme.neutralGray),
                      prefixIcon: Icon(Icons.search, color: AppTheme.neutralGray),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
              ],

              // User actions section
              _buildUserActions(context, isDesktop, isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrand(BuildContext context, bool isDesktop, bool isTablet) {
    return Row(
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
        if (isTablet) ...[
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
    );
  }

  Widget _buildUserActions(BuildContext context, bool isDesktop, bool isTablet) {
    final isMobile = MediaQuery.of(context).size.width <= 600;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Notifications (show on web always, mobile only on dashboard)
        if (!isMobile || isDashboard)
          IconButton(
            icon: Badge(
              label: const Text('3'),
              child: const Icon(Icons.notifications_outlined),
            ),
            onPressed: onNotificationTap,
            tooltip: 'Notificações',
          ),

        if (!isMobile || isDashboard) const SizedBox(width: 8),

        // User Profile (show on web always, mobile only on dashboard)
        if (!isMobile || isDashboard)
          InkWell(
            onTap: onProfileTap,
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                  // Show user info only on desktop or dashboard
                  if (isDesktop || isDashboard) ...[
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
                          user.roleDisplayName,
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
    );
  }
}

// Convenience constructors for different screen types
class DashboardHeader extends StatelessWidget {
  final UserModel user;
  final VoidCallback onProfileTap;
  final VoidCallback onNotificationTap;

  const DashboardHeader({
    super.key,
    required this.user,
    required this.onProfileTap,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return SharedHeader(
      user: user,
      onProfileTap: onProfileTap,
      onNotificationTap: onNotificationTap,
      showSearch: true,
      isDashboard: true,
    );
  }
}

class ScreenHeader extends StatelessWidget {
  final UserModel user;
  final String title;
  final String? subtitle;
  final VoidCallback onProfileTap;
  final VoidCallback onNotificationTap;
  final bool showBackButton;
  final List<Widget>? actions;
  final String? fallbackRoute;

  const ScreenHeader({
    super.key,
    required this.user,
    required this.title,
    this.subtitle,
    required this.onProfileTap,
    required this.onNotificationTap,
    this.showBackButton = true,
    this.actions,
    this.fallbackRoute,
  });

  @override
  Widget build(BuildContext context) {
    return SharedHeader(
      user: user,
      title: title,
      subtitle: subtitle,
      onProfileTap: onProfileTap,
      onNotificationTap: onNotificationTap,
      showBackButton: showBackButton,
      actions: actions,
      isDashboard: false,
      fallbackRoute: fallbackRoute,
    );
  }
}
