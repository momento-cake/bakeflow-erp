// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get uid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;
  bool get emailVerified => throw _privateConstructorUsedError;
  String? get businessId => throw _privateConstructorUsedError;
  UserRole get role => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastSignInAt => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String uid,
      String email,
      String? displayName,
      String? photoURL,
      bool emailVerified,
      String? businessId,
      UserRole role,
      DateTime? createdAt,
      DateTime? lastSignInAt,
      bool isActive,
      Map<String, dynamic> metadata});

  $UserRoleCopyWith<$Res> get role;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? photoURL = freezed,
    Object? emailVerified = null,
    Object? businessId = freezed,
    Object? role = null,
    Object? createdAt = freezed,
    Object? lastSignInAt = freezed,
    Object? isActive = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      businessId: freezed == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSignInAt: freezed == lastSignInAt
          ? _value.lastSignInAt
          : lastSignInAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  /// Create a copy of UserModel
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
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String email,
      String? displayName,
      String? photoURL,
      bool emailVerified,
      String? businessId,
      UserRole role,
      DateTime? createdAt,
      DateTime? lastSignInAt,
      bool isActive,
      Map<String, dynamic> metadata});

  @override
  $UserRoleCopyWith<$Res> get role;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? photoURL = freezed,
    Object? emailVerified = null,
    Object? businessId = freezed,
    Object? role = null,
    Object? createdAt = freezed,
    Object? lastSignInAt = freezed,
    Object? isActive = null,
    Object? metadata = null,
  }) {
    return _then(_$UserModelImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      businessId: freezed == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSignInAt: freezed == lastSignInAt
          ? _value.lastSignInAt
          : lastSignInAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.uid,
      required this.email,
      this.displayName,
      this.photoURL,
      required this.emailVerified,
      this.businessId,
      this.role = const UserRole.owner(),
      this.createdAt,
      this.lastSignInAt,
      this.isActive = true,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String uid;
  @override
  final String email;
  @override
  final String? displayName;
  @override
  final String? photoURL;
  @override
  final bool emailVerified;
  @override
  final String? businessId;
  @override
  @JsonKey()
  final UserRole role;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastSignInAt;
  @override
  @JsonKey()
  final bool isActive;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, displayName: $displayName, photoURL: $photoURL, emailVerified: $emailVerified, businessId: $businessId, role: $role, createdAt: $createdAt, lastSignInAt: $lastSignInAt, isActive: $isActive, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL) &&
            (identical(other.emailVerified, emailVerified) ||
                other.emailVerified == emailVerified) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastSignInAt, lastSignInAt) ||
                other.lastSignInAt == lastSignInAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      email,
      displayName,
      photoURL,
      emailVerified,
      businessId,
      role,
      createdAt,
      lastSignInAt,
      isActive,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String uid,
      required final String email,
      final String? displayName,
      final String? photoURL,
      required final bool emailVerified,
      final String? businessId,
      final UserRole role,
      final DateTime? createdAt,
      final DateTime? lastSignInAt,
      final bool isActive,
      final Map<String, dynamic> metadata}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get uid;
  @override
  String get email;
  @override
  String? get displayName;
  @override
  String? get photoURL;
  @override
  bool get emailVerified;
  @override
  String? get businessId;
  @override
  UserRole get role;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get lastSignInAt;
  @override
  bool get isActive;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserRole {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() admin,
    required TResult Function() viewer,
    required TResult Function() companyAdmin,
    required TResult Function() companyManager,
    required TResult Function() companyEmployee,
    required TResult Function() owner,
    required TResult Function() manager,
    required TResult Function() employee,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? admin,
    TResult? Function()? viewer,
    TResult? Function()? companyAdmin,
    TResult? Function()? companyManager,
    TResult? Function()? companyEmployee,
    TResult? Function()? owner,
    TResult? Function()? manager,
    TResult? Function()? employee,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? admin,
    TResult Function()? viewer,
    TResult Function()? companyAdmin,
    TResult Function()? companyManager,
    TResult Function()? companyEmployee,
    TResult Function()? owner,
    TResult Function()? manager,
    TResult Function()? employee,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Admin value) admin,
    required TResult Function(_Viewer value) viewer,
    required TResult Function(_CompanyAdmin value) companyAdmin,
    required TResult Function(_CompanyManager value) companyManager,
    required TResult Function(_CompanyEmployee value) companyEmployee,
    required TResult Function(_Owner value) owner,
    required TResult Function(_Manager value) manager,
    required TResult Function(_Employee value) employee,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Admin value)? admin,
    TResult? Function(_Viewer value)? viewer,
    TResult? Function(_CompanyAdmin value)? companyAdmin,
    TResult? Function(_CompanyManager value)? companyManager,
    TResult? Function(_CompanyEmployee value)? companyEmployee,
    TResult? Function(_Owner value)? owner,
    TResult? Function(_Manager value)? manager,
    TResult? Function(_Employee value)? employee,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Admin value)? admin,
    TResult Function(_Viewer value)? viewer,
    TResult Function(_CompanyAdmin value)? companyAdmin,
    TResult Function(_CompanyManager value)? companyManager,
    TResult Function(_CompanyEmployee value)? companyEmployee,
    TResult Function(_Owner value)? owner,
    TResult Function(_Manager value)? manager,
    TResult Function(_Employee value)? employee,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRoleCopyWith<$Res> {
  factory $UserRoleCopyWith(UserRole value, $Res Function(UserRole) then) =
      _$UserRoleCopyWithImpl<$Res, UserRole>;
}

