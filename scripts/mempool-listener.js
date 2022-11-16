const ethers = require('ethers');
const toUniswap = '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D';

async function main() {
  const customWsProvider = new ethers.providers.WebSocketProvider(
    'wss://eth-mainnet.g.alchemy.com/v2/B9CsoB57IVJUmspnzBmjCR7PzAhpssl1'
  );

  customWsProvider.on('pending', (tx) => {
    customWsProvider.getTransaction(tx).then(function (transaction) {
      if (tx.to == toUniswap) {
        console.log(transaction);
      }
    });
  });
}

main();
