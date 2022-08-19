// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./library/PriceConverter.sol";

contract Transaction {
    using PriceConverter for uint256;

    uint256 public mininumUSD = 2 * 1e18;
    address[] public funder;
    mapping(address => uint256) public amountFunded;

    function fund() public payable {
        require(msg.value.converter() >= mininumUSD, "Amount must be greater than 1");
        funder.push(msg.sender);
        amountFunded[msg.sender] = msg.value;

    } 


}