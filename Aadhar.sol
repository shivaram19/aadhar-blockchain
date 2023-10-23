// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.7;

contract Aadhar{
    
    // add owner
    address owner ;
    constructor() {
        owner = msg.sender;
    }

    struct Holder {
        address walletAddress;
        string name ;
        uint age;
        uint aadharard;
        bool canSeeProfile;
    }
    // add aadhar holder 
    Holder[] public holders;
    
    modifier onlyOwner() {
        require( msg.sender == owner," only the owner can the holders " );
        _;
    }

    function addHolders( address walletAddress, string memory name, uint age, uint aadharCard, bool canSeeProfile ) public onlyOwner{
        holders.push(Holder(
            walletAddress,
            name,
            age,
            aadharCard,
            canSeeProfile
        ));
    }

    // only that user that can access information

}