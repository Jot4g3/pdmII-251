import 'package:flutter/material.dart';
import 'package:prova_pratica_02/data/models/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza o conteúdo no Card
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    child: Text(
                      order.customer.firstName.substring(0,1)
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Text(
                  order.customer.firstName,
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const Divider(height: 4),
            Text('ID: ${order.id}', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 2),
            Text('Itens:', style: Theme.of(context).textTheme.labelLarge,),
            Column(
              children: [
                ...order.items.entries.map((entry) {
                  final product = entry.key;
                  final quantity = entry.value;

                  return Text(
                    '- ${quantity}x ${product.name} (R\$ ${product.price.toStringAsFixed(2)} cada)',
                    style: const TextStyle(height: 1.5),
                  );
                }).toList(),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Text('Preço:', style: Theme.of(context).textTheme.labelLarge,),
                SizedBox(width: 5,),
                Text(
                  'R\$ ${order.totalAmount}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Row(
              children: [
                Text('Data:', style: Theme.of(context).textTheme.labelLarge,),
                SizedBox(width: 5,),
                Text(
                  'R\$ ${order.orderDate}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}