import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_model.dart';

part 'company_user_model.freezed.dart';
part 'company_user_model.g.dart';

@freezed
class CompanyUser with _$CompanyUser {
  const factory CompanyUser({
    required String id,
    required String businessId,
    required String email,
    required String name,
    String? phone,
    @Default(UserRole.companyEmployee()) UserRole role,
    @Default(true) bool isActive,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? lastLogin,
    required String createdBy, // Admin user ID who created this user
    @Default({}) Map<String, dynamic> metadata,
  }) = _CompanyUser;

  factory CompanyUser.fromJson(Map<String, dynamic> json) =>
      _$CompanyUserFromJson(json);
}

extension CompanyUserExtension on CompanyUser {
  bool get canManageOtherUsers => role.canManageCompanyUsers && isActive;
  
  bool get canBeDeleted => role != const UserRole.companyAdmin() || metadata['canBeDeleted'] == true;
  
  String get roleDisplayName => role.displayName;
  
  String get initials {
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else if (words.isNotEmpty) {
      return words[0].substring(0, 1).toUpperCase();
    }
    return 'U';
  }
  
  String get statusDisplayName => isActive ? 'Ativo' : 'Inativo';
}