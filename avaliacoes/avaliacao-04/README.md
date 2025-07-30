# 📒 Avaliação 4

Implementar as funcionalidades relacionadas na função `main()` no arquivo Dart, conforme proposto em aula, utilizando SQLite3 para persistência de dados.  
Evidenciar o código Dart e os prints de saída no GitHub, além do link da atividade no Google Classroom.

# 🗃️ Acesso a Banco de Dados SQLite3 com Dart

Este projeto demonstra como acessar e manipular um banco de dados SQLite3 usando a linguagem Dart. A atividade faz parte do módulo de Programação Mobile com Dart, abordando conceitos de persistência local de dados.

## 📁 Estrutura do Projeto

- `alunos.dart`: Arquivo principal contendo a implementação da criação de banco de dados, inserção e listagem de alunos via terminal.

## 🧪 Funcionalidades Implementadas

1. Conexão com banco de dados SQLite3.
2. Criação automática da tabela `TB_ALUNO`, com os campos:
   - `id`: inteiro, chave primária, autoincrementado;
   - `nome`: texto, máximo de 50 caracteres.
3. Inserção de alunos com leitura do teclado.
4. Listagem de todos os alunos cadastrados, ordenados por ID.
5. Validação do tamanho do nome e truncamento caso ultrapasse 50 caracteres.
6. Menu interativo com opções:
   - `1`: Inserir novo aluno;
   - `2`: Listar alunos;
   - `0`: Sair do sistema.


## 💻 Execução do Projeto

Para executar este projeto localmente:

```bash
dart pub add sqlite3
dart alunos.dart
```

## 🧾 Evidências
<img width="1524" height="946" alt="Image" src="https://github.com/user-attachments/assets/4d14abc1-55d1-44d8-9f0a-684dc609218a" />
