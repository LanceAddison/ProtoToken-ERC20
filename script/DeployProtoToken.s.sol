// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import {ProtoToken} from "../src/ProtoToken.sol";

contract DeployProtoToken is Script {
    uint256 public constant INITIAL_SUPPLY = 100 ether;
    uint256 public deployerKey;

    function run() external returns (ProtoToken) {
        if (block.chainid == 31337) {
            deployerKey = vm.envUint("DEFAULT_ANVIL_KEY");
        } else {
            deployerKey = vm.envUint("PRIVATE_KEY");
        }

        vm.startBroadcast(deployerKey);
        ProtoToken pt = new ProtoToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return pt;
    }
}