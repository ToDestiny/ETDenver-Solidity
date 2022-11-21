require('@nomiclabs/hardhat-waffle');
require('dotenv').config();

// const API_ALCHEMY

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    compilers: [
      {
        version: '0.7.6',
      },
      {
        version: '0.8.17',
      },
      {
        version: '0.8.0',
      },
    ],
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000,
      },
      // networks: {
      //   hardhat: {
      //     forking: { url: API_ALCHEMY },
      //   },
      // },
    },
  },
};
