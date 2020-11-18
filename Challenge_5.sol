pragma solidity ^0.6.0;

contract Challenge_5{
    
    address payable sender;
    address payable reciever;
    uint256 internal paytime;
    
    modifier onlyReciever(){
        require(reciever == msg.sender || sender == msg.sender,"amount will withdraw by sender or provided reciever");
        _;
    }
   
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    function deposit(address payable _reciever, uint256 _timeDelayInMin) payable public {
        
        paytime = now + ( _timeDelayInMin * 1 minutes);
        
        require(_reciever!=address(0),"address should be valid");
        require(paytime > block.timestamp,"Given has been passed");
        sender = msg.sender;
        reciever = _reciever;
    }
    
     function withdraw() public payable onlyReciever {
         require(block.timestamp >= paytime,"Sorry! You have to wait for withdraw time");
        msg.sender.transfer(address(this).balance);
    }
    
}