import 'package:flutter/material.dart';
import 'package:prova_pratica_02/core/validators/form_validators.dart';
import 'package:prova_pratica_02/data/models/product_model.dart';
import 'package:prova_pratica_02/data/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus(); // Remove o foco e esconde o teclado.

      final newProduct = ProductModel(
        name: _nameController.text,
        description: _descController.text,
        price: double.tryParse(_priceController.text.replaceAll(',', '.')) ?? 0.0,
      );

      // Usa o provider para adicionar o produto, sem ouvir mudanças (listen: false)
      try{
        Provider.of<ProductProvider>(
          context,
          listen: false,
        ).addProduct(newProduct);
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
      _descController.clear();
      _priceController.clear();

      // Mostra uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produto cadastrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
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
              "Insira os dados do produto",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Colors.deepPurple,
              ),
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome', hintText: "Digite o nome do Produto..."),
              validator: FormValidators.notNull,
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Descrição', hintText: "Digite a descrição do Produto...", border: OutlineInputBorder(), alignLabelWithHint: true, floatingLabelBehavior: FloatingLabelBehavior.never),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              validator: FormValidators.notNull,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Preço', hintText: "Digite o preço do Produto...", prefix: Text("R\$")),
              keyboardType: TextInputType.number,
              inputFormatters: [
                // Permite apenas números e no máximo um separador (ponto ou vírgula)
                // E no máximo 2 casas decimais.
                FilteringTextInputFormatter.allow(RegExp(r'^\d+[,.]?\d{0,2}')),
              ],
              validator: FormValidators.notNull,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Salvar Produto'),
            ),
          ],
        ),
      ),
    );
  }
}
