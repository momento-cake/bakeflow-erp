import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_model.freezed.dart';
part 'business_model.g.dart';

@freezed
class Business with _$Business {
  const factory Business({
    required String id,
    required String name,
    String? cnpj, // Optional for solo entrepreneurs
    String? fantasyName, // Nome fantasia
    required String address,
    required String city,
    required String state,
    required String zipCode,
    required String phone,
    String? email,
    @Default(BusinessType.soloEntrepreneur()) BusinessType type,
    @Default(BusinessStatus.active()) BusinessStatus status,
    @Default([]) List<String> authorizedUsers,
    required DateTime createdAt,
    DateTime? updatedAt,
    required String createdBy, // Admin user ID who created this business
    @Default({}) Map<String, dynamic> settings,
  }) = _Business;

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);
}


@freezed
class BusinessType with _$BusinessType {
  const BusinessType._();
  
  const factory BusinessType.formalCompany() = _FormalCompany;
  const factory BusinessType.soloEntrepreneur() = _SoloEntrepreneur;

  factory BusinessType.fromJson(dynamic json) {
    if (json is String) {
      return BusinessType.fromString(json);
    }
    if (json is Map<String, dynamic>) {
      if (json.containsKey('type')) {
        return BusinessType.fromString(json['type'] as String);
      }
      if (json.containsKey('runtimeType')) {
        return BusinessType.fromString(json['runtimeType'] as String);
      }
    }
    return const BusinessType.soloEntrepreneur();
  }

  static BusinessType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'formalcompany':
      case 'formal_company':
        return const BusinessType.formalCompany();
      case 'soloentrepreneur':
      case 'solo_entrepreneur':
        return const BusinessType.soloEntrepreneur();
      default:
        return const BusinessType.soloEntrepreneur();
    }
  }

  Map<String, dynamic> toJson() => {
    'type': name,
  };

  String get name => when(
    formalCompany: () => 'formal_company',
    soloEntrepreneur: () => 'solo_entrepreneur',
  );

  String get displayName => when(
    formalCompany: () => 'Empresa Formal / MEI',
    soloEntrepreneur: () => 'Empreendedor Individual',
  );

  bool get requiresCnpj => when(
    formalCompany: () => true,
    soloEntrepreneur: () => false,
  );

  bool get allowsMultipleUsers => when(
    formalCompany: () => true,
    soloEntrepreneur: () => false,
  );
}

@freezed
class BusinessStatus with _$BusinessStatus {
  const BusinessStatus._();
  
  const factory BusinessStatus.active() = _Active;
  const factory BusinessStatus.inactive() = _Inactive;
  const factory BusinessStatus.suspended() = _Suspended;

  factory BusinessStatus.fromJson(dynamic json) {
    if (json is String) {
      return BusinessStatus.fromString(json);
    }
    if (json is Map<String, dynamic>) {
      if (json.containsKey('type')) {
        return BusinessStatus.fromString(json['type'] as String);
      }
      if (json.containsKey('runtimeType')) {
        return BusinessStatus.fromString(json['runtimeType'] as String);
      }
    }
    return const BusinessStatus.active();
  }

  static BusinessStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'active':
        return const BusinessStatus.active();
      case 'inactive':
        return const BusinessStatus.inactive();
      case 'suspended':
        return const BusinessStatus.suspended();
      default:
        return const BusinessStatus.active();
    }
  }

  Map<String, dynamic> toJson() => {
    'type': name,
  };

  String get name => when(
    active: () => 'active',
    inactive: () => 'inactive',
    suspended: () => 'suspended',
  );

  String get displayName => when(
    active: () => 'Ativo',
    inactive: () => 'Inativo',
    suspended: () => 'Suspenso',
  );

  bool get isActive => when(
    active: () => true,
    inactive: () => false,
    suspended: () => false,
  );
}

@freezed
class BusinessSettings with _$BusinessSettings {
  const factory BusinessSettings({
    @Default('pt-BR') String locale,
    @Default('BRL') String currency,
    @Default('dd/MM/yyyy') String dateFormat,
    @Default(100.0) double defaultMargin,
    @Default(true) bool enableInventoryTracking,
    @Default(true) bool enableCostCalculation,
    @Default(false) bool enableMultiLocation,
    @Default({}) Map<String, dynamic> customFields,
  }) = _BusinessSettings;

  factory BusinessSettings.fromJson(Map<String, dynamic> json) =>
      _$BusinessSettingsFromJson(json);
}