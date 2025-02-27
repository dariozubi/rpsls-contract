// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract RPSLS {

    enum Move { Null, Rock, Paper, Scissors, Spock, Lizard }
    address payable public player1;
    address payable public player2;
    uint256 public stake;
    uint256 public timeout = 5 minutes;
    uint256 public lastActionTime;
    bytes32 public move1Hashed;
    Move public move2;

    constructor(address _player2, bytes32 _move1Hashed) payable {        
        stake = msg.value;
        player1 = payable(msg.sender);
        player2 = payable(_player2);
        move1Hashed = _move1Hashed;
        lastActionTime = block.timestamp;
    }

    function play(Move movePlayer2) public payable {
        require(msg.sender == player2, "You are not player 2");
        require(msg.value >= stake, "The stake value is higher than what you sent");
        require(move2 == Move.Null, "You already played");
        require(movePlayer2 != Move.Null, "You cannot do a Null move");

        move2 = movePlayer2;
        lastActionTime = block.timestamp;
    }

    function solve(Move move1, uint256 salt) public {
        require(msg.sender == player1, "You are not player 1"); 
        require(move1 != Move.Null, "You cannot do a Null move"); 
        require(move2 != Move.Null, "Player 2 hasn't played yet");
        require(keccak256(abi.encodePacked(move1,salt)) == move1Hashed, "The move or salt does not correspond to your commitment"); 
        
        if (win(move1, move2)){
            player1.transfer(2 * stake);
        }
        else if (win(move2,move1)){
            player2.transfer(2 * stake);
        }
        else {
            player1.transfer(stake);
            player2.transfer(stake);
        }
        stake = 0;
    }

    function win(Move movePlayer1, Move movePlayer2) public pure returns (bool w) {
        if (movePlayer1 == movePlayer2)
            return false; 
        else if (movePlayer1 == Move.Null)
            return false; 
        else if (uint(movePlayer1) % 2 == uint(movePlayer2) % 2) 
            return (movePlayer1 < movePlayer2);
        else
            return (movePlayer1 > movePlayer2);
    }

    function player1Timeout() public {
        require(move2 != Move.Null, "Player 2 hasn't made a move"); 
        require(block.timestamp > lastActionTime + timeout, "There's still some time"); 
        player2.transfer(2 * stake);
        stake = 0;
    }

    function player2Timeout() public {
        require(move2 == Move.Null, "Player 2 already made a move"); 
        require(block.timestamp > lastActionTime + timeout, "There's still some time"); 
        player1.transfer(stake);
        stake = 0;
    }

}