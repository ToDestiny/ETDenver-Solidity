const { expect } = require('chai');
const hre = require('hardhat');
const { ethers } = require('hardhat');
const { loadFixture } = require('@nomicfoundation/hardhat-network-helpers');

describe('VulcanoCoin Smart Contract', function () {
  async function deployTokenFixture() {
    const VulcanoCoin = await ethers.getContractFactory('VulcanoCoin');
    const [owner, addr1] = await ethers.getSigners();
    const vulcanoCoin = await VulcanoCoin.deploy();
    await vulcanoCoin.deployed();

    // Fixtures can return anything you consider useful for your tests
    return { VulcanoCoin, vulcanoCoin, owner, addr1 };
  }

  it('Should check the initial total supply', async function () {
    const { vulcanoCoin, owner } = await loadFixture(deployTokenFixture);

    const ownerBalance = await vulcanoCoin.getUserBalance(owner.address);
    expect(await vulcanoCoin.getTotalSupply()).to.equal(ownerBalance);
  });
  it('Should increase the total supply by 1000', async function () {
    const { vulcanoCoin } = await loadFixture(deployTokenFixture);

    await vulcanoCoin.increaseTotalSupply();
    expect(await vulcanoCoin.getTotalSupply()).to.equal(11000);
  });
  it('Should be reverted because not the Owner', async function () {
    const { vulcanoCoin, addr1 } = await loadFixture(deployTokenFixture);

    await expect(
      vulcanoCoin.connect(addr1).increaseTotalSupply()
    ).to.be.revertedWith('Ownable: caller is not the owner');
  });
});
