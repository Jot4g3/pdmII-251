import 'package:provapratica1_estudo/provapratica1_estudo.dart' as provapratica1_estudo;
import 'dart:convert';

import 'package:provapratica1_estudo/tarefa.dart';
import 'package:provapratica1_estudo/toemail.dart';

void main(List<String> arguments) {

  var listaTarefas = [
    Tarefa(
      titulo: 'Passear com o Olaf.',
      descricao: 'Dar uma voltinha de 15min pelo bairro com o meu cachorrinho, Olaf, não se esqueça de levar as sacolas para juntar os cocôs!',
      dataVencimento: DateTime.parse('2025-05-29T09:00:04Z'), //Às 9:00 de 29/05.
      prioridade: 2
    ),
    Tarefa(
      titulo: 'Estudar - Prova Prática Dart',
      descricao: 'Haverá uma prova prática de PDMII. Cairá nela: Definição de Classes, Criação de Objetos, Popular Objetos, Transformar Objetos em JSON e Enviar Coisas por Email',
      dataVencimento: DateTime.parse('2025-05-29T11:20:04Z'), //Às 11:20 de 29/05.
      prioridade: 4
    ),
    Tarefa(
      titulo: 'Estudar - Quiz de PWeb',
      descricao: 'Haverá um quiz de PWeb. Cairá nele principalmente MongoDB (eu acho!).',
      dataVencimento: DateTime.parse('2025-05-29T11:20:04Z'), //Às 11:20 de 29/05.
      prioridade: 4
    )
  ];

  //Guardando o JSON de todas as tarefas!
  String jsonTarefas = '';
  jsonTarefas = jsonEncode(listaTarefas);
  print(jsonTarefas);

  sendEmail(nomeRemetente: 'João Gabriel', emailRemetente: 'gabriel.joao61@aluno.ifce.edu.br', senhaRemetente: 'pnor skeu jnbj svta', emailDestinatario: 'kaua.sousa63@aluno.ifce.edu.br', assuntoEmail: 'Tarefas em JSON', conteudoEmail: jsonTarefas, quantidadeEnvios: 1);
}
