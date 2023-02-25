// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Receiver.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SmartContract is ERC1155, ERC1155Receiver, Ownable {
    string private _cameraName;
    uint256 private _lastOnTime;
    uint256 private _lastOffTime;

    constructor(address _cameraOwner, string memory _name) ERC1155("") {
        transferOwnership(_cameraOwner);
        _cameraName = _name;
    }

    function setCameraOwner(address _newOwner) public onlyOwner {
        transferOwnership(_newOwner);
    }

    function getCameraOwner() public view returns (address) {
        return owner();
    }

    function getCameraName() public view returns (string memory) {
        return _cameraName;
    }

    function turnOn() public onlyOwner {
        _lastOnTime = block.timestamp;
    }

    function turnOff() public onlyOwner {
        _lastOffTime = block.timestamp;
    }

    function getLastOnTime() public view returns (uint256) {
        return _lastOnTime;
    }

    function getLastOffTime() public view returns (uint256) {
        return _lastOffTime;
    }

    function getTokenURI(uint256 tokenId) public view override returns (string memory) {
        return "";
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual override(ERC1155, ERC1155Receiver) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _onTokenTransfer(address operator, address from, uint256 id, uint256 value, bytes calldata data) internal virtual override(ERC1155Receiver) {
        super._onTokenTransfer(operator, from, id, value, data);
    }

    function _onTokenBatchTransfer(address operator, address from, uint256[] memory ids, uint256[] memory values, bytes memory data) internal virtual override(ERC1155Receiver) {
        super._onTokenBatchTransfer(operator, from, ids, values, data);
    }

    function withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    receive() external payable {}
}
