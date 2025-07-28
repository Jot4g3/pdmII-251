// Classe-modelo Fornecedores

class SupplierModel {
  final String id;
  final String name;
  final String cnpj; // CNPJ ou outro identificador
  final String contact;

  SupplierModel({
    required this.name,
    required this.cnpj,
    required this.contact,
  }) : id = DateTime.now().toIso8601String();
}