# Atividade 08 - Flutter, Consumo de API e Lista Dinâmica

Este é um projeto Flutter desenvolvido para a Atividade 08 da disciplina de PDMII, que demonstra o consumo de uma API REST (a API de Rick and Morty) e a exibição dos dados em uma lista dinâmica e interativa.

## ✨ Funcionalidades

* **Consumo da [API de Rick and Morty](https://rickandmortyapi.com)** para buscar uma lista de personagens.
* **Exibição dos personagens** em uma lista vertical utilizando Cards personalizados.
* **Gerenciamento de estado com Provider** para controlar os estados de carregamento (loading), sucesso e erro.
* **Indicador de progresso** exibido enquanto os dados são carregados.
* **Tratamento de erros** de rede com mensagens amigáveis na interface.
* **Funcionalidade de "Puxar para Atualizar" (Pull-to-Refresh)** para recarregar a lista de personagens.

## 💡 Conceitos Aplicados

* **Arquitetura de Pastas em Camadas:** O projeto foi estruturado separando as responsabilidades em camadas (Presentation, Data, Core, Services).
* **Consumo de API REST:** Utilização do pacote `http` para realizar requisições GET.
* **Parse de JSON:** Conversão da resposta JSON da API para objetos Dart (Models) com o método `fromJson`.
* **State Management:** Gerenciamento de estado declarativo com o pacote `provider` e `ChangeNotifier`.
* **Widgets Dinâmicos:** Uso de `ListView.builder` para construir a lista de forma eficiente.
* **UI Reativa:** Implementação de uma interface que reage a diferentes estados (loading, data, error) usando o widget `Consumer`.
* **Segurança de Nulos (Null Safety):** Tratamento de dados que podem ser nulos para garantir a robustez da aplicação.

## 📱 Telas em Execução

<img src="https://github.com/user-attachments/assets/0192114a-cd7f-48ba-bc62-36c8556b71c8" width="250">

<img src="https://github.com/user-attachments/assets/71922f59-cf7e-4cb1-a4e3-39e52961545e" width="250">

