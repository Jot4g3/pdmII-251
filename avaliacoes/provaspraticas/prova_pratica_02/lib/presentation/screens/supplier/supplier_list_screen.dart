import 'dart:math'; // Import para a função 'min'
import 'package:flutter/material.dart';
import 'package:prova_pratica_02/data/providers/product_provider.dart';
import 'package:prova_pratica_02/data/providers/supplier_provider.dart';
import 'package:prova_pratica_02/presentation/widgets/product_card.dart';
import 'package:prova_pratica_02/presentation/widgets/supplier_card.dart';
import 'package:provider/provider.dart';

class SupplierListScreen extends StatelessWidget {
  const SupplierListScreen({super.key});

  // Definimos quantos itens queremos por página
  final int itemsPerPage = 3;

  @override
  Widget build(BuildContext context) {
    return Consumer<SupplierProvider>(
      builder: (context, supplierProvider, child) {
        final suppliers = supplierProvider.suppliers;

        // Se a lista estiver vazia, mostra uma mensagem centralizada
        if (suppliers.isEmpty) {
          return const Center(
            child: Text(
              'Nenhum fornecedor cadastrado.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        // --- LÓGICA DE PAGINAÇÃO COMEÇA AQUI ---

        // 1. Calcula o número total de páginas necessárias
        final int pageCount = (suppliers.length / itemsPerPage).ceil();

        // Estrutura principal da tela
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Lista de Fornecedores",
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
                    final endIndex = min(startIndex + itemsPerPage, suppliers.length);
                    
                    // 4. Pega a sub-lista de fornecedores para a página atual
                    final pagesuppliers = suppliers.sublist(startIndex, endIndex);

                    // 5. Retorna uma ListView para exibir os 3 (ou menos) fornecedores
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...pagesuppliers.map((supplier) => SupplierCard(supplier: supplier))
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