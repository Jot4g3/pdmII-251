class Jogo {
  final String nome;
  final double preco;
  final String descricao;
  final String genero;
  final double avaliacao; // de 0 a 5
  final String imagemUrl;

  Jogo({
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.genero,
    required this.avaliacao,
    required this.imagemUrl,
  });

  // Para persistência, pode criar toJson/fromJson se precisar
}
