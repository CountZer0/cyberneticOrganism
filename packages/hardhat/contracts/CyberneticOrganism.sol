// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "./DiceUtilities.sol";
import "./CyborgTables.sol";
import "./Base64.sol";

contract CyberneticOrganism is ERC721URIStorage{

    uint256 public tokenCounter;

    struct Character {
        string name;

        int8 strength;
        int8 agility;
        int8 presence;
        int8 toughness;
        int8 knowledge;

        int8 hitPoints;

        string externalUrl;
    }

    Character[] public characters;

    constructor () ERC721 ("CyberneticOrganism", "CY80RG"){
        tokenCounter = 0;
    }

    function createCyBorg(
        string memory name,
        int8 strength,
        int8 agility,
        int8 presence,
        int8 toughness,
        int8 knowledge,
        int8 hitPoints,
        string memory externalUrl
    ) public returns (uint256) {
        uint256 newTokenId = tokenCounter;

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

    function getNumberOfCharacters() public view returns (uint256) {
        return characters.length;
    }

    function getCharacterStats(uint256 tokenId) public view returns (
        int, // strength
        int, // agility
        int, // presence
        int, // toughness
        int, // knowledge
        int, // hitPoints
        string memory // externalUrl
    )
    {
        // only allowed to return max of 7 attributes
        return (
        characters[tokenId].strength,
        characters[tokenId].agility,
        characters[tokenId].presence,
        characters[tokenId].toughness,
        characters[tokenId].knowledge,
        characters[tokenId].hitPoints,
        characters[tokenId].externalUrl
        );
    }

    function getHitPoints(uint256 tokenId) public view returns (int8){
        return characters[tokenId].hitPoints;
    }

    function _buildTokenURI(uint256 id, address walletAddress) internal view returns (string memory) {

        // We create the an array of string with max length 17
        string[9] memory parts;

        parts[0] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 450 350"><style>.base { stroke: "black"; font-family: monospace; font-size: 12px; }</style><rect width="100%" height="100%" fill="yellow" /><text x="10" y="20" class="base">';

        parts[1] = characters[id].name;
        parts[2] = uint256ToString(uint256(uint8(characters[id].strength)));
        parts[3] = uint256ToString(uint256(uint8(characters[id].agility)));
        parts[4] = uint256ToString(uint256(uint8(characters[id].presence)));
        parts[5] = uint256ToString(uint256(uint8(characters[id].toughness)));
        parts[6] = uint256ToString(uint256(uint8(characters[id].knowledge)));
        parts[7] = uint256ToString(uint256(uint8(characters[id].hitPoints)));

        // roll attribute data
        uint8[] memory oneToFiftyRolls = DiceUtilities.dieRollsMultiple(50, 1, 3);
        bytes memory style = CyborgTables.getStyle(oneToFiftyRolls[0]-1);
        bytes memory feature = CyborgTables.getFeature(oneToFiftyRolls[1]-1);
        bytes memory obsession = CyborgTables.getObsession(oneToFiftyRolls[2]-1);

        string memory svg = string(
            abi.encodePacked(
                parts[0],
                "Soul: 0x", _toString(walletAddress), '</text><text x="10" y="40" class="base">',
                "Name: ", parts[1], '</text><text x="10" y="60" class="base">',
                "Strength: ", parts[2], '</text><text x="10" y="80" class="base">',
                "Agility: ", parts[3], '</text><text x="10" y="100" class="base">'
            )
        );
        // add 4 more parts
        svg = string(
            abi.encodePacked(
                svg,
                "Presence: ", parts[4], '</text><text x="10" y="120" class="base">',
                "Toughness: ", parts[5],'</text><text x="10" y="140" class="base">',
                "Knowledge: ", parts[6],'</text><text x="10" y="160" class="base">',
                "</text></svg>"
            )
        );

        string memory attributes = string(
            abi.encodePacked(
//                '{ "trait_type": "Base", "value": "Cy80RG"}',
                ', {"trait_type": "Strength", "value": ', parts[2], '}',
                ', {"trait_type": "Agility", "value": ', parts[3], '}',
                ', {"trait_type": "Presence", "value": ', parts[4], '}',
                ', {"trait_type": "Toughness", "value": ', parts[5], '}',
                ', {"trait_type": "Knowledge", "value": ', parts[6], '}'
            )
        );
        // add more
        attributes = string(
            abi.encodePacked(
                attributes,
//                ', {"display_type": "number", "trait_type": "Generation", "value": "1.0"}',
                ', {"trait_type": "Style", "value": "', style, '"}',
                ', {"trait_type": "Feature", "value": "', feature, '"}',
                ', {"trait_type": "Obsession", "value": "', obsession, '"}',
                ', {"trait_type": "HitPoints", "value": ', parts[7],'}'
            )
        );

        bytes memory image = abi.encodePacked(
            "data:image/svg+xml;base64,",
            Base64.encode(bytes(svg))
        );

        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            parts[1],
                            '", "image":"',
                            image,
                            '", "external_url":"',
                            characters[id].externalUrl,
                            '", "description": "I am souldbound to 0x', _toString(walletAddress), '."',
                            ', "attributes": [',
                            attributes,
                            ']}'
                        )
                    )
                )
            )
        );
    }

    function _toString(address x) internal pure returns (string memory) {
        bytes memory s = new bytes(40);
        for (uint i = 0; i < 20; i++) {
            bytes1 b = bytes1(uint8(uint(uint160(x)) / (2**(8*(19 - i)))));
            bytes1 hi = bytes1(uint8(b) / 16);
            bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
            s[2*i] = char(hi);
            s[2*i+1] = char(lo);
        }
        return string(s);
    }

    function char(bytes1 b) internal pure returns (bytes1 c) {
        if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
        else return bytes1(uint8(b) + 0x57);
    }

    function uint256ToString(uint256 number) internal pure returns (string memory) {
        // from int8 to uint8 to uint256
        if (number > 200){
            return string(abi.encodePacked("-", Strings.toString(256-number)));
        }
        return Strings.toString(number);
    }
}


