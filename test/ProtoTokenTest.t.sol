// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Test} from "forge-std/Test.sol";
import {ProtoToken} from "../src/ProtoToken.sol";
import {DeployProtoToken} from "../script/DeployProtoToken.s.sol";

contract ProtoTokenTest is Test {
    DeployProtoToken deployer;
    ProtoToken protoToken;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");
    address public deployerAddress;

    uint256 public constant STARTING_BALANCE = 100 ether;
    string public tokenSymbol = "PT";

    function setUp() public {
        deployer = new DeployProtoToken();
        protoToken = deployer.run();

        deployerAddress = vm.addr(deployer.deployerKey());
        vm.prank(deployerAddress);
        protoToken.transfer(bob, STARTING_BALANCE);
    }

    function testInitialBalanceBob() public view {
        assertEq(STARTING_BALANCE, protoToken.balanceOf(bob));
    }

    function testTokenSymbol() public view {
        assertEq(protoToken.symbol(), tokenSymbol);
    }

    function testTransfer() public {
        uint256 transferAmount = 10 ether;

        vm.prank(bob);
        protoToken.transfer(alice, transferAmount);

        assertEq(protoToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
        assertEq(protoToken.balanceOf(alice), transferAmount);
    }

    function testBurn() public {
        uint256 burnAmount = 10 ether;

        vm.prank(bob);
        protoToken.burn(burnAmount);

        assertEq(protoToken.balanceOf(bob), STARTING_BALANCE - burnAmount);
        assertEq(protoToken.totalSupply(), deployer.INITIAL_SUPPLY() - burnAmount);
    }

    function testApprovalWorks() public {
        uint256 approvalAmount = 10 ether;

        vm.prank(bob);
        protoToken.approve(alice, approvalAmount);

        vm.prank(alice);
        protoToken.transferFrom(bob, alice, approvalAmount);

        assertEq(protoToken.balanceOf(alice), approvalAmount);
        assertEq(protoToken.balanceOf(bob), STARTING_BALANCE - approvalAmount);
    }

    function testFailTransferFromMoreThanAllowed() public {
        uint256 transferAmount = 10 ether;

        vm.prank(bob);
        protoToken.approve(alice, transferAmount / 2);

        vm.prank(alice);
        protoToken.transferFrom(bob, alice, transferAmount);
    }
}
