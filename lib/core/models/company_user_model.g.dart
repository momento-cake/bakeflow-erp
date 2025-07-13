// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyUserImpl _$$CompanyUserImplFromJson(Map<String, dynamic> json) =>
    _$CompanyUserImpl(
      id: json['id'] as String,
      businessId: json['businessId'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      role: json['role'] == null
          ? const UserRole.companyEmployee()
          : UserRole.fromJson(json['role'] as Map<String, dynamic>),
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      lastLogin: json['lastLogin'] == null
          ? null
          : DateTime.parse(json['lastLogin'] as String),
      createdBy: json['createdBy'] as String,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$CompanyUserImplToJson(_$CompanyUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'businessId': instance.businessId,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'role': instance.role,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'lastLogin': instance.lastLogin?.toIso8601String(),
      'createdBy': instance.createdBy,
      'metadata': instance.metadata,
    };
