// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract BuyMeACoffee {
    //event to emit when a Memo is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    //Memo struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    //List of all memos received from freinds
    Memo[] memos;

    //address of contract deployer
    address payable owner;

    //Deploy logic
    constructor() {
        owner = payable(msg.sender);
    }

    /**
     * @dev buy a coffee for smart contract owner
     * @param _name name of the buyer
     * @param _message a nice message from the buyer
     */

    function buyCoffee(string memory _name, string memory _message)
        public
        payable
    {
        require(msg.value > 0, "Can't buy coffee with 0 ETH");

        // add the memo to storage
        memos.push(Memo(msg.sender, block.timestamp, _name, _message));

        //emit a log event when a new memo is created
        emit NewMemo(msg.sender, block.timestamp, _name, _message);
    }

    //to withdraw money
    /**
     * @dev send the entire balbance stored in this contract to the owner

    */
    function withdrawTips() public {
        address(this).balance;
        require(owner.send(address(this).balance));
    }

    /**
     * @dev retrieve all the memeos received stored on the blockchain

    */
    function getMemos() public view returns (Memo[] memory) {
        return memos;
    }
}
