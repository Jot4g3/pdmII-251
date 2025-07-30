// lib/presentation/customer/customer_form_screen.dart
import 'package:flutter/material.dart';
import 'package:prova_pratica_02/core/validators/form_validators.dart';
import 'package:prova_pratica_02/data/models/customer_model.dart';
import 'package:prova_pratica_02/data/models/supplier_model.dart';
import 'package:prova_pratica_02/data/providers/supplier_provider.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class SupplierFormScreen extends StatefulWidget {
  const SupplierFormScreen({super.key});

  @override
  State<SupplierFormScreen> createState() => _SupplierFormScreenState();
}

class _SupplierFormScreenState extends State<SupplierFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _contactController = TextEditingController();

  final _cnpjMaskFormatter = MaskTextInputFormatter(
    mask: '##.###.###/####-##', 
    filter: { "#": RegExp(r'[0-9]') }
  );

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus(); // Remove o foco e esconde o teclado.

      final newSupplier = SupplierModel(
        name: _nameController.text,
        cnpj: _cnpjController.text,
        contact: _contactController.text,
      );

      // Usa o provider para adicionar o cliente, sem ouvir mudanças (listen: false)
      try{
        Provider.of<SupplierProvider>(
          context,
          listen: false,
        ).addSupplier(newSupplier);
      } catch(err){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Ocorreu um erro: ${err}"),
            backgroundColor: Colors.red,
          ),
        );
      }

      // Limpa os campos após o envio
      _formKey.currentState!.reset();
      _nameController.clear();
      _cnpjController.clear();
      _contactController.clear();

      // Mostra uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cliente cadastrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cnpjController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          // Usamos ListView para evitar overflow em telas pequenas
          children: [
            Text(
              "Insira os dados do Fornecedor",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Colors.deepPurple,
              ),
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome', hintText: "Digite o nome do Fornecedor..."),
              validator: FormValidators.notNull,
            ),
            TextFormField(
              controller: _cnpjController,
              inputFormatters: [_cnpjMaskFormatter],
              decoration: const InputDecoration(labelText: 'CNPJ', hintText: '00.000.000/0000-00'),
              keyboardType: TextInputType.text,
              validator: FormValidators.validateCnpj,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _contactController,
              decoration: const InputDecoration(labelText: 'Contato', hintText: "Digite o contato do Cliente..."),
              keyboardType: TextInputType.text,
              validator: FormValidators.validatePhone,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Salvar Cliente'),
            ),
          ],
        ),
      ),
    );
  }
}
