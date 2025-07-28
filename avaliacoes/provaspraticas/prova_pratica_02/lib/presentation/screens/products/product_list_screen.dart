import 'dart:math'; // Import para a função 'min'
import 'package:flutter/material.dart';
import 'package:prova_pratica_02/data/providers/product_provider.dart';
import 'package:prova_pratica_02/presentation/widgets/product_card.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  // Definimos quantos itens queremos por página
  final int itemsPerPage = 3;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        final products = productProvider.products;

        // Se a lista estiver vazia, mostra uma mensagem centralizada
        if (products.isEmpty) {
          return const Center(
            child: Text(
              'Nenhum produto cadastrado.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        // --- LÓGICA DE PAGINAÇÃO COMEÇA AQUI ---

        // 1. Calcula o número total de páginas necessárias
        final int pageCount = (products.length / itemsPerPage).ceil();

        // Estrutura principal da tela
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Lista de Produtos",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.deepPurple),
              ),
              const Text(
                "Role horizontalmente para ver mais páginas.",
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
              ),
              Expanded(
                child: PageView.builder(
                  // 2. O itemCount agora é o número de páginas
                  itemCount: pageCount,
                  // O builder cria uma página por vez
                  itemBuilder: (context, pageIndex) {
                    // 3. Calcula os índices de início e fim para a fatia da lista
                    final startIndex = pageIndex * itemsPerPage;
                    final endIndex = min(startIndex + itemsPerPage, products.length);
                    
                    // 4. Pega a sub-lista de clientes para a página atual
                    final pageProducts = products.sublist(startIndex, endIndex);

                    // 5. Retorna uma ListView para exibir os 3 (ou menos) clientes
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...pageProducts.map((product) => ProductCard(product: product))
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}