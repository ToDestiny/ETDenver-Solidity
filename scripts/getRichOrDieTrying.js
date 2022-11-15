const { ethers } = require('hardhat');

// Get Vitalik account - address 0x220866B1A2219f40e72f5c628B65D54268cA3A9D
async function runBlockchain() {
  console.log('Before transfer...');
  console.log('-------------------------------------');
  const vitalikAccount = await ethers.getImpersonatedSigner(
    '0x220866B1A2219f40e72f5c628B65D54268cA3A9D'
  );
  const vitalikBalance = await vitalikAccount.getBalance();
  console.log('Vitalik balance :', vitalikBalance);
  // get team 5 account balance
  const team5Account = await ethers.getImpersonatedSigner(
    '0x8f4BA2C139A38Fb01A723236a2F19CB7B6a49eBd'
  );
  const team5AccountBalance = await team5Account.getBalance();
  console.log('team5 balance: ', team5AccountBalance);
  // transfer
  const transactionResponse = await vitalikAccount.sendTransaction({
    to: team5Account.address,
    value: ethers.utils.parseEther('289000'),
  });
  console.log('Transferring...');
  await transactionResponse.wait(1);
  console.log('------------------------------------');
  console.log('New balances after transfer...');
  const newVitalikBalance = await vitalikAccount.getBalance();
  const newTeam5Balance = await team5Account.getBalance();
  console.log('Vitalik new balance: ', newVitalikBalance);
  console.log('team5 new balance: ', newTeam5Balance);
}

runBlockchain()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
