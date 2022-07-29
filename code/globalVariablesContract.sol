pragma solidity ^0.4.24;

contract GlobalVariables {
    string public lastCaller = "not set";

    function etherUnitTest() public pure returns (bool) {
        bool value = (1 ether == 1000 finney);
        return value;
    }

    function  timeUnits() public view returns (uint) {
        uint timeNow = now; //storing current time using now
        //returns block time in seconds since 1970
        if (timeNow == 1000 days) { // converting 1000 literal to days, using the suffix days
            return timeNow;
        }
    }
    function getBlockInfo()
        public
        view
        returns (
            uint256 number,
            bytes32 hash,
            address coinbase,
            uint256 difficulty
        )
    {
        number = block.number;
        hash = blockhash(number - 1);
        coinbase = block.coinbase;
        difficulty = block.difficulty;
    }

    function getMsgInfo()
        public
        view
        returns (
            bytes memory data,
            bytes4 sig,
            address sender
        )
    {
        data = msg.data;
        sig = msg.sig;
        sender = msg.sender;
    }
}
