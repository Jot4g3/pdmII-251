// Classe-modelo pedidos

import 'package:prova_pratica_02/data/models/customer_model.dart';
import 'package:prova_pratica_02/data/models/product_model.dart';

class OrderModel {
  final String id;
  final CustomerModel customer;
  final Map<ProductModel, int> items;
  final DateTime orderDate;
  final double totalAmount;

  OrderModel({
    required this.customer,
    required this.items,
  })  : id = DateTime.now().toIso8601String(),
        orderDate = DateTime.now(),
        // Calcula o total do pedido somando o preço dos itens
        totalAmount = items.entries.fold(
          0.0,
          (sum, entry) => sum + (entry.key.price * entry.value),
        );
}