/// @nodoc
class _$UserRoleCopyWithImpl<$Res, $Val extends UserRole>
    implements $UserRoleCopyWith<$Res> {
  _$UserRoleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserRole
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AdminImplCopyWith<$Res> {
  factory _$$AdminImplCopyWith(
          _$AdminImpl value, $Res Function(_$AdminImpl) then) =
      __$$AdminImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AdminImplCopyWithImpl<$Res>
    extends _$UserRoleCopyWithImpl<$Res, _$AdminImpl>
    implements _$$AdminImplCopyWith<$Res> {
  __$$AdminImplCopyWithImpl(
      _$AdminImpl _value, $Res Function(_$AdminImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRole
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AdminImpl extends _Admin {
  const _$AdminImpl() : super._();

  @override
  String toString() {
    return 'UserRole.admin()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AdminImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() admin,
    required TResult Function() viewer,
    required TResult Function() companyAdmin,
    required TResult Function() companyManager,
    required TResult Function() companyEmployee,
    required TResult Function() owner,
    required TResult Function() manager,
    required TResult Function() employee,
  }) {
    return admin();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? admin,
    TResult? Function()? viewer,
    TResult? Function()? companyAdmin,
    TResult? Function()? companyManager,
    TResult? Function()? companyEmployee,
    TResult? Function()? owner,
    TResult? Function()? manager,
    TResult? Function()? employee,
  }) {
    return admin?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? admin,
    TResult Function()? viewer,
    TResult Function()? companyAdmin,
    TResult Function()? companyManager,
    TResult Function()? companyEmployee,
    TResult Function()? owner,
    TResult Function()? manager,
    TResult Function()? employee,
    required TResult orElse(),
  }) {
    if (admin != null) {
      return admin();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Admin value) admin,
    required TResult Function(_Viewer value) viewer,
    required TResult Function(_CompanyAdmin value) companyAdmin,
    required TResult Function(_CompanyManager value) companyManager,
    required TResult Function(_CompanyEmployee value) companyEmployee,
    required TResult Function(_Owner value) owner,
    required TResult Function(_Manager value) manager,
    required TResult Function(_Employee value) employee,
  }) {
    return admin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Admin value)? admin,
    TResult? Function(_Viewer value)? viewer,
    TResult? Function(_CompanyAdmin value)? companyAdmin,
    TResult? Function(_CompanyManager value)? companyManager,
    TResult? Function(_CompanyEmployee value)? companyEmployee,
    TResult? Function(_Owner value)? owner,
    TResult? Function(_Manager value)? manager,
    TResult? Function(_Employee value)? employee,
  }) {
    return admin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Admin value)? admin,
    TResult Function(_Viewer value)? viewer,
    TResult Function(_CompanyAdmin value)? companyAdmin,
    TResult Function(_CompanyManager value)? companyManager,
    TResult Function(_CompanyEmployee value)? companyEmployee,
    TResult Function(_Owner value)? owner,
    TResult Function(_Manager value)? manager,
    TResult Function(_Employee value)? employee,
    required TResult orElse(),
  }) {
    if (admin != null) {
      return admin(this);
    }
    return orElse();
  }
}

