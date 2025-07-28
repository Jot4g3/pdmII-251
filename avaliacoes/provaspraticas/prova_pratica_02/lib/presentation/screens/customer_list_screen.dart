import 'dart:math'; // Import para a função 'min'
import 'package:flutter/material.dart';
import 'package:prova_pratica_02/presentation/widgets/customer_card.dart'; // Ajuste o caminho
import 'package:provider/provider.dart';
import 'package:prova_pratica_02/data/providers/customer_provider.dart'; // Ajuste o caminho

class CustomerListScreen extends StatelessWidget {
  const CustomerListScreen({super.key});

  // Definimos quantos itens queremos por página
  final int itemsPerPage = 3;

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProvider>(
      builder: (context, customerProvider, child) {
        final customers = customerProvider.customers;

        // Se a lista estiver vazia, mostra uma mensagem centralizada
        if (customers.isEmpty) {
          return const Center(
            child: Text(
              'Nenhum cliente cadastrado.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        // --- LÓGICA DE PAGINAÇÃO COMEÇA AQUI ---

        // 1. Calcula o número total de páginas necessárias
        final int pageCount = (customers.length / itemsPerPage).ceil();

        // Estrutura principal da tela
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Lista de Clientes",
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
                    final endIndex = min(startIndex + itemsPerPage, customers.length);
                    
                    // 4. Pega a sub-lista de clientes para a página atual
                    final pageCustomers = customers.sublist(startIndex, endIndex);

                    // 5. Retorna uma ListView para exibir os 3 (ou menos) clientes
                    return ListView.builder(
                      // Importante: desativa o scroll da ListView interna
                      // para não conflitar com o scroll do PageView.
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: pageCustomers.length,
                      itemBuilder: (ctx, itemIndex) {
                        final customer = pageCustomers[itemIndex];
                        return CustomerCard(customer: customer);
                      },
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