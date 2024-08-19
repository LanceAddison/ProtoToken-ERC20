-include .env

.PHONY: deploy build test help

help:
	@echo "Usage:"
	@echo " make deploy [ARGS=...]\n	example: make deploy ARGS=\"--network sepolia\""

build :; forge build

test :; forge test

NETWORK_ARGS := --rpc-url $(ANVIL_RPC_URL) --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) --legacy
endif

deploy:
	@forge script script/DeployProtoToken.s.sol:DeployProtoToken $(NETWORK_ARGS)