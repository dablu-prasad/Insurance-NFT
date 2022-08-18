/** @type import('hardhat/config').HardhatUserConfig */
require("@nomiclabs/hardhat-ganache");

module.exports = {
  solidity: {
    compilers: [
      {
        version: '0.8.9',
        settings: {
          optimizer: {
            enabled: true,
            runs: 1000,
          },
        }
      },
    ]
  },
  defaultNetwork: "ganache",
  networks: {
    ganache: {
      url: `HTTP://localhost`,
      gasLimit: 6000000000,
      defaultBalanceEther: 10,
    },
  },
};
