import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:prova_pratica_02/data/models/customer_model.dart';
import 'package:prova_pratica_02/data/models/product_model.dart';
import 'package:prova_pratica_02/data/models/order_model.dart';

import 'package:prova_pratica_02/data/providers/customer_provider.dart';
import 'package:prova_pratica_02/data/providers/product_provider.dart';
import 'package:prova_pratica_02/data/providers/order_provider.dart';

class OrderFormScreen extends StatefulWidget {
  const OrderFormScreen({super.key});

  @override
  State<OrderFormScreen> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  // Estado local para gerenciar a montagem do pedido
  CustomerModel? _selectedCustomer;
  final Map<ProductModel, int> _cart = {}; // O nosso carrinho de compras

  void _addProductToCart(ProductModel product) {
    setState(() {
      _cart.update(product, (value) => value + 1, ifAbsent: () => 1);
    });
  }
  
  void _removeProductFromCart(ProductModel product) {
    setState(() {
      if (_cart.containsKey(product) && _cart[product]! > 1) {
        _cart.update(product, (value) => value - 1);
      } else {
        _cart.remove(product);
      }
    });
  }

  void _submitOrder() {
    if (_selectedCustomer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecione um cliente.'), backgroundColor: Colors.red),
      );
      return;
    }
    if (_cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('O carrinho de compras está vazio.'), backgroundColor: Colors.red),
      );
      return;
    }

    final newOrder = OrderModel(
      customer: _selectedCustomer!,
      items: Map.from(_cart),
    );

    Provider.of<OrderProvider>(context, listen: false).addOrder(newOrder);

    setState(() {
      _selectedCustomer = null;
      _cart.clear();
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pedido criado com sucesso!'), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Insira os dados do pedido",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 16),
              // --- SEÇÃO 1: SELEÇÃO DE CLIENTE ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonFormField<CustomerModel>(
                  value: _selectedCustomer,
                  hint: const Text('Selecione um Cliente'),
                  isExpanded: true,
                  items: customerProvider.customers.map((customer) {
                    return DropdownMenuItem(
                      value: customer,
                      // AJUSTE: Simplificado para um Row, que é mais seguro para o layout do dropdown
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Text(customer.firstName.substring(0,1)), // Assumindo que o modelo tem 'name'
                            radius: 15,
                          ),
                          const SizedBox(width: 10),
                          Text(customer.firstName), // Assumindo que o modelo tem 'name'
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (customer) {
                    setState(() {
                      _selectedCustomer = customer;
                    });
                  },
                  validator: (value) => value == null ? 'Campo obrigatório' : null,
                ),
              ),
              const Divider(height: 32, thickness: 2),
      
              // --- SEÇÃO 2: LISTA DE PRODUTOS DISPONÍVEIS ---
              const Text('Produtos Disponíveis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              // CORREÇÃO: Removido o 'Expanded' e adicionado 'shrinkWrap' e 'physics'
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: productProvider.products.isEmpty ? 1 : productProvider.products.length,
                itemBuilder: (context, index) {
                  if (productProvider.products.isEmpty) {
                    return const Center(child: Padding(padding: EdgeInsets.all(16.0), child: Text('Nenhum produto cadastrado.')));
                  }
                  final product = productProvider.products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_shopping_cart, color: Colors.deepPurple),
                      onPressed: () => _addProductToCart(product),
                    ),
                  );
                },
              ),
              const Divider(height: 32, thickness: 2),
              
              // --- SEÇÃO 3: CARRINHO / RESUMO DO PEDIDO ---
              const Text('Itens no Pedido', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              // CORREÇÃO: Removido o 'Expanded' e adicionado 'shrinkWrap' e 'physics'
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _cart.isEmpty ? 1 : _cart.length,
                itemBuilder: (context, index) {
                  if (_cart.isEmpty) {
                    return const Center(child: Padding(padding: EdgeInsets.all(16.0), child: Text('Carrinho vazio.')));
                  }
                  final product = _cart.keys.elementAt(index);
                  final quantity = _cart[product]!;
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text('Quantidade: $quantity'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: const Icon(Icons.remove), onPressed: () => _removeProductFromCart(product)),
                        IconButton(icon: const Icon(Icons.add), onPressed: () => _addProductToCart(product)),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              
              // --- BOTÃO FINALIZAR ---
              ElevatedButton.icon(
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Finalizar Pedido'),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                onPressed: _submitOrder,
              ),
            ],
          ),
        ),
      ),
    );
  }
}