// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "hardhat/console.sol";

contract UpgradeableERC20 is Initializable {
    uint256 public abc;
    uint256 public bcd;
    uint256[48] __gap;

    function initialize() public onlyInitializing(){
        abc = 12;
        bcd = 23;
    }

}


contract UpgradeableERC20Child is UpgradeableERC20 {
    uint256 public testGap;

    function __UpgradeableERC20Child_init(uint256 _testGap) public initializer(){
        UpgradeableERC20.initialize();
        testGap = _testGap;
    }

    function readStorage() public {
        for (uint8 i = 0; i<60; ++i){
            uint256 storage_slot;
            assembly{
                storage_slot := sload(i)
            }
            console.log("Slot - ", i);
            console.log(storage_slot);
        }
    }
}