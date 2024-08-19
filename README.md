# ProtoToken ERC20
# Getting Started
## Quickstart
```
git clone https://github.com/LanceAddison/ProtoToken-ERC20.git
cd ProtoToken-ERC20
forge install
forge build
```
# Usage
## OpenZeppelin
### Installing OpenZeppelin Contracts Package
```
forge install OpenZeppelin/openzeppelin-contracts --no-commit
```

## Start a local node
```
make anvil
```
   
## Deploy
This will default to your local node. You need to have it runnint in another window in order for it to deploy
```
make deploy
```

## Deploy - Other Network
[See below](#deployment-to-a-testnet-or-mainnet)

## Testing
```
forge test
```

# Deployment to a testnet or mainnet
1. Setup environment variables
You'll want to set your ```SEPOLIA_RPC_URL``` and ```PRIVATE_KEY``` as environment variables in a ```.env``` file. 
Optionally you can add a ```ETHERSCAN_API_KEY``` if you want to verify you contract on Etherscan
1. Get testnet ETH
2. Deploy
```
make deploy ARGS="--network sepolia"
```

## Scripts
After deploying to a testnet or local net, you can run these scripts.
Using cast deployed locally example:
```
cast call <ERC20_CONTRACT_ADDRESS> "balanceOf(address) <ADDRESS_TO_CHECK> --rpc-url <CHAIN_RPC_URL>
``` 
or, to transfer to another wallet
```
cast send <ERC20_CONTRACT_ADDRESS> "transfer(address,uint256) <TO_ADDRESS> <AMOUNT> --rpc-url <CHAIN_RPC_URL> --private-key <PRIVATE_KEY>
```

# Thank you!
