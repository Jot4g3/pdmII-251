import 'dart:math'; // Import para a função 'min'
import 'package:flutter/material.dart';
import 'package:prova_pratica_02/data/providers/order_provider.dart';
import 'package:prova_pratica_02/data/providers/product_provider.dart';
import 'package:prova_pratica_02/presentation/widgets/order_card.dart';
import 'package:prova_pratica_02/presentation/widgets/product_card.dart';
import 'package:provider/provider.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  // Definimos quantos itens queremos por página
  final int itemsPerPage = 2;

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, productProvider, child) {
        final orders = productProvider.orders;

        // Se a lista estiver vazia, mostra uma mensagem centralizada
        if (orders.isEmpty) {
          return const Center(
            child: Text(
              'Nenhum pedido cadastrado.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        // --- LÓGICA DE PAGINAÇÃO COMEÇA AQUI ---

        // 1. Calcula o número total de páginas necessárias
        final int pageCount = (orders.length / itemsPerPage).ceil();

        // Estrutura principal da tela
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Lista de Pedidos",
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
                    final endIndex = min(startIndex + itemsPerPage, orders.length);
                    
                    // 4. Pega a sub-lista de produtos para a página atual
                    final pageProducts = orders.sublist(startIndex, endIndex);

                    // 5. Retorna uma ListView para exibir os 3 (ou menos) produtos
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...pageProducts.map((order) => OrderCard(order: order))
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