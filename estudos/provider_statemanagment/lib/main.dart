import 'package:flutter/material.dart';
import 'package:flutter_application_1/carrinho.dart';
import 'package:flutter_application_1/lista_games.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // Provider como gerenciador de estado global: O Provider é configurado na raiz da aplicação (normalmente no método main), onde se cria uma instância única do modelo de estado — no caso, a classe Carrinho que estende ChangeNotifier
    ChangeNotifierProvider(
      create: (context) => Carrinho(), // Essa instância é compartilhada e acessível por qualquer widget na árvore de widgets, evitando a criação de múltiplas instâncias e facilitando a manutenção do estado global do carrinho.
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: TelaPrincipal(),
    );
  }
}

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final total = context.watch<Carrinho>().total; // O estado é acessado via context.watch<Carrinho>() para obter o valor atualizado e reconstruir o widget quando o carrinho mudar.

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total: R\$ $total', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaJogos()),
                );
              },
              child: Text('Adicionar Itens'),
            ),
          ],
        ),
      ),
    );
  }
}

class ListaJogos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Jogos'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: jogosDisponiveis.length,
        itemBuilder: (context, index) {
          final jogo = jogosDisponiveis[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  // Imagem do jogo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      jogo.imagemUrl,
                      width: 100,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 100,
                        height: 60,
                        color: Colors.grey[300],
                        child: Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  // Detalhes do jogo
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jogo.nome,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          jogo.genero,
                          style: TextStyle(color: Colors.grey[700], fontStyle: FontStyle.italic),
                        ),
                        SizedBox(height: 4),
                        Text(
                          jogo.descricao,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text(jogo.avaliacao.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Preço e botão adicionar
                  Column(
                    children: [
                      Text(
                        'R\$ ${jogo.preco.toStringAsFixed(2)}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          context.read<Carrinho>().adicionar(jogo);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${jogo.nome} adicionado ao carrinho!')),
                          );
                        },
                        child: Icon(Icons.add_shopping_cart),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
