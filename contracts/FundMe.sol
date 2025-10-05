// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.30;
import {PriceConverter} from "./PriceConverter.sol";

// Allow users to send $
// Have a minimum $ sent
// Withdraw funds sent
// Set a minimum of funds being sent in USD

contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 5e18; // or 5 * 1e18 // or 5 * (10 ** 18)

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

// 1. How do we send ETH to this contract?
    function fund() public payable {
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough ETH"); // 1e-5 = 0.00001 ETH = 0.00001
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;

    }
     function withdraw() public onlyOwner {
        
        // for loop
        //[1,2,3,4] elements
        // 0,1,2,3  indexes
        //for(/* starting index, ending index, step amount */){
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);

        // Withdraw the funds

           // transfer
          // msg.sender = address
         //  payable(msg.sender) = payable address
        // payable(msg.sender).transfer(address(this).balance);
         
        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed!"); 

       // call
       (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
       require(callSuccess, "Call failed!");
      

        }

        modifier onlyOwner() {
            require(msg.sender == owner, "Sender is not owner!");
            _;
        }
     
     receive() external payable {
        fund();
     }

     fallback() external payable {
        fund();
     }
     
     
     }
