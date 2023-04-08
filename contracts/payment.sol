// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Payment {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function pay() public payable {
        require(msg.value > 0, "Payment cannot be zero");
        owner.transfer(msg.value);
    }
}
