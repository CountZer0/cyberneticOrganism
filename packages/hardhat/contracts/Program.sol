// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./CyberneticOrganism.sol";

contract Program is ERC721URIStorage {

    uint256 public tokenCounter;
    address cyberneticOrganismAddress;

    struct ProgramStats {
        string name;
        string description;

        int8 damage;

        string ipfsURLs;
    }

    ProgramStats[] public programStats;

    constructor(address addr) ERC721 ("Program", "PRGM") {
        tokenCounter = 0;
        cyberneticOrganismAddress = addr;
    }

    function createProgram(
        string memory name,
        string memory description,
        int8 damage,
        string memory ipfsURLs
    ) public returns (uint256) {
        uint256 newTokenId = tokenCounter;

        programStats.push(
            ProgramStats(
                name,
                    description,
                    damage,
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
        programStats[tokenId].damage +=1;
        // update uri
        _setTokenURI(tokenId, _buildTokenURI(tokenId, msg.sender));
    }

    function getCyberneticOrganismAddress() public view returns (address) {
        return cyberneticOrganismAddress;
    }

    function getProgramStats(uint8 tokenId) public view returns (
        string memory, // name
        string memory, // description
        int8, // damage
        string memory // ipfsURLs
    )
    {
        return (
        programStats[tokenId].name,
        programStats[tokenId].description,
        programStats[tokenId].damage,
        programStats[tokenId].ipfsURLs
        );
    }

    function _buildTokenURI(uint256 id, address walletAddress) internal view returns (string memory) {

        // We create the an array of string with max length 17
        string[3] memory parts;
        parts[0] = programStats[id].name;
        parts[1] = programStats[id].description;
        parts[2] = Strings.toString(uint256(uint8(programStats[id].damage)));


        // roll attribute data
//        uint8[] memory oneToFiftyRolls = DiceUtilities.dieRollsMultiple(50, 1, 3);

        // TODO: ProgramTables
//        bytes memory style = CyborgTables.getStyle(oneToFiftyRolls[0]-1);

        string memory attributes = string(
            abi.encodePacked(
                '{"trait_type": "Name", "value": ', parts[0], '}',
                ', {"trait_type": "Description", "value": ', parts[1], '}',
                ', {"trait_type": "Damage", "value": ', parts[2], '}'
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
                                programStats[id].ipfsURLs,
                            '", "external_url":"',
                                programStats[id].ipfsURLs,
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