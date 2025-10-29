// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FavoriteColorNFT is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;
    mapping(string => bool) public colorExists;
    mapping(uint256 => string) public tokenIdToColor;

    constructor() ERC721("FavoriteColorNFT", "COLOR") Ownable(msg.sender) {}

    function mintColor(string memory colorHex) public {
        require(bytes(colorHex).length > 0, "Color cannot be empty");
        require(!colorExists[colorHex], "Color already minted!");

        uint256 tokenId = nextTokenId;
        _safeMint(msg.sender, tokenId);

        tokenIdToColor[tokenId] = colorHex;
        colorExists[colorHex] = true;
        nextTokenId++;

        // Optional: set placeholder URI
        _setTokenURI(tokenId, colorHex);
    }

    function getColor(uint256 tokenId) public view returns (string memory) {
        require(_ownerOf(tokenId) != address(0), "Token does not exist");
        return tokenIdToColor[tokenId];
    }

    function totalMinted() public view returns (uint256) {
        return nextTokenId;
    }
}

