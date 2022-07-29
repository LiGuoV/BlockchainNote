pragma solidity ^0.4.24;

import "./main.sol";

interface ContractInterface {
    function sendMoney(uint amount, address _address) external returns (bool);
}

contract BaseContract {
    uint public value;
    constructor (uint amount) public {
        value = amount;
    }
    function deposit(uint amount) public {
        value += amount;
    }

    function withdraw(uint amount) public {
        value -= amount;
    }
}

contract InheritanceContract is BaseContract(100), ContractInterface, MainContract(200) {
    string public name;
    constructor (string memory _n) public {
        name = _n;
    }
    function getValue() public view returns (uint){
        return value;
    }

    function _make_payable(address x) internal pure returns (address){
        return address(uint160(x));
    }

    function sendMoney(uint amount, address _address) public returns (bool) {
        return _make_payable(_address).transfer(amount);
    }
}

