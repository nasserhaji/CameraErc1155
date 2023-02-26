const abi = require('./<YOUR-ABI-FILE>.json');
const contractAddress = '<YOUR-CONTRACT-ADDRESS>';
const contract = new web3.eth.Contract(abi, contractAddress);
