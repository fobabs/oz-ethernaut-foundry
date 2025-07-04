// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Level} from "./Level.sol";

contract Ethernaut is Ownable {
    // Errors
    error Ethernaut__LevelNotRegistered();
    error Ethernaut__WrongInstanceForPlayer();
    error Ethernaut__LevelAlreadyCompleted();

    // Struct
    struct InstanceData {
        address player;
        Level level;
        bool isCompleted;
    }

    // Mappings
    mapping(address => InstanceData) public instances;
    mapping(address => bool) public registeredLevels;

    // Events
    event LevelInstanceCreated(address indexed player, address instance);
    event LevelCompleted(address indexed player, Level level);

    constructor() Ownable(msg.sender) {}

    function registerLevel(Level _level) public onlyOwner {
        registeredLevels[address(_level)] = true;
    }

    function createLevelInstance(Level _level) public payable returns (address instance) {
        if (!registeredLevels[address(_level)]) revert Ethernaut__LevelNotRegistered();

        instance = _level.createInstance{value: msg.value}(msg.sender);
        instances[instance] = InstanceData(msg.sender, _level, false);

        emit LevelInstanceCreated(msg.sender, instance);
    }

    function submitLevelInstance(address payable _instance) public returns (bool) {
        InstanceData memory instanceData = instances[_instance];
        if (instanceData.player != msg.sender) revert Ethernaut__WrongInstanceForPlayer();
        if (instanceData.isCompleted) revert Ethernaut__LevelAlreadyCompleted();

        if (instanceData.level.validateInstance(_instance, msg.sender)) {
            instanceData.isCompleted = true;

            emit LevelCompleted(msg.sender, instanceData.level);
            return true;
        }
        return false;
    }
}
