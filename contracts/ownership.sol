// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract NFT {
    mapping (uint => address) public tokenOwners;
    mapping (address => uint) public balances;

    function mint(address _owner, uint _tokenId) public {
        require(tokenOwners[_tokenId] == address(0), "Token already exists");
        tokenOwners[_tokenId] = _owner;
        balances[_owner]++;
    }

    function transfer(address _to, uint _tokenId) public {
        require(tokenOwners[_tokenId] == msg.sender, "Not the owner of this token");
        tokenOwners[_tokenId] = _to;
        balances[msg.sender]--;
        balances[_to]++;
    }

    function balanceOf(address _owner) public view returns (uint) {
        return balances[_owner];
    }
}
