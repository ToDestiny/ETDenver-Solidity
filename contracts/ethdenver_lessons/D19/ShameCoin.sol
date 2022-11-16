// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ShameCoin is ERC20, ERC20Burnable, Ownable {
    address public admin;
    mapping(address => uint) public balances;

    modifier onlyAdmins() {
        require(msg.sender == admin, "Only admins");
        _;
    }

    constructor() ERC20("ShameCoin", "SHC") {
        admin = msg.sender;
    }

    function getUserBalance(address _user) public view returns(uint) {
        return balances[_user];
    }

    function transferShameCoin(address to) public {
        if(admin == msg.sender) {
            balances[to] += 1;
        } else {
            if (approve(admin, 1)) {
                balances[msg.sender] -= 1;
            }
            else balances[msg.sender] += 1;
        }
    }
}