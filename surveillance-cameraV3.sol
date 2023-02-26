// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract CameraControl {
    address public cameraOwner;
    string public cameraName;
    uint public lastOnTime;
    uint public turnOnCount;
    uint public turnOffCount;

    event CameraTurnedOn(uint timestamp);
    event CameraTurnedOff(uint timestamp);

    constructor(address _cameraOwner, string memory _name) {
        cameraOwner = _cameraOwner;
        cameraName = _name;
    }

    function setCameraOwner(address _newOwner) public {
        require(msg.sender == cameraOwner, "Only camera owner can change the camera owner.");
        cameraOwner = _newOwner;
    }

    function getCameraOwner() public view returns (address) {
        return cameraOwner;
    }

    function getCameraName() public view returns (string memory) {
        return cameraName;
    }

    function turnOn() public {
        require(msg.sender == cameraOwner, "Only camera owner can turn on the camera.");
        require(turnOnCount == turnOffCount, "Cannot turn on the camera as it is already on.");
        lastOnTime = block.timestamp;
        turnOnCount++;
        emit CameraTurnedOn(lastOnTime);
    }

    function turnOff() public {
        require(msg.sender == cameraOwner, "Only camera owner can turn off the camera.");
        require(turnOnCount > turnOffCount, "Cannot turn off the camera as it is already off.");
        turnOffCount++;
        emit CameraTurnedOff(block.timestamp);
    }

    function getLastOnTime() public view returns (uint) {
        require(turnOnCount > turnOffCount, "Camera is currently off.");
        return lastOnTime;
    }
}
