// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ProtoToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("ProtoToken", "PT") {
        _mint(msg.sender, initialSupply);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }
}