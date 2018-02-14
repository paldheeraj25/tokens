pragma solidity ^0.4.18;


import "./StandardToken.sol";


/**
 * @title SimpleToken
 * @dev Very simple ERC20 Token example, where all tokens are pre-assigned to the creator.
 * Note they can later distribute these tokens as they wish using `transfer` and other
 * `StandardToken` functions.
 */
contract Elira1 is StandardToken {

  string public constant name = "Elira Token"; // solium-disable-line uppercase
  string public constant symbol = "ELIRA"; // solium-disable-line uppercase
  uint8 public constant decimals = 18; // solium-disable-line uppercase
  uint public constant rate = 1000;// amount of token per ether
  uint public etherCap = 800000;//ether cap to raise
  
  address private _owner;

  uint256 public constant INITIAL_SUPPLY = 600000000;
  uint public bountyAllocation = 200000000;

  event Bounty(address _address, uint _value);
  
  /**
   * @dev Constructor that gives msg.sender all of existing tokens.
   */
  function Elira1() public {
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
  
  /**
   * @dev Transfer bouty tokens on signup
   * @param _value uint256 the amount of tokens to be transferred
   */
  function bounty(uint _value) public {
      require(_value == 5 || _value == 10);
      //check bounty funds
      require(bountyAllocation > _value);
      // add bounty count to thier account
      balances[msg.sender] = balances[msg.sender].add(_value);
      // substract bouty from bounty fund
      bountyAllocation = bountyAllocation.sub(_value);
      Bounty(msg.sender, _value);
  }
  

}