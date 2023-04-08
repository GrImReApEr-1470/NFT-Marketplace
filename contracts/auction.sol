// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./ownership.sol";

contract Auction {
    address public owner;
    uint public startBlock;
    uint public endBlock;
    uint public highestBid;
    address public highestBidder;
    NFT public nftContract;
    uint public tokenId;

    mapping(address => uint) public bids;

    constructor(address _nftContract, uint _tokenId, uint _startBlock, uint _endBlock) {
        owner = msg.sender;
        nftContract = NFT(_nftContract);
        tokenId = _tokenId;
        startBlock = _startBlock;
        endBlock = _endBlock;
    }

    function bid() public payable {
        require(block.number >= startBlock, "Auction has not started");
        require(block.number <= endBlock, "Auction has ended");
        require(msg.value > highestBid, "There is already a higher bid");
        require(msg.sender != owner, "Owner cannot bid on their own auction");

        if (highestBid != 0) {
            bids[highestBidder] += highestBid;
        }
        highestBid = msg.value;
        highestBidder = msg.sender;
    }

    function endAuction() public {
        require(block.number > endBlock, "Auction has not ended");
        require(msg.sender == owner, "Only the owner can end the auction");

        nftContract.transfer(highestBidder, tokenId);
        payable(owner).transfer(highestBid);
        highestBid = 0;
        owner = address(0);
    }
}
