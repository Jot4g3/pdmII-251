// Essa classe não deve ser instanciada!
class ApiConstants{
  // Fazer o construtor privado previne que a classe seja instanciada.
  ApiConstants._();

  //URL Base - API Rick And Morty
  static const String baseURL = "https://rickandmortyapi.com/api";

  // Endpoints
  static const String charactersEndpoint = "/character";
  static const String locationsEndpoint = "/location";
  static const String episodesEndpoint = "/episode";
}