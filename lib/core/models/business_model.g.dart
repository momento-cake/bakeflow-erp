// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessImpl _$$BusinessImplFromJson(Map<String, dynamic> json) =>
    _$BusinessImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      cnpj: json['cnpj'] as String?,
      fantasyName: json['fantasyName'] as String?,
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      type: json['type'] == null
          ? const BusinessType.soloEntrepreneur()
          : BusinessType.fromJson(json['type']),
      status: json['status'] == null
          ? const BusinessStatus.active()
          : BusinessStatus.fromJson(json['status']),
      authorizedUsers: (json['authorizedUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdBy: json['createdBy'] as String,
      settings: json['settings'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$BusinessImplToJson(_$BusinessImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cnpj': instance.cnpj,
      'fantasyName': instance.fantasyName,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'phone': instance.phone,
      'email': instance.email,
      'type': instance.type,
      'status': instance.status,
      'authorizedUsers': instance.authorizedUsers,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdBy': instance.createdBy,
      'settings': instance.settings,
    };

_$BusinessSettingsImpl _$$BusinessSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$BusinessSettingsImpl(
      locale: json['locale'] as String? ?? 'pt-BR',
      currency: json['currency'] as String? ?? 'BRL',
      dateFormat: json['dateFormat'] as String? ?? 'dd/MM/yyyy',
      defaultMargin: (json['defaultMargin'] as num?)?.toDouble() ?? 100.0,
      enableInventoryTracking: json['enableInventoryTracking'] as bool? ?? true,
      enableCostCalculation: json['enableCostCalculation'] as bool? ?? true,
      enableMultiLocation: json['enableMultiLocation'] as bool? ?? false,
      customFields: json['customFields'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$BusinessSettingsImplToJson(
        _$BusinessSettingsImpl instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'currency': instance.currency,
      'dateFormat': instance.dateFormat,
      'defaultMargin': instance.defaultMargin,
      'enableInventoryTracking': instance.enableInventoryTracking,
      'enableCostCalculation': instance.enableCostCalculation,
      'enableMultiLocation': instance.enableMultiLocation,
      'customFields': instance.customFields,
    };
