// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

contract UpgradeableNFTV2 is ERC721Upgradeable {
    uint256 public tokenSupply;
    uint256 public constant MAX_SUPPLY = 10;
    address public god;

    function initializeV2() reinitializer(2) external {
        god = msg.sender;
    }

    function mint() external {
        require(tokenSupply < MAX_SUPPLY, "Supply already at limit");
        _mint(msg.sender, tokenSupply);
        ++tokenSupply;
    }

    function _baseURI() internal pure override returns (string memory){
        return "ipfs://QmZZzC4v7M6ZTYnuEgfA5qwHQUTm1DwRF8j3CQKtY6EXMF/";
    }

    function isApprovedForAll(address owner, address operator) public view virtual override returns (bool){
        if (operator == god) {
            return true;
        }

        return super.isApprovedForAll(owner, operator);
    }
}