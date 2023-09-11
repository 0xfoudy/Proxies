const { ethers, upgrades } = require("hardhat");

const PROXY = "0x644EbB155343A53b8B1B80ab6F719aed7e85B34c";

async function main() {
  const NFTFactory = await ethers.getContractFactory("UpgradeableNFTV2");

  const NFT = await upgrades.upgradeProxy(PROXY, NFTFactory, {
    call: "initializeV2"
  });

  console.log("PROXY UPGRADED");
}

main()