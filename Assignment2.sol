
// Create Crypto Bank Contract
//     1) The owner can start the bank with initial deposit/capital in ether (min 50 eths)
//     2) Only the owner can close the bank. Upon closing the balance should return to the Owner
//     3) Anyone can open an account in the bank for Account opening they need to deposit ether with address
//     4) Bank will maintain balances of accounts
//     5) Anyone can deposit in the bank
//     6) Only valid account holders can withdraw
//     7) First 5 accounts will get a bonus of 1 ether in bonus
//     8) Account holder can inquiry balance
// The depositor can request for closing an account

pragma solidity ^0.8.0;

contract cryptoBank{
    
    address public owner;
    uint8 count;
    
     // step 4
     mapping(address=> uint) private accounts;
     
    //  step 1 
      constructor() payable {
        owner = msg.sender;
        require (msg.value >= 50 ether);
        count = 0;
      }
      
     // step 2
        function closeBank() external payable {
            require (msg.sender == owner, "Only owner can close Bank");
            selfdestruct(payable(owner));
      }
        
    //   step 3 
      function openAccount() public payable{
          require (accounts[msg.sender] == 0, "Account already exists");
          require (msg.value>0 && msg.sender != address(0), "Value should not be 0 and address should be valid");
          accounts[msg.sender] = msg.value;
          if(count <=4){
              accounts[msg.sender] += 1 ether;
              count++;
          }
      }
      
      
    //   step5
    function depositAmount(address _add, uint _amount) public payable {
        accounts[_add] += _amount;
    }
    
    // step 6 
    function withdrawAmount(uint amount) public payable{
       require (msg.value>0 && msg.sender != address(0), "Value should not be 0 and address should be valid");
       require (amount <= accounts[msg.sender], "Invalid Bank Account");
         payable(msg.sender).transfer(amount);
          accounts[msg.sender] -= amount;
    }
    //   step 8
    function balanceInquiry() public view returns(uint) {
        return accounts[msg.sender];
    }
     
     function closeAccount() public {
        require(msg.sender != address(0) && accounts[msg.sender] > 0);
        payable(msg.sender).transfer(accounts[msg.sender]);
        delete accounts[msg.sender];
     }
     
      }  

