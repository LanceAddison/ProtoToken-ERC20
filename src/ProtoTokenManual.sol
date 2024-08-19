// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract ProtoTokenManual {
    error ProtoTokenManual__TransferBalancesIncorrect();

    mapping(address=>uint256) private s_balances;
    uint256 private s_totalSupply;

    constructor() {
        _mint(msg.sender, 100 ether);
    }
    
    function name() public pure returns (string memory) {
        return "ProtoTokenManual";
    }

    function symbol() public pure returns (string memory) {
        return "PTM";
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function totalSupply() public view returns (uint256) {
        return s_totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return s_balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        uint256 previousBalances = balanceOf(msg.sender) + balanceOf(_to);
        s_balances[msg.sender] -= _value;
        s_balances[_to] += _value;
        if (balanceOf(msg.sender) + balanceOf(_to) != previousBalances) {
            revert ProtoTokenManual__TransferBalancesIncorrect();
        }
        return true;
    }

    function _mint(address _to, uint256 _amount) private {
        s_totalSupply += _amount;
        s_balances[_to] += _amount;
    }
}