abstract class _Admin extends UserRole {
  const factory _Admin() = _$AdminImpl;
  const _Admin._() : super._();
}

/// @nodoc
abstract class _$$ViewerImplCopyWith<$Res> {
  factory _$$ViewerImplCopyWith(
          _$ViewerImpl value, $Res Function(_$ViewerImpl) then) =
      __$$ViewerImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ViewerImplCopyWithImpl<$Res>
    extends _$UserRoleCopyWithImpl<$Res, _$ViewerImpl>
    implements _$$ViewerImplCopyWith<$Res> {
  __$$ViewerImplCopyWithImpl(
      _$ViewerImpl _value, $Res Function(_$ViewerImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRole
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ViewerImpl extends _Viewer {
  const _$ViewerImpl() : super._();

  @override
  String toString() {
    return 'UserRole.viewer()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ViewerImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() admin,
    required TResult Function() viewer,
    required TResult Function() companyAdmin,
    required TResult Function() companyManager,
    required TResult Function() companyEmployee,
    required TResult Function() owner,
    required TResult Function() manager,
    required TResult Function() employee,
  }) {
    return viewer();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? admin,
    TResult? Function()? viewer,
    TResult? Function()? companyAdmin,
    TResult? Function()? companyManager,
    TResult? Function()? companyEmployee,
    TResult? Function()? owner,
    TResult? Function()? manager,
    TResult? Function()? employee,
  }) {
    return viewer?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? admin,
    TResult Function()? viewer,
    TResult Function()? companyAdmin,
    TResult Function()? companyManager,
    TResult Function()? companyEmployee,
    TResult Function()? owner,
    TResult Function()? manager,
    TResult Function()? employee,
    required TResult orElse(),
  }) {
    if (viewer != null) {
      return viewer();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Admin value) admin,
    required TResult Function(_Viewer value) viewer,
    required TResult Function(_CompanyAdmin value) companyAdmin,
    required TResult Function(_CompanyManager value) companyManager,
    required TResult Function(_CompanyEmployee value) companyEmployee,
    required TResult Function(_Owner value) owner,
    required TResult Function(_Manager value) manager,
    required TResult Function(_Employee value) employee,
  }) {
    return viewer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Admin value)? admin,
    TResult? Function(_Viewer value)? viewer,
    TResult? Function(_CompanyAdmin value)? companyAdmin,
    TResult? Function(_CompanyManager value)? companyManager,
    TResult? Function(_CompanyEmployee value)? companyEmployee,
    TResult? Function(_Owner value)? owner,
    TResult? Function(_Manager value)? manager,
    TResult? Function(_Employee value)? employee,
  }) {
    return viewer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Admin value)? admin,
    TResult Function(_Viewer value)? viewer,
    TResult Function(_CompanyAdmin value)? companyAdmin,
    TResult Function(_CompanyManager value)? companyManager,
    TResult Function(_CompanyEmployee value)? companyEmployee,
    TResult Function(_Owner value)? owner,
    TResult Function(_Manager value)? manager,
    TResult Function(_Employee value)? employee,
    required TResult orElse(),
  }) {
    if (viewer != null) {
      return viewer(this);
    }
    return orElse();
  }
}

