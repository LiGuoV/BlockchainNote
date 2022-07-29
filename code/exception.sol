pragma solidity ^0.4.25;

contract ExceptionContract {
    string public  name = "Li";

    function revertBehavior(string memory _name) public returns (bool){
        name = _name;
        if (bytes(name).length==0){
            revert();
        }
        require(bytes(name).length>0,"the string length is 0");
        return true;
    }

}