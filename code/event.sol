pragma solidity ^0.4.25;

contract EventContract {
    uint biddingEnds = now + 5 days;

    struct HighBidder {
        address bidder;
        string bidderName;
        uint bid;
    }

    HighBidder public highBidder;

    event NewHighBid (address indexed who, string name, uint howmuch);
    event BidFaild(address indexed who, string name, uint howmuch);

    modifier timed {
        if (now < biddingEnds) {
            _;
        } else {
            revert("throw an exception");
        }
    }

    constructor() public {
        highBidder.bid = 1 ether;
    }

    function bid(string memory bidderName) public payable timed {
        if (msg.value > highBidder.bid) {
            highBidder.bidder = msg.sender;
            highBidder.bidderName = bidderName;
            highBidder.bid = msg.value;

            emit NewHighBid(msg.sender, bidderName, msg.value);
        } else {
            emit BidFaild(msg.sender, bidderName, msg.value);
            revert("throw an exception");
        }
    }
}