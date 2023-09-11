const { ethers, upgrades } = require("hardhat");

async function main() {
  const NFTFactory = await ethers.getContractFactory("UpgradeableNFT");

  const NFT = await upgrades.deployProxy(NFTFactory, {
    initializer: "initialize"
  });

  console.log("NFT deployed at :" + await NFT.address)
}

main()