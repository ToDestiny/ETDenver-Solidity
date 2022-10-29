const { expect } = require('chai');
const hre = require('hardhat');
const { ethers } = require('hardhat');

describe('VulcanoCoin Smart Contract', function () {
  it('Should check the initial total supply', async function () {
    const [owner] = await ethers.getSigners();
    const VulcanoCoin = await ethers.getContractFactory('VulcanoCoin');
    const vulcanoCoin = await VulcanoCoin.deploy();

    const ownerBalance = await vulcanoCoin.getUserBalance(owner.address);
    expect(await vulcanoCoin.getTotalSupply()).to.equal(ownerBalance);
  });
  it('Should increase the total supply by 1000', async function () {
    const [owner] = await ethers.getSigners();
    const VulcanoCoin = await ethers.getContractFactory('VulcanoCoin');
    const vulcanoCoin = await VulcanoCoin.deploy();

    await vulcanoCoin.increaseTotalSupply();
    expect(await vulcanoCoin.getTotalSupply()).to.equal(11000);
  });
});
