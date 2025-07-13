// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Business _$BusinessFromJson(Map<String, dynamic> json) {
  return _Business.fromJson(json);
}

/// @nodoc
mixin _$Business {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get cnpj =>
      throw _privateConstructorUsedError; // Optional for solo entrepreneurs
  String? get fantasyName =>
      throw _privateConstructorUsedError; // Nome fantasia
  String get address => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get zipCode => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  BusinessType get type => throw _privateConstructorUsedError;
  BusinessStatus get status => throw _privateConstructorUsedError;
  List<String> get authorizedUsers => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String get createdBy =>
      throw _privateConstructorUsedError; // Admin user ID who created this business
  Map<String, dynamic> get settings => throw _privateConstructorUsedError;

  /// Serializes this Business to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessCopyWith<Business> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessCopyWith<$Res> {
  factory $BusinessCopyWith(Business value, $Res Function(Business) then) =
      _$BusinessCopyWithImpl<$Res, Business>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? cnpj,
      String? fantasyName,
      String address,
      String city,
      String state,
      String zipCode,
      String phone,
      String? email,
      BusinessType type,
      BusinessStatus status,
      List<String> authorizedUsers,
      DateTime createdAt,
      DateTime? updatedAt,
      String createdBy,
      Map<String, dynamic> settings});

  $BusinessTypeCopyWith<$Res> get type;
  $BusinessStatusCopyWith<$Res> get status;
}

/// @nodoc
class _$BusinessCopyWithImpl<$Res, $Val extends Business>
    implements $BusinessCopyWith<$Res> {
  _$BusinessCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? cnpj = freezed,
    Object? fantasyName = freezed,
    Object? address = null,
    Object? city = null,
    Object? state = null,
    Object? zipCode = null,
    Object? phone = null,
    Object? email = freezed,
    Object? type = null,
    Object? status = null,
    Object? authorizedUsers = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? createdBy = null,
    Object? settings = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      cnpj: freezed == cnpj
          ? _value.cnpj
          : cnpj // ignore: cast_nullable_to_non_nullable
              as String?,
      fantasyName: freezed == fantasyName
          ? _value.fantasyName
          : fantasyName // ignore: cast_nullable_to_non_nullable
              as String?,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      zipCode: null == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BusinessType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BusinessStatus,
      authorizedUsers: null == authorizedUsers
          ? _value.authorizedUsers
          : authorizedUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BusinessTypeCopyWith<$Res> get type {
    return $BusinessTypeCopyWith<$Res>(_value.type, (value) {
      return _then(_value.copyWith(type: value) as $Val);
    });
  }

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BusinessStatusCopyWith<$Res> get status {
    return $BusinessStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BusinessImplCopyWith<$Res>
    implements $BusinessCopyWith<$Res> {
  factory _$$BusinessImplCopyWith(
          _$BusinessImpl value, $Res Function(_$BusinessImpl) then) =
      __$$BusinessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? cnpj,
      String? fantasyName,
      String address,
      String city,
      String state,
      String zipCode,
      String phone,
      String? email,
      BusinessType type,
      BusinessStatus status,
      List<String> authorizedUsers,
      DateTime createdAt,
      DateTime? updatedAt,
      String createdBy,
      Map<String, dynamic> settings});

  @override
  $BusinessTypeCopyWith<$Res> get type;
  @override
  $BusinessStatusCopyWith<$Res> get status;
}

