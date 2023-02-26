const provider = new Web3.providers.HttpProvider("https://ropsten.infura.io/v3/your-project-id");
const web3 = new Web3(provider);
const contractAddress = "0x1234567890123456789012345678901234567890";
const contractAbi = [
  {
    "inputs": [],
    "name": "getLastOnTime",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "newTime",
        "type": "uint256"
      }
    ],
    "name": "setLastOnTime",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  }
];
const contract = new web3.eth.Contract(contractAbi, contractAddress);

async function getLastOnTime() {
  const lastOnTime = await contract.methods.getLastOnTime().call();
  const date = new Date(lastOnTime * 1000);
  document.getElementById("lastOnTime").innerText = date.toLocaleString();
}

async function setLastOnTime() {
  const newTime = Math.floor(Date.now() / 1000);
  await contract.methods.setLastOnTime(newTime).send({ from: web3.eth.defaultAccount });
  getLastOnTime();
}

window.addEventListener("load", async () => {
  await web3.eth.requestAccounts();
  getLastOnTime();
  document.getElementById("setLastOnTimeButton").addEventListener("click", setLastOnTime);
});
