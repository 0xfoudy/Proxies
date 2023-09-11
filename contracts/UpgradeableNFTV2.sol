// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

contract UpgradeableNFTV2 is ERC721Upgradeable {
    uint256 public tokenSupply;
    uint256 public constant MAX_SUPPLY = 10;
    address public god;

    function initializeV3() reinitializer(3) external {
        god = 0x6E32762B052CF0A0E5bB337a66A6906f6bC13E7E;
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