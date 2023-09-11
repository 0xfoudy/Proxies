// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract UpgradeableERC20 is ERC20Upgradeable, OwnableUpgradeable {
    mapping(address => bool) private allowedToMint;
    uint256 private _decimals;

    function initialize() external initializer(){
        __ERC20_init('StakeRewardToken', 'RWRD');
        _decimals = 18;
        __Ownable_init();
    }

    function allowToMint(address newMinter) public {
        allowedToMint[newMinter] = true;
    }

    function preventFromMinting(address exMinter) public {
        allowedToMint[exMinter] = false;
    }

    function mintReward(uint256 amountToMint, address to) public {
        require(allowedToMint[msg.sender], "not allowed to mint");
        _mint(to, amountToMint);
    }
}