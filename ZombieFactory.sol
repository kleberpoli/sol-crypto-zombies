// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract ZombieFactory {

    // Definindo constantes e variáveis
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) public ownerZombieCount;

    event NewZombie(uint zombieId, string name, uint dna);

    // Função pública para criação de zumbi
    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0, unicode"Apenas um zumbi por usuário.");
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

    // Função interna que cria um novo zumbi
    function _createZombie(string memory _name, uint _dna) internal {
        zombies.push(Zombie(_name, _dna, 1, uint32(block.timestamp + cooldownTime)));
        uint id = zombies.length - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id, _name, _dna);
    }

    // Função para gerar DNA aleatório
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    // Função para gerar um ID único (já está implementada)
    function _generateUniqueId() private view returns (uint) {
        uint randomPart = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 100000000;
        uint timestampPart = block.timestamp;
        return timestampPart * 100000000 + randomPart;
    }

    // NOVAS FUNÇÕES

    // Função para listar zumbis de um usuário
    function getZombiesByOwner(address _owner) external view returns (Zombie[] memory) {
        uint count = ownerZombieCount[_owner];
        Zombie[] memory result = new Zombie[](count);
        uint counter = 0;

        for (uint i = 0; i < zombies.length; i++) {
            if (zombieToOwner[i] == _owner) {
                result[counter] = zombies[i];
                counter++;
            }
        }
        return result;
    }

    // Função para treinar o zumbi (subir de nível)
    function levelUp(uint _zombieId) external {
        require(msg.sender == zombieToOwner[_zombieId], "Apenas o dono pode treinar este zumbi.");
        Zombie storage myZombie = zombies[_zombieId];
        myZombie.level++;
    }

    // Função para verificar se o zumbi está pronto para batalhar
    function isReady(uint _zombieId) public view returns (bool) {
        Zombie storage myZombie = zombies[_zombieId];
        return (myZombie.readyTime <= block.timestamp);
    }

    // Função para definir o cooldown após um ataque
    function _triggerCooldown(Zombie storage _zombie) internal {
        _zombie.readyTime = uint32(block.timestamp + cooldownTime);
    }
}