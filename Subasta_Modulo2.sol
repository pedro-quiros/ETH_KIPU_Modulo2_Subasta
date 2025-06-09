// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 <0.9.0;

contract Subasta {
    address public owner;
    address public mejorOferente;
    uint256 public mejorOfertaMonto;
    uint256 public finSubastaTiempo;
    uint256 public constant COMISION_PORCENTAJE = 2;
    bool public estaFinalizada;

    mapping(address => Oferta[]) public ofertasPorUsuario;
    mapping(address => uint256) public depositos;

    struct Oferta {
        uint256 monto;
        uint256 timestamp;
    }

    event OfertaRealizada(address indexed oferente, uint256 monto);
    event SubastaFinalizada(address ganador, uint256 monto);

    modifier soloOwner() {
        require(msg.sender == owner, "Solo el propietario puede ejecutar esta funcion.");
        _;
    }
    modifier soloMientrasActiva() {
        require(block.timestamp < finSubastaTiempo, "La subasta ya finalizo.");
        _;
    }
    modifier soloDespuesDeFinalizar() {
        require(block.timestamp >= finSubastaTiempo, "La subasta sigue activa.");
        _;
    }

    constructor() {
        owner = msg.sender;
        finSubastaTiempo = block.timestamp + 10 minutes;
        estaFinalizada = false;
    }

function ofertar() external payable soloMientrasActiva {
    require(msg.sender != mejorOferente, "Ya sos el mejor oferente.");

    uint256 minimoOferta = mejorOfertaMonto + (mejorOfertaMonto * 5 / 100);
    require(msg.value >= minimoOferta || mejorOfertaMonto == 0, "Oferta con monto demasiado bajo.");

    ofertasPorUsuario[msg.sender].push(Oferta({
        monto: msg.value,
        timestamp: block.timestamp
    }));

    depositos[msg.sender] += msg.value;
    mejorOfertaMonto = msg.value;
    mejorOferente = msg.sender;

    if (finSubastaTiempo - block.timestamp <= 10 minutes) {
        finSubastaTiempo += 10 minutes;
    }

    emit OfertaRealizada(msg.sender, msg.value);
}

    function finalizarSubasta() external soloOwner soloDespuesDeFinalizar {
        require(!estaFinalizada, "La subasta ya esta finalizada.");

        estaFinalizada = true;

        uint256 comisionValor = (mejorOfertaMonto * COMISION_PORCENTAJE) / 100;
        uint256 montoNeto = mejorOfertaMonto - comisionValor;

        payable(owner).transfer(montoNeto);

        emit SubastaFinalizada(mejorOferente, mejorOfertaMonto);
    }

    function reembolsar() external soloDespuesDeFinalizar {
        require(msg.sender != mejorOferente, "El ganador no puede recibir reembolso.");

        uint256 montoDeposito = depositos[msg.sender];

        require(montoDeposito > 0, "No tiene fondos para reembolsar.");

        depositos[msg.sender] = 0;

        payable(msg.sender).transfer(montoDeposito);
    }

    function verGanador() external view returns (address, uint256) {
        return (mejorOferente, mejorOfertaMonto);
    }

    function verOfertas(address usuario) external view returns (Oferta[] memory) {
        return ofertasPorUsuario[usuario];
    }

    function retirarExcedente() external {
        Oferta[] memory misOfertas = ofertasPorUsuario[msg.sender];
        require(misOfertas.length > 1, "No tiene ofertas anteriores para retirar.");

        uint256 totalExcedente = 0;
        for (uint256 i = 0; i < misOfertas.length - 1; i++) {
            totalExcedente += misOfertas[i].monto;
        }

        require(totalExcedente > 0, "No hay excedente para retirar.");

        depositos[msg.sender] -= totalExcedente;
        payable(msg.sender).transfer(totalExcedente);
    }
}
