// import { useContractReader } from "eth-hooks";
// import { ethers } from "ethers";
import React from "react";
import { Link } from "react-router-dom";

import localBackgroundImage from "../img/Count_Zer0_continuity_artificial_intelligence_e9251595-46d2-4530-b7c3-91fd07c5938a.png";

/**
 * web3 props can be passed from '../App.jsx' into your local view component for use
 * @param {*} yourLocalBalance balance on current network
 * @param {*} readContracts contracts from current chain already pre-loaded using ethers contract module. More here https://docs.ethers.io/v5/api/contract/contract/
 * @returns react component
 **/
function Home({ yourLocalBalance, readContracts }) {
  // you can also use hooks locally in your component of choice
  // in this case, let's keep track of 'purpose' variable from our contract
  // const purpose = useContractReader(readContracts, "CyberneticOrganism", "purpose");

  return (
    <div>
      <div style={{ margin: 32 }}></div>
      <div
        style={{
          backgroundImage: `url(${localBackgroundImage})`,
          backgroundPosition: "center",
          backgroundRepeat: "no-repeat",
          backgroundSize: "cover",
          height: 1024,
        }}
      >
        Tinker with your smart contract using the <Link to="/debug">"Debug Contract"</Link> tab.
      </div>
    </div>
  );
}

export default Home;