/// @nodoc
class __$$BusinessImplCopyWithImpl<$Res>
    extends _$BusinessCopyWithImpl<$Res, _$BusinessImpl>
    implements _$$BusinessImplCopyWith<$Res> {
  __$$BusinessImplCopyWithImpl(
      _$BusinessImpl _value, $Res Function(_$BusinessImpl) _then)
      : super(_value, _then);

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? cnpj = freezed,
    Object? fantasyName = freezed,
    Object? address = null,
    Object? city = null,
    Object? state = null,
    Object? zipCode = null,
    Object? phone = null,
    Object? email = freezed,
    Object? type = null,
    Object? status = null,
    Object? authorizedUsers = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? createdBy = null,
    Object? settings = null,
  }) {
    return _then(_$BusinessImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      cnpj: freezed == cnpj
          ? _value.cnpj
          : cnpj // ignore: cast_nullable_to_non_nullable
              as String?,
      fantasyName: freezed == fantasyName
          ? _value.fantasyName
          : fantasyName // ignore: cast_nullable_to_non_nullable
              as String?,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      zipCode: null == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BusinessType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BusinessStatus,
      authorizedUsers: null == authorizedUsers
          ? _value._authorizedUsers
          : authorizedUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      settings: null == settings
          ? _value._settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessImpl implements _Business {
  const _$BusinessImpl(
      {required this.id,
      required this.name,
      this.cnpj,
      this.fantasyName,
      required this.address,
      required this.city,
      required this.state,
      required this.zipCode,
      required this.phone,
      this.email,
      this.type = const BusinessType.soloEntrepreneur(),
      this.status = const BusinessStatus.active(),
      final List<String> authorizedUsers = const [],
      required this.createdAt,
      this.updatedAt,
      required this.createdBy,
      final Map<String, dynamic> settings = const {}})
      : _authorizedUsers = authorizedUsers,
        _settings = settings;

  factory _$BusinessImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? cnpj;
// Optional for solo entrepreneurs
  @override
  final String? fantasyName;
// Nome fantasia
  @override
  final String address;
  @override
  final String city;
  @override
  final String state;
  @override
  final String zipCode;
  @override
  final String phone;
  @override
  final String? email;
  @override
  @JsonKey()
  final BusinessType type;
  @override
  @JsonKey()
  final BusinessStatus status;
  final List<String> _authorizedUsers;
  @override
  @JsonKey()
  List<String> get authorizedUsers {
    if (_authorizedUsers is EqualUnmodifiableListView) return _authorizedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_authorizedUsers);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String createdBy;
// Admin user ID who created this business
  final Map<String, dynamic> _settings;
// Admin user ID who created this business
  @override
  @JsonKey()
  Map<String, dynamic> get settings {
    if (_settings is EqualUnmodifiableMapView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_settings);
  }

  @override
  String toString() {
    return 'Business(id: $id, name: $name, cnpj: $cnpj, fantasyName: $fantasyName, address: $address, city: $city, state: $state, zipCode: $zipCode, phone: $phone, email: $email, type: $type, status: $status, authorizedUsers: $authorizedUsers, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.cnpj, cnpj) || other.cnpj == cnpj) &&
            (identical(other.fantasyName, fantasyName) ||
                other.fantasyName == fantasyName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._authorizedUsers, _authorizedUsers) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            const DeepCollectionEquality().equals(other._settings, _settings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      cnpj,
      fantasyName,
      address,
      city,
      state,
      zipCode,
      phone,
      email,
      type,
      status,
      const DeepCollectionEquality().hash(_authorizedUsers),
      createdAt,
      updatedAt,
      createdBy,
      const DeepCollectionEquality().hash(_settings));

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessImplCopyWith<_$BusinessImpl> get copyWith =>
      __$$BusinessImplCopyWithImpl<_$BusinessImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessImplToJson(
      this,
    );
  }
}

abstract class _Business implements Business {
  const factory _Business(
      {required final String id,
      required final String name,
      final String? cnpj,
      final String? fantasyName,
      required final String address,
      required final String city,
      required final String state,
      required final String zipCode,
      required final String phone,
      final String? email,
      final BusinessType type,
      final BusinessStatus status,
      final List<String> authorizedUsers,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      required final String createdBy,
      final Map<String, dynamic> settings}) = _$BusinessImpl;

  factory _Business.fromJson(Map<String, dynamic> json) =
      _$BusinessImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get cnpj; // Optional for solo entrepreneurs
  @override
  String? get fantasyName; // Nome fantasia
  @override
  String get address;
  @override
  String get city;
  @override
  String get state;
  @override
  String get zipCode;
  @override
  String get phone;
  @override
  String? get email;
  @override
  BusinessType get type;
  @override
  BusinessStatus get status;
  @override
  List<String> get authorizedUsers;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  String get createdBy; // Admin user ID who created this business
  @override
  Map<String, dynamic> get settings;

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessImplCopyWith<_$BusinessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BusinessType {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() formalCompany,
    required TResult Function() soloEntrepreneur,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? formalCompany,
    TResult? Function()? soloEntrepreneur,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? formalCompany,
    TResult Function()? soloEntrepreneur,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FormalCompany value) formalCompany,
    required TResult Function(_SoloEntrepreneur value) soloEntrepreneur,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FormalCompany value)? formalCompany,
    TResult? Function(_SoloEntrepreneur value)? soloEntrepreneur,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FormalCompany value)? formalCompany,
    TResult Function(_SoloEntrepreneur value)? soloEntrepreneur,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessTypeCopyWith<$Res> {
  factory $BusinessTypeCopyWith(
          BusinessType value, $Res Function(BusinessType) then) =
      _$BusinessTypeCopyWithImpl<$Res, BusinessType>;
}

/// @nodoc
class _$BusinessTypeCopyWithImpl<$Res, $Val extends BusinessType>
    implements $BusinessTypeCopyWith<$Res> {
  _$BusinessTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FormalCompanyImplCopyWith<$Res> {
  factory _$$FormalCompanyImplCopyWith(
          _$FormalCompanyImpl value, $Res Function(_$FormalCompanyImpl) then) =
      __$$FormalCompanyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FormalCompanyImplCopyWithImpl<$Res>
    extends _$BusinessTypeCopyWithImpl<$Res, _$FormalCompanyImpl>
    implements _$$FormalCompanyImplCopyWith<$Res> {
  __$$FormalCompanyImplCopyWithImpl(
      _$FormalCompanyImpl _value, $Res Function(_$FormalCompanyImpl) _then)
      : super(_value, _then);

  /// Create a copy of BusinessType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FormalCompanyImpl extends _FormalCompany {
  const _$FormalCompanyImpl() : super._();

  @override
  String toString() {
    return 'BusinessType.formalCompany()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FormalCompanyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() formalCompany,
    required TResult Function() soloEntrepreneur,
  }) {
    return formalCompany();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? formalCompany,
    TResult? Function()? soloEntrepreneur,
  }) {
    return formalCompany?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? formalCompany,
    TResult Function()? soloEntrepreneur,
    required TResult orElse(),
  }) {
    if (formalCompany != null) {
      return formalCompany();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FormalCompany value) formalCompany,
    required TResult Function(_SoloEntrepreneur value) soloEntrepreneur,
  }) {
    return formalCompany(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FormalCompany value)? formalCompany,
    TResult? Function(_SoloEntrepreneur value)? soloEntrepreneur,
  }) {
    return formalCompany?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FormalCompany value)? formalCompany,
    TResult Function(_SoloEntrepreneur value)? soloEntrepreneur,
    required TResult orElse(),
  }) {
    if (formalCompany != null) {
      return formalCompany(this);
    }
    return orElse();
  }
}

