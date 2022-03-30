//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Lottery {
    address payable[] public players;
    address public admin;
    string LotName;
    /*struct {

    }lottery;
    mapping(uint => lottery) a doua varianta pentru event*/

    function get() public view returns(string memory) {
        return LotName;
    }

    function set(string memory _LotName) public {
        LotName = _LotName;
    }

    //TODO: fara getter si setter

    constructor (string memory name)payable { //constructor fara payable
        admin = msg.sender;
        LotName = name;
        //automatically adds admin on deployment
        players.push(payable(admin));
    }
    
    modifier onlyOwner() {
        require(admin == msg.sender, "You are not the owner");
        _;
    }
    
    receive() external payable {
        //suma la care se intra in tombola
        require(msg.value == 0.1 ether , "Must send 0.1 ether amount");
        //seful nu participa la tombola tho
        require(msg.sender != admin);
        players.push(payable(msg.sender));
    }

    function getBalance() public view onlyOwner returns(uint){
        return address(this).balance;
    }
    
    function random() internal view returns(uint){
       return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
       //yup, there might be quite some troubles, but I have no other idea how to change it
    }
    
    function pickWinner() public onlyOwner {
        require(players.length >= 2 , "Nu avem participanti pentru tombola");
        address payable winner;
        address payable winner_2;
        uint index = random() % players.length;
        winner = players[index];
        winner.transfer( (getBalance() * 75) / 100); //primul castigator
        players[index] = players[players.length - 1];
        players.pop();
        winner_2 = players[random() % players.length];
        winner_2.transfer( (getBalance() * 20) / 100); //al doilea castigator
        payable(admin).transfer(getBalance(); //seful ia comisionul
        resetTombola(); 

        ///random counter
    }
    //resetare tombola
    function resetTombola() internal {
        players = new address payable[](0);
    }
}