import 'package:flutter/material.dart';
import 'package:prova_pratica_02/presentation/screens/auth/register_screen.dart';
import 'package:prova_pratica_02/presentation/screens/main_menu_screen.dart';
import 'package:provider/provider.dart';
import 'package:prova_pratica_02/data/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _passwordVisible = false;

  Future<void> _submitForm() async {
    // Valida o formulário
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Usa o AuthProvider para a lógica de login
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      final success = authProvider.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );


      if (!success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email ou senha inválidos.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocorreu um erro: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(fontWeight: FontWeight.w900)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ... Seus Text widgets de boas-vindas ...
              Text("Gerenciador de Empresas!", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w900, fontSize: 25),),
              Text("Por favor, faça login com a conta de sua empresa.", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),),
              
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail', hintText: "Digite o seu e-mail...", prefixIcon: Icon(Icons.email)),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  }

                  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                  final regExp = RegExp(pattern);
                  if (!regExp.hasMatch(value)) {
                    return 'Por favor, insira um e-mail válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: "Digite a sua senha...",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_passwordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua senha';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                        )
                      : const Text('Entrar'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Não possui conta?"),
                  TextButton(
                    onPressed: () {
                      // Navega para a tela de cadastro
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text("Crie uma agora!"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}