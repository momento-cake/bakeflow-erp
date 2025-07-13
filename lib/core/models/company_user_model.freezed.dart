// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompanyUser _$CompanyUserFromJson(Map<String, dynamic> json) {
  return _CompanyUser.fromJson(json);
}

/// @nodoc
mixin _$CompanyUser {
  String get id => throw _privateConstructorUsedError;
  String get businessId => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  UserRole get role => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get lastLogin => throw _privateConstructorUsedError;
  String get createdBy =>
      throw _privateConstructorUsedError; // Admin user ID who created this user
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this CompanyUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompanyUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompanyUserCopyWith<CompanyUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyUserCopyWith<$Res> {
  factory $CompanyUserCopyWith(
          CompanyUser value, $Res Function(CompanyUser) then) =
      _$CompanyUserCopyWithImpl<$Res, CompanyUser>;
  @useResult
  $Res call(
      {String id,
      String businessId,
      String email,
      String name,
      String? phone,
      UserRole role,
      bool isActive,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? lastLogin,
      String createdBy,
      Map<String, dynamic> metadata});

  $UserRoleCopyWith<$Res> get role;
}

/// @nodoc
class _$CompanyUserCopyWithImpl<$Res, $Val extends CompanyUser>
    implements $CompanyUserCopyWith<$Res> {
  _$CompanyUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompanyUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? email = null,
    Object? name = null,
    Object? phone = freezed,
    Object? role = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? lastLogin = freezed,
    Object? createdBy = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  /// Create a copy of CompanyUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserRoleCopyWith<$Res> get role {
    return $UserRoleCopyWith<$Res>(_value.role, (value) {
      return _then(_value.copyWith(role: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CompanyUserImplCopyWith<$Res>
    implements $CompanyUserCopyWith<$Res> {
  factory _$$CompanyUserImplCopyWith(
          _$CompanyUserImpl value, $Res Function(_$CompanyUserImpl) then) =
      __$$CompanyUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String businessId,
      String email,
      String name,
      String? phone,
      UserRole role,
      bool isActive,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? lastLogin,
      String createdBy,
      Map<String, dynamic> metadata});

  @override
  $UserRoleCopyWith<$Res> get role;
}

/// @nodoc
class __$$CompanyUserImplCopyWithImpl<$Res>
    extends _$CompanyUserCopyWithImpl<$Res, _$CompanyUserImpl>
    implements _$$CompanyUserImplCopyWith<$Res> {
  __$$CompanyUserImplCopyWithImpl(
      _$CompanyUserImpl _value, $Res Function(_$CompanyUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompanyUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? email = null,
    Object? name = null,
    Object? phone = freezed,
    Object? role = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? lastLogin = freezed,
    Object? createdBy = null,
    Object? metadata = null,
  }) {
    return _then(_$CompanyUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompanyUserImpl implements _CompanyUser {
  const _$CompanyUserImpl(
      {required this.id,
      required this.businessId,
      required this.email,
      required this.name,
      this.phone,
      this.role = const UserRole.companyEmployee(),
      this.isActive = true,
      required this.createdAt,
      this.updatedAt,
      this.lastLogin,
      required this.createdBy,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata;

  factory _$CompanyUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyUserImplFromJson(json);

  @override
  final String id;
  @override
  final String businessId;
  @override
  final String email;
  @override
  final String name;
  @override
  final String? phone;
  @override
  @JsonKey()
  final UserRole role;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? lastLogin;
  @override
  final String createdBy;
// Admin user ID who created this user
  final Map<String, dynamic> _metadata;
// Admin user ID who created this user
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'CompanyUser(id: $id, businessId: $businessId, email: $email, name: $name, phone: $phone, role: $role, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, lastLogin: $lastLogin, createdBy: $createdBy, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastLogin, lastLogin) ||
                other.lastLogin == lastLogin) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      businessId,
      email,
      name,
      phone,
      role,
      isActive,
      createdAt,
      updatedAt,
      lastLogin,
      createdBy,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of CompanyUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyUserImplCopyWith<_$CompanyUserImpl> get copyWith =>
      __$$CompanyUserImplCopyWithImpl<_$CompanyUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyUserImplToJson(
      this,
    );
  }
}

abstract class _CompanyUser implements CompanyUser {
  const factory _CompanyUser(
      {required final String id,
      required final String businessId,
      required final String email,
      required final String name,
      final String? phone,
      final UserRole role,
      final bool isActive,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final DateTime? lastLogin,
      required final String createdBy,
      final Map<String, dynamic> metadata}) = _$CompanyUserImpl;

  factory _CompanyUser.fromJson(Map<String, dynamic> json) =
      _$CompanyUserImpl.fromJson;

  @override
  String get id;
  @override
  String get businessId;
  @override
  String get email;
  @override
  String get name;
  @override
  String? get phone;
  @override
  UserRole get role;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get lastLogin;
  @override
  String get createdBy; // Admin user ID who created this user
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of CompanyUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompanyUserImplCopyWith<_$CompanyUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
