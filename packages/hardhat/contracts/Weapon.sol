// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./CyberneticOrganism.sol";

contract Weapon is ERC721URIStorage{

    uint256 public tokenCounter;
    address cyberneticOrganismAddress;

    struct WeaponStats {
        string name;
        string class;

        int8 level;

        string ipfsURLs;
    }

    WeaponStats[] public weaponStats;

    constructor(address addr) ERC721 ("Weapon", "Weapon"){
        tokenCounter = 0;
        cyberneticOrganismAddress = addr;
    }

    function createWeapon(
        string memory name,
        string memory class,
        int8 level,
        string memory ipfsURLs
    ) public returns (uint256) {
        uint256 newTokenId = tokenCounter;

        weaponStats.push(
            WeaponStats(
                name,
                class,
                level,
                ipfsURLs
            )
        );

        _safeMint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, _buildTokenURI(newTokenId, msg.sender));
        tokenCounter = tokenCounter + 1;

        return newTokenId;
    }

    function doDamage(uint256 tokenId, int8 damage) public{
        CyberneticOrganism co = CyberneticOrganism(cyberneticOrganismAddress);
        co.adjustHitPoints(tokenId, damage);
        // advance level
        weaponStats[tokenId].level += 1;
        // update uri
        _setTokenURI(tokenId, _buildTokenURI(tokenId, msg.sender));
    }

    function getCyberneticOrganismAddress() public view returns (address) {
        return cyberneticOrganismAddress;
    }

    function getWeaponStats(uint8 tokenId) public view returns (
        string memory, // name
        string memory, // class
        int8, // level
        string memory // ipfsURLs
    )
    {
        return (
        weaponStats[tokenId].name,
        weaponStats[tokenId].class,
        weaponStats[tokenId].level,
        weaponStats[tokenId].ipfsURLs
        );
    }

    function _buildTokenURI(uint256 id, address walletAddress) internal view returns (string memory) {

        // We create the an array of string with max length 17
        string[3] memory parts;
        parts[0] = weaponStats[id].name;
        parts[1] = weaponStats[id].class;
        parts[2] = Strings.toString(uint256(uint8(weaponStats[id].level)));


        // roll attribute data
//        uint8[] memory oneToFiftyRolls = DiceUtilities.dieRollsMultiple(50, 1, 3);

        // TODO: WeaponTables
//        bytes memory style = CyborgTables.getStyle(oneToFiftyRolls[0]-1);

        string memory attributes = string(
            abi.encodePacked(
                '{"trait_type": "Name", "value": ', parts[0], '}',
                ', {"trait_type": "Class", "value": ', parts[1], '}',
                ', {"trait_type": "Level", "value": ', parts[2], '}'
            )
        );

        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                                parts[0],
                            '", "image":"',
                                weaponStats[id].ipfsURLs,
                            '", "external_url":"',
                                weaponStats[id].ipfsURLs,
                            '", "description": "I am souldbound to 0x', Strings.toHexString(walletAddress), '."',
                            ', "attributes": [',
                                attributes,
                            ']}'
                        )
                    )
                )
            )
        );
    }
}