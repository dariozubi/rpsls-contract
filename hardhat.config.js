require("@nomicfoundation/hardhat-toolbox");

const fs = require("fs");
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  sepolia: {
    url: `https://eth-sepolia.g.alchemy.com/v2/${fs
      .readFileSync(".alchemy")
      .toString()
      .trim()}`,
    accounts: [fs.readFileSync(".metamask").toString().trim()],
  },
  etherscan: {
    apiKey: fs.readFileSync(".etherscan").toString().trim(),
  },
};
