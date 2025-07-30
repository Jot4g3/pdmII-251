import 'package:flutter/material.dart';
import 'package:prova_pratica_02/data/models/supplier_model.dart';

class SupplierCard extends StatelessWidget {
  final SupplierModel supplier;

  const SupplierCard({super.key, required this.supplier});

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
                      supplier.name.substring(0,1)
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Text(
                  supplier.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const Divider(height: 4),
            Text('ID: ${supplier.id}', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 2),
            Text('CNPJ:', style: Theme.of(context).textTheme.labelLarge,),
            Text(
              supplier.cnpj,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Text('Contato:', style: Theme.of(context).textTheme.labelLarge,),
                Text(
                  supplier.contact,
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