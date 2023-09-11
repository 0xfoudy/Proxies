// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

contract UpgradeableNFT is ERC721Upgradeable {
    uint256 public tokenSupply;
    uint256 public constant MAX_SUPPLY = 10;

    function initialize() external {
        tokenSupply = 0;
    }

    function mint() external {
        require(tokenSupply < MAX_SUPPLY, "Supply already at limit");
        _mint(msg.sender, tokenSupply);
        ++tokenSupply;
    }

    function _baseURI() internal pure override returns (string memory){
        return "ipfs://QmZZzC4v7M6ZTYnuEgfA5qwHQUTm1DwRF8j3CQKtY6EXMF/";
    }
}