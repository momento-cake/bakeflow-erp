import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/services/auth_service.dart';
import '../models/user_model.dart';

/// Centralized permission service for role-based access control
///
/// This service provides a unified interface for checking permissions across all app features.
/// It handles both platform-level permissions (ERP admin/viewer) and company-level permissions.
class PermissionService {
  /// Checks if user has access to a specific feature
  bool hasFeatureAccess(UserModel user, AppFeature feature) {
    // Platform admins have access to everything
    if (user.role.isAdmin) return true;

    // Platform viewers have read-only access to most features
    if (user.role.isPlatformRole && !user.role.isAdmin) {
      return _getViewerPermissions().contains(feature);
    }

    // Company users need to be associated with a business
    if (user.businessId == null) return false;

    return _getCompanyRolePermissions(user.role).contains(feature);
  }

  /// Checks if user can perform a specific action within a feature
  bool hasActionAccess(UserModel user, AppFeature feature, FeatureAction action) {
    // First check if user has access to the feature
    if (!hasFeatureAccess(user, feature)) return false;

    // Platform admins can do everything
    if (user.role.isAdmin) return true;

    // Platform viewers can only view
    if (user.role.isPlatformRole && !user.role.isAdmin) {
      return action == FeatureAction.view;
    }

    // Check company role permissions
    return _hasCompanyActionAccess(user.role, feature, action);
  }

  /// Checks if user can manage company users
  bool canManageCompanyUsers(UserModel user) {
    return hasActionAccess(user, AppFeature.companyUsers, FeatureAction.manage);
  }

  /// Checks if user can view all companies (platform feature)
  bool canViewAllCompanies(UserModel user) {
    return user.role.isPlatformRole;
  }

  /// Checks if user can manage company settings
  bool canManageCompanySettings(UserModel user) {
    return hasActionAccess(user, AppFeature.companySettings, FeatureAction.manage);
  }

  /// Checks if user can access financial reports
  bool canAccessFinancialReports(UserModel user) {
    return hasFeatureAccess(user, AppFeature.financialReports);
  }

  /// Checks if user can manage products
  bool canManageProducts(UserModel user) {
    return hasActionAccess(user, AppFeature.products, FeatureAction.manage);
  }

  /// Checks if user can manage recipes
  bool canManageRecipes(UserModel user) {
    return hasActionAccess(user, AppFeature.recipes, FeatureAction.manage);
  }

  /// Checks if user can manage ingredients
  bool canManageIngredients(UserModel user) {
    return hasActionAccess(user, AppFeature.ingredients, FeatureAction.manage);
  }

  /// Checks if user can manage suppliers
  bool canManageSuppliers(UserModel user) {
    return hasActionAccess(user, AppFeature.suppliers, FeatureAction.manage);
  }

  /// Checks if user can manage purchases
  bool canManagePurchases(UserModel user) {
    return hasActionAccess(user, AppFeature.purchases, FeatureAction.manage);
  }

  /// Checks if user can access inventory management
  bool canAccessInventory(UserModel user) {
    return hasFeatureAccess(user, AppFeature.inventory);
  }

  /// Checks if user can manage orders
  bool canManageOrders(UserModel user) {
    return hasActionAccess(user, AppFeature.orders, FeatureAction.manage);
  }

  /// Checks if user can access pricing tools
  bool canAccessPricing(UserModel user) {
    return hasFeatureAccess(user, AppFeature.pricing);
  }

  /// Checks if user can view analytics dashboard
  bool canViewAnalytics(UserModel user) {
    return hasFeatureAccess(user, AppFeature.analytics);
  }

  /// Checks if user can manage app settings
  bool canManageAppSettings(UserModel user) {
    return hasActionAccess(user, AppFeature.appSettings, FeatureAction.manage);
  }

  /// Get features accessible to platform viewers
  Set<AppFeature> _getViewerPermissions() {
    return {
      AppFeature.dashboard,
      AppFeature.products,
      AppFeature.recipes,
      AppFeature.ingredients,
      AppFeature.suppliers,
      AppFeature.purchases,
      AppFeature.inventory,
      AppFeature.orders,
      AppFeature.pricing,
      AppFeature.analytics,
      AppFeature.financialReports,
      AppFeature.companyList,
    };
  }

