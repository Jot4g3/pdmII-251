import 'package:flutter/material.dart';
import 'package:prova_pratica_02/data/providers/auth_provider.dart';
import 'package:prova_pratica_02/data/providers/customer_provider.dart';
import 'package:prova_pratica_02/data/providers/order_provider.dart';
import 'package:prova_pratica_02/data/providers/product_provider.dart';
import 'package:prova_pratica_02/data/providers/supplier_provider.dart';
import 'package:prova_pratica_02/presentation/screens/auth/login_screen.dart';
import 'package:prova_pratica_02/presentation/screens/main_menu_screen.dart';
import 'package:prova_pratica_02/presentation/screens/auth/register_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => SupplierProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: const MainApp()
    ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return MaterialApp(
      title: 'Gerenciador de Empresas',
      debugShowCheckedModeBanner: false,
      // Lógica para mostrar a tela de login ou o menu principal
      home: LoginScreen()
    );
  }
}
