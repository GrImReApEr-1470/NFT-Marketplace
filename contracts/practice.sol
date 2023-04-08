// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract MyContract {
    function getCurrentBlockNumber() public view returns (uint256) {
        return block.number;
    }
}
