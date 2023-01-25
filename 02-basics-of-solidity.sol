// SPDX-License-Identifier: MIT
pragma solidity 0.8.8; 

// lts -> 0.8.17
// ^ means any version >= 0.8.7, e.g. ^0.8.7
// between a range: >=0.8.7 <0.9.0

// EVM, Ethereum Virtual Machine
// Avalanche, Fantom, Polygon -> EVM compatible

contract SimpleStorage {
    // basic types: boolean, uint, int, address, bytes (8 bits -> 1 byte)
    // we can specify the bits for a uint variable e.g. uint256 
    
    // other types: string (secretly bytes but for text)
    // max bytes is byte32, min int is int8

    uint256 favoriteNumber;
    People public person = People( { favoriteNumber: 2, name: "Andrew" } );
    // initialize an object
    // People( { favoriteNumber: 2, name: "Andrew" } )
    // People( "Andrew", 2 )

    // class, struct
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    // dictionary in sol:
    mapping( string => uint256 ) public nameToFavoriteNumber;

    People[] public people; // people is an array of People

    
    function store(uint256 _favoriteNumber ) public {
        favoriteNumber = _favoriteNumber;
    }

    // view -> read only
    // pure -> doesn't allow reading
    // view and pure functions, when called along, don't spend gas
    // they only spend gas if called by other contracts (functions)
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }

    // data location must be "storage", "memory", or "calldata"
    // or ( "stack", "code", "logs" )
    // data location can only be specified for array, struct or mapping types
    
    // calldata and memory -> data will be stored temporarily
    // calldata -> cannot modify data
    // storage -> data exists outside of function executions
    
    // we cannot specify variables to be stack, code or logs
    function addPerson( string memory _name, uint256 _favoriteNumber ) public {
        people.push(People( _favoriteNumber, _name ));
        nameToFavoriteNumber[ _name ] = _favoriteNumber;
    }


}


// think of contract as a class
// deployed Contract has an Address
