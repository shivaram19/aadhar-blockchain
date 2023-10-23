// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.7;

contract CryptoKids {
    // owner DAD 
    address owner;

    constructor(){
        owner = msg.sender;
    }
    // define Kid 
    struct Kid {
        address  payable walletAddress;
        string firstName;
        string lastName;
        uint releaseTime;
        uint amount;
        bool canWithdraw;
    }

    // add kid to contract 
    Kid[] public kids;
 
    modifier onlyOwner() {
        require( msg.sender == owner," only the owner can add the kids " );
        _;
    }

    function addKid( address payable walletAddress, string memory firstName, string memory lastName, uint releaseTime, uint amount, bool canWithdraw ) public onlyOwner {
        kids.push(Kid(
        walletAddress,
        firstName,
        lastName,
        releaseTime,
        amount,
        canWithdraw
        ));
    }


    function balanceOf() public view returns(uint) {
        return address (this).balance;
    }
    // deposit funds to contract , specifically to a kid's account 

    function deposit( address walletAddress ) payable public { 
        addToKidsBalance( walletAddress );
     }
    function addToKidsBalance( address walletAddress ) private {
        for( uint i=0; i < kids.length; i++ ){
            if( kids[i].walletAddress == walletAddress ){
                kids[i].amount = msg.value;
            }
        }
    }
    function getIndex( address walletAddress ) view private returns( uint ) {
        for( uint i = 0; i < kids.length ; i++ ){
            if( kids[i].walletAddress == walletAddress ){
                return i;
            }
        }
        return 9999;
    }
    function availableToWithdraw( address walletAddress ) public returns ( bool ) {
        uint i = getIndex( walletAddress );
        require( block.timestamp < kids[i].releaseTime, "you can't withdraw yet !" );
        if ( block.timestamp > kids[i].releaseTime ){
            kids[i].canWithdraw = true;
            return  true ;
        }
        else {
            return false;
            }
    }

    // kid checks if able to withdraw

    // if able to withdraw then withdraw the money 
    function withdraw( address payable walletAddress ) payable  public {
        uint i = getIndex( walletAddress );
        require( msg.sender == kids[i].walletAddress," you must be the kid to withdraw " );
        require( kids[i].canWithdraw = true," your time hasn't come yet " );
        kids[i].walletAddress.transfer( kids[i].amount );
    }

}