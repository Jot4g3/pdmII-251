class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;
  final String location;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
    required this.location
  });

  // Construtor que converte JSON em um objeto CharacterModel
  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'], 
      name: json['name'], 
      status: json['status'], 
      species: json['species'], 
      image: json['image'],
      location: json['location']['name']
    );
  }
}