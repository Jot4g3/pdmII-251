import 'package:flutter/material.dart';
import 'package:flutter_application_1/jogo.dart';

class Carrinho with ChangeNotifier {
  // Classe do Flutter que permite notificar os widgets consumidores sempre que o estado interno mudar (por exemplo, ao adicionar ou remover itens).
  final List<Jogo> _jogos = [];

  List<Jogo> get jogos => _jogos;

  double get total => _jogos.fold(0, (sum, jogo) => sum + jogo.preco);

  void adicionar(Jogo jogo) {
    _jogos.add(jogo);
    notifyListeners(); // Todos os widgets que usam o Provider para escutar o Carrinho são reconstruídos automaticamente, refletindo as mudanças na UI sem a necessidade de gerenciar manualmente o estado.
  }

  void remover(Jogo jogo) {
    _jogos.remove(jogo);
    notifyListeners() ;
  }
}
