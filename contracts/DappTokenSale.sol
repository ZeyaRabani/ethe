pragma solidity ^0.5.16;
import "./DappToken.sol";

contract DappTokenSale {

    //address admin;
    address payable admin;
    DappToken public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;

    event Sell(address _buyer, uint256 _amount);
    event EndSale(uint256 _totalAmountSold);

    constructor(DappToken _tokenContract, uint256 _tokenPrice) public {
        admin = msg.sender;
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }
    function multiply(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }

    function buyTokens(uint256 _numberOfTokens) public payable {
        // require(msg.value == multiply(_numberOfTokens, tokenPrice));
        // require(tokenContract.balanceOf(address(this)) >= _numberOfTokens);
        // require(tokenContract.transfer(msg.sender, _numberOfTokens));
                require(msg.value == multiply(_numberOfTokens, tokenPrice), 'msg.value must equal number of tokens in wei');
        require(tokenContract.balanceOf(address(this)) >= _numberOfTokens, 'cannot purchase more tokens than available');
        require(tokenContract.transfer(msg.sender, _numberOfTokens), 'Unable to send tokens');

        tokensSold += _numberOfTokens;

        emit Sell(msg.sender, _numberOfTokens);

    }

    function endSale() public {
        require(msg.sender == admin);
        require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));
         admin.transfer(address(this).balance);
         emit EndSale(tokensSold);
        // require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));
        //require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));
        //admin = address payable admin;
      //  selfdestruct(admin);
       // selfdestruct(admin);
       //selfdestruct(address(uint256(admin)));
       //address payable adminAddress = address(uint160(admin));
        //selfdestruct(adminAddress);
    }
}

