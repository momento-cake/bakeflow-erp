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
  String get cnpj => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  List<String> get authorizedUsers => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
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
      String cnpj,
      String? address,
      String? phone,
      String? email,
      String ownerId,
      List<String> authorizedUsers,
      DateTime createdAt,
      bool isActive,
      Map<String, dynamic> settings});
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
    Object? cnpj = null,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? ownerId = null,
    Object? authorizedUsers = null,
    Object? createdAt = null,
    Object? isActive = null,
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
      cnpj: null == cnpj
          ? _value.cnpj
          : cnpj // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      authorizedUsers: null == authorizedUsers
          ? _value.authorizedUsers
          : authorizedUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
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
      String cnpj,
      String? address,
      String? phone,
      String? email,
      String ownerId,
      List<String> authorizedUsers,
      DateTime createdAt,
      bool isActive,
      Map<String, dynamic> settings});
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
    Object? cnpj = null,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? ownerId = null,
    Object? authorizedUsers = null,
    Object? createdAt = null,
    Object? isActive = null,
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
      cnpj: null == cnpj
          ? _value.cnpj
          : cnpj // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      authorizedUsers: null == authorizedUsers
          ? _value._authorizedUsers
          : authorizedUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
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
      required this.cnpj,
      this.address,
      this.phone,
      this.email,
      required this.ownerId,
      final List<String> authorizedUsers = const [],
      required this.createdAt,
      this.isActive = true,
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
  final String cnpj;
  @override
  final String? address;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String ownerId;
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
  @JsonKey()
  final bool isActive;
  final Map<String, dynamic> _settings;
  @override
  @JsonKey()
  Map<String, dynamic> get settings {
    if (_settings is EqualUnmodifiableMapView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_settings);
  }

  @override
  String toString() {
    return 'Business(id: $id, name: $name, cnpj: $cnpj, address: $address, phone: $phone, email: $email, ownerId: $ownerId, authorizedUsers: $authorizedUsers, createdAt: $createdAt, isActive: $isActive, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.cnpj, cnpj) || other.cnpj == cnpj) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality()
                .equals(other._authorizedUsers, _authorizedUsers) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other._settings, _settings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      cnpj,
      address,
      phone,
      email,
      ownerId,
      const DeepCollectionEquality().hash(_authorizedUsers),
      createdAt,
      isActive,
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
      required final String cnpj,
      final String? address,
      final String? phone,
      final String? email,
      required final String ownerId,
      final List<String> authorizedUsers,
      required final DateTime createdAt,
      final bool isActive,
      final Map<String, dynamic> settings}) = _$BusinessImpl;

  factory _Business.fromJson(Map<String, dynamic> json) =
      _$BusinessImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get cnpj;
  @override
  String? get address;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  String get ownerId;
  @override
  List<String> get authorizedUsers;
  @override
  DateTime get createdAt;
  @override
  bool get isActive;
  @override
  Map<String, dynamic> get settings;

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessImplCopyWith<_$BusinessImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
