const Web3 = require('web3');
const web3 = new Web3('https://ropsten.infura.io/v3/<YOUR-PROJECT-ID>');

// Connect to an account
const account = web3.eth.accounts.privateKeyToAccount('<YOUR-PRIVATE-KEY>');
web3.eth.accounts.wallet.add(account);
web3.eth.defaultAccount = account.address;
