// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./library/PriceConverter.sol";

error NotOwner();

contract Transaction {
    using PriceConverter for uint256;

    uint256 public constant MINIMUMUSD = 2 * 1e18;
    address[] public funder;
    mapping(address => uint256) public amountFunded;
    address public immutable i_owner;

    // Set the owner of the contract
    constructor() {
        i_owner = msg.sender;
    }


    function fund() public payable {
        require(msg.value.converter() >= MINIMUMUSD, "Amount must be greater than 1");
        funder.push(msg.sender);
        amountFunded[msg.sender] = msg.value;

    } 

    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funder.length; funderIndex++) {
            address funderAddress = funder[funderIndex];
            amountFunded[funderAddress] = 0;
        }

        // Reset the funder array
        funder = new address[](0);

        // // Perform withdraw here
        // payable(msg.sender).transfer(address(this).balance);

        // // send
        // bool snd = payable(msg.sender).send(address(this).balance);
        // require(snd, "Amount can not be without");

        // call
        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "Review amount");
    }


    modifier onlyOwner {
        // require(msg.sender == i_owner, "Only owner can access this");
        if(msg.sender != i_owner) { revert NotOwner(); }
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

}