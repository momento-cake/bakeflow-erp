import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/services/auth_service.dart';
import '../../features/auth/views/login_screen.dart';
import '../../features/auth/views/forgot_password_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/admin/views/admin_dashboard_screen.dart';
import '../../features/admin/views/initial_setup_screen.dart';
import '../../features/admin/services/initial_setup_service.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final currentUser = ref.watch(currentUserProvider);
  final hasAdmins = ref.watch(hasAdminUsersProvider);
  
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      // Check if we need initial setup
      final isSetupPage = state.fullPath == '/setup';
      final needsSetup = hasAdmins.when(
        data: (hasAdmins) => !hasAdmins,
        loading: () => false,
        error: (_, __) => false,
      );
      
      // If no admins exist and not on setup page, redirect to setup
      if (needsSetup && !isSetupPage) {
        return '/setup';
      }
      
      // If admins exist and on setup page, redirect to login
      if (!needsSetup && isSetupPage) {
        return '/login';
      }
      
      // If on setup page and setup is needed, allow access
      if (isSetupPage && needsSetup) {
        return null;
      }
      
      return currentUser.when(
        data: (user) {
          final isLoggedIn = user != null;
          final isAuthPage = state.fullPath == '/login' || 
                            state.fullPath == '/forgot-password';
          final isAdminPage = state.fullPath == '/admin';
          
          if (!isLoggedIn && !isAuthPage && !isSetupPage) {
            return '/login';
          }
          
          if (isLoggedIn && isAuthPage) {
            // Redirect admins to admin dashboard, others to regular dashboard
            final isAdmin = user.role.when(
              admin: () => true,
              owner: () => false,
              manager: () => false,
              employee: () => false,
              viewer: () => false,
            );
            return isAdmin ? '/admin' : '/dashboard';
          }
          
          // Prevent non-admin users from accessing admin area
          if (isAdminPage) {
            final isAdmin = user?.role.when(
              admin: () => true,
              owner: () => false,
              manager: () => false,
              employee: () => false,
              viewer: () => false,
            ) ?? false;
            if (!isAdmin) return '/dashboard';
          }
          
          return null;
        },
        loading: () => null,
        error: (_, __) => '/login',
      );
    },
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => '/login',
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/admin',
        name: 'admin',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: '/setup',
        name: 'setup',
        builder: (context, state) => const InitialSetupScreen(),
      ),
    ],
  );
});