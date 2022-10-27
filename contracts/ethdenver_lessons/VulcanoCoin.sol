import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.7.3/contracts/access/Ownable.sol";

// SPDX-License-Identifier: UNLICENSED 
pragma solidity ^0.8.0;

    /**
    *@title VulcanoCoin
    *@dev   Smart contract for the VulcanoCoin
    */

contract VolcanoCoin is Ownable {
    uint256 public TOTAL_SUPPLY = 10000;
    event eventTotalSupplyChanged(string, uint256);
    event eventTransfer(string, uint256);
    
    struct Payment {
        address to;
        uint amount;
    }

    mapping(address => uint) balances;
    mapping(address => Payment[]) payments;

    constructor() {
        balances[msg.sender] = TOTAL_SUPPLY;
    }

    /**
    *@dev Increase the total supply of tokens
    */
    function increaseTotalSupply() public onlyOwner {
        TOTAL_SUPPLY += 1000;
        emit eventTotalSupplyChanged("New Total Supply = " , TOTAL_SUPPLY);
    }

    function getUserBalance(address _user) public view returns(uint) {
        return balances[_user];
    }

    function getUserPayment(address _user) public view returns(Payment[] memory) {
        return payments[_user];
    }

    function recordPayment(address _sender, address _to, uint _amount) private {
        payments[_sender].push(Payment({to: _to, amount: _amount}));
    }

    /**
    *@dev Transfer token from one address to another
    */
    function transfer(address _to, uint _amount) public {
        require(balances[msg.sender] >= _amount, "Not enough balance to execute your transfer.");
        require(_amount > 0, "transfer amount must be greater than 0");
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        recordPayment(msg.sender, _to, _amount);
        emit eventTransfer("Amount transfered = ", _amount);
    }
}