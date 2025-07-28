import 'package:flutter/material.dart';
import 'package:prova_pratica_02/data/models/customer_model.dart';

class CustomerCard extends StatelessWidget {
  final CustomerModel customer;

  const CustomerCard({super.key, required this.customer});

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
                CircleAvatar(
                  child: Text(
                    customer.firstName.substring(0,1)
                  ),
                ),
                Text(
                  customer.firstName + " " + customer.lastName,
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const Divider(height: 4),
            Text('ID: ${customer.id}', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 2),
            Text('Email: ', style: Theme.of(context).textTheme.labelLarge,),
            Text(customer.email),
            const SizedBox(height: 2),
            Text('Telefone: ', style: Theme.of(context).textTheme.labelLarge,),
            Text(customer.phone),
          ],
        ),
      ),
    );
  }
}