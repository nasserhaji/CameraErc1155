from web3 import Web3
from solcx import compile_source

# Ethereum network information
rpc_url = "https://mainnet.infura.io/v3/your-project-id"
web3 = Web3 (Web3.HTTPProvider(rpc_url))

# Smart contract address
contract_address = "0x123..."

# The private key of the wallet
private_key = "Your private key"

# Compile the smart contract
contract_source = """
Pragma Strength ^0.8.0;

SmartContract {
      // Declaration of functions and smart contracts
}

"""
compiled_sol = compile_source (contract_source)
contract_interface = compiled_sol["<stdin>:SmartContract"]

# Create an object from the smart contract
contract = web3.eth.contract(address=contract_address, abi=contract_interface["abi"])

# Create a transaction
tx = contract.functions.turnOn().buildTransaction({
      "from": web3.eth.accounts[0],
      "Gas": 2000000,
      "gasPrice": web3.toWei("50", "gwei")
})

# Transaction signature
signed_tx = web3.eth.account.signTransaction(tx, private_key=private_key)

# Send the transaction to the network
tx_hash = web3.eth.sendRawTransaction(signed_tx.rawTransaction)
