// deploy/00_deploy_your_contract.js
// noinspection JSUnusedLocalSymbols
/* eslint-disable no-unused-vars */

const { ethers } = require("hardhat");

const localChainId = "31337";

// const sleep = (ms) =>
//   new Promise((r) =>
//     setTimeout(() => {
//       console.log(`waited for ${(ms / 1000).toFixed(3)} seconds`);
//       r();
//     }, ms)
//   );

module.exports = async ({ getNamedAccounts, deployments, getChainId }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  // eslint-disable-next-line no-unused-vars
  const chainId = await getChainId();

  await deploy("CyberneticOrganism", {
    // Learn more about args here: https://www.npmjs.com/package/hardhat-deploy#deploymentsdeploy
    from: deployer,
    // args: [ "Hello", ethers.utils.parseEther("1.5") ],
    log: true,
    waitConfirmations: 5,
  });

  await deploy("AvatarDNA", {
    from: deployer,
    log: true,
    waitConfirmations: 5,
  });

  // const avatarDNA = await ethers.getContract("AvatarDNA", deployer);
  // const cyborg = await ethers.getContract("CyberneticOrganism", deployer);

  await deploy("Cy8029", {
    from: deployer,
    log: true,
    waitConfirmations: 5,
    // args: [cyborg.address],
  });

  // Getting a previously deployed contract
  // const CyberneticOrganism = await ethers.getContract("CyberneticOrganism", deployer);
  // const CyberneticOrganism = await ethers.getContract("Cy8029", deployer);
  /*  await CyberneticOrganism.setPurpose("Hello");
  
    // To take ownership of CyberneticOrganism using the ownable library uncomment next line and add the 
    // address you want to be the owner. 
    
    await CyberneticOrganism.transferOwnership(
      "ADDRESS_HERE"
    );

    //const CyberneticOrganism = await ethers.getContractAt('CyberneticOrganism', "0xaAC799eC2d00C013f1F11c37E654e59B0429DF6A") //<-- if you want to instantiate a version of a contract at a specific address!
  */

  /*
  //If you want to send value to an address from the deployer
  const deployerWallet = ethers.provider.getSigner()
  await deployerWallet.sendTransaction({
    to: "0x34aA3F359A9D614239015126635CE7732c18fDF3",
    value: ethers.utils.parseEther("0.001")
  })
  */

  /*
  //If you want to send some ETH to a contract on deploy (make your constructor payable!)
  const CyberneticOrganism = await deploy("CyberneticOrganism", [], {
  value: ethers.utils.parseEther("0.05")
  });
  */

  /*
  //If you want to link a library into your contract:
  // reference: https://github.com/austintgriffith/scaffold-eth/blob/using-libraries-example/packages/hardhat/scripts/deploy.js#L19
  const CyberneticOrganism = await deploy("CyberneticOrganism", [], {}, {
   LibraryName: **LibraryAddress**
  });
  */

  // Verify from the command line by running `yarn verify`

  // You can also Verify your contracts with Etherscan here...
  // You don't want to verify on localhost
  // try {
  //   if (chainId !== localChainId) {
  //     await run("verify:verify", {
  //       address: CyberneticOrganism.address,
  //       contract: "contracts/CyberneticOrganism.sol:CyberneticOrganism",
  //       constructorArguments: [],
  //     });
  //   }
  // } catch (error) {
  //   console.error(error);
  // }
};
module.exports.tags = ["CyberneticOrganism", "Cy8029", "AvatarDNA"];
