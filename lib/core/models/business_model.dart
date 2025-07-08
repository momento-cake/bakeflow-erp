import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_model.freezed.dart';
part 'business_model.g.dart';

@freezed
class Business with _$Business {
  const factory Business({
    required String id,
    required String name,
    required String cnpj,
    String? address,
    String? phone,
    String? email,
    required String ownerId,
    @Default([]) List<String> authorizedUsers,
    required DateTime createdAt,
    @Default(true) bool isActive,
    @Default({}) Map<String, dynamic> settings,
  }) = _Business;

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);
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