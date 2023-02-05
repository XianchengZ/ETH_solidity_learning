// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallbackExample {
    uint256 public result;

    receive() external payable {
        // as long as calldata is blank, this function will be triggered
        // doesn't matter if any money is sent along
        result = 1;
    }

    fallback() external payable {
        result = 2;
    }
}