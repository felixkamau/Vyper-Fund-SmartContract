#pragma version 0.4.0

owner: public(address)
total_funds: public(uint256)
balances: public(HashMap[address, uint256])
paused: public(bool)

@deploy
def __init__():
    self.owner = msg.sender 
    self.paused = False

@payable
@external
def deposit():
    assert not self.paused, "Contract is paused"
    assert msg.value > 0, "Must Deposit amount greater than 0"
    self.balances[msg.sender] += msg.value
    self.total_funds += msg.value

@external
def withdraw(amount: uint256):
    assert amount > 0, "Amount must be greater than zero"
    assert self.balances[msg.sender] >= amount, "Insufficient Balance"
    self.balances[msg.sender] -= amount
    self.total_funds -= amount
    # Transfer ether with `send`
    send(msg.sender, amount)

@external
def withdraw_all():
    self.onlyOwner()
    # Transfer all funds to the owner
    send(self.owner, self.total_funds)
    self.total_funds = 0

@internal
def onlyOwner():
    assert msg.sender == self.owner, "Not Authorized"

@external
def toggle_pause():
    self.onlyOwner()
    self.paused = not self.paused
