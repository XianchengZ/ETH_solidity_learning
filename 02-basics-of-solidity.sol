// SPDX-License-Identifier: MIT
pragma solidity 0.8.8; 

// lts -> 0.8.17
// ^ means any version >= 0.8.7, e.g. ^0.8.7
// between a range: >=0.8.7 <0.9.0

contract SimpleStorage {
    // basic types: boolean, uint, int, address, bytes (8 bits -> 1 byte)
    // we can specify the bits for a uint variable e.g. uint256 
    
    // other types: string (secretly bytes but for text)
    // max bytes is byte32, min int is int8

    uint256 favoriteNumber;
    
}
// think of contract as a class

