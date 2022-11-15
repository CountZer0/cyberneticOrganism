// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

library CyborgTables {

    function getStyle(uint roll) internal pure returns (bytes memory){

        bytes[50] memory style;
        style[0] ="0Core";
        style[1] ="Acid panda";
        style[2] ="Beastie";
        style[3] ="Bitcrusher";
        style[4] ="Bloodsport";
        style[5] ="Cadavercore";
        style[6] ="Codefolk";
        style[7] ="Converter";
        style[8] ="Corpodrone";
        style[9] = "Cosmopunk";
        style[10] ="Cvit";
        style[11] ="Cybercrust";
        style[12] ="CyPop";
        style[13] ="Daemonista";
        style[14] ="Deathbloc";
        style[15] ="Doomtroop";
        style[16] ="Ghoul";
        style[17] ="Glitchmode";
        style[18] ="Goregrinder";
        style[19] = "Gutterscum";
        style[20] ="Hexcore";
        style[21] ="Hype street";
        style[22] ="Kill mode";
        style[23] ="Meta";
        style[24] ="Mimic";

        style[25] ="Minimal";
        style[26] ="Minotaur";
        style[27] ="Mobwave";
        style[28] ="Monsterwave";
        style[29]= "Murdercore";
        style[30] ="Necropop";
        style[31] ="Neurotripper";
        style[32] ="NuFlesh";
        style[33] ="NuGoth";
        style[34] ="NuPrep";
        style[35] ="Oceanwave";
        style[36] ="OG";
        style[37] ="Old-school cyberpunk";
        style[38] ="Orbital";
        style[39] = "Postlife";
        style[40] ="Pyrocore";
        style[41] ="Razormouth";
        style[42] ="Retro metal";
        style[43] ="Riot kid";
        style[44] ="Robomode";
        style[45] ="Roller bruiser";
        style[46] ="Technoir";
        style[47] ="Trad punk";
        style[48] ="Wallgoth";
        style[49] = "Waster";

        return style[roll];
    }

    function getFeature(uint roll) internal pure returns (bytes memory){

        bytes[50] memory feature;
        feature[0] ="Abundance of rings";
        feature[1] ="All monochrome";
        feature[2] ="Artificial skin";
        feature[3] ="Beastlike";
        feature[4] ="Broken nose";
        feature[5] ="Burn scars";
        feature[6] ="Complete hairless";
        feature[7] ="Cosmetic gills";
        feature[8] ="Covered in tattoos";
        feature[9] = "Customized voicebox";
        feature[10] ="Disheveled look";
        feature[11] ="Dollfaced";
        feature[12] ="Dueling scars";
        feature[13] ="Elaborate hairstyle";
        feature[14] ="Enhanced cheekbones";
        feature[15] ="Fluorescent veins";
        feature[16] ="Forehead display";
        feature[17] ="Giant RCD helmet rig";
        feature[18] ="Glitterskin";
        feature[19] = "Glowing respirator";
        feature[20] ="Golden grillz";
        feature[21] ="Headband";
        feature[22] ="Heavy on the makeup";
        feature[23] ="Holomorphed face";
        feature[24] ="Interesting perfume";

        feature[25] ="Lace trimmings";
        feature[26] ="Laser branded";
        feature[27] ="Lipless-just teeth";
        feature[28] ="Mirror eyes";
        feature[29] = "More plastic than skin";
        feature[30] ="Necrotic face";
        feature[31] ="Nonhuman ears";
        feature[32] ="Palms covered in notes";
        feature[33] ="Pattern overdose";
        feature[34] ="Plenty of piercings";
        feature[35] ="Radiant eyebrows";
        feature[36] ="Rainbow haircut";
        feature[37] ="Ritual scarifications";
        feature[38] ="Robotlike";
        feature[39] = "Shoulder pads";
        feature[40] ="Subdermal implants";
        feature[41] ="Tons of jewelery";
        feature[42] ="Traditional amulets";
        feature[43] ="Translucent skin";
        feature[44] ="Transparent wear";
        feature[45] ="Unkept hair";
        feature[46] ="Unnatural eyes";
        feature[47] ="UV-inked face";
        feature[48] ="VIP lookalike";
        feature[49] = "War paints";

        return feature[roll];
    }

    function getObsession(uint roll) internal pure returns (bytes memory){

        bytes[50] memory obsession;
        obsession[0] ="Adrenaline";
        obsession[1] ="AI Poetry";
        obsession[2] ="Ammonium Chloride Candy";
        obsession[3] ="Ancient Grimoires";
        obsession[4] ="Arachnids";
        obsession[5] ="Belts";
        obsession[6] ="Blades";
        obsession[7] ="Bones";
        obsession[8] ="Customized Cars";
        obsession[9] = "Dronespotting";
        obsession[10] ="Experimental Stimuli";
        obsession[11] ="Explosives";
        obsession[12] ="Extravagant Manicure";
        obsession[13] ="Gauze and Band-aids";
        obsession[14] ="Gin";
        obsession[15] ="Graffiti";
        obsession[16] ="Hand-Pressed Synthpresso";
        obsession[17] ="Handheld Games";
        obsession[18] ="Headphones";
        obsession[19] = "History Sims";
        obsession[20] ="Interactive Holo-ink";
        obsession[21] ="Journaling";
        obsession[22] ="Masks";
        obsession[23] ="Medieval Weaponry";
        obsession[24] ="Microbots";

        obsession[25] ="Mixing Stimulants";
        obsession[26] ="Model Mech Kits";
        obsession[27] ="Obsolete Tech";
        obsession[28] ="Porcelain figurines";
        obsession[29] = "Painted Shirts";
        obsession[30] ="Puppets";
        obsession[31] ="Records";
        obsession[32] ="Recursive Synthesizers";
        obsession[33] ="Shades";
        obsession[34] ="Slacklining";
        obsession[35] ="Sneakers";
        obsession[36] ="Stim Smokes";
        obsession[37] ="Style Hopping";
        obsession[38] ="Tarot";
        obsession[39] = "Taxidermy";
        obsession[40] ="Trendy Food";
        obsession[41] ="Urban Exploring";
        obsession[42] ="Vampires vs. Werewolves";
        obsession[43] ="Vintage Army Jackets";
        obsession[44] ="Vintage TV Shows";
        obsession[45] ="Virtuaflicks";
        obsession[46] ="Virtuapals";
        obsession[47] ="Voice Modulators";
        obsession[48] ="Watches";
        obsession[49] = "Wigs";

        return obsession[roll];
    }

    function getWants(uint roll) internal pure returns (bytes memory){

        bytes[20] memory wants;
        wants[0] ="Anarchy";
        wants[1] ="Burn It All Down";
        wants[2] ="Cash";
        wants[3] ="Drugs";
        wants[4] ="Enlightenment";
        wants[5] ="Fame";
        wants[6] ="Freedom";
        wants[7] ="Fun";
        wants[8] ="Justice";
        wants[9] = "Love";
        wants[10] ="Mayhem";
        wants[11] ="Power Over Others";
        wants[12] ="Revenge";
        wants[13] ="Safety for Loved Ones";
        wants[14] ="Save the World";
        wants[15] ="See Others Fail";
        wants[16] ="Self-Control";
        wants[17] ="Self-Actualization";
        wants[18] ="Success";
        wants[19] = "To Kill";

        return wants[roll];
    }

    function getQuirk(uint roll) internal pure returns (bytes memory){

        bytes[20] memory quirk;
        quirk[0] ="Chainsmoker";
        quirk[1] ="Chew on Hair";
        quirk[2] ="Compulsive Swearing";
        quirk[3] ="Constantly Watching Holos";
        quirk[4] ="Coughs";
        quirk[5] ="Fiddles with Jewelry";
        quirk[6] ="Flirty";
        quirk[7] ="Gestures a Lot";
        quirk[8] ="Giggles Inappropriately";
        quirk[9] = "Hat/Hood and Shades, Always";
        quirk[10] ="Itchy";
        quirk[11] ="Loudly Chews Gum";
        quirk[12] = "Must Tag Every Location";
        quirk[13] ="Never Looks Anyone in the Eye";
        quirk[14] ="Nosepicker";
        quirk[15] ="Rapid Blinking";
        quirk[16] ="Reeks of Lighter Fluid";
        quirk[17] ="Scratches Facial Scar";
        quirk[18] ="Twitchy";
        quirk[19] = "Wheezes";

        return quirk[roll];
    }

}