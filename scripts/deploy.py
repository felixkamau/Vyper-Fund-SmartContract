from ape import accounts, project
from datetime import datetime

def main(contract_name="fund"):
    """
    Deploys the specified contract and records its address with a timestamp.
    
    Args:
        contract_name (str): The name of the contract to deploy. Default is "fund".
    """
    try:
        # Load the developer account
        dev_account = accounts.load("metamask1")
        print(f"Deploying {contract_name}...")

        # Get the contract class from the project
        contract_class = getattr(project, contract_name)
        
        # Deploy the contract
        deployed_contract = dev_account.deploy(contract_class)
        contract_address = deployed_contract.address

        # Record deployment information
        current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        with open("deployed_contracts.txt", "a") as file:
            file.write(f"{current_time}: {contract_name} - Address: {contract_address} \n")
        
        print(f"{contract_name} deployed at {contract_address} and recorded with timestamp.")

    except Exception as e:
        print(f"An error occurred: {e}")

# Example RPC URLs for Sepolia testnet
# https://zksync-sepolia.drpc.org
# https://rpc.sepolia.org
