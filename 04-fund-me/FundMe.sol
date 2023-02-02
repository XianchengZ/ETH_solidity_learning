// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// import library
import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function fund() public payable {
        // set a minimum amount in USD

        // global keyword to get the amount of money who calls this function
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough"); // 1e18 = 1 * 10^18 wei = 1 Eth
        funders.push( msg.sender );
        addressToAmountFunded[ msg.sender ] += msg.value;
        // require revert the action if the condition is not satisfied
        // second field is the error message send back
        // require revert all prior actions/computations
        
        // 18 decimal places
    }


    function withdraw() public onlyOwner {
        
        
        for( uint256 i = 0; i < funders.length; i++ ){
            address funder = funders[ i ];
            addressToAmountFunded[ funder ] = 0;
        }
        // reset the array
        funders = new address[](0); // 0 objects to start
        // withdraw funds

        // 3 ways to send eth
        // transfer
        // send
        // call

        (bool callSuccess,) = payable(msg.sender).call{ value: address(this).balance }("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner{
        require(msg.sender == owner, "You are not the owner!");
        _; // call function code
    }
}