// call by running from /packages/hardhat % npx hardhat deploy --tags "Weapon"
// then push all to react-app with cyberneticOrganism % yarn deploy

const { ethers } = require("hardhat");

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  const cyborg = await ethers.getContract("CyberneticOrganism", deployer);

  await deploy("Weapon", {
    from: deployer,
    log: true,
    waitConfirmations: 5,
    args: [cyborg.address]
  });

};
module.exports.tags = ["Weapon"];