abstract class _Viewer extends UserRole {
  const factory _Viewer() = _$ViewerImpl;
  const _Viewer._() : super._();
}

/// @nodoc
abstract class _$$CompanyAdminImplCopyWith<$Res> {
  factory _$$CompanyAdminImplCopyWith(
          _$CompanyAdminImpl value, $Res Function(_$CompanyAdminImpl) then) =
      __$$CompanyAdminImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CompanyAdminImplCopyWithImpl<$Res>
    extends _$UserRoleCopyWithImpl<$Res, _$CompanyAdminImpl>
    implements _$$CompanyAdminImplCopyWith<$Res> {
  __$$CompanyAdminImplCopyWithImpl(
      _$CompanyAdminImpl _value, $Res Function(_$CompanyAdminImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRole
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CompanyAdminImpl extends _CompanyAdmin {
  const _$CompanyAdminImpl() : super._();

  @override
  String toString() {
    return 'UserRole.companyAdmin()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CompanyAdminImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() admin,
    required TResult Function() viewer,
    required TResult Function() companyAdmin,
    required TResult Function() companyManager,
    required TResult Function() companyEmployee,
    required TResult Function() owner,
    required TResult Function() manager,
    required TResult Function() employee,
  }) {
    return companyAdmin();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? admin,
    TResult? Function()? viewer,
    TResult? Function()? companyAdmin,
    TResult? Function()? companyManager,
    TResult? Function()? companyEmployee,
    TResult? Function()? owner,
    TResult? Function()? manager,
    TResult? Function()? employee,
  }) {
    return companyAdmin?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? admin,
    TResult Function()? viewer,
    TResult Function()? companyAdmin,
    TResult Function()? companyManager,
    TResult Function()? companyEmployee,
    TResult Function()? owner,
    TResult Function()? manager,
    TResult Function()? employee,
    required TResult orElse(),
  }) {
    if (companyAdmin != null) {
      return companyAdmin();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Admin value) admin,
    required TResult Function(_Viewer value) viewer,
    required TResult Function(_CompanyAdmin value) companyAdmin,
    required TResult Function(_CompanyManager value) companyManager,
    required TResult Function(_CompanyEmployee value) companyEmployee,
    required TResult Function(_Owner value) owner,
    required TResult Function(_Manager value) manager,
    required TResult Function(_Employee value) employee,
  }) {
    return companyAdmin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Admin value)? admin,
    TResult? Function(_Viewer value)? viewer,
    TResult? Function(_CompanyAdmin value)? companyAdmin,
    TResult? Function(_CompanyManager value)? companyManager,
    TResult? Function(_CompanyEmployee value)? companyEmployee,
    TResult? Function(_Owner value)? owner,
    TResult? Function(_Manager value)? manager,
    TResult? Function(_Employee value)? employee,
  }) {
    return companyAdmin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Admin value)? admin,
    TResult Function(_Viewer value)? viewer,
    TResult Function(_CompanyAdmin value)? companyAdmin,
    TResult Function(_CompanyManager value)? companyManager,
    TResult Function(_CompanyEmployee value)? companyEmployee,
    TResult Function(_Owner value)? owner,
    TResult Function(_Manager value)? manager,
    TResult Function(_Employee value)? employee,
    required TResult orElse(),
  }) {
    if (companyAdmin != null) {
      return companyAdmin(this);
    }
    return orElse();
  }
}

abstract class _CompanyAdmin extends UserRole {
  const factory _CompanyAdmin() = _$CompanyAdminImpl;
  const _CompanyAdmin._() : super._();
}

