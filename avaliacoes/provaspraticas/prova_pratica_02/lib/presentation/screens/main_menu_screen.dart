import 'package:flutter/material.dart';
import 'package:prova_pratica_02/data/providers/auth_provider.dart';
import 'package:prova_pratica_02/presentation/screens/customer/customer_screen.dart';
import 'package:prova_pratica_02/presentation/screens/products/product_screen.dart';
import 'package:provider/provider.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Gerenciador de Empresas",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
            icon: const Icon(Icons.logout),
            tooltip: "Sair",
            color: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "O que deseja fazer hoje?",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Colors.deepPurple
              ),
            ),
            SizedBox(height: 20,),  
            ElevatedButton.icon(
              icon: const Icon(Icons.person_add),
              label: const Text('Gerenciar Clientes'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                // Navega para a tela de cadastro/listagem de clientes
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => CustomerScreen()));
              },
            ),
            const SizedBox(height: 16),

            // Botão para Cadastro de Produtos
            ElevatedButton.icon(
              icon: const Icon(Icons.shopping_bag),
              label: const Text('Gerenciar Produtos'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                // Navega para a tela de cadastro/listagem de produtos
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductScreen()));
              },
            ),
            const SizedBox(height: 16),

            // Botão para Cadastro de Fornecedores
            ElevatedButton.icon(
              icon: const Icon(Icons.local_shipping),
              label: const Text('Gerenciar Fornecedores'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                // Navega para a tela de cadastro/listagem de fornecedores
                // Navigator.of(context).push(MaterialPageRoute(builder: (_) => SupplierScreen()));
              },
            ),
            const SizedBox(height: 16),

            // Botão para Cadastro de Pedidos
            ElevatedButton.icon(
              icon: const Icon(Icons.receipt_long),
              label: const Text('Gerenciar Pedidos'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                // Navega para a tela de cadastro/listagem de pedidos
                // Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
