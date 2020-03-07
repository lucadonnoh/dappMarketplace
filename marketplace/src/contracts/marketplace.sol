pragma solidity ^0.6.1;

contract Marketplace
{
    string public name;

    struct Product
    {
        uint id;
        string name;
        uint price;
        address owner;
        bool purchased;
    }

    constructor() public
    {
        name = "Donnoh's Marketplace";
    }
}

