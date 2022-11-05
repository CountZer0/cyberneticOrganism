// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import * as CyborgTables from "./CyborgTables.sol";

/**
    @notice Roll dice
    @param die How many faces on the dice
    @return Die result
 */
function dieRoll(uint die) view returns (uint8) {
    uint randomHash = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));
    uint8 dieResult = uint8(randomHash % die + 1);
    return dieResult;
}

/**
    @notice Roll dice
    @param die How many faces on the dice
    @param n How many dice to add together
    @return addedUp Total of all dice
 */
function dieRolls(uint die, uint256 n) view returns (uint8 addedUp) {

    uint256 randomValue = uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));
    for (uint256 i = 0; i < n; i++) {
        addedUp += uint8(uint256(keccak256(abi.encode(randomValue, i))) % die + 1);
        //            addedUp += uint8(uint256(keccak256(abi.encodePacked(randomValue, i, tx.gasprice))) % die + 1);
    }
    return addedUp;
}

/**
    @notice Roll dice
    @param die How many faces on the dice
    @param dice How many dice to add together
    @param n How many groups of dice to create
    @return expandedRolls Total of all dice in groups
 */
function dieRollsMultiple(uint die, uint dice, uint256 n) view returns (uint8[] memory expandedRolls) {
    uint256 randomValue = uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));
    expandedRolls = new uint8[](n);
    for (uint256 i = 0; i < n; i++) {
        uint8 addedUp;
        for (uint256 j = 0; j < dice; j++) {
            addedUp += uint8(uint256(keccak256(abi.encode(randomValue, i))) % die + 1);
        }
        expandedRolls[i] = addedUp;
    }
    return expandedRolls;
}

/**

    @notice Roll dice
    @param roll Convert dice to agility modifier
    @return agility modifier
 */
function rollToAbilityModifier(uint roll) pure returns (int8) {
    if      (roll <= 4) return -3;
    else if (roll <= 6) return -2;
    else if (roll <= 8) return -1;
    else if (roll <= 12) return 0;
    else if (roll <= 14) return 1;
    else if (roll <= 17) return 2;
    else                 return 3;
}
