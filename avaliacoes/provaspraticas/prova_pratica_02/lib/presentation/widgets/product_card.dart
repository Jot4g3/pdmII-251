import 'package:flutter/material.dart';
import 'package:prova_pratica_02/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

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
                      product.name.substring(0,1)
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const Divider(height: 4),
            Text('ID: ${product.id}', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 2),
            Text('Descrição:', style: Theme.of(context).textTheme.labelLarge,),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Text('Preço:', style: Theme.of(context).textTheme.labelLarge,),
                Text(
                  'R\$ ${product.price}',
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