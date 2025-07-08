// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      emailVerified: json['emailVerified'] as bool,
      businessId: json['businessId'] as String?,
      role: json['role'] == null
          ? const UserRole.owner()
          : UserRole.fromJson(json['role'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastSignInAt: json['lastSignInAt'] == null
          ? null
          : DateTime.parse(json['lastSignInAt'] as String),
      isActive: json['isActive'] as bool? ?? true,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
      'emailVerified': instance.emailVerified,
      'businessId': instance.businessId,
      'role': instance.role,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastSignInAt': instance.lastSignInAt?.toIso8601String(),
      'isActive': instance.isActive,
      'metadata': instance.metadata,
    };

_$OwnerImpl _$$OwnerImplFromJson(Map<String, dynamic> json) => _$OwnerImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$OwnerImplToJson(_$OwnerImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ManagerImpl _$$ManagerImplFromJson(Map<String, dynamic> json) =>
    _$ManagerImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ManagerImplToJson(_$ManagerImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$EmployeeImpl _$$EmployeeImplFromJson(Map<String, dynamic> json) =>
    _$EmployeeImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$EmployeeImplToJson(_$EmployeeImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ViewerImpl _$$ViewerImplFromJson(Map<String, dynamic> json) => _$ViewerImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ViewerImplToJson(_$ViewerImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };
