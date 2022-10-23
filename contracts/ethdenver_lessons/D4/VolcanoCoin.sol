// SPDX-License-Identifier: UNLICENSED 
pragma solidity ^0.8.0;

contract VolcanoCoin {
    uint256 public TOTAL_SUPPLY = 10000;
    address public owner;
    event eventTotalSupplyChanged(string, uint256);
    event eventTransfer(string, uint256);
    
    struct Payment {
        address user;
        uint amount;
    }

    mapping(address => uint) balances;
    mapping(address => Payment) public payments;

    constructor() {
        owner = msg.sender;
        balances[owner] = TOTAL_SUPPLY;
    }

    modifier onlyOwner {
        if (msg.sender == owner) {
            _;
        }
    }

    function increaseTotalSupply() public onlyOwner {
        TOTAL_SUPPLY += 1000;
        emit eventTotalSupplyChanged("New Total Supply = " , TOTAL_SUPPLY);
    }

    function getUserBalance(address user) public view returns(uint) {
        return balances[user];
    }

    function transfer(address user, uint _amount) public {
        require(balances[msg.sender] >= _amount, "Not enough balance to execute your transfer.");
        balances[msg.sender] -= _amount;
        balances[user] += _amount;
        emit eventTransfer("Amount transfered = ", _amount);
    }
}