// SPDX-License-Identifier: UNLICENSED
// pragma solidity >=0.5.0 <0.6.0;
pragma solidity ^0.8.19;

contract ZombieFactory {
    // events are a way for the contract to communicate that something happened on the blockchain to your front end
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies; // public dynamic array

    function _createZombie(string memory _name, uint _dna) private {
        // array.push() adds something to the end of the array(ordered)
        zombies.push(Zombie(_name, _dna));
        uint id = zombies.length - 1;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(
        string memory _str
    ) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
