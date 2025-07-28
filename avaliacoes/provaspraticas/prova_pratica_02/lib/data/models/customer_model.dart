// Classe-modelo Clientes

class CustomerModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  CustomerModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone
  }) : id = DateTime.now().toIso8601String();
}