/// @nodoc
abstract class _$$CompanyManagerImplCopyWith<$Res> {
  factory _$$CompanyManagerImplCopyWith(_$CompanyManagerImpl value,
          $Res Function(_$CompanyManagerImpl) then) =
      __$$CompanyManagerImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CompanyManagerImplCopyWithImpl<$Res>
    extends _$UserRoleCopyWithImpl<$Res, _$CompanyManagerImpl>
    implements _$$CompanyManagerImplCopyWith<$Res> {
  __$$CompanyManagerImplCopyWithImpl(
      _$CompanyManagerImpl _value, $Res Function(_$CompanyManagerImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRole
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CompanyManagerImpl extends _CompanyManager {
  const _$CompanyManagerImpl() : super._();

  @override
  String toString() {
    return 'UserRole.companyManager()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CompanyManagerImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() admin,
    required TResult Function() viewer,
    required TResult Function() companyAdmin,
    required TResult Function() companyManager,
    required TResult Function() companyEmployee,
    required TResult Function() owner,
    required TResult Function() manager,
    required TResult Function() employee,
  }) {
    return companyManager();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? admin,
    TResult? Function()? viewer,
    TResult? Function()? companyAdmin,
    TResult? Function()? companyManager,
    TResult? Function()? companyEmployee,
    TResult? Function()? owner,
    TResult? Function()? manager,
    TResult? Function()? employee,
  }) {
    return companyManager?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? admin,
    TResult Function()? viewer,
    TResult Function()? companyAdmin,
    TResult Function()? companyManager,
    TResult Function()? companyEmployee,
    TResult Function()? owner,
    TResult Function()? manager,
    TResult Function()? employee,
    required TResult orElse(),
  }) {
    if (companyManager != null) {
      return companyManager();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Admin value) admin,
    required TResult Function(_Viewer value) viewer,
    required TResult Function(_CompanyAdmin value) companyAdmin,
    required TResult Function(_CompanyManager value) companyManager,
    required TResult Function(_CompanyEmployee value) companyEmployee,
    required TResult Function(_Owner value) owner,
    required TResult Function(_Manager value) manager,
    required TResult Function(_Employee value) employee,
  }) {
    return companyManager(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Admin value)? admin,
    TResult? Function(_Viewer value)? viewer,
    TResult? Function(_CompanyAdmin value)? companyAdmin,
    TResult? Function(_CompanyManager value)? companyManager,
    TResult? Function(_CompanyEmployee value)? companyEmployee,
    TResult? Function(_Owner value)? owner,
    TResult? Function(_Manager value)? manager,
    TResult? Function(_Employee value)? employee,
  }) {
    return companyManager?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Admin value)? admin,
    TResult Function(_Viewer value)? viewer,
    TResult Function(_CompanyAdmin value)? companyAdmin,
    TResult Function(_CompanyManager value)? companyManager,
    TResult Function(_CompanyEmployee value)? companyEmployee,
    TResult Function(_Owner value)? owner,
    TResult Function(_Manager value)? manager,
    TResult Function(_Employee value)? employee,
    required TResult orElse(),
  }) {
    if (companyManager != null) {
      return companyManager(this);
    }
    return orElse();
  }
}

abstract class _CompanyManager extends UserRole {
  const factory _CompanyManager() = _$CompanyManagerImpl;
  const _CompanyManager._() : super._();
}

