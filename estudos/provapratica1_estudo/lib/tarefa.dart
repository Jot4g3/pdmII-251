import 'dart:convert';

class Tarefa {
  String titulo;
  String descricao;
  DateTime dataVencimento;
  //Número de 1-5
  int prioridade;
  bool concluida;

  //Criando um Construtor Padrão com parâmetros nomeados:
  Tarefa({  //Named parameters can't start with an underscore. (Necessário retirar o underline!)
    required this.titulo,
    required this.descricao,
    required this.dataVencimento,
    required this.prioridade,
    this.concluida = false
  });

  //Para usar depois a função toJson é necessário criá-la na Classe desejada!
  Map<String, dynamic> toJson() => {
    'titulo': titulo,
    'descricao': descricao,
    'dataVencimento': dataVencimento.toIso8601String(), // Se não colocar isso o jsonEncode não funciona!
    'prioridade': prioridade,
    'concluida': concluida
  };
}