// lib/presentation/customer/customer_screen.dart
import 'package:flutter/material.dart';
import 'package:prova_pratica_02/presentation/screens/products/product_form_screen.dart';
import 'package:prova_pratica_02/presentation/screens/products/product_list_screen.dart';
import 'package:prova_pratica_02/presentation/screens/supplier/supplier_form_screen.dart';
import 'package:prova_pratica_02/presentation/screens/supplier/supplier_list_screen.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({super.key});

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

// Usamos 'SingleTickerProviderStateMixin' para o TabController
class _SupplierScreenState extends State<SupplierScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Inicializa o controller com 2 abas
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Fornecedores'),
        // A TabBar fica na parte de baixo da AppBar
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.deepPurple, // Cor da linha selecionada
          indicatorWeight: 4.0,
          tabs: const [
            Tab(
              icon: Icon(Icons.add_box),
              text: 'Cadastrar',
            ),
            Tab(
              icon: Icon(Icons.list_alt),
              text: 'Listar',
            ),
          ],
        ),
      ),
      // O corpo da tela é a TabBarView, que contém o conteúdo de cada aba
      body: TabBarView(
        controller: _tabController,
        children: const [
          // Conteúdo da primeira aba
          SupplierFormScreen(),
          // Conteúdo da segunda aba
          SupplierListScreen(),
        ],
      ),
    );
  }
}