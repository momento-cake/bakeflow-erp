import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/services/auth_service.dart';
import '../../features/auth/views/login_screen.dart';
import '../../features/auth/views/register_screen.dart';
import '../../features/auth/views/forgot_password_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      return authState.when(
        data: (user) {
          final isLoggedIn = user != null;
          final isAuthPage = state.fullPath == '/login' || 
                            state.fullPath == '/register' || 
                            state.fullPath == '/forgot-password';
          
          if (!isLoggedIn && !isAuthPage) {
            return '/login';
          }
          
          if (isLoggedIn && isAuthPage) {
            return '/dashboard';
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
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
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
    ],
  );
});