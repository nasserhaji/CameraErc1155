pragma solidity ^0.8.0;

contract CameraControl {
address private cameraOwner;
string private name;
uint private lastOnTime;
event CameraOn(address indexed _cameraOwner, uint _time);
event CameraOff(address indexed _cameraOwner, uint _time);

constructor(address _cameraOwner, string memory _name) {
    cameraOwner = _cameraOwner;
    name = _name;
}

function setCameraOwner(address _newOwner) public {
    require(msg.sender == cameraOwner, "Only the camera owner can change the owner.");
    cameraOwner = _newOwner;
}

function getCameraOwner() public view returns (address) {
    return cameraOwner;
}

function getCameraName() public view returns (string memory) {
    return name;
}

function turnOn() public {
    require(msg.sender == cameraOwner, "Only the camera owner can turn on the camera.");
    lastOnTime = block.timestamp;
    emit CameraOn(cameraOwner, lastOnTime);
}

function turnOff() public {
    require(msg.sender == cameraOwner, "Only the camera owner can turn off the camera.");
    emit CameraOff(cameraOwner, block.timestamp);
}

function getLastOnTime() public view returns (uint) {
    return lastOnTime;
}
}
