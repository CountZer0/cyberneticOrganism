// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./DiceUtilities.sol";
import "./CyborgTables.sol";
import "./Base64.sol";

contract CyborgDNA is ERC721URIStorage{

    uint256 public tokenCounter;

    struct Avatar {
        string name;

        int8 strength;
        int8 agility;
        int8 presence;
        int8 toughness;
        int8 knowledge;

        int8 hitPoints;

//        string externalUrl;
//        string ipfs;
        string ipfsURLs;
    }

    Avatar[] public avatars;

    constructor () ERC721 ("CyborgDNA", "CDNA"){
        tokenCounter = 0;
    }

    function createAvatar(
        string memory name,
        int8 strength,
        int8 agility,
        int8 presence,
        int8 toughness,
        int8 knowledge,
        int8 hitPoints,
//        string memory externalUrl,
//        string memory ipfs
        string memory ipfsURLs
    ) public returns (uint256) {
        uint256 newTokenId = tokenCounter;

        avatars.push(
            Avatar(
                name,
                strength,
                agility,
                presence,
                toughness,
                knowledge,
                hitPoints,
//                externalUrl,
//                ipfs
                ipfsURLs
            )
        );

        _safeMint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, _buildTokenURI(newTokenId, msg.sender));
        tokenCounter = tokenCounter + 1;

        return newTokenId;
    }

    function getNumberOfAvatars() public view returns (uint256) {
        return avatars.length;
    }

    function getAvatarStats(uint256 tokenId) public view returns (
        int, // strength
        int, // agility
        int, // presence
        int, // toughness
        int, // knowledge
        int, // hitPoints
//        string memory, // externalUrl
//        string memory // ipfs
        string memory // ipfsURLs
    )
    {
        // only allowed to return max of 7 attributes
        return (
        avatars[tokenId].strength,
        avatars[tokenId].agility,
        avatars[tokenId].presence,
        avatars[tokenId].toughness,
        avatars[tokenId].knowledge,
        avatars[tokenId].hitPoints,
//        avatars[tokenId].externalUrl,
//        avatars[tokenId].ipfs
        avatars[tokenId].ipfsURLs
        );
    }

    function getHitPoints(uint256 tokenId) public view returns (int8){
        return avatars[tokenId].hitPoints;
    }

    function setHitPoints(uint256 tokenId, int8 hitPoints) public{
        avatars[tokenId].hitPoints = hitPoints;
    }

    function _buildTokenURI(uint256 id, address walletAddress) internal view returns (string memory) {

        // We create the an array of string with max length 17
        string[8] memory parts;
        parts[1] = avatars[id].name;
        parts[2] = Strings.toString(uint256(uint8(avatars[id].strength)));
        parts[3] = Strings.toString(uint256(uint8(avatars[id].agility)));
        parts[4] = Strings.toString(uint256(uint8(avatars[id].presence)));
        parts[5] = Strings.toString(uint256(uint8(avatars[id].toughness)));
        parts[6] = Strings.toString(uint256(uint8(avatars[id].knowledge)));
        parts[7] = Strings.toString(uint256(uint8(avatars[id].hitPoints)));

        // roll attribute data
//        uint8[] memory oneToFiftyRolls = DiceUtilities.dieRollsMultiple(50, 1, 3);
        uint8[3] memory oneToFiftyRolls = [1,2,3];

//        // TODO: AvatarTables
//        bytes memory style = CyborgTables.getStyle(oneToFiftyRolls[0]-1);
//        bytes memory style = getStyle(oneToFiftyRolls[0]-1);
//        bytes memory feature = CyborgTables.getFeature(oneToFiftyRolls[1]-1);
//        bytes memory feature = getFeature(oneToFiftyRolls[1]-1);
//        string memory feature = getFeature(oneToFiftyRolls[1]-1);
//        bytes memory obsession = CyborgTables.getObsession(oneToFiftyRolls[2]-1);
//        bytes memory obsession = getObsession(oneToFiftyRolls[2]-1);
//        string memory obsession = getObsession(oneToFiftyRolls[2]-1);


        string memory attributes = string(
            abi.encodePacked(
//                '{ "trait_type": "Base", "value": "Cy80RG"}',
                '{"trait_type": "Strength", "value": ', parts[2], '}',
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
                ', {"display_type": "number", "trait_type": "Generation", "value": "1.0"}',
//                ', {"trait_type": "Style", "value": "', style, '"}',
//                ', {"trait_type": "Feature", "value": "', feature, '"}',
//                ', {"trait_type": "Obsession", "value": "', obsession, '"}',
                ', {"trait_type": "HitPoints", "value": ', parts[7],'}'
            )
        );

//        bytes memory image = "ipfs://bafybeibdbvbg7vzikrbdrvhrcyycw3es3rzdrjmeaubyiykxupmj6qpiq4";

//        bytes memory ipfsImage = avatars[id].ipfsURLs;
//        bytes memory externalUrlImage = avatars[id].ipfsURLs;

        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            parts[1],
                            '", "image":"',
//                            image,
//                            avatars[id].ipfs,
                                avatars[id].ipfsURLs,
                            '", "external_url":"',
//                            avatars[id].externalUrl,
                                avatars[id].ipfsURLs,
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