abstract class _FormalCompany extends BusinessType {
  const factory _FormalCompany() = _$FormalCompanyImpl;
  const _FormalCompany._() : super._();
}

/// @nodoc
abstract class _$$SoloEntrepreneurImplCopyWith<$Res> {
  factory _$$SoloEntrepreneurImplCopyWith(_$SoloEntrepreneurImpl value,
          $Res Function(_$SoloEntrepreneurImpl) then) =
      __$$SoloEntrepreneurImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SoloEntrepreneurImplCopyWithImpl<$Res>
    extends _$BusinessTypeCopyWithImpl<$Res, _$SoloEntrepreneurImpl>
    implements _$$SoloEntrepreneurImplCopyWith<$Res> {
  __$$SoloEntrepreneurImplCopyWithImpl(_$SoloEntrepreneurImpl _value,
      $Res Function(_$SoloEntrepreneurImpl) _then)
      : super(_value, _then);

  /// Create a copy of BusinessType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SoloEntrepreneurImpl extends _SoloEntrepreneur {
  const _$SoloEntrepreneurImpl() : super._();

  @override
  String toString() {
    return 'BusinessType.soloEntrepreneur()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SoloEntrepreneurImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() formalCompany,
    required TResult Function() soloEntrepreneur,
  }) {
    return soloEntrepreneur();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? formalCompany,
    TResult? Function()? soloEntrepreneur,
  }) {
    return soloEntrepreneur?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? formalCompany,
    TResult Function()? soloEntrepreneur,
    required TResult orElse(),
  }) {
    if (soloEntrepreneur != null) {
      return soloEntrepreneur();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FormalCompany value) formalCompany,
    required TResult Function(_SoloEntrepreneur value) soloEntrepreneur,
  }) {
    return soloEntrepreneur(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FormalCompany value)? formalCompany,
    TResult? Function(_SoloEntrepreneur value)? soloEntrepreneur,
  }) {
    return soloEntrepreneur?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FormalCompany value)? formalCompany,
    TResult Function(_SoloEntrepreneur value)? soloEntrepreneur,
    required TResult orElse(),
  }) {
    if (soloEntrepreneur != null) {
      return soloEntrepreneur(this);
    }
    return orElse();
  }
}

