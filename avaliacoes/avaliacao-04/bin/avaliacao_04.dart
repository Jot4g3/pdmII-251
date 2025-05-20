import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

void main() {
  final db = sqlite3.open('alunos.db');

  // Criar a tabela TB_ALUNO se não existir
  db.execute('''
    CREATE TABLE IF NOT EXISTS TB_ALUNO (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL CHECK(length(nome) <= 50)
    );
  ''');

  print('---=== Sistema de Gerenciamento de Alunos ===----');

  while (true) {
    print('\nEscolha uma opção:');
    print('1 - Inserir novo aluno');
    print('2 - Listar alunos');
    print('0 - Sair');
    stdout.write('Opção: ');
    final choice = stdin.readLineSync();

    if (choice == '1') {
      _inserirAluno(db);
    } else if (choice == '2') {
      _listarAlunos(db);
    } else if (choice == '0') {
      print('Saindo...');
      db.dispose();
      break;
    } else {
      print('Opção inválida, tente novamente.');
    }
  }
}

void _inserirAluno(Database db) {
  stdout.write('Digite o nome do aluno (máx 50 caracteres): ');
  String? nome = stdin.readLineSync();

  if (nome == null || nome.trim().isEmpty) {
    print('Nome não pode ser vazio.');
    return;
  }

  // Truncar para 50 caracteres se for maior
  if (nome.length > 50) {
    nome = nome.substring(0, 50);
    print('Nome truncado para 50 caracteres.');
  }

  final stmt = db.prepare('INSERT INTO TB_ALUNO (nome) VALUES (?);');
  stmt.execute([nome]);
  stmt.dispose();

  print('Aluno "$nome" inserido com sucesso.');
}

void _listarAlunos(Database db) {
  final ResultSet resultSet = db.select('SELECT id, nome FROM TB_ALUNO ORDER BY id;');

  if (resultSet.isEmpty) {
    print('Nenhum aluno cadastrado.');
    return;
  }

  print('\nLista de alunos:');
  for (final row in resultSet) {
    print('ID: ${row['id']} - Nome: ${row['nome']}');
  }
}