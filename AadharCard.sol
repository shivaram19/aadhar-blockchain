// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserInformation {
    address public admin;
    
    struct UserInfo {
        uint aadharCard;
        string name;
        uint age;
        address walletAddress;
    }
    
    mapping(address => UserInfo) public users;
    
    constructor() {
        admin = msg.sender;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this operation");
        _;
    }
    
    function addUser(
        address _userAddress,
        uint _aadharCard,
        string memory _name,
        uint _age,
        address _walletAddress
    ) public onlyAdmin {
        UserInfo memory newUser = UserInfo(_aadharCard, _name, _age, _walletAddress);
        users[_userAddress] = newUser;
    }
    
    function viewUserInfo() public view returns (uint , string memory, uint, address) {
        UserInfo storage userInfo = users[msg.sender];
        require(userInfo.walletAddress == msg.sender, "You can only view your own information");
        return (userInfo.aadharCard, userInfo.name, userInfo.age, userInfo.walletAddress);
    }
}
