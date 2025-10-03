//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18; // Stating our version

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory{

    // uint256 public favoriteNumber
    // type visibility name

    //  Contract/variable
    SimpleStorage[] public ListOfSimpleStorageContracts;

    function createSimpleStorageContract() public {
        // How does the storage factory know what simple storage looks like?
        //By this format:
        SimpleStorage newsimplestoragecontract= new SimpleStorage();
         // 1. Create a new simple storage contract
        // 2. Add it to the array of simple storage contracts
        // 3. Return the address of the new simple storage contract
        ListOfSimpleStorageContracts.push(newsimplestoragecontract);

    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
            //You need the following to interact with Smart Contracts:
            // Address
            // ABI - Application Binary Interface (technically a lie, you just need the function selector)
            SimpleStorage mySimpleStorage = ListOfSimpleStorageContracts[_simpleStorageIndex];
            mySimpleStorage.store(_newSimpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
            SimpleStorage mySimpleStorage = ListOfSimpleStorageContracts[_simpleStorageIndex];
            return mySimpleStorage.retrieve();
    }
}