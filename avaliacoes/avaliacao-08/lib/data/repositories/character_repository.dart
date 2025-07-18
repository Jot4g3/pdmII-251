
// Classe responsável por buscar dados de personagens da API
import 'dart:convert';

import 'package:avaliacao_08/core/api/api_constants.dart';
import 'package:avaliacao_08/data/models/character_model.dart';
import 'package:http/http.dart' as http;

class CharacterRepository {
  //Busca a lista de personagens da API do Rick And Morty
  Future<List<CharacterModel>> getCharacters() async {
    try{
      // Montando a URL pelas Constantes da API
      final url = Uri.parse(ApiConstants.baseURL+ApiConstants.charactersEndpoint);

      // Fazendo a requisição GET à API
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        // Recebe o JSON e o decodifica
        final jsonResponse = jsonDecode(response.body);
        // Acessa o campo results da resposta em JSON (Veja em 'https://rickandmortyapi.com/api/character')
        final List<dynamic> results = jsonResponse['results'];

        // Converte o JSON em uma lista de CharacterModel
        final characters = results.map((charJson) => CharacterModel.fromJson(charJson)).toList();

        return characters;
      } else {
        throw Exception("Falha ao carregar os personagens da API");
      }
    } catch (err) {
      throw Exception("Falha de conexão: $err");
    }
  }
}