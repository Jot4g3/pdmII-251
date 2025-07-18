
import 'package:avaliacao_08/data/models/character_model.dart';
import 'package:avaliacao_08/data/repositories/character_repository.dart';
import 'package:flutter/material.dart';

class CharacterProvider extends ChangeNotifier{
  final CharacterRepository _characterRepository = CharacterRepository();

  // Estados da tela
  bool _isLoading = false;
  List<CharacterModel> _characters = [];
  String? _errorMessage;

  // Getters públicos para que a interface de usuário possa acessar os estados de maneira segura
  bool get isLoading => _isLoading;
  List<CharacterModel> get characters => _characters;
  String? get errorMessage => _errorMessage;

  // Método que a UI vai chamar para buscar os personagens
  Future<void> fetchCharacters() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Avisa à UI que está carregando.

    try {
      // Usa o repositório para acessar os dados
      _characters = await _characterRepository.getCharacters();
    } catch (err) {
      _errorMessage = err.toString();
    }

    _isLoading = false;
    notifyListeners(); // Avisa à UI que o carregamento terminou.
  }
}