// call by running from /packages/hardhat % npx hardhat deploy --tags "CyberneticOranism"
// then push all to react-app with cyberneticOrganism % yarn deploy

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  await deploy("CyberneticOrganism", {
    from: deployer,
    log: true,
    waitConfirmations: 5,
  });

};
module.exports.tags = ["CyberneticOrganism"];
