const { expect } = require('chai');
const hre = require('hardhat');
const { ethers } = require('hardhat');
const { loadFixture } = require('@nomicfoundation/hardhat-network-helpers');

describe('Uniswap Smart Contract', function () {
  async function deployTokenFixture() {
    const UniSwap = await ethers.getContractFactory('SwapExamples');
    const [owner, addr1] = await ethers.getSigners();
    const uniSwap = await UniSwap.deploy(
      '0xE592427A0AEce92De3Edee1F18E0157C05861564'
    );
    await uniSwap.deployed();
    console.log('Before transfer...');
    console.log('-------------------------------------');
    const binanceAccount = await ethers.getImpersonatedSigner(
      '0xDFd5293D8e347dFe59E90eFd55b2956a1343963d'
    );
    const binanceBalance = await binanceAccount.getBalance();
    console.log('Binance balance :', binanceBalance);
    // get team 5 account balance

    // Fixtures can return anything you consider useful for your tests
    return { UniSwap, uniSwap, owner, addr1, binanceAccount };
  }

  it('Should check that a swap has been made', async function () {
    const { uniSwap, binanceAccount } = await loadFixture(deployTokenFixture);
    const amountIn = 100;
    const res = await uniSwap.swapExactInputSingle(amountIn);
    console.log(res);
    expect(res).to.Be();
  });
});
