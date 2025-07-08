class AuthValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email é obrigatório';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$',
    );
    
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Digite um email válido';
    }
    
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }
    
    if (value.length < 6) {
      return 'Senha deve ter pelo menos 6 caracteres';
    }
    
    if (value.length > 128) {
      return 'Senha muito longa (máximo 128 caracteres)';
    }
    
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Confirmação de senha é obrigatória';
    }
    
    if (value != password) {
      return 'Senhas não coincidem';
    }
    
    return null;
  }

  static String? validateBusinessName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nome da empresa é obrigatório';
    }
    
    if (value.length < 2) {
      return 'Nome deve ter pelo menos 2 caracteres';
    }
    
    if (value.length > 100) {
      return 'Nome muito longo (máximo 100 caracteres)';
    }
    
    return null;
  }

  static String? validateCNPJ(String? value) {
    if (value == null || value.isEmpty) {
      return null; // CNPJ is optional
    }
    
    // Remove non-numeric characters
    final cnpj = value.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cnpj.length != 14) {
      return 'CNPJ deve ter 14 dígitos';
    }
    
    // Basic CNPJ validation
    if (!_isValidCNPJ(cnpj)) {
      return 'CNPJ inválido';
    }
    
    return null;
  }

  static String? validateDisplayName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nome é obrigatório';
    }
    
    if (value.length < 2) {
      return 'Nome deve ter pelo menos 2 caracteres';
    }
    
    if (value.length > 50) {
      return 'Nome muito longo (máximo 50 caracteres)';
    }
    
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Phone is optional
    }
    
    // Remove non-numeric characters
    final phone = value.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (phone.length < 10 || phone.length > 11) {
      return 'Telefone deve ter 10 ou 11 dígitos';
    }
    
    return null;
  }

  static bool _isValidCNPJ(String cnpj) {
    // Basic CNPJ validation algorithm
    if (cnpj.length != 14) return false;
    
    // Check if all digits are the same
    if (RegExp(r'^(\d)\1{13}$').hasMatch(cnpj)) return false;
    
    // Calculate first check digit
    int sum = 0;
    final weights1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    
    for (int i = 0; i < 12; i++) {
      sum += int.parse(cnpj[i]) * weights1[i];
    }
    
    int remainder = sum % 11;
    int firstDigit = remainder < 2 ? 0 : 11 - remainder;
    
    if (int.parse(cnpj[12]) != firstDigit) return false;
    
    // Calculate second check digit
    sum = 0;
    final weights2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    
    for (int i = 0; i < 13; i++) {
      sum += int.parse(cnpj[i]) * weights2[i];
    }
    
    remainder = sum % 11;
    int secondDigit = remainder < 2 ? 0 : 11 - remainder;
    
    return int.parse(cnpj[13]) == secondDigit;
  }
}

extension StringExtension on String {
  String formatCNPJ() {
    final cnpj = replaceAll(RegExp(r'[^0-9]'), '');
    if (cnpj.length != 14) return this;
    
    return '${cnpj.substring(0, 2)}.${cnpj.substring(2, 5)}.${cnpj.substring(5, 8)}/${cnpj.substring(8, 12)}-${cnpj.substring(12, 14)}';
  }
  
  String formatPhone() {
    final phone = replaceAll(RegExp(r'[^0-9]'), '');
    if (phone.length == 10) {
      return '(${phone.substring(0, 2)}) ${phone.substring(2, 6)}-${phone.substring(6, 10)}';
    } else if (phone.length == 11) {
      return '(${phone.substring(0, 2)}) ${phone.substring(2, 7)}-${phone.substring(7, 11)}';
    }
    return this;
  }
}