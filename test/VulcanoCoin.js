const { expect } = require('chai');
const hre = require('hardhat');
const { ethers } = require('hardhat');
const { loadFixture } = require('@nomicfoundation/hardhat-network-helpers');

describe('VulcanoCoin Smart Contract', function () {
  async function deployTokenFixture() {
    const VulcanoCoin = await ethers.getContractFactory('VulcanoCoin');
    const [owner] = await ethers.getSigners();
    const vulcanoCoin = await VulcanoCoin.deploy();
    await vulcanoCoin.deployed();

    // Fixtures can return anything you consider useful for your tests
    return { VulcanoCoin, vulcanoCoin, owner };
  }

  it('Should check the initial total supply', async function () {
    const { vulcanoCoin, owner } = await loadFixture(deployTokenFixture);

    const ownerBalance = await vulcanoCoin.getUserBalance(owner.address);
    expect(await vulcanoCoin.getTotalSupply()).to.equal(ownerBalance);
  });
  it('Should increase the total supply by 1000', async function () {
    const { vulcanoCoin, owner } = await loadFixture(deployTokenFixture);

    await vulcanoCoin.increaseTotalSupply();
    expect(await vulcanoCoin.getTotalSupply()).to.equal(11000);
  });
});
