// Classe-modelo Produtos

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;

  ProductModel({
    required this.name,
    required this.description,
    required this.price,
  }) : id = DateTime.now().toIso8601String();
}