// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");
const { ethers } = require("hardhat");

const ONE_GWEI = 1_000_000_000n;
const salt = 12345;

module.exports = buildModule("RPSLS", (m) => {
  const opponent = m.getParameter(
    "opponent",
    "0x70997970C51812dc3A010C7d01b50e0d17dc79C8"
  );
  const commitment = m.getParameter(
    "commitment",
    ethers.solidityPackedKeccak256(["uint8", "uint256"], [1, salt])
  );

  const rpsls = m.contract("RPSLS", [opponent, commitment], {
    value: ONE_GWEI,
  });

  return { rpsls };
});
