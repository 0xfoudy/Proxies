const { ethers, upgrades } = require("hardhat");
const fs = require('fs');

async function main() {
  const NFTStakerFactory = await ethers.getContractFactory("UpgradeableNFTStakerV1");

 const NFTStaker = await upgrades.deployProxy(NFTStakerFactory, ['0x644EbB155343A53b8B1B80ab6F719aed7e85B34c', '0xB15d5CC06015c350E18f1079e5b6d23444042D7e'], {
    initializer: "initialize"
  });
  console.log("NFT staker deployed at :" + NFTStaker.address)

}

main()