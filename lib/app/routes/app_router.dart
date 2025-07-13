import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/services/auth_service.dart';
import '../../features/auth/views/forgot_password_screen.dart';
import '../../features/auth/views/login_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/dashboard/admin_dashboard_screen.dart';
import '../../features/admin/views/admin_users_screen.dart';
import '../../features/admin/views/create_user_screen.dart';
import '../../features/admin/views/initial_setup_screen.dart';
import '../../features/admin/services/initial_setup_service.dart';
import '../../features/admin/companies/presentation/screens/companies_screen.dart';
import '../../features/admin/companies/presentation/screens/create_company_screen.dart';
import '../../features/admin/companies/presentation/screens/company_details_screen.dart';
import '../../features/admin/companies/presentation/screens/create_company_user_screen.dart';
import '../../features/admin/companies/presentation/screens/company_user_details_screen.dart';

// Custom page transition that slides from bottom for modal-like screens
Page<T> _modalPageBuilder<T extends Object?>(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const curve = Curves.easeInOutCubic;

      // Primary animation: slide up from bottom (forward navigation)
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;

      var slideAnimation = animation.drive(
        Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        ),
      );

      var fadeAnimation = animation.drive(
        Tween(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: curve),
        ),
      );

      return FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: child,
        ),
      );
    },
  );
}

final routerProvider = Provider<GoRouter>((ref) {
  final basicUser = ref.watch(currentUserProvider);
  final hasAdmins = ref.watch(hasAdminUsersProvider);

  // Get the full user data from Firestore for accurate role checking
  final firestoreUser = basicUser != null
      ? ref.watch(firestoreUserProvider(basicUser.uid))
      : const AsyncValue.data(null);

  final currentUser = firestoreUser.when(
    data: (user) => user ?? basicUser,
    loading: () => basicUser,
    error: (_, __) => basicUser,
  );

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      // Check if we need initial setup
      final isSetupPage = state.fullPath == '/setup';
      final isLoggedIn = currentUser != null;
      final isAuthPage = state.fullPath == '/login' || state.fullPath == '/forgot-password';

      final needsSetup = hasAdmins.when(
        data: (hasAdmins) => !hasAdmins,
        loading: () => null, // Return null during loading to prevent redirect
        error: (_, __) => false,
      );

      // CRITICAL FIX: If an admin user is already logged in, 
      // never redirect to setup regardless of the hasAdmins check result
      if (isLoggedIn) {
        // Check if logged in user is admin by examining their role
        final isAdminUser = currentUser.role.when(
          admin: () => true,
          viewer: () => false,
          companyAdmin: () => false,
          companyManager: () => false,
          companyEmployee: () => false,
          // Legacy support
          owner: () => false,
          manager: () => false,
          employee: () => false,
        );

        // If logged in as admin and on setup page, redirect to admin dashboard
        if (isAdminUser && isSetupPage) {
          return '/admin/dashboard';
        }

        // Normal logged-in user redirects based on role
        if (isAuthPage) {
          return isAdminUser ? '/admin/dashboard' : '/dashboard';
        }

        // Redirect to appropriate dashboard if on root
        if (state.fullPath == '/') {
          return isAdminUser ? '/admin/dashboard' : '/dashboard';
        }

        // Prevent non-admin users from accessing admin routes
        if (state.fullPath?.startsWith('/admin') == true && !isAdminUser) {
          return '/dashboard';
        }

        return null; // Allow access to other pages when logged in
      }

      // If still loading admin check, prevent any redirects
      if (needsSetup == null) {
        return null;
      }

      // If no admins exist and not on setup page, redirect to setup
      if (needsSetup == true && !isSetupPage) {
        return '/setup';
      }

      // If admins exist and on setup page, redirect to login
      if (needsSetup == false && isSetupPage) {
        return '/login';
      }

      // If on setup page and setup is needed, allow access
      if (isSetupPage && needsSetup == true) {
        return null;
      }

      // Handle non-logged-in users
      if (!isLoggedIn && !isAuthPage && !isSetupPage) {
        return '/login';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardScreen(),
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
        path: '/admin/dashboard',
        name: 'admin-dashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: '/company/:id/dashboard',
        name: 'company-dashboard',
        builder: (context, state) {
          final companyId = state.pathParameters['id']!;
          return DashboardScreen(companyId: companyId);
        },
      ),
      GoRoute(
        path: '/admin/users',
        name: 'admin-users',
        builder: (context, state) => const AdminUsersScreen(),
      ),
      GoRoute(
        path: '/admin/users/create',
        name: 'admin-users-create',
        pageBuilder: (context, state) => _modalPageBuilder(
          context,
          state,
          const CreateUserScreen(),
        ),
      ),
      // Companies routes
      GoRoute(
        path: '/admin/companies',
        name: 'admin-companies',
        builder: (context, state) => const CompaniesScreen(),
      ),
      GoRoute(
        path: '/admin/companies/create',
        name: 'admin-companies-create',
        builder: (context, state) => const CreateCompanyScreen(),
      ),
      GoRoute(
        path: '/admin/companies/:id',
        name: 'admin-company-details',
        builder: (context, state) {
          final companyId = state.pathParameters['id']!;
          final initialTab = state.uri.queryParameters['tab'];
          return CompanyDetailsScreen(
            companyId: companyId,
            initialTab: initialTab,
          );
        },
      ),
      GoRoute(
        path: '/admin/companies/:id/users/create',
        name: 'admin-create-company-user',
        builder: (context, state) {
          final companyId = state.pathParameters['id']!;
          return CreateCompanyUserScreen(companyId: companyId);
        },
      ),
      GoRoute(
        path: '/admin/companies/:id/users/:userId',
        name: 'admin-company-user-details',
        builder: (context, state) {
          final companyId = state.pathParameters['id']!;
          final userId = state.pathParameters['userId']!;
          return CompanyUserDetailsScreen(companyId: companyId, userId: userId);
        },
      ),
      GoRoute(
        path: '/setup',
        name: 'setup',
        builder: (context, state) => const InitialSetupScreen(),
      ),
    ],
  );
});
