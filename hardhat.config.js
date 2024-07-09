require('dotenv').config({ path: __dirname + '/.env' });

require("@nomicfoundation/hardhat-toolbox");

// dotenv.config();

const DEPLOYER_PRIVATE_KEY =  process.env.DEPLOYER_PRIVATE_KEY;
const ALCHEMY_API_KEY = process.env.ALCHEMY_API_KEY;

if(!DEPLOYER_PRIVATE_KEY) throw new Error();
if(!ALCHEMY_API_KEY) throw new Error();

module.exports = {
  solidity: "0.8.24",

  networks: {
    hardhat: { },
    sepolia: {
      url: "https://eth-sepolia.g.alchemy.com/v2/"+ALCHEMY_API_KEY,
      accounts: [ DEPLOYER_PRIVATE_KEY ],
    }
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
  sourcify: {
    enabled: true,
  }
};
