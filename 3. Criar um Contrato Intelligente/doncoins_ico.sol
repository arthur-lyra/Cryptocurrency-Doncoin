// URL para compilar
//http://remix.ethereum.org/#appVersion=0.7.7&optimize=false&version=soljson-v0.4.11+commit.68ef5810.js

//ico doncoins

//versão
pragma solidity ^0.4.11;
 
contract doncoin_ico {
 
    //número máximo de doncoins disponíveis no ICO		 
    uint public max_doncoins = 1000000;
    //Taxa cotacao do doncoin por dolar	
    uint public usd_to_doncoins = 1000;
    //total de doncoins compradas por investidores	
    uint public total_doncoins_bought = 0;
    
    //funcoes de equivalencia
    mapping(address => uint) equity_doncoins;
    mapping(address => uint) equity_usd;
 
    //verificando se o investidor por comprar doncoins
    modifier can_buy_doncoins(uint usd_invested) {
        require (usd_invested * usd_to_doncoins + total_doncoins_bought <= max_doncoins);
        _;
    }
 
    //retorna o valor do investimento em doncoins 	
    function equity_in_doncoins(address investor) external constant returns (uint){
        return equity_doncoins[investor];
    }
 
    //retorna o valor do investimento em dolares
    function equity_in_usd(address investor) external constant returns (uint){
        return equity_usd[investor];
    }
 
    //compra de doncoins 
    function buy_doncoins(address investor, uint usd_invested) external 
    can_buy_doncoins(usd_invested) {
        uint doncoins_bought = usd_invested * usd_to_doncoins;
        equity_doncoins[investor] += doncoins_bought;
        equity_usd[investor] = equity_doncoins[investor] / 1000;
        total_doncoins_bought += doncoins_bought;
    }
 
    //venda de doncoins
    function sell_doncoins(address investor, uint doncoins_sold) external {
        equity_doncoins[investor] -= doncoins_sold;
        equity_usd[investor] = equity_doncoins[investor] / 1000;
        total_doncoins_bought -= doncoins_sold;
    }
    
    
    
    
}
