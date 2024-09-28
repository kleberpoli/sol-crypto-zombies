// 1. Definicao do contrato ABI
var abi = ''; /* abi gerada pelo compilador */
var ZombieFactoryContract = web3.eth.contract(abi);
var contractAddress = ''; /* endereco do nosso contrato apos ser implantado */
var ZombieFactory = ZombieFactoryContract.at(contractAddress);

// 2. Interacao com o contrato
$('#ourButton').click(function(e) {
	var name = $.trim($('#nameInput').val());
	ZombieFactory.createRandomZombie(name);
});

// 3. Escutando eventos
var event = ZombieFactory.NewZombie(function(error, result) {
	if (error)
		return generateZombie(
			result.zombieID,
			result.name,
			result.dna
		);
});

// 4. Gerando detalhes do zumbi
function generateZombie(id, name, dna) {
	// ... codigo para gerar detalhes do zumbi
	return zombieDetails;

}

/*
Este codigo exemplifica como conectar um frontend (interface de usuario) com um contrato inteligente 
em Solidity para criar uma aplicacao descentralizada (dApp) interativa. Aqui, o jogo de zumbis utiliza 
contratos inteligentes para gerar e gerenciar zumbis unicos com base em um algoritmo de DNA.
*/