// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {

  signers = await ethers.getSigners();
  accounts = signers.map((item) => item.address);

  // owners = signers.slice(0, 3);
  // signatories = signers.slice(3, 8);

  // ownerAddresses = accounts.slice(0, 3);
  // signatoriesAddresses = accounts.slice(3, 6);

  const contractFactory = await hre.ethers.getContractFactory("AnkhValidatorModule");
  const contract = await contractFactory.deploy();
  // await contract.deployed();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

