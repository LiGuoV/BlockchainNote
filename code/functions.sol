pragma solidity ^0.4.24;

contract FunctionsConstract {
    string name;
    uint8 age;

    constructor (string memory _name, uint8 _age) public {
        name = _name;
        age = _age;
    }

    function setInfo(string memory _name, uint8 _age) public {
        name = _name;
        age = _age;
    }

    function secretFunction() private pure {

    }

    function getInfo() public view returns (string memory _name, uint8 _age){
        _name = name;
        _age = age;
    }

    function getName() public view returns (string memory _name){
        return name;
    }
}