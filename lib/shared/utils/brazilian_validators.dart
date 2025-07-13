
class BrazilianValidators {
  // CNPJ Validation
  static bool isValidCnpj(String cnpj) {
    // Remove formatting
    cnpj = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Check length
    if (cnpj.length != 14) return false;
    
    // Check for repeated numbers
    if (RegExp(r'^(.)\1*$').hasMatch(cnpj)) return false;
    
    // Calculate first verification digit
    int sum = 0;
    List<int> weights1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    
    for (int i = 0; i < 12; i++) {
      sum += int.parse(cnpj[i]) * weights1[i];
    }
    
    int remainder = sum % 11;
    int digit1 = remainder < 2 ? 0 : 11 - remainder;
    
    if (int.parse(cnpj[12]) != digit1) return false;
    
    // Calculate second verification digit
    sum = 0;
    List<int> weights2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    
    for (int i = 0; i < 13; i++) {
      sum += int.parse(cnpj[i]) * weights2[i];
    }
    
    remainder = sum % 11;
    int digit2 = remainder < 2 ? 0 : 11 - remainder;
    
    return int.parse(cnpj[13]) == digit2;
  }
  
  // CPF Validation
  static bool isValidCpf(String cpf) {
    // Remove formatting
    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Check length
    if (cpf.length != 11) return false;
    
    // Check for repeated numbers
    if (RegExp(r'^(.)\1*$').hasMatch(cpf)) return false;
    
    // Calculate first verification digit
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(cpf[i]) * (10 - i);
    }
    
    int remainder = sum % 11;
    int digit1 = remainder < 2 ? 0 : 11 - remainder;
    
    if (int.parse(cpf[9]) != digit1) return false;
    
    // Calculate second verification digit
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(cpf[i]) * (11 - i);
    }
    
    remainder = sum % 11;
    int digit2 = remainder < 2 ? 0 : 11 - remainder;
    
    return int.parse(cpf[10]) == digit2;
  }
  
  // Brazilian Phone Validation
  static bool isValidPhone(String phone) {
    // Remove formatting
    phone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Check length (10 or 11 digits)
    if (phone.length != 10 && phone.length != 11) return false;
    
    // Check area code (first two digits should be between 11-99)
    int areaCode = int.parse(phone.substring(0, 2));
    if (areaCode < 11 || areaCode > 99) return false;
    
    // For 11 digits, third digit should be 9 (mobile)
    if (phone.length == 11) {
      if (phone[2] != '9') return false;
    }
    
    return true;
  }
  
  // Brazilian ZIP Code Validation
  static bool isValidZipCode(String zipCode) {
    // Remove formatting
    zipCode = zipCode.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Check length (8 digits)
    return zipCode.length == 8;
  }
  
  // Email Validation
  static bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }
}

class BrazilianFormatters {
  // Format CNPJ: XX.XXX.XXX/XXXX-XX
  static String formatCnpj(String cnpj) {
    cnpj = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cnpj.length != 14) return cnpj;
    
    return cnpj.replaceAllMapped(
      RegExp(r'(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})'),
      (match) => '${match[1]}.${match[2]}.${match[3]}/${match[4]}-${match[5]}',
    );
  }
  
  // Format CPF: XXX.XXX.XXX-XX
  static String formatCpf(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cpf.length != 11) return cpf;
    
    return cpf.replaceAllMapped(
      RegExp(r'(\d{3})(\d{3})(\d{3})(\d{2})'),
      (match) => '${match[1]}.${match[2]}.${match[3]}-${match[4]}',
    );
  }
  
  // Format Phone: (XX) XXXXX-XXXX or (XX) XXXX-XXXX
  static String formatPhone(String phone) {
    phone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (phone.length == 10) {
      return phone.replaceAllMapped(
        RegExp(r'(\d{2})(\d{4})(\d{4})'),
        (match) => '(${match[1]}) ${match[2]}-${match[3]}',
      );
    } else if (phone.length == 11) {
      return phone.replaceAllMapped(
        RegExp(r'(\d{2})(\d{5})(\d{4})'),
        (match) => '(${match[1]}) ${match[2]}-${match[3]}',
      );
    }
    
    return phone;
  }
  
  // Format ZIP Code: XXXXX-XXX
  static String formatZipCode(String zipCode) {
    zipCode = zipCode.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (zipCode.length != 8) return zipCode;
    
    return zipCode.replaceAllMapped(
      RegExp(r'(\d{5})(\d{3})'),
      (match) => '${match[1]}-${match[2]}',
    );
  }
  
  // Remove formatting from any string
  static String removeFormatting(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }
}

class BrazilianStates {
  static const List<Map<String, String>> states = [
    {'code': 'AC', 'name': 'Acre'},
    {'code': 'AL', 'name': 'Alagoas'},
    {'code': 'AP', 'name': 'Amapá'},
    {'code': 'AM', 'name': 'Amazonas'},
    {'code': 'BA', 'name': 'Bahia'},
    {'code': 'CE', 'name': 'Ceará'},
    {'code': 'DF', 'name': 'Distrito Federal'},
    {'code': 'ES', 'name': 'Espírito Santo'},
    {'code': 'GO', 'name': 'Goiás'},
    {'code': 'MA', 'name': 'Maranhão'},
    {'code': 'MT', 'name': 'Mato Grosso'},
    {'code': 'MS', 'name': 'Mato Grosso do Sul'},
    {'code': 'MG', 'name': 'Minas Gerais'},
    {'code': 'PA', 'name': 'Pará'},
    {'code': 'PB', 'name': 'Paraíba'},
    {'code': 'PR', 'name': 'Paraná'},
    {'code': 'PE', 'name': 'Pernambuco'},
    {'code': 'PI', 'name': 'Piauí'},
    {'code': 'RJ', 'name': 'Rio de Janeiro'},
    {'code': 'RN', 'name': 'Rio Grande do Norte'},
    {'code': 'RS', 'name': 'Rio Grande do Sul'},
    {'code': 'RO', 'name': 'Rondônia'},
    {'code': 'RR', 'name': 'Roraima'},
    {'code': 'SC', 'name': 'Santa Catarina'},
    {'code': 'SP', 'name': 'São Paulo'},
    {'code': 'SE', 'name': 'Sergipe'},
    {'code': 'TO', 'name': 'Tocantins'},
  ];
  
  static List<String> get codes => states.map((state) => state['code']!).toList();
  
  static List<String> get names => states.map((state) => state['name']!).toList();
  
  static String getNameByCode(String code) {
    final state = states.firstWhere(
      (state) => state['code'] == code,
      orElse: () => {'name': code},
    );
    return state['name']!;
  }
  
  static String getCodeByName(String name) {
    final state = states.firstWhere(
      (state) => state['name'] == name,
      orElse: () => {'code': name},
    );
    return state['code']!;
  }
}