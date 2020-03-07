pragma solidity ^0.6.1;

contract Marketplace
{
    string public name;
    uint public productCount = 0;
    mapping(uint => Product) public products;

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

    function createProduct(string memory _name, uint _price) public
    {
        //make sure params are correct
        // create the product
        // increment productCount
        productCount++;
        // trigger an event
    }
}

