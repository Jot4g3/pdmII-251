// Agregação e Composição
import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

   Map toJson() => {
        'nome': _nome
  };
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

   Map toJson() => {
        'nome': _nome,
        'dependentes': _dependentes
  };

}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

   Map toJson() => {
        'nomeProjeto': _nomeProjeto,
        'funcionarios': _funcionarios
  };
}

void main() {
  // 1. Criar varios objetos Dependentes
  Dependente d1 = Dependente("Kauã Sousa de Oliveira");
  Dependente d2 = Dependente("Ismael Lira Nasciment");
  Dependente d3 = Dependente("Gabriel Souza de Alencar");
  Dependente d4 = Dependente("João Gabriel Aguiar de Senna");

  // 2. Criar varios objetos Funcionario
  // 3. Associar os Dependentes criados aos respectivos funcionarios
  Funcionario f1 = Funcionario("Ricardo Duarte Taveira", [d1, d3]);
  Funcionario f2 = Funcionario("Roger Moura Sarmento", [d2, d4]);
  Funcionario f3 = Funcionario("Francisco Tadeu de Carvalho Belchior Magalhães", [d1, d2, d3, d4]);
  Funcionario f4 = Funcionario("Cícero Marcos Túlio Cardoso de Figueiredo", [d1, d2, d3]);

  // 4. Criar uma lista de Funcionarios
  List<Funcionario> listaDeFuncionarios = [f1, f2, f3, f4];

  // 5. Criar um objeto Equipe Projeto chamando o metodo
  //    construtor que dá nome ao projeto e insere uma
  //    coleção de funcionarios
  EquipeProjeto equipeProjeto = EquipeProjeto("TechOS", listaDeFuncionarios);

  // 6. Printar no formato JSON o objeto Equipe Projeto.
  print(jsonEncode(equipeProjeto));
}