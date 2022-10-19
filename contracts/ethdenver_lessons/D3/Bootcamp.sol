// SPDX-License-Identifier: None

pragma solidity 0.8.17;


contract BootcampContract {

    uint256 number;
    address public owner;
    address addr = 0x000000000000000000000000000000000000dEaD;

    constructor() {
        owner = msg.sender;
    }


    function store(uint256 num) public {
        number = num;
    }


    function retrieve() public view returns (uint256){
        return number;
    }

    function setDeployerAddress() external view returns (address) {
        if (msg.sender == owner)
            return addr;
        else
            return owner;
    }
}

contract CallerBootcampContract {
    BootcampContract bc;
    
    function storeAddress(address _bcaddr) external {
        bc = BootcampContract(_bcaddr);
    }

    function deployAddress() external view returns(address) {
        return bc.setDeployerAddress();
    }
}