class FormValidators { // Classe de validadores de formulário

  // Validador de nulidade
  static String? notNull(String? value){
    if (value == null || value.isEmpty) return "Campo obrigatório";
  }

  // Validador de CNPJ
  static String? validateCnpj(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    // Remove todos os caracteres que não são dígitos.
    // Isso remove a máscara (pontos, barra, traço) antes de validar.
    final String cnpj = value.replaceAll(RegExp(r'[^\d]'), '');

    if (cnpj.length != 14) {
      return 'CNPJ precisa ter 14 dígitos';
    }

    // Validação para evitar sequências de números iguais
    if (RegExp(r'^(\d)\1*$').hasMatch(cnpj)) {
      return 'CNPJ inválido';
    }

    // Lógica completa de validação do algoritmo do CNPJ
    try {
      List<int> numbers = cnpj.split('').map((d) => int.parse(d)).toList();
      
      // Validação do primeiro dígito verificador
      var calc = 0;
      var weight = 5;
      for (int i = 0; i < 12; i++) {
        calc += numbers[i] * weight;
        weight--;
        if (weight < 2) weight = 9;
      }
      var digit = 11 - (calc % 11);
      if (digit > 9) digit = 0;
      if (numbers[12] != digit) return 'CNPJ inválido';

      // Validação do segundo dígito verificador
      calc = 0;
      weight = 6;
      for (int i = 0; i < 13; i++) {
        calc += numbers[i] * weight;
        weight--;
        if (weight < 2) weight = 9;
      }
      digit = 11 - (calc % 11);
      if (digit > 9) digit = 0;
      if (numbers[13] != digit) return 'CNPJ inválido';
      
    } catch (e) {
      return 'CNPJ inválido';
    }

    return null; // Se passou por tudo, é válido
  }

  // Validador de e-mail
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    // Regex para validar o formato de e-mail padrão.
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Por favor, insira um e-mail válido';
    }
    return null;
  }

  // Validador de telefone
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    // Remove a máscara e caracteres não numéricos.
    final String phone = value.replaceAll(RegExp(r'[^\d]'), '');
    
    // Verifica se o telefone tem 10 (fixo com DDD) ou 11 (celular com DDD) dígitos.
    if (phone.length < 9 || phone.length > 11) {
      return 'Número de telefone inválido';
    }
    return null;
  }
}