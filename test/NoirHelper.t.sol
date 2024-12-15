// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NoirHelper} from "../src/NoirHelper.sol";

contract NoirHelperTest is Test {
    NoirHelper public noirHelper;

    function setUp() public {
        noirHelper = new NoirHelper();
    }

    function test_NoirHelper() public {
        bytes32[][] memory test = new bytes32[][](2);
        test[0] = new bytes32[](2);
        test[1] = new bytes32[](2);
        test[0][0] = bytes32(uint256(1));
        test[0][1] = bytes32(uint256(4));
        test[1][0] = bytes32(uint256(1));
        test[1][1] = bytes32(uint256(5));
        noirHelper.withInput("x", 8).withInput("b", test).withInput("y", 9).withStruct("test").withStructInput("a", test);
        noirHelper.generateProof("test", 5);
    }

}
