// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// import packages from NPM
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUsd = 50 * 1e18;

    function fund() public payable {
        // set a minimum amount in USD

        // global keyword to get the amount of money who calls this function
        require(getConversionRate(msg.value) >= minimumUsd, "Didn't send enough"); // 1e18 = 1 * 10^18 wei = 1 Eth
        // require revert the action if the condition is not satisfied
        // second field is the error message send back
        // require revert all prior actions/computations
        
        // 18 decimal places
    }

    function getPrice() public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        // (uint80 roundId, int256 price, uint startedAt, uint timeStamp, uint80 answerInRound) = priceFeed.latestRoundData();
        // notice how we keep the comma
        (,int256 price,,,) = priceFeed.latestRoundData();
        // ETH in terms of USD
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256) {
        // eth / usd
        // ABI
        // Address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e (Goerli)
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
    // function withdraw() {}
}