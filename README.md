# Zombie Factory

## Descrição
Este projeto implementa um contrato inteligente para um jogo de criação e evolução de zumbis chamado **Zombie Factory**. Utilizando a linguagem Solidity e rodando na blockchain Ethereum. O contrato permite que os usuários criem zumbis com DNA gerado aleatoriamente, façam o "level up" dos seus zumbis e visualizem a lista de zumbis que possuem. O projeto é inspirado no jogo **CryptoZombies** e serve como um exemplo prático de implementação de lógica de jogos on-chain, além de lidar com propriedades digitais.

## Funcionalidades
- **Criação de Zumbis**: Os usuários podem criar um zumbi com DNA gerado aleatoriamente usando a função `createRandomZombie`.
- **Evolução (Level Up)**: Proprietários de zumbis podem aumentar o nível dos seus zumbis com a função `levelUp`.
- **Listagem de Zumbis**: Qualquer usuário pode visualizar os zumbis de um endereço específico com a função `getZombiesByOwner`.
- **Controle de Propriedade**: Cada zumbi é atribuído a um proprietário único (endereço Ethereum).
- **Geração de DNA**: O DNA de cada zumbi é gerado de forma pseudo-aleatória a partir do nome fornecido.

## Estrutura do Código
### Variáveis Principais
- **`dnaDigits`**: Número de dígitos do DNA do zumbi (16).
- **`dnaModulus`**: Usado para garantir que o DNA do zumbi tenha 16 dígitos.
- **`cooldownTime`**: Tempo de espera (cooldown) para ações como batalhas e evolução, definido como 1 dia.

### Estruturas e Eventos
- **`Zombie`**: Estrutura que armazena as informações de cada zumbi (nome, DNA, nível e tempo de cooldown).
- **`NewZombie`**: Evento emitido quando um novo zumbi é criado. Armazena o ID, nome e DNA do zumbi.

### Funções
- **`createRandomZombie(string memory _name)`**: Função pública que permite a criação de um zumbi para um endereço que ainda não tenha zumbis. O DNA é gerado a partir do nome fornecido.
- **`_createZombie(string memory _name, uint _dna)`**: Função interna que cria o zumbi e o armazena no array de zumbis, além de emitir o evento `NewZombie`.
- **`_generateRandomDna(string memory _str)`**: Função privada que gera um DNA pseudo-aleatório baseado em uma string (nome do zumbi).
- **`levelUp(uint _zombieId)`**: Função pública que permite ao proprietário de um zumbi aumentar o seu nível.
- **`getZombiesByOwner(address _owner)`**: Função pública que retorna todos os zumbis pertencentes a um endereço específico.
- **`isReady(uint _zombieId)`**: Função pública que verifica se um zumbi está pronto para realizar ações (cooldown concluído).
- **`_triggerCooldown(Zombie storage _zombie)`**: Função interna que define o tempo de espera após uma ação do zumbi.

## Como Executar
1. **Clone o Repositório**: Clone este repositório para o seu ambiente local.
```bash
git clone https://github.com/seu-repositorio/zombie-factory.git
cd zombie-factory
```

2. **Instale o Hardhat** (ou outra ferramenta de desenvolvimento Solidity).
```bash
npm install --save-dev hardhat
```

3. **Compilação**: Compile o contrato usando o Hardhat.
```bash
npx hardhat compile
```

4. **Implantação**: Implemente o contrato na rede de testes de sua escolha (ex.: Goerli) usando Hardhat ou Truffle.

5. **Interação com o Contrato**:
- Use ferramentas como Remix IDE, Hardhat ou scripts personalizados para chamar as funções do contrato.
- Os usuários podem criar zumbis chamando a função `createRandomZombie`.
- Verifique seus zumbis com `getZombiesByOwner`.

## Requisitos
- **Node.js** e **NPM** instalados.
- **Hardhat** ou **Remix IDE** para desenvolvimento e implantação.
- Conta na **Ethereum Testnet** (Goerli, Sepolia, etc.) com fundos de teste.
- **Metamask** para interagir com o contrato.

## Melhorias Futuras
- Implementar um sistema de batalhas entre zumbis.
- Criar uma função para permitir a fusão de dois zumbis, gerando um novo zumbi com DNA combinado.
- Adicionar diferentes tipos de zumbis com habilidades únicas ou estatísticas especiais.
- Implementar tokens ERC-721 para transformar os zumbis em NFTs negociáveis.

## Licença
Este projeto está licenciado sob a licença MIT. Consulte o arquivo LICENSE para mais detalhes.