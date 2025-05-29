# Prova Prática 01 - Sistema de Pedido de Vendas (Dart)

Este projeto implementa um sistema simplificado de pedido de vendas utilizando a linguagem Dart. Ele é parte da Prova Prática 01 e demonstra a criação de classes, objetos, serialização de dados para JSON e o envio de e-mails com o conteúdo JSON.

## Estrutura do Projeto

O projeto é organizado em classes que representam as entidades de um pedido de vendas:

* **`Cliente`**: Representa o cliente que realiza o pedido.
* **`Vendedor`**: Representa o vendedor responsável pelo pedido.
* **`Veiculo`**: Representa o veículo que está sendo vendido no pedido.
* **`ItemPedido`**: Representa um item (acessório) individual dentro de um pedido, com sua quantidade e valor.
* **`PedidoVenda`**: A classe principal que agrega todas as informações de um pedido, incluindo cliente, vendedor, veículo e uma lista de acessórios. Possui um método para calcular o valor total do pedido.

## Funcionalidades Implementadas

1.  **Definição de Classes**: Implementação das classes `Cliente`, `Vendedor`, `Veiculo`, `ItemPedido` e `PedidoVenda` com seus respectivos atributos e construtores nomeados e obrigatórios.
2.  **Serialização JSON**: Todas as classes possuem o método `toJson()` para converter suas instâncias em um `Map<String, dynamic>`, permitindo a fácil serialização para o formato JSON.
3.  **Cálculo de Pedido**: A classe `PedidoVenda` contém o método `calcularPedido()` que soma o valor do veículo com o valor total dos acessórios (quantidade * valor do item).
4.  **Criação e Inicialização de Objetos**: Na função `main`, são criados objetos de cada classe e inicializados com dados de exemplo para simular um cenário real de pedido de vendas.
5.  **Geração de JSON**: Uma instância de `PedidoVenda` é convertida para uma string JSON utilizando `dart:convert`, com um `toEncodable` customizado para lidar com as classes aninhadas.
6.  **Envio de E-mail**: A string JSON gerada é enviada como conteúdo de um e-mail para um destinatário específico, utilizando a biblioteca `mailer`.

## Como Executar o Projeto

Para rodar este projeto, siga os passos abaixo:

1.  **Pré-requisitos**:
    * Certifique-se de ter o SDK do Dart instalado em sua máquina.
    * Você precisará ter as dependências do projeto instaladas.

2.  **Clonar o Repositório (se ainda não o fez)**:
    ```bash
    git clone <URL_DO_SEU_REPOSITORIO_GITHUB>
    cd <nome_da_sua_pasta_do_projeto_dart>
    ```

3.  **Instalar Dependências**:
    Dentro da pasta do projeto Dart, execute:
    ```bash
    dart pub get
    ```
    Isso baixará as dependências necessárias, como `mailer`.

4.  **Configurar o E-mail (Importante!)**:
    No arquivo `main.dart`, você encontrará a função `sendEmail`. **Você precisará substituir as credenciais de e-mail de remetente (`emailRemetente`, `senhaRemetente`) pelas suas, além do e-mail do destinatário (`emailDestinatario`).**

    **Atenção:** Se estiver usando o Gmail, você precisará gerar uma **senha de aplicativo** (App Password) em suas configurações de segurança do Google, pois a senha normal da sua conta não funcionará para envio de e-mails via aplicativos de terceiros. A senha no código (`"fpsy fvmo osag juuz"`) é um exemplo de senha de aplicativo.

5.  **Executar o Código**:
    Ainda dentro da pasta do projeto, execute:
    ```bash
    dart run
    ```
    Isso compilará e executará o arquivo `main.dart`. Você deverá ver mensagens no console indicando o status do envio do e-mail.