abstract class _SoloEntrepreneur extends BusinessType {
  const factory _SoloEntrepreneur() = _$SoloEntrepreneurImpl;
  const _SoloEntrepreneur._() : super._();
}

/// @nodoc
mixin _$BusinessStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() active,
    required TResult Function() inactive,
    required TResult Function() suspended,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? active,
    TResult? Function()? inactive,
    TResult? Function()? suspended,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? active,
    TResult Function()? inactive,
    TResult Function()? suspended,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Active value) active,
    required TResult Function(_Inactive value) inactive,
    required TResult Function(_Suspended value) suspended,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Active value)? active,
    TResult? Function(_Inactive value)? inactive,
    TResult? Function(_Suspended value)? suspended,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Active value)? active,
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Suspended value)? suspended,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessStatusCopyWith<$Res> {
  factory $BusinessStatusCopyWith(
          BusinessStatus value, $Res Function(BusinessStatus) then) =
      _$BusinessStatusCopyWithImpl<$Res, BusinessStatus>;
}

/// @nodoc
class _$BusinessStatusCopyWithImpl<$Res, $Val extends BusinessStatus>
    implements $BusinessStatusCopyWith<$Res> {
  _$BusinessStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ActiveImplCopyWith<$Res> {
  factory _$$ActiveImplCopyWith(
          _$ActiveImpl value, $Res Function(_$ActiveImpl) then) =
      __$$ActiveImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ActiveImplCopyWithImpl<$Res>
    extends _$BusinessStatusCopyWithImpl<$Res, _$ActiveImpl>
    implements _$$ActiveImplCopyWith<$Res> {
  __$$ActiveImplCopyWithImpl(
      _$ActiveImpl _value, $Res Function(_$ActiveImpl) _then)
      : super(_value, _then);

  /// Create a copy of BusinessStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ActiveImpl extends _Active {
  const _$ActiveImpl() : super._();

  @override
  String toString() {
    return 'BusinessStatus.active()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ActiveImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() active,
    required TResult Function() inactive,
    required TResult Function() suspended,
  }) {
    return active();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? active,
    TResult? Function()? inactive,
    TResult? Function()? suspended,
  }) {
    return active?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? active,
    TResult Function()? inactive,
    TResult Function()? suspended,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Active value) active,
    required TResult Function(_Inactive value) inactive,
    required TResult Function(_Suspended value) suspended,
  }) {
    return active(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Active value)? active,
    TResult? Function(_Inactive value)? inactive,
    TResult? Function(_Suspended value)? suspended,
  }) {
    return active?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Active value)? active,
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Suspended value)? suspended,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(this);
    }
    return orElse();
  }
}

