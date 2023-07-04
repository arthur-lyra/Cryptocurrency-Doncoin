// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract doncoin_ico {

    // Número máximo de doncoins disponíveis no ICO		 
    uint public max_doncoins = 1000000;

    // Taxa de cotação do doncoin por dólar	
    uint public usd_to_doncoins = 1000;

    // Total de doncoins compradas por investidores	
    uint public total_doncoins_bought = 0;
    
    // Funções de equivalência
    mapping(address => uint) equity_doncoins;
    mapping(address => uint) equity_usd;

    // Verifica se o investidor pode comprar doncoins
    modifier can_buy_doncoins(uint usd_invested) {
        require((usd_invested * usd_to_doncoins) + total_doncoins_bought <= max_doncoins, "Not enough doncoins available for purchase");
        _;
    }

    // Retorna o valor do investimento em doncoins 	
    function equity_in_doncoins(address investor) external view returns (uint) {
        return equity_doncoins[investor];
    }

    // Retorna o valor do investimento em dólares
    function equity_in_usd(address investor) external view returns (uint) {
        return equity_usd[investor];
    }

    // Compra de doncoins 
    function buy_doncoins(address investor, uint usd_invested) external can_buy_doncoins(usd_invested) {
        uint doncoins_bought = usd_invested * usd_to_doncoins;
        equity_doncoins[investor] += doncoins_bought;
        equity_usd[investor] = equity_doncoins[investor] / 1000;
        total_doncoins_bought += doncoins_bought;
    }

    // Venda de doncoins
    function sell_doncoins(address investor, uint doncoins_sold) external {
        require(equity_doncoins[investor] >= doncoins_sold, "Not enough doncoins to sell");
        equity_doncoins[investor] -= doncoins_sold;
        equity_usd[investor] = equity_doncoins[investor] / 1000;
        total_doncoins_bought -= doncoins_sold;
    }
}
