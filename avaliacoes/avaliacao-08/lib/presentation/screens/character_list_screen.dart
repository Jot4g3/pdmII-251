import 'package:avaliacao_08/presentation/providers/character_provider.dart';
import 'package:avaliacao_08/presentation/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  // Pedimos para o provider buscar os dados assim que a tela é construída
  @override
  void initState() {
    super.initState();
    // Usamos listen: false aqui porque só queremos chamar a função,
    // não precisamos reconstruir o widget dentro do initState.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CharacterProvider>(context, listen: false).fetchCharacters();
    });
  }

  Future<void> _refreshCharacters(BuildContext context) async {
    await Provider.of<CharacterProvider>(context, listen: false).fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty Characters'),
      ),
      // O Consumer é o widget do Provider que ouve as mudanças e se redesenha
      body: Consumer<CharacterProvider>(
        builder: (context, provider, child) {
          // 1. Estado de Carregamento
          if (provider.isLoading && provider.characters.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Estado de Erro
          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                children: [
                  Text("Ocorreu um erro: \n ${provider.errorMessage}", style: TextStyle(color: Colors.red)),
                  const SizedBox(height: 20,),
                  ElevatedButton(onPressed: () => _refreshCharacters(context), child: const Text("Tentar Novamente"))
                ],
              ),
            );
          }

          // 3. Estado de Sucesso
          return RefreshIndicator(
            child: ListView.builder(
              itemCount: provider.characters.length,
              itemBuilder: (context, index) {
                final character = provider.characters[index];
                // Card personalizado de personagem
                return CharacterCard(character: character);
              },
            ), 
            onRefresh: () => _refreshCharacters(context)
          );
        },
      ),
    );
  }
}