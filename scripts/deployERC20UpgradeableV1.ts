const { ethers, upgrades } = require("hardhat");

async function main() {
  const ERC20Factory = await ethers.getContractFactory("UpgradeableERC20");

  const ERC20 = await upgrades.deployProxy(ERC20Factory, {
    initializer: "initialize"
  });

  console.log("ERC20 deployed at :" + ERC20.address)
}

main()