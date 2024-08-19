// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Test} from "forge-std/Test.sol";
import {ProtoTokenManual} from "../src/ProtoTokenManual.sol";

contract ProtoTokenManualTest is Test {
    ProtoTokenManual ptm;
    uint256 public deployerKey = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    function setUp() public {
        address deployerPubKey = vm.addr(deployerKey);

        vm.startBroadcast(deployerPubKey);
        ptm = new ProtoTokenManual();
        vm.stopBroadcast();

        vm.prank(deployerPubKey);
        ptm.transfer(bob, 100 ether);
    }

    function testBobBalance() public view {
        uint256 expectedBalance = 100 ether;
        assertEq(ptm.balanceOf(bob), expectedBalance);
    }

    function testTransferManual() public {
        uint256 transferAmount = 10 ether;
        uint256 initialBalanceBob = ptm.balanceOf(bob);
        vm.prank(bob);
        ptm.transfer(alice, transferAmount);

        assertEq(ptm.balanceOf(alice), transferAmount);
        assertEq(ptm.balanceOf(bob), initialBalanceBob - transferAmount);
    }

    function testProtoTokenManualDecimals() public view {
        uint256 expectedDecimals = 18;
        assertEq(ptm.decimals(), expectedDecimals);
    }
}
