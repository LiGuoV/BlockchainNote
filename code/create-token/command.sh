# 参考
# https://docs.openzeppelin.com/contracts/4.x/erc20#api:presets.adoc#ERC20PresetMinterPauser
# https://wizard.openzeppelin.com/

npm install -g truffle
truffle init
npm install --save truffle-hdwallet-provider
npm install --save  openzeppelin-solidity
truffle develop
$ truffle(develop)> compile
$ truffle(develop)> migrate --reset --network rinkeby