var GLDToken = artifacts.require("GLDToken");

module.exports = function(deployer) {
  deployer.deploy(GLDToken, 1000n * (10n ** 18n));
};