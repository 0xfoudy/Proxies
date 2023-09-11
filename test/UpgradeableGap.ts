const { ethers, upgrades } = require("hardhat");
const { expect } = require("chai");


describe("UpgradeableStorage", function () {
  it("Check gaps", async function() {
    const ERCChildFactory = await ethers.getContractFactory("UpgradeableERC20Child");

    const ERCChild = await upgrades.deployProxy(ERCChildFactory, [42], {
      initializer: "__UpgradeableERC20Child_init"
    });
  
    await ERCChild.readStorage()
  });
});
