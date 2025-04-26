// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Token {
    mapping(address => uint256) balances;
    uint256 public totalSupply;

    constructor(uint256 _initialSupply) {
        // Remove unnecessary visibility modifier
        balances[msg.sender] = totalSupply = _initialSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        // Solidity ^0.8.0 prevents overflow/underflow for uint256
        // so we have to make it unchecked to behave as though the contract is using solidity <0.8.0
        unchecked {
            require(balances[msg.sender] - _value >= 0);
            balances[msg.sender] -= _value;
            balances[_to] += _value;
        }
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }
}
