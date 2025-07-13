import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    required String email,
    String? displayName,
    String? photoURL,
    required bool emailVerified,
    String? businessId,
    @Default(UserRole.owner()) UserRole role,
    DateTime? createdAt,
    DateTime? lastSignInAt,
    @Default(true) bool isActive,
    @Default({}) Map<String, dynamic> metadata,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoURL: user.photoURL,
      emailVerified: user.emailVerified,
      businessId: null, // Set during business context setup
      role: const UserRole.owner(), // Default role
      createdAt: user.metadata.creationTime,
      lastSignInAt: user.metadata.lastSignInTime,
      isActive: true,
      metadata: const {},
    );
  }
}

@freezed
class UserRole with _$UserRole {
  const UserRole._();
  
  // Platform roles
  const factory UserRole.admin() = _Admin;
  const factory UserRole.viewer() = _Viewer;
  
  // Company roles  
  const factory UserRole.companyAdmin() = _CompanyAdmin;
  const factory UserRole.companyManager() = _CompanyManager;
  const factory UserRole.companyEmployee() = _CompanyEmployee;
  
  // Legacy roles (for backward compatibility)
  const factory UserRole.owner() = _Owner;
  const factory UserRole.manager() = _Manager;
  const factory UserRole.employee() = _Employee;

  factory UserRole.fromJson(Map<String, dynamic> json) {
    // Handle Firestore format where role is stored as {type: "admin"}
    if (json.containsKey('type')) {
      return UserRole.fromString(json['type'] as String);
    }
    // Handle Freezed format where role is stored as {runtimeType: "admin"}
    if (json.containsKey('runtimeType')) {
      return UserRole.fromString(json['runtimeType'] as String);
    }
    // Default to employee if no valid format found
    return const UserRole.employee();
  }

  static UserRole fromString(String value) {
    switch (value.toLowerCase()) {
      case 'admin':
        return const UserRole.admin();
      case 'viewer':
        return const UserRole.viewer();
      case 'companyadmin':
      case 'company_admin':
        return const UserRole.companyAdmin();
      case 'companymanager':
      case 'company_manager':
        return const UserRole.companyManager();
      case 'companyemployee':
      case 'company_employee':
        return const UserRole.companyEmployee();
      // Legacy support
      case 'owner':
        return const UserRole.owner();
      case 'manager':
        return const UserRole.manager();
      case 'employee':
        return const UserRole.employee();
      default:
        return const UserRole.companyEmployee();
    }
  }
  
  // Custom toJson to match Firestore format
  Map<String, dynamic> toJson() => {
    'type': name,
  };
}

extension UserRoleExtension on UserRole {
  String get name => when(
        admin: () => 'admin',
        viewer: () => 'viewer',
        companyAdmin: () => 'company_admin',
        companyManager: () => 'company_manager',
        companyEmployee: () => 'company_employee',
        // Legacy support
        owner: () => 'owner',
        manager: () => 'manager',
        employee: () => 'employee',
      );

  bool get isAdmin => when(
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

  bool get isPlatformRole => when(
        admin: () => true,
        viewer: () => true,
        companyAdmin: () => false,
        companyManager: () => false,
        companyEmployee: () => false,
        // Legacy support
        owner: () => false,
        manager: () => false,
        employee: () => false,
      );

  bool get canManageUsers => when(
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

  bool get canViewCompanies => when(
        admin: () => true,
        viewer: () => true,
        companyAdmin: () => false,
        companyManager: () => false,
        companyEmployee: () => false,
        // Legacy support
        owner: () => false,
        manager: () => false,
        employee: () => false,
      );

  bool get canManageCompanies => when(
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

  bool get canResetPasswords => when(
        admin: () => true,
        viewer: () => false,
        companyAdmin: () => true,
        companyManager: () => false,
        companyEmployee: () => false,
        // Legacy support
        owner: () => false,
        manager: () => false,
        employee: () => false,
      );

  bool get canCreateAccounts => when(
        admin: () => true,
        viewer: () => false,
        companyAdmin: () => true,
        companyManager: () => false,
        companyEmployee: () => false,
        // Legacy support
        owner: () => false,
        manager: () => false,
        employee: () => false,
      );

  bool get canManageCompanyUsers => when(
        admin: () => true, // ERP admin has unlimited access
        viewer: () => false,
        companyAdmin: () => true, // Only Admin da Empresa can manage company users
        companyManager: () => false, // Gerente MUST NOT have access to managing users
        companyEmployee: () => false,
        // Legacy support
        owner: () => true,
        manager: () => false,
        employee: () => false,
      );

  String get displayName => when(
        admin: () => 'Administrador',
        viewer: () => 'Visualizador',
        companyAdmin: () => 'Admin da Empresa',
        companyManager: () => 'Gerente',
        companyEmployee: () => 'Funcionário',
        // Legacy support
        owner: () => 'Proprietário',
        manager: () => 'Gerente',
        employee: () => 'Funcionário',
      );

  bool get canManageProducts => when(
        admin: () => true,
        viewer: () => false,
        companyAdmin: () => true,
        companyManager: () => true,
        companyEmployee: () => true,
        // Legacy support
        owner: () => true,
        manager: () => true,
        employee: () => true,
      );

  bool get canViewReports => when(
        admin: () => true,
        viewer: () => true,
        companyAdmin: () => true,
        companyManager: () => true,
        companyEmployee: () => false,
        // Legacy support
        owner: () => true,
        manager: () => true,
        employee: () => false,
      );
}

extension UserModelExtension on UserModel {
  bool get isInitialAdmin => metadata['isInitialAdmin'] == true;
  
  bool get canDeleteAdmins => role.isAdmin && isInitialAdmin;
  
  bool get canBeDeleted => role.isAdmin ? !isInitialAdmin : true;
  
  bool get canManageOtherAdmins => role.isAdmin && isInitialAdmin;
  
  String get roleDisplayName {
    if (role.isAdmin && isInitialAdmin) {
      return '${role.displayName} (Master)';
    }
    return role.displayName;
  }
}