  /// Get features accessible to each company role
  Set<AppFeature> _getCompanyRolePermissions(UserRole role) {
    return role.when(
      admin: () => AppFeature.values.toSet(), // Platform admin has all features
      viewer: () => _getViewerPermissions(),
      companyAdmin: () => {
        AppFeature.dashboard,
        AppFeature.products,
        AppFeature.recipes,
        AppFeature.ingredients,
        AppFeature.suppliers,
        AppFeature.purchases,
        AppFeature.inventory,
        AppFeature.orders,
        AppFeature.pricing,
        AppFeature.analytics,
        AppFeature.financialReports,
        AppFeature.companyUsers,
        AppFeature.companySettings,
        AppFeature.appSettings,
      },
      companyManager: () => {
        AppFeature.dashboard,
        AppFeature.products,
        AppFeature.recipes,
        AppFeature.ingredients,
        AppFeature.suppliers,
        AppFeature.purchases,
        AppFeature.inventory,
        AppFeature.orders,
        AppFeature.pricing,
        AppFeature.analytics,
        AppFeature.financialReports,
        AppFeature.appSettings,
      },
      companyEmployee: () => {
        AppFeature.dashboard,
        AppFeature.products,
        AppFeature.recipes,
        AppFeature.ingredients,
        AppFeature.suppliers,
        AppFeature.purchases,
        AppFeature.inventory,
        AppFeature.orders,
        AppFeature.pricing,
        AppFeature.appSettings,
      },
    );
  }

  /// Check if company role has access to specific action
  bool _hasCompanyActionAccess(UserRole role, AppFeature feature, FeatureAction action) {
    // View access - most roles can view most features
    if (action == FeatureAction.view) {
      return _getCompanyRolePermissions(role).contains(feature);
    }

    // Manage access - more restrictive
    if (action == FeatureAction.manage) {
      switch (feature) {
        case AppFeature.companyUsers:
          return role.canManageCompanyUsers;

        case AppFeature.companySettings:
          return role.canManageCompanyUsers; // Same permission as managing users

        case AppFeature.financialReports:
        case AppFeature.analytics:
          return role.canViewReports;

        default:
          // For other features, use existing permissions
          return role.canManageProducts; // Most operational features
      }
    }

    // Create access - similar to manage for most features
    if (action == FeatureAction.create) {
      return _hasCompanyActionAccess(role, feature, FeatureAction.manage);
    }

    // Edit access - similar to manage for most features
    if (action == FeatureAction.edit) {
      return _hasCompanyActionAccess(role, feature, FeatureAction.manage);
    }

    // Delete access - more restrictive than manage
    if (action == FeatureAction.delete) {
      switch (feature) {
        case AppFeature.companyUsers:
        case AppFeature.companySettings:
          return role.canManageCompanyUsers;

        default:
          // For other features, use existing permissions but maybe more restrictive
          return role.canManageProducts;
      }
    }

    return false;
  }

  /// Get all features user has access to
  Set<AppFeature> getUserFeatures(UserModel user) {
    if (user.role.isAdmin) {
      return AppFeature.values.toSet();
    }

    if (user.role.isPlatformRole && !user.role.isAdmin) {
      return _getViewerPermissions();
    }

    if (user.businessId == null) {
      return {};
    }

    return _getCompanyRolePermissions(user.role);
  }

  /// Get user's role display name
  String getRoleDisplayName(UserRole role) {
    return role.when(
      admin: () => 'Administrador da Plataforma',
      viewer: () => 'Visualizador da Plataforma',
      companyAdmin: () => 'Administrador da Empresa',
      companyManager: () => 'Gerente da Empresa',
      companyEmployee: () => 'Funcionário da Empresa',
    );
  }
}

/// Available app features
enum AppFeature {
  dashboard,
  products,
  recipes,
  ingredients,
  suppliers,
  purchases,
  inventory,
  orders,
  pricing,
  analytics,
  financialReports,
  companyUsers,
  companySettings,
  companyList,
  appSettings,
}

/// Available actions within features
enum FeatureAction {
  view,
  create,
  edit,
  delete,
  manage, // Combination of create, edit, delete
}

/// Extension for feature display names
extension AppFeatureExtension on AppFeature {
  String get displayName {
    switch (this) {
      case AppFeature.dashboard:
        return 'Painel de Controle';
      case AppFeature.products:
        return 'Produtos';
      case AppFeature.recipes:
        return 'Receitas';
      case AppFeature.ingredients:
        return 'Ingredientes';
      case AppFeature.suppliers:
        return 'Fornecedores';
      case AppFeature.purchases:
        return 'Compras';
      case AppFeature.inventory:
        return 'Estoque';
      case AppFeature.orders:
        return 'Pedidos';
      case AppFeature.pricing:
        return 'Precificação';
      case AppFeature.analytics:
        return 'Análises';
      case AppFeature.financialReports:
        return 'Relatórios Financeiros';
      case AppFeature.companyUsers:
        return 'Usuários da Empresa';
      case AppFeature.companySettings:
        return 'Configurações da Empresa';
      case AppFeature.companyList:
        return 'Lista de Empresas';
      case AppFeature.appSettings:
        return 'Configurações do App';
    }
  }
}

/// Provider for permission service
final permissionServiceProvider = Provider<PermissionService>((ref) {
  return PermissionService();
});

/// Provider that combines current user with permission service
final userPermissionsProvider = Provider<AsyncValue<UserPermissions?>>((ref) {
  final currentUser = ref.watch(currentUserProvider);
  final permissionService = ref.watch(permissionServiceProvider);

  if (currentUser == null) {
    return const AsyncValue.data(null);
  }

  final firestoreUser = ref.watch(firestoreUserProvider(currentUser.uid));

  return firestoreUser.when(
    data: (userData) =>
        AsyncValue.data(userData != null ? UserPermissions(userData, permissionService) : null),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Provider for current user permissions (unwrapped)
final currentUserPermissionsProvider = Provider<UserPermissions?>((ref) {
  final permissionsAsync = ref.watch(userPermissionsProvider);
  return permissionsAsync.when(
    data: (permissions) => permissions,
    loading: () => null,
    error: (_, __) => null,
  );
});

/// Helper class that combines user data with permission checking
class UserPermissions {
  final UserModel user;
  final PermissionService _permissionService;

  UserPermissions(this.user, this._permissionService);

  /// Check if user has access to a feature
  bool hasFeatureAccess(AppFeature feature) {
    return _permissionService.hasFeatureAccess(user, feature);
  }

  /// Check if user can perform an action
  bool hasActionAccess(AppFeature feature, FeatureAction action) {
    return _permissionService.hasActionAccess(user, feature, action);
  }

  /// Get all features user has access to
  Set<AppFeature> get userFeatures {
    return _permissionService.getUserFeatures(user);
  }

  /// Get role display name
  String get roleDisplayName {
    return _permissionService.getRoleDisplayName(user.role);
  }

  /// Quick access methods
  bool get canManageCompanyUsers => _permissionService.canManageCompanyUsers(user);
  bool get canViewAllCompanies => _permissionService.canViewAllCompanies(user);
  bool get canManageCompanySettings => _permissionService.canManageCompanySettings(user);
  bool get canAccessFinancialReports => _permissionService.canAccessFinancialReports(user);
  bool get canManageProducts => _permissionService.canManageProducts(user);
  bool get canManageRecipes => _permissionService.canManageRecipes(user);
  bool get canManageIngredients => _permissionService.canManageIngredients(user);
  bool get canManageSuppliers => _permissionService.canManageSuppliers(user);
  bool get canManagePurchases => _permissionService.canManagePurchases(user);
  bool get canAccessInventory => _permissionService.canAccessInventory(user);
  bool get canManageOrders => _permissionService.canManageOrders(user);
  bool get canAccessPricing => _permissionService.canAccessPricing(user);
  bool get canViewAnalytics => _permissionService.canViewAnalytics(user);
  bool get canManageAppSettings => _permissionService.canManageAppSettings(user);
}
