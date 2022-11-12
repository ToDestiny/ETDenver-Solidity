// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "./VolcanoCoin.sol";

contract VolcanoNFT is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    uint256 constant ETH_MINT_PRICE = 0.001 ether;
    uint256 constant VOLCANOCOIN_MINT_PRICE = 1 ether; // Not actual ether, just used to multiply by 10^decimals()

    VolcanoCoin private immutable volcanoCoin;

    constructor(VolcanoCoin _volcanoCoin) ERC721("VolcanoNFT", "VCN") {
        volcanoCoin = _volcanoCoin;
    }

    function mint() public payable returns(uint256) {
        if (msg.value < ETH_MINT_PRICE) {
            require(
                volcanoCoin.transferFrom(msg.sender, address(this), VOLCANOCOIN_MINT_PRICE),
                "Mint price is either 0.001 ETH or 1 VCN."
            );
        }

        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(msg.sender, tokenId);

        return tokenId;
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function withdraw() public onlyOwner returns (bool success) {
        (success,) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "Withdraw failed");
    }
}