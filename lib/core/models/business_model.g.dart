// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessImpl _$$BusinessImplFromJson(Map<String, dynamic> json) =>
    _$BusinessImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      cnpj: json['cnpj'] as String,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      ownerId: json['ownerId'] as String,
      authorizedUsers: (json['authorizedUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      isActive: json['isActive'] as bool? ?? true,
      settings: json['settings'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$BusinessImplToJson(_$BusinessImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cnpj': instance.cnpj,
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
      'ownerId': instance.ownerId,
      'authorizedUsers': instance.authorizedUsers,
      'createdAt': instance.createdAt.toIso8601String(),
      'isActive': instance.isActive,
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
