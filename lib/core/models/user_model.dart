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
  const factory UserRole.owner() = _Owner;
  const factory UserRole.manager() = _Manager;
  const factory UserRole.employee() = _Employee;
  const factory UserRole.viewer() = _Viewer;

  factory UserRole.fromJson(Map<String, dynamic> json) =>
      _$UserRoleFromJson(json);

  static UserRole fromString(String value) {
    switch (value.toLowerCase()) {
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
}

extension UserRoleExtension on UserRole {
  String get name => when(
        owner: () => 'owner',
        manager: () => 'manager',
        employee: () => 'employee',
        viewer: () => 'viewer',
      );

  String get displayName => when(
        owner: () => 'Proprietário',
        manager: () => 'Gerente',
        employee: () => 'Funcionário',
        viewer: () => 'Visualizador',
      );

  bool get canManageUsers => when(
        owner: () => true,
        manager: () => true,
        employee: () => false,
        viewer: () => false,
      );

  bool get canManageProducts => when(
        owner: () => true,
        manager: () => true,
        employee: () => true,
        viewer: () => false,
      );

  bool get canViewReports => when(
        owner: () => true,
        manager: () => true,
        employee: () => false,
        viewer: () => true,
      );
}