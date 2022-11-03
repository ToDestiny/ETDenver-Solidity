// contracts/GameItem.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract VolcanoNFT is ERC721URIStorage, Ownable {
    uint256 private priceEth = 10000000000000000; // 0.01 Ether
    uint256 private priceVolcanoCoin = 250; // 250 VulcanoCoin

	using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

	constructor() ERC721("VolcanoNFT", "VNFT") {

    }

	    function mintNFTEth(address _user, uint _amount, string memory tokenURI)
        public payable
        returns (uint256)
    {
        require(msg.value == 0.01 ether, "Need to send 0.1 ether");
        require(_amount > 0, "Need to send 0.1 ether");
        uint256 newItemId = _tokenIds.current();
        _safeMint(_user, newItemId);
        _setTokenURI(newItemId, tokenURI); 

        _tokenIds.increment();
        return newItemId;
    }

        function withdraw(address payable recipient) public onlyOwner {
        uint256 balance = address(this).balance;
        recipient.transfer(balance);
    }

}
