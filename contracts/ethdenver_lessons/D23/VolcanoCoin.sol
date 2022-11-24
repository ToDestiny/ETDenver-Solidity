// SPDX-License-Identifier: UNLICENSED 
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "github.com/Arachnid/solidity-stringutils/src/strings.sol";
import "hardhat/console.sol";

    /**
    *@title VulcanoCoin
    *@dev   Smart contract for the VulcanoCoin
    */

contract VulcanoCoin is Ownable, Pausable {
	using strings for *;
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
			owner() == msg.sender;
      balances[msg.sender] = TOTAL_SUPPLY;
    }

    /**
    *@dev Increase the total supply of tokens
    */
    function increaseTotalSupply() public onlyOwner {
			require(owner() == msg.sender, "Ownable: caller is not the owner");
        TOTAL_SUPPLY += 1000;
        emit eventTotalSupplyChanged("New Total Supply = " , TOTAL_SUPPLY);
    }

    function getTotalSupply() public view returns(uint) {
        return TOTAL_SUPPLY;
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

	function manipulateString(string memory _input) public returns(string memory) {
		require(_input, "It shouldnt be null!");
		string memory _input2 = " from ETH Denver.";
		string memory ret = _input.toSlice().concat(_input2.toSlice());
		return ret;
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