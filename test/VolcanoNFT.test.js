const { expect } = require('chai');
const hre = require('hardhat');
const { ethers } = require('hardhat');
const { loadFixture } = require('@nomicfoundation/hardhat-network-helpers');

describe('VolcanoNFT Smart Contract', function () {
  async function deployTokenFixture() {
    const VolcanoNFT = await ethers.getContractFactory('VolcanoNFT');
    const [owner, addr1] = await ethers.getSigners();
    const volcanoNFT = await VolcanoNFT.deploy();
    await volcanoNFT.deployed();

    // Fixtures can return anything you consider useful for your tests
    return { VolcanoNFT, volcanoNFT, owner, addr1 };
  }

  it('Should check the minting function', async function () {
    const { volcanoNFT, owner, addr1 } = await loadFixture(deployTokenFixture);

    await volcanoNFT.mintVolcanoNFT(owner.address);
    await volcanoNFT.mintVolcanoNFT(addr1.address);
    expect(await volcanoNFT.balanceOf(owner.address)).to.equal('1');
    expect(await volcanoNFT.balanceOf(addr1.address)).to.equal('1');
  });

  it('Should check the transfer function', async function () {
    const { volcanoNFT, owner, addr1 } = await loadFixture(deployTokenFixture);

    console.log(owner.address);
    console.log(addr1.address);
    await volcanoNFT.mintVolcanoNFT(owner.address);
    await volcanoNFT['safeTransferFrom(address,address,uint256)'](
      owner.address,
      addr1.address,
      0
    );
    expect(await volcanoNFT.balanceOf(addr1)).to.equal('1');
  });
});
