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
  
  const factory UserRole.admin() = _Admin;
  const factory UserRole.owner() = _Owner;
  const factory UserRole.manager() = _Manager;
  const factory UserRole.employee() = _Employee;
  const factory UserRole.viewer() = _Viewer;

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
      case 'owner':
        return const UserRole.owner();
      case 'manager':
        return const UserRole.manager();
      case 'employee':
        return const UserRole.employee();
      case 'viewer':
        return const UserRole.viewer();
      default:
        return const UserRole.employee();
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
        owner: () => 'owner',
        manager: () => 'manager',
        employee: () => 'employee',
        viewer: () => 'viewer',
      );

  bool get isAdmin => when(
        admin: () => true,
        owner: () => false,
        manager: () => false,
        employee: () => false,
        viewer: () => false,
      );

  bool get canManageUsers => when(
        admin: () => true,
        owner: () => false,
        manager: () => false,
        employee: () => false,
        viewer: () => false,
      );

  bool get canManageCompanies => when(
        admin: () => true,
        owner: () => false,
        manager: () => false,
        employee: () => false,
        viewer: () => false,
      );

  bool get canResetPasswords => when(
        admin: () => true,
        owner: () => false,
        manager: () => false,
        employee: () => false,
        viewer: () => false,
      );

  bool get canCreateAccounts => when(
        admin: () => true,
        owner: () => false,
        manager: () => false,
        employee: () => false,
        viewer: () => false,
      );

  String get displayName => when(
        admin: () => 'Administrador',
        owner: () => 'Proprietário',
        manager: () => 'Gerente',
        employee: () => 'Funcionário',
        viewer: () => 'Visualizador',
      );

  bool get canManageProducts => when(
        admin: () => true,
        owner: () => true,
        manager: () => true,
        employee: () => true,
        viewer: () => false,
      );

  bool get canViewReports => when(
        admin: () => true,
        owner: () => true,
        manager: () => true,
        employee: () => false,
        viewer: () => true,
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