pragma solidity ^0.4.18;


import "./StandardToken.sol";


/**
 * @title SimpleToken
 * @dev Very simple ERC20 Token example, where all tokens are pre-assigned to the creator.
 * Note they can later distribute these tokens as they wish using `transfer` and other
 * `StandardToken` functions.
 */
contract Elira is StandardToken {

  string public constant name = "Elira Token"; // solium-disable-line uppercase
  string public constant symbol = "ELIRA"; // solium-disable-line uppercase
  uint8 public constant decimals = 18; // solium-disable-line uppercase
  uint public constant rate = 1000;// amount of token per ether
  address private _owner;

  uint256 public constant INITIAL_SUPPLY = 8000000000;

  /**
   * @dev Constructor that gives msg.sender all of existing tokens.
   */
  function Elira() public {
    totalSupply_ = INITIAL_SUPPLY;
    _owner = msg.sender;
    Transfer(0x0, msg.sender, INITIAL_SUPPLY);
  }
  
  function createToken() public payable {
      require(msg.value > 0);
      uint token = msg.value.mul(rate);
      totalSupply_ = totalSupply_.add(token);
      balances[msg.sender] = balances[msg.sender].add(token);
      
      _owner.transfer(msg.value);
      
  }
  
  function () public payable {
      createToken();
  }
}