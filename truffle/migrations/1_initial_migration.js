// const Migrations = artifacts.require("Migrations");
const MARS_NFT = artifacts.require("MARS_NFT.sol");

module.exports = function (deployer) {
  // deployer.deploy(Migrations);
  deployer.deploy(MARS_NFT);
};