/// @nodoc
abstract class _$$CompanyEmployeeImplCopyWith<$Res> {
  factory _$$CompanyEmployeeImplCopyWith(_$CompanyEmployeeImpl value,
          $Res Function(_$CompanyEmployeeImpl) then) =
      __$$CompanyEmployeeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CompanyEmployeeImplCopyWithImpl<$Res>
    extends _$UserRoleCopyWithImpl<$Res, _$CompanyEmployeeImpl>
    implements _$$CompanyEmployeeImplCopyWith<$Res> {
  __$$CompanyEmployeeImplCopyWithImpl(
      _$CompanyEmployeeImpl _value, $Res Function(_$CompanyEmployeeImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRole
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CompanyEmployeeImpl extends _CompanyEmployee {
  const _$CompanyEmployeeImpl() : super._();

  @override
  String toString() {
    return 'UserRole.companyEmployee()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CompanyEmployeeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() admin,
    required TResult Function() viewer,
    required TResult Function() companyAdmin,
    required TResult Function() companyManager,
    required TResult Function() companyEmployee,
    required TResult Function() owner,
    required TResult Function() manager,
    required TResult Function() employee,
  }) {
    return companyEmployee();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? admin,
    TResult? Function()? viewer,
    TResult? Function()? companyAdmin,
    TResult? Function()? companyManager,
    TResult? Function()? companyEmployee,
    TResult? Function()? owner,
    TResult? Function()? manager,
    TResult? Function()? employee,
  }) {
    return companyEmployee?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? admin,
    TResult Function()? viewer,
    TResult Function()? companyAdmin,
    TResult Function()? companyManager,
    TResult Function()? companyEmployee,
    TResult Function()? owner,
    TResult Function()? manager,
    TResult Function()? employee,
    required TResult orElse(),
  }) {
    if (companyEmployee != null) {
      return companyEmployee();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Admin value) admin,
    required TResult Function(_Viewer value) viewer,
    required TResult Function(_CompanyAdmin value) companyAdmin,
    required TResult Function(_CompanyManager value) companyManager,
    required TResult Function(_CompanyEmployee value) companyEmployee,
    required TResult Function(_Owner value) owner,
    required TResult Function(_Manager value) manager,
    required TResult Function(_Employee value) employee,
  }) {
    return companyEmployee(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Admin value)? admin,
    TResult? Function(_Viewer value)? viewer,
    TResult? Function(_CompanyAdmin value)? companyAdmin,
    TResult? Function(_CompanyManager value)? companyManager,
    TResult? Function(_CompanyEmployee value)? companyEmployee,
    TResult? Function(_Owner value)? owner,
    TResult? Function(_Manager value)? manager,
    TResult? Function(_Employee value)? employee,
  }) {
    return companyEmployee?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Admin value)? admin,
    TResult Function(_Viewer value)? viewer,
    TResult Function(_CompanyAdmin value)? companyAdmin,
    TResult Function(_CompanyManager value)? companyManager,
    TResult Function(_CompanyEmployee value)? companyEmployee,
    TResult Function(_Owner value)? owner,
    TResult Function(_Manager value)? manager,
    TResult Function(_Employee value)? employee,
    required TResult orElse(),
  }) {
    if (companyEmployee != null) {
      return companyEmployee(this);
    }
    return orElse();
  }
}

abstract class _CompanyEmployee extends UserRole {
  const factory _CompanyEmployee() = _$CompanyEmployeeImpl;
  const _CompanyEmployee._() : super._();
}

/// @nodoc
abstract class _$$OwnerImplCopyWith<$Res> {
  factory _$$OwnerImplCopyWith(
          _$OwnerImpl value, $Res Function(_$OwnerImpl) then) =
      __$$OwnerImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OwnerImplCopyWithImpl<$Res>
    extends _$UserRoleCopyWithImpl<$Res, _$OwnerImpl>
    implements _$$OwnerImplCopyWith<$Res> {
  __$$OwnerImplCopyWithImpl(
      _$OwnerImpl _value, $Res Function(_$OwnerImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRole
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OwnerImpl extends _Owner {
  const _$OwnerImpl() : super._();

  @override
  String toString() {
    return 'UserRole.owner()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OwnerImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() admin,
    required TResult Function() viewer,
    required TResult Function() companyAdmin,
    required TResult Function() companyManager,
    required TResult Function() companyEmployee,
    required TResult Function() owner,
    required TResult Function() manager,
    required TResult Function() employee,
  }) {
    return owner();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? admin,
    TResult? Function()? viewer,
    TResult? Function()? companyAdmin,
    TResult? Function()? companyManager,
    TResult? Function()? companyEmployee,
    TResult? Function()? owner,
    TResult? Function()? manager,
    TResult? Function()? employee,
  }) {
    return owner?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? admin,
    TResult Function()? viewer,
    TResult Function()? companyAdmin,
    TResult Function()? companyManager,
    TResult Function()? companyEmployee,
    TResult Function()? owner,
    TResult Function()? manager,
    TResult Function()? employee,
    required TResult orElse(),
  }) {
    if (owner != null) {
      return owner();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Admin value) admin,
    required TResult Function(_Viewer value) viewer,
    required TResult Function(_CompanyAdmin value) companyAdmin,
    required TResult Function(_CompanyManager value) companyManager,
    required TResult Function(_CompanyEmployee value) companyEmployee,
    required TResult Function(_Owner value) owner,
    required TResult Function(_Manager value) manager,
    required TResult Function(_Employee value) employee,
  }) {
    return owner(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Admin value)? admin,
    TResult? Function(_Viewer value)? viewer,
    TResult? Function(_CompanyAdmin value)? companyAdmin,
    TResult? Function(_CompanyManager value)? companyManager,
    TResult? Function(_CompanyEmployee value)? companyEmployee,
    TResult? Function(_Owner value)? owner,
    TResult? Function(_Manager value)? manager,
    TResult? Function(_Employee value)? employee,
  }) {
    return owner?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Admin value)? admin,
    TResult Function(_Viewer value)? viewer,
    TResult Function(_CompanyAdmin value)? companyAdmin,
    TResult Function(_CompanyManager value)? companyManager,
    TResult Function(_CompanyEmployee value)? companyEmployee,
    TResult Function(_Owner value)? owner,
    TResult Function(_Manager value)? manager,
    TResult Function(_Employee value)? employee,
    required TResult orElse(),
  }) {
    if (owner != null) {
      return owner(this);
    }
    return orElse();
  }
}

