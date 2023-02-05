// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// import library
import "./PriceConverter.sol";

// constant, immutable -> to lower gas fee
// constant -> assigned at compile time
// immutable -> can be un-assigned first
//              doesn't change after assigned

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable {
        // set a minimum amount in USD

        // global keyword to get the amount of money who calls this function
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough"); // 1e18 = 1 * 10^18 wei = 1 Eth
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
        // require(msg.sender == i_owner, "You are not the owner!");
        if( msg.sender != i_owner ) revert NotOwner();
        _; // call function code
    }

    // What happens if someone send this contract ETH without calling the fund function?

    // receive()
    // fallback()
    
    
    // Explainer from: https://solidity-by-example.org/fallback/
    // Ether is sent to contract
    //      is msg.data empty?
    //          /   \ 
    //         yes  no
    //         /     \
    //    receive()?  fallback() 
    //     /   \ 
    //   yes   no
    //  /        \
    //receive()  fallback()

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }
}