abstract class _Active extends BusinessStatus {
  const factory _Active() = _$ActiveImpl;
  const _Active._() : super._();
}

/// @nodoc
abstract class _$$InactiveImplCopyWith<$Res> {
  factory _$$InactiveImplCopyWith(
          _$InactiveImpl value, $Res Function(_$InactiveImpl) then) =
      __$$InactiveImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InactiveImplCopyWithImpl<$Res>
    extends _$BusinessStatusCopyWithImpl<$Res, _$InactiveImpl>
    implements _$$InactiveImplCopyWith<$Res> {
  __$$InactiveImplCopyWithImpl(
      _$InactiveImpl _value, $Res Function(_$InactiveImpl) _then)
      : super(_value, _then);

  /// Create a copy of BusinessStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InactiveImpl extends _Inactive {
  const _$InactiveImpl() : super._();

  @override
  String toString() {
    return 'BusinessStatus.inactive()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InactiveImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() active,
    required TResult Function() inactive,
    required TResult Function() suspended,
  }) {
    return inactive();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? active,
    TResult? Function()? inactive,
    TResult? Function()? suspended,
  }) {
    return inactive?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? active,
    TResult Function()? inactive,
    TResult Function()? suspended,
    required TResult orElse(),
  }) {
    if (inactive != null) {
      return inactive();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Active value) active,
    required TResult Function(_Inactive value) inactive,
    required TResult Function(_Suspended value) suspended,
  }) {
    return inactive(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Active value)? active,
    TResult? Function(_Inactive value)? inactive,
    TResult? Function(_Suspended value)? suspended,
  }) {
    return inactive?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Active value)? active,
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Suspended value)? suspended,
    required TResult orElse(),
  }) {
    if (inactive != null) {
      return inactive(this);
    }
    return orElse();
  }
}

abstract class _Inactive extends BusinessStatus {
  const factory _Inactive() = _$InactiveImpl;
  const _Inactive._() : super._();
}

/// @nodoc
abstract class _$$SuspendedImplCopyWith<$Res> {
  factory _$$SuspendedImplCopyWith(
          _$SuspendedImpl value, $Res Function(_$SuspendedImpl) then) =
      __$$SuspendedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SuspendedImplCopyWithImpl<$Res>
    extends _$BusinessStatusCopyWithImpl<$Res, _$SuspendedImpl>
    implements _$$SuspendedImplCopyWith<$Res> {
  __$$SuspendedImplCopyWithImpl(
      _$SuspendedImpl _value, $Res Function(_$SuspendedImpl) _then)
      : super(_value, _then);

  /// Create a copy of BusinessStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SuspendedImpl extends _Suspended {
  const _$SuspendedImpl() : super._();

  @override
  String toString() {
    return 'BusinessStatus.suspended()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SuspendedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() active,
    required TResult Function() inactive,
    required TResult Function() suspended,
  }) {
    return suspended();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? active,
    TResult? Function()? inactive,
    TResult? Function()? suspended,
  }) {
    return suspended?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? active,
    TResult Function()? inactive,
    TResult Function()? suspended,
    required TResult orElse(),
  }) {
    if (suspended != null) {
      return suspended();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Active value) active,
    required TResult Function(_Inactive value) inactive,
    required TResult Function(_Suspended value) suspended,
  }) {
    return suspended(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Active value)? active,
    TResult? Function(_Inactive value)? inactive,
    TResult? Function(_Suspended value)? suspended,
  }) {
    return suspended?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Active value)? active,
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Suspended value)? suspended,
    required TResult orElse(),
  }) {
    if (suspended != null) {
      return suspended(this);
    }
    return orElse();
  }
}

abstract class _Suspended extends BusinessStatus {
  const factory _Suspended() = _$SuspendedImpl;
  const _Suspended._() : super._();
}

BusinessSettings _$BusinessSettingsFromJson(Map<String, dynamic> json) {
  return _BusinessSettings.fromJson(json);
}

/// @nodoc
mixin _$BusinessSettings {
  String get locale => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get dateFormat => throw _privateConstructorUsedError;
  double get defaultMargin => throw _privateConstructorUsedError;
  bool get enableInventoryTracking => throw _privateConstructorUsedError;
  bool get enableCostCalculation => throw _privateConstructorUsedError;
  bool get enableMultiLocation => throw _privateConstructorUsedError;
  Map<String, dynamic> get customFields => throw _privateConstructorUsedError;

  /// Serializes this BusinessSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessSettingsCopyWith<BusinessSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessSettingsCopyWith<$Res> {
  factory $BusinessSettingsCopyWith(
          BusinessSettings value, $Res Function(BusinessSettings) then) =
      _$BusinessSettingsCopyWithImpl<$Res, BusinessSettings>;
  @useResult
  $Res call(
      {String locale,
      String currency,
      String dateFormat,
      double defaultMargin,
      bool enableInventoryTracking,
      bool enableCostCalculation,
      bool enableMultiLocation,
      Map<String, dynamic> customFields});
}

/// @nodoc
class _$BusinessSettingsCopyWithImpl<$Res, $Val extends BusinessSettings>
    implements $BusinessSettingsCopyWith<$Res> {
  _$BusinessSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locale = null,
    Object? currency = null,
    Object? dateFormat = null,
    Object? defaultMargin = null,
    Object? enableInventoryTracking = null,
    Object? enableCostCalculation = null,
    Object? enableMultiLocation = null,
    Object? customFields = null,
  }) {
    return _then(_value.copyWith(
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      dateFormat: null == dateFormat
          ? _value.dateFormat
          : dateFormat // ignore: cast_nullable_to_non_nullable
              as String,
      defaultMargin: null == defaultMargin
          ? _value.defaultMargin
          : defaultMargin // ignore: cast_nullable_to_non_nullable
              as double,
      enableInventoryTracking: null == enableInventoryTracking
          ? _value.enableInventoryTracking
          : enableInventoryTracking // ignore: cast_nullable_to_non_nullable
              as bool,
      enableCostCalculation: null == enableCostCalculation
          ? _value.enableCostCalculation
          : enableCostCalculation // ignore: cast_nullable_to_non_nullable
              as bool,
      enableMultiLocation: null == enableMultiLocation
          ? _value.enableMultiLocation
          : enableMultiLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      customFields: null == customFields
          ? _value.customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BusinessSettingsImplCopyWith<$Res>
    implements $BusinessSettingsCopyWith<$Res> {
  factory _$$BusinessSettingsImplCopyWith(_$BusinessSettingsImpl value,
          $Res Function(_$BusinessSettingsImpl) then) =
      __$$BusinessSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String locale,
      String currency,
      String dateFormat,
      double defaultMargin,
      bool enableInventoryTracking,
      bool enableCostCalculation,
      bool enableMultiLocation,
      Map<String, dynamic> customFields});
}

/// @nodoc
class __$$BusinessSettingsImplCopyWithImpl<$Res>
    extends _$BusinessSettingsCopyWithImpl<$Res, _$BusinessSettingsImpl>
    implements _$$BusinessSettingsImplCopyWith<$Res> {
  __$$BusinessSettingsImplCopyWithImpl(_$BusinessSettingsImpl _value,
      $Res Function(_$BusinessSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of BusinessSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locale = null,
    Object? currency = null,
    Object? dateFormat = null,
    Object? defaultMargin = null,
    Object? enableInventoryTracking = null,
    Object? enableCostCalculation = null,
    Object? enableMultiLocation = null,
    Object? customFields = null,
  }) {
    return _then(_$BusinessSettingsImpl(
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      dateFormat: null == dateFormat
          ? _value.dateFormat
          : dateFormat // ignore: cast_nullable_to_non_nullable
              as String,
      defaultMargin: null == defaultMargin
          ? _value.defaultMargin
          : defaultMargin // ignore: cast_nullable_to_non_nullable
              as double,
      enableInventoryTracking: null == enableInventoryTracking
          ? _value.enableInventoryTracking
          : enableInventoryTracking // ignore: cast_nullable_to_non_nullable
              as bool,
      enableCostCalculation: null == enableCostCalculation
          ? _value.enableCostCalculation
          : enableCostCalculation // ignore: cast_nullable_to_non_nullable
              as bool,
      enableMultiLocation: null == enableMultiLocation
          ? _value.enableMultiLocation
          : enableMultiLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      customFields: null == customFields
          ? _value._customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessSettingsImpl implements _BusinessSettings {
  const _$BusinessSettingsImpl(
      {this.locale = 'pt-BR',
      this.currency = 'BRL',
      this.dateFormat = 'dd/MM/yyyy',
      this.defaultMargin = 100.0,
      this.enableInventoryTracking = true,
      this.enableCostCalculation = true,
      this.enableMultiLocation = false,
      final Map<String, dynamic> customFields = const {}})
      : _customFields = customFields;

  factory _$BusinessSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessSettingsImplFromJson(json);

  @override
  @JsonKey()
  final String locale;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final String dateFormat;
  @override
  @JsonKey()
  final double defaultMargin;
  @override
  @JsonKey()
  final bool enableInventoryTracking;
  @override
  @JsonKey()
  final bool enableCostCalculation;
  @override
  @JsonKey()
  final bool enableMultiLocation;
  final Map<String, dynamic> _customFields;
  @override
  @JsonKey()
  Map<String, dynamic> get customFields {
    if (_customFields is EqualUnmodifiableMapView) return _customFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customFields);
  }

  @override
  String toString() {
    return 'BusinessSettings(locale: $locale, currency: $currency, dateFormat: $dateFormat, defaultMargin: $defaultMargin, enableInventoryTracking: $enableInventoryTracking, enableCostCalculation: $enableCostCalculation, enableMultiLocation: $enableMultiLocation, customFields: $customFields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessSettingsImpl &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.dateFormat, dateFormat) ||
                other.dateFormat == dateFormat) &&
            (identical(other.defaultMargin, defaultMargin) ||
                other.defaultMargin == defaultMargin) &&
            (identical(
                    other.enableInventoryTracking, enableInventoryTracking) ||
                other.enableInventoryTracking == enableInventoryTracking) &&
            (identical(other.enableCostCalculation, enableCostCalculation) ||
                other.enableCostCalculation == enableCostCalculation) &&
            (identical(other.enableMultiLocation, enableMultiLocation) ||
                other.enableMultiLocation == enableMultiLocation) &&
            const DeepCollectionEquality()
                .equals(other._customFields, _customFields));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      locale,
      currency,
      dateFormat,
      defaultMargin,
      enableInventoryTracking,
      enableCostCalculation,
      enableMultiLocation,
      const DeepCollectionEquality().hash(_customFields));

  /// Create a copy of BusinessSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessSettingsImplCopyWith<_$BusinessSettingsImpl> get copyWith =>
      __$$BusinessSettingsImplCopyWithImpl<_$BusinessSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessSettingsImplToJson(
      this,
    );
  }
}

abstract class _BusinessSettings implements BusinessSettings {
  const factory _BusinessSettings(
      {final String locale,
      final String currency,
      final String dateFormat,
      final double defaultMargin,
      final bool enableInventoryTracking,
      final bool enableCostCalculation,
      final bool enableMultiLocation,
      final Map<String, dynamic> customFields}) = _$BusinessSettingsImpl;

  factory _BusinessSettings.fromJson(Map<String, dynamic> json) =
      _$BusinessSettingsImpl.fromJson;

  @override
  String get locale;
  @override
  String get currency;
  @override
  String get dateFormat;
  @override
  double get defaultMargin;
  @override
  bool get enableInventoryTracking;
  @override
  bool get enableCostCalculation;
  @override
  bool get enableMultiLocation;
  @override
  Map<String, dynamic> get customFields;

  /// Create a copy of BusinessSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessSettingsImplCopyWith<_$BusinessSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
