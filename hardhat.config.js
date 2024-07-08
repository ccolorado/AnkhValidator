require('dotenv').config({ path: __dirname + '/.env' });

require("@nomicfoundation/hardhat-toolbox");

// dotenv.config();

const DEPLOYER_PRIVATE_KEY =  process.env.DEPLOYER_PRIVATE_KEY;

if(!DEPLOYER_PRIVATE_KEY) throw new Error();


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",

  networks: {
    hardhat: { },
    sepolia: {
      url: "https://eth-sepolia.g.alchemy.com/v2/"+process.env.DEPLOYER_PRIVATE_KEY,
      accounts: [ DEPLOYER_PRIVATE_KEY ],
      chainId: 43114,
      // gasPrice: 470000000000,
      // accounts: [
    }
  }
};
