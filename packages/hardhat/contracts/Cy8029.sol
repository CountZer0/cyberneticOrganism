// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./CyberneticOrganism.sol";

contract Cy8029 is CyberneticOrganism{

    function rollCyBorg(
        string memory name,
        string memory externalUrl
    ) public returns (uint256) {
        // Roll the die for attributes

        uint256 newTokenId = tokenCounter;

        uint8[] memory manyRolls = DiceUtilities.dieRollsMultiple(6, 3, 5);

        int8 strength = DiceUtilities.rollToAbilityModifier(manyRolls[0]);
        int8 agility = DiceUtilities.rollToAbilityModifier(manyRolls[1]);
        int8 presence = DiceUtilities.rollToAbilityModifier(manyRolls[2]);
        int8 toughness = DiceUtilities.rollToAbilityModifier(manyRolls[3]);
        int8 knowledge = DiceUtilities.rollToAbilityModifier(manyRolls[4]);

        int8 hitPoints = int8(DiceUtilities.dieRoll(8)) + toughness;
        if (hitPoints < 1){
            hitPoints = 1;
        }

        characters.push(
            Character(
                name,
                strength,
                agility,
                presence,
                toughness,
                knowledge,
                hitPoints,
                externalUrl
            )
        );

        _safeMint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, _buildTokenURI(newTokenId, msg.sender));
        tokenCounter = tokenCounter + 1;

        return newTokenId;
    }
}