abstract class _Owner extends UserRole {
  const factory _Owner() = _$OwnerImpl;
  const _Owner._() : super._();
}

/// @nodoc
abstract class _$$ManagerImplCopyWith<$Res> {
  factory _$$ManagerImplCopyWith(
          _$ManagerImpl value, $Res Function(_$ManagerImpl) then) =
      __$$ManagerImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ManagerImplCopyWithImpl<$Res>
    extends _$UserRoleCopyWithImpl<$Res, _$ManagerImpl>
    implements _$$ManagerImplCopyWith<$Res> {
  __$$ManagerImplCopyWithImpl(
      _$ManagerImpl _value, $Res Function(_$ManagerImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRole
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ManagerImpl extends _Manager {
  const _$ManagerImpl() : super._();

  @override
  String toString() {
    return 'UserRole.manager()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ManagerImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() admin,
    required TResult Function() viewer,
    required TResult Function() companyAdmin,
    required TResult Function() companyManager,
    required TResult Function() companyEmployee,
    required TResult Function() owner,
    required TResult Function() manager,
    required TResult Function() employee,
  }) {
    return manager();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? admin,
    TResult? Function()? viewer,
    TResult? Function()? companyAdmin,
    TResult? Function()? companyManager,
    TResult? Function()? companyEmployee,
    TResult? Function()? owner,
    TResult? Function()? manager,
    TResult? Function()? employee,
  }) {
    return manager?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? admin,
    TResult Function()? viewer,
    TResult Function()? companyAdmin,
    TResult Function()? companyManager,
    TResult Function()? companyEmployee,
    TResult Function()? owner,
    TResult Function()? manager,
    TResult Function()? employee,
    required TResult orElse(),
  }) {
    if (manager != null) {
      return manager();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Admin value) admin,
    required TResult Function(_Viewer value) viewer,
    required TResult Function(_CompanyAdmin value) companyAdmin,
    required TResult Function(_CompanyManager value) companyManager,
    required TResult Function(_CompanyEmployee value) companyEmployee,
    required TResult Function(_Owner value) owner,
    required TResult Function(_Manager value) manager,
    required TResult Function(_Employee value) employee,
  }) {
    return manager(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Admin value)? admin,
    TResult? Function(_Viewer value)? viewer,
    TResult? Function(_CompanyAdmin value)? companyAdmin,
    TResult? Function(_CompanyManager value)? companyManager,
    TResult? Function(_CompanyEmployee value)? companyEmployee,
    TResult? Function(_Owner value)? owner,
    TResult? Function(_Manager value)? manager,
    TResult? Function(_Employee value)? employee,
  }) {
    return manager?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Admin value)? admin,
    TResult Function(_Viewer value)? viewer,
    TResult Function(_CompanyAdmin value)? companyAdmin,
    TResult Function(_CompanyManager value)? companyManager,
    TResult Function(_CompanyEmployee value)? companyEmployee,
    TResult Function(_Owner value)? owner,
    TResult Function(_Manager value)? manager,
    TResult Function(_Employee value)? employee,
    required TResult orElse(),
  }) {
    if (manager != null) {
      return manager(this);
    }
    return orElse();
  }
}

