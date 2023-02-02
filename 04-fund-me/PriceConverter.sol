// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// import packages from NPM
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
        function getPrice() internal view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        // (uint80 roundId, int256 price, uint startedAt, uint timeStamp, uint80 answerInRound) = priceFeed.latestRoundData();
        // notice how we keep the comma
        (,int256 price,,,) = priceFeed.latestRoundData();
        // ETH in terms of USD
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        // eth / usd
        // ABI
        // Address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e (Goerli)
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}