// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

import "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;

    function simpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
         
    }

    function stStore(uint256 _storageIndex, uint256 _number) public {
        simpleStorageArray[_storageIndex].create(_number);
    }

    function stGet(uint256 _stoageIndex) public view returns(uint256) {
        return simpleStorageArray[_stoageIndex].retrive();
    }
}