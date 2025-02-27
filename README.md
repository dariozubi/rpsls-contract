# Rock, Paper, Scissors, Lizard, Spock for Ethereum

This project sets the ground for a local development of a RPSLS contract for Ethereum. The contract is just an updated version of the [contract made by Clément Lesaege](https://github.com/clesaege/RPS/blob/master/RPS.sol) with some extra messages for error handling.

## Compiling the contract

To compile the contract you have to run:

```bash
npx hardhat compile
```

## Using the console

To test the contract with an interactive console you can use Hardhat's console. To do it, first run the node in one terminal:

```bash
npx hardhat node
```

Then you have to deploy the smart contract:

```bash
npx hardhat ignition deploy ignition/modules/RPSLS.js --network localhost
```

To run the interactive console:

```bash
npx hardhat console --network localhost
```

Then you can do stuff like:

```javascript
> const signers = await ethers.getSigners()
> const contract = await ethers.getContractAt("RPSLS", "0x5fbdb2315678afecb367f032d93f642f64180aa3")
> await ethers.provider.getBalance("0x5fbdb2315678afecb367f032d93f642f64180aa3")
> await contract.connect(signers[1]).play(2, { value: ethers.parseUnits("1", "gwei") })
> await ethers.provider.getBalance("0x5fbdb2315678afecb367f032d93f642f64180aa3")
> await contract.solve(1, 12345)
> await ethers.provider.getBalance("0x5fbdb2315678afecb367f032d93f642f64180aa3")
```
