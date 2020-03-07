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
        address payable owner;
        bool purchased;
    }

    event ProductCreated(
        uint id,
        string name,
        uint price,
        address payable owner,
        bool purchased
    );

    event ProductPurchased(
        uint id,
        string name,
        uint price,
        address payable owner,
        bool purchased
    );

    constructor() public
    {
        name = "Donnoh's Marketplace!";
    }

    function createProduct(string memory _name, uint _price) public
    {
        //require a name
        require(bytes(_name).length > 0);
        //require a valid price
        require(_price > 0);
        // increment productCount
        productCount++;
        // create the product
        products[productCount] = Product(productCount, _name, _price, msg.sender, false);
        // trigger an event
        emit ProductCreated(productCount, _name, _price, msg.sender, false);
    }

    function purchaseProduct(uint _id) public payable
    {
        // fetch product
        Product memory _product = products[_id];
        // fetch owner
        address payable _seller = _product.owner;
        // make sure the product has a valid id
        require(_product.id > 0 && _product.id <= productCount);
        // require that there is enough ether in the transaction
        require(msg.value >= _product.price);
        // require that the product has not been already purchased
        require(!_product.purchased);
        //require that the buyer is not the seller
        require(_seller != msg.sender);
        // transer the ownership to the buyer
        _product.owner = msg.sender;
        // mark as purchased
        _product.purchased = true;
        // update the product
        products[_id] = _product;
        // pay the seller by sending them ether
        payable(address(_seller)).transfer(msg.value);
        // trigger an event
        emit ProductPurchased(productCount, _product.name, _product.price, msg.sender, true);

    }
}

