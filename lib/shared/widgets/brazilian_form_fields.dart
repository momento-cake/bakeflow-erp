import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app/themes/app_theme.dart';
import '../../core/models/business_model.dart';
import '../utils/brazilian_validators.dart';

class BrazilianFormFields {
  // CNPJ Input Field
  static Widget cnpjField({
    required TextEditingController controller,
    String? labelText,
    String? hintText,
    bool enabled = true,
    FormFieldValidator<String>? validator,
    VoidCallback? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText ?? 'CNPJ',
        hintText: hintText ?? 'XX.XXX.XXX/XXXX-XX',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
        ),
        prefixIcon: const Icon(Icons.business),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TextInputFormatter.withFunction((oldValue, newValue) {
          final text = newValue.text;
          if (text.length <= 14) {
            return TextEditingValue(
              text: BrazilianFormatters.formatCnpj(text),
              selection: TextSelection.collapsed(
                offset: BrazilianFormatters.formatCnpj(text).length,
              ),
            );
          }
          return oldValue;
        }),
      ],
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'CNPJ é obrigatório';
        }
        if (!BrazilianValidators.isValidCnpj(value)) {
          return 'CNPJ inválido';
        }
        return null;
      },
      onChanged: onChanged != null ? (value) => onChanged() : null,
    );
  }

  // Phone Input Field
  static Widget phoneField({
    required TextEditingController controller,
    String? labelText,
    String? hintText,
    bool enabled = true,
    FormFieldValidator<String>? validator,
    VoidCallback? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText ?? 'Telefone',
        hintText: hintText ?? '(XX) XXXXX-XXXX',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
        ),
        prefixIcon: const Icon(Icons.phone),
      ),
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TextInputFormatter.withFunction((oldValue, newValue) {
          final text = newValue.text;
          if (text.length <= 11) {
            return TextEditingValue(
              text: BrazilianFormatters.formatPhone(text),
              selection: TextSelection.collapsed(
                offset: BrazilianFormatters.formatPhone(text).length,
              ),
            );
          }
          return oldValue;
        }),
      ],
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Telefone é obrigatório';
        }
        if (!BrazilianValidators.isValidPhone(value)) {
          return 'Telefone inválido';
        }
        return null;
      },
      onChanged: onChanged != null ? (value) => onChanged() : null,
    );
  }

  // ZIP Code Input Field
  static Widget zipCodeField({
    required TextEditingController controller,
    String? labelText,
    String? hintText,
    bool enabled = true,
    FormFieldValidator<String>? validator,
    VoidCallback? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText ?? 'CEP',
        hintText: hintText ?? 'XXXXX-XXX',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
        ),
        prefixIcon: const Icon(Icons.location_on),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TextInputFormatter.withFunction((oldValue, newValue) {
          final text = newValue.text;
          if (text.length <= 8) {
            return TextEditingValue(
              text: BrazilianFormatters.formatZipCode(text),
              selection: TextSelection.collapsed(
                offset: BrazilianFormatters.formatZipCode(text).length,
              ),
            );
          }
          return oldValue;
        }),
      ],
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'CEP é obrigatório';
        }
        if (!BrazilianValidators.isValidZipCode(value)) {
          return 'CEP inválido';
        }
        return null;
      },
      onChanged: onChanged != null ? (value) => onChanged() : null,
    );
  }

  // State Dropdown Field
  static Widget stateDropdownField({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? labelText,
    bool enabled = true,
    FormFieldValidator<String>? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: enabled ? onChanged : null,
      decoration: InputDecoration(
        labelText: labelText ?? 'Estado',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
        ),
        prefixIcon: const Icon(Icons.map),
      ),
      items: BrazilianStates.states.map((state) {
        return DropdownMenuItem<String>(
          value: state['code'],
          child: Text('${state['code']} - ${state['name']}'),
        );
      }).toList(),
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Estado é obrigatório';
        }
        return null;
      },
    );
  }

  // Business Type Radio Field
  static Widget businessTypeField({
    required BusinessType value,
    required ValueChanged<BusinessType> onChanged,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tipo de Empresa',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppTheme.neutralGray,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: [
            RadioListTile<BusinessType>(
              title: const Text('Empresa Formal / MEI'),
              subtitle: const Text('Empresa com CNPJ registrado'),
              value: const BusinessType.formalCompany(),
              groupValue: value,
              onChanged: enabled ? (val) => onChanged(val!) : null,
              activeColor: AppTheme.primaryColor,
            ),
            RadioListTile<BusinessType>(
              title: const Text('Empreendedor Individual'),
              subtitle: const Text('Pessoa física'),
              value: const BusinessType.soloEntrepreneur(),
              groupValue: value,
              onChanged: enabled ? (val) => onChanged(val!) : null,
              activeColor: AppTheme.primaryColor,
            ),
          ],
        ),
      ],
    );
  }

  // Email Input Field
  static Widget emailField({
    required TextEditingController controller,
    String? labelText,
    String? hintText,
    bool enabled = true,
    FormFieldValidator<String>? validator,
    VoidCallback? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText ?? 'E-mail',
        hintText: hintText ?? 'exemplo@email.com',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
        ),
        prefixIcon: const Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: validator ?? (value) {
        if (value != null && value.isNotEmpty) {
          if (!BrazilianValidators.isValidEmail(value)) {
            return 'E-mail inválido';
          }
        }
        return null;
      },
      onChanged: onChanged != null ? (value) => onChanged() : null,
    );
  }

  // Generic Text Field
  static Widget textField({
    required TextEditingController controller,
    required String labelText,
    String? hintText,
    IconData? prefixIcon,
    bool enabled = true,
    int maxLines = 1,
    FormFieldValidator<String>? validator,
    VoidCallback? onChanged,
    VoidCallback? onFieldSubmitted,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
        ),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
      validator: validator,
      onChanged: onChanged != null ? (value) => onChanged() : null,
      onFieldSubmitted: onFieldSubmitted != null ? (value) => onFieldSubmitted() : null,
    );
  }
}