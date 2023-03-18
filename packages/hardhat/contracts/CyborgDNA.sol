// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "./DiceUtilities.sol";
import "./CyborgTables.sol";
import "./Base64.sol";

contract Cy8029DNA is ERC721URIStorage{

    uint256 public tokenCounter;

    struct Avatar {
        string name;

        int8 strength;
        int8 agility;
        int8 presence;
        int8 toughness;
        int8 knowledge;

        int8 hitPoints;

        int8 glitches;

        string ipfsURLs;
    }

    Avatar[] public avatars;

    constructor () ERC721 ("CY8029DNA", "CDNA"){
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
        int8 glitches,
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
                glitches,
                ipfsURLs
            )
        );

        _safeMint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, _buildTokenURI(newTokenId, msg.sender));
//        _setTokenURI(newTokenId, _buildTokenURI(newTokenId));
        tokenCounter = tokenCounter + 1;

        return newTokenId;
    }

    function getNumberOfAvatars() public view returns (uint256) {
        return avatars.length;
    }

    function setAvatarStats(
        uint256 tokenId,
        int8 strength,
        int8 agility,
        int8 presence,
        int8 toughness,
        int8 knowledge
    ) public {
        avatars[tokenId].strength = strength;
        avatars[tokenId].agility = agility;
        avatars[tokenId].presence = presence;
        avatars[tokenId].toughness = toughness;
        avatars[tokenId].knowledge = knowledge;

        // update tokenURI TODO: use old wallet address
        _setTokenURI(tokenId, _buildTokenURI(tokenId, msg.sender));
//        _setTokenURI(tokenId, _buildTokenURI(tokenId));
    }

    function updateTokenURI(uint256 tokenId) public{
        // update tokenURI TODO: use old wallet address
        _setTokenURI(tokenId, _buildTokenURI(tokenId, msg.sender));
    }


    function getHitPoints(uint256 tokenId) public view returns (int8){
        return avatars[tokenId].hitPoints;
    }

    function setHitPoints(uint256 tokenId, int8 hitPoints) public{
        avatars[tokenId].hitPoints = hitPoints;

        // update tokenURI TODO: use old wallet address
        _setTokenURI(tokenId, _buildTokenURI(tokenId, msg.sender));
//        _setTokenURI(tokenId, _buildTokenURI(tokenId));
    }

    function adjustHitPoints(uint256 tokenId, int8 hitPoints) public returns (int8) {
        int8 newHitPoints = avatars[tokenId].hitPoints + hitPoints;
        avatars[tokenId].hitPoints = newHitPoints;

        _setTokenURI(tokenId, _buildTokenURI(tokenId, msg.sender));
        return newHitPoints;
    }

    function getGlitches(uint256 tokenId) public view returns (int8){
        return avatars[tokenId].glitches;
    }

    function setGlitches(uint256 tokenId, int8 glitches) public{
        avatars[tokenId].glitches = glitches;

        // update tokenURI TODO: use old wallet address
        _setTokenURI(tokenId, _buildTokenURI(tokenId, msg.sender));
//        _setTokenURI(tokenId, _buildTokenURI(tokenId));
    }

    function _buildTokenURI(uint256 id, address walletAddress) internal view returns (string memory) {
//    function _buildTokenURI(uint256 id) internal view returns (string memory) {

        // We create the an array of string with max length 17
        string[9] memory parts;
        parts[1] = avatars[id].name;
        parts[2] = uint256ToString(uint256(uint8(avatars[id].strength)));
        parts[3] = uint256ToString(uint256(uint8(avatars[id].agility)));
        parts[4] = uint256ToString(uint256(uint8(avatars[id].presence)));
        parts[5] = uint256ToString(uint256(uint8(avatars[id].toughness)));
        parts[6] = uint256ToString(uint256(uint8(avatars[id].knowledge)));
        parts[7] = uint256ToString(uint256(uint8(avatars[id].hitPoints)));
        parts[8] = uint256ToString(uint256(uint8(avatars[id].glitches)));

        string memory attributes = string(
            abi.encodePacked(
                '{ "trait_type": "Base", "value": "Cy80RG"}',
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
                ', {"display_type": "number", "trait_type": "Generation", "value": "1.0"}',
//                ', {"trait_type": "Style", "value": "', style, '"}',
//                ', {"trait_type": "Feature", "value": "', feature, '"}',
//                ', {"trait_type": "Obsession", "value": "', obsession, '"}',
                ', {"trait_type": "HitPoints", "value": ', parts[7],'}'
            ', {"trait_type": "Glitches", "value": ', parts[8],'}'
            )
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
                            avatars[id].ipfsURLs,
                            '", "external_url":"',
                            avatars[id].ipfsURLs,
                            '", "description": "I am souldbound to 0x', Strings.toHexString(walletAddress), '."',
//                            '", "description": "I am born from the ThursdayNightAcademy.eth"',
                            ', "attributes": [',
                            attributes,
                            ']}'
                        )
                    )
                )
            )
        );
    }

    function uint256ToString(uint256 number) internal pure returns (string memory) {
        // from int8 to uint8 to uint256
        if (number > 200){
            return string(abi.encodePacked("-", Strings.toString(256-number)));
        }
        return Strings.toString(number);
    }
}
