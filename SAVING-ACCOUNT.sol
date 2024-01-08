// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract SavingsAccount {
    address public owner;
    mapping(address => uint256) public balances;

    event Deposit(address indexed depositor, uint256 amount);
    event Withdrawal(address indexed withdrawer, uint256 amount);

    constructor() {
        owner =msg.sender;
    }

    function deposit() external payable{
        require(msg.value > 0,"Must deposit a non-zero amount");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) external {
        require(_amount > 0, "Withdrawal amount must be greater than zero");
        require(_amount <= balances[msg.sender], "Insufficient funds");

        balances[msg.sender] -= _amount;

        payable(msg.sender).transfer(_amount);
        emit Withdrawal(msg.sender, _amount);
    }

    receive()  external payable {
        //Fallback function to recieve Ether deposit();
    }
}