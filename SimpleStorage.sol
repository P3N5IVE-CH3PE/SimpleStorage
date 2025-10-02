//SPDX-License-Identifier: MIT
pragma solidity 0.8.18; // Stating our version

contract SimpleStorage {
// Basic Types: boolean, uint, int, address, bytes
bool hasFavoriteNumber = true || false;

uint256 internal myfavoriteNumber; // Deafaults to 0 value.

// How would we know whose number it is? Below examples doesnt allow us to see
// uint256[] listOfFavoriteNumbers;
//But creating a struct does.
struct Person{
    uint256 favoriteNumber;
    string name;
}

Person[] public listOfPeople;

mapping(string => uint256) public nameToFavoriteNumber;

// Person public Satoshi = Person({favoriteNumber:21000000, name: "Satoshi"});

function store(uint256 _favoriteNumber) public {
    myfavoriteNumber = _favoriteNumber;
}

function retrieve() public view returns(uint256) {
    return myfavoriteNumber;
}

function addPerson(string memory _name, uint256 _favoriteNumber) public {
    listOfPeople.push( Person(_favoriteNumber, _name) );
    nameToFavoriteNumber[_name] = _favoriteNumber;
}

}