abstract class _Manager extends UserRole {
  const factory _Manager() = _$ManagerImpl;
  const _Manager._() : super._();
}

/// @nodoc
abstract class _$$EmployeeImplCopyWith<$Res> {
  factory _$$EmployeeImplCopyWith(
          _$EmployeeImpl value, $Res Function(_$EmployeeImpl) then) =
      __$$EmployeeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EmployeeImplCopyWithImpl<$Res>
    extends _$UserRoleCopyWithImpl<$Res, _$EmployeeImpl>
    implements _$$EmployeeImplCopyWith<$Res> {
  __$$EmployeeImplCopyWithImpl(
      _$EmployeeImpl _value, $Res Function(_$EmployeeImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRole
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EmployeeImpl extends _Employee {
  const _$EmployeeImpl() : super._();

  @override
  String toString() {
    return 'UserRole.employee()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EmployeeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() admin,
    required TResult Function() viewer,
    required TResult Function() companyAdmin,
    required TResult Function() companyManager,
    required TResult Function() companyEmployee,
    required TResult Function() owner,
    required TResult Function() manager,
    required TResult Function() employee,
  }) {
    return employee();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? admin,
    TResult? Function()? viewer,
    TResult? Function()? companyAdmin,
    TResult? Function()? companyManager,
    TResult? Function()? companyEmployee,
    TResult? Function()? owner,
    TResult? Function()? manager,
    TResult? Function()? employee,
  }) {
    return employee?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? admin,
    TResult Function()? viewer,
    TResult Function()? companyAdmin,
    TResult Function()? companyManager,
    TResult Function()? companyEmployee,
    TResult Function()? owner,
    TResult Function()? manager,
    TResult Function()? employee,
    required TResult orElse(),
  }) {
    if (employee != null) {
      return employee();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Admin value) admin,
    required TResult Function(_Viewer value) viewer,
    required TResult Function(_CompanyAdmin value) companyAdmin,
    required TResult Function(_CompanyManager value) companyManager,
    required TResult Function(_CompanyEmployee value) companyEmployee,
    required TResult Function(_Owner value) owner,
    required TResult Function(_Manager value) manager,
    required TResult Function(_Employee value) employee,
  }) {
    return employee(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Admin value)? admin,
    TResult? Function(_Viewer value)? viewer,
    TResult? Function(_CompanyAdmin value)? companyAdmin,
    TResult? Function(_CompanyManager value)? companyManager,
    TResult? Function(_CompanyEmployee value)? companyEmployee,
    TResult? Function(_Owner value)? owner,
    TResult? Function(_Manager value)? manager,
    TResult? Function(_Employee value)? employee,
  }) {
    return employee?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Admin value)? admin,
    TResult Function(_Viewer value)? viewer,
    TResult Function(_CompanyAdmin value)? companyAdmin,
    TResult Function(_CompanyManager value)? companyManager,
    TResult Function(_CompanyEmployee value)? companyEmployee,
    TResult Function(_Owner value)? owner,
    TResult Function(_Manager value)? manager,
    TResult Function(_Employee value)? employee,
    required TResult orElse(),
  }) {
    if (employee != null) {
      return employee(this);
    }
    return orElse();
  }
}

abstract class _Employee extends UserRole {
  const factory _Employee() = _$EmployeeImpl;
  const _Employee._() : super._();
}
