pragma solidity ^0.4.25;

contract MainContract {
    uint internal value;
    constructor (uint amout) public {
        value = amout;
    }
    function deposit (uint amount) public {
        value += amount;
    }
    function withdraw(uint amount) public {
        value -= amount;
    }
}