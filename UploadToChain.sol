// SPDX-License-Identifier: MIT

pragma solidity 0.8.12;

contract UploadToChain {

    // 存储数据的map
    mapping (string => string) infos;

    // utf-8字符串先转好编码 https://mothereff.in/utf-8
    // The _key can not be empty.       _key不能为空
    string KeyEmpty             =   "\x5F\x6B\x65\x79\xE4\xB8\x8D\xE8\x83\xBD\xE4\xB8\xBA\xE7\xA9\xBA";
    // The _value can not be empty.     _value不能为空
    string ValueEmpty           =   "\x5F\x76\x61\x6C\x75\x65\xE4\xB8\x8D\xE8\x83\xBD\xE4\xB8\xBA\xE7\xA9\xBA";
    // The _value corresponding to _key already exists.     _key对应的_value已经存在
    string ValueAlreadyExists   =   "\x5F\x6B\x65\x79\xE5\xAF\xB9\xE5\xBA\x94\xE7\x9A\x84\x5F\x76\x61\x6C\x75\x65\xE5\xB7\xB2\xE7\xBB\x8F\xE5\xAD\x98\xE5\x9C\xA8";
    // The _value corresponding to _key does not exist.     _key对应的_value不存在
    string ValueNotFound        =   "\x5F\x6B\x65\x79\xE5\xAF\xB9\xE5\xBA\x94\xE7\x9A\x84\x5F\x76\x61\x6C\x75\x65\xE4\xB8\x8D\xE5\xAD\x98\xE5\x9C\xA8";

    function setInfo(string calldata _key, string calldata _value) public{

        // 对于空值与重复键的处理
        require(bytes(_key).length != 0, KeyEmpty);
        require(bytes(_value).length != 0, ValueEmpty);
        require(bytes(infos[_key]).length == 0, ValueAlreadyExists);

        infos[_key] = _value;
    }

    function deleteInfo(string calldata _key) public {

        require(bytes(_key).length != 0, KeyEmpty);

        // 空值应使用delete
        delete infos[_key];
    }
    
    function updateInfo(string calldata _key, string calldata _value) public {

        require(bytes(_key).length != 0, KeyEmpty);
        require(bytes(_value).length != 0, ValueEmpty);
        require(bytes(infos[_key]).length != 0, ValueNotFound);
        
        // 重复键应使用update
        infos[_key] = _value;
    }

    function getInfo(string calldata _key) public view returns (string memory) {

        require(bytes(_key).length != 0, KeyEmpty);

        if (bytes(infos[_key]).length == 0) {
            return ValueNotFound;
        }

        return infos[_key];
    }
}
