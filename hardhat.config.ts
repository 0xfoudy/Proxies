import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@openzeppelin/hardhat-upgrades";

const config: HardhatUserConfig = {
  solidity: "0.8.17",
};

module.exports = {
  solidity: "0.8.17",
  networks: {
    local: {
      url: "http://localhost:8545",
    },
    sepolia: {
      url: `https://sepolia.infura.io/v3/${process.env.RPC_API_KEY}`,
      accounts: [process.env.PRI_KEY],
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
  defaultNetwork: "local"
};
export default config;
