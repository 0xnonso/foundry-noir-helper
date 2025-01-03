// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NoirHelper} from "../src/NoirHelper.sol";

contract NoirHelperTest is Test {
    NoirHelper noirHelper;

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
        (bytes32[] memory publicInputs,) = noirHelper.generateProof(1);
        assertEq(publicInputs[0], bytes32(uint(9)));
    }

    function test_NoirHelper1() public {
        bytes32[][] memory test = new bytes32[][](2);
        test[0] = new bytes32[](2);
        test[1] = new bytes32[](2);
        test[0][0] = bytes32(uint256(1));
        test[0][1] = bytes32(uint256(4));
        test[1][0] = bytes32(uint256(1));
        test[1][1] = bytes32(uint256(5));
        noirHelper.withInput("x", bytes32(uint256(67))).withInput("b", test).withInput("y", bytes32(uint256(79))).withStruct("test").withStructInput("a", test);
        (bytes32[] memory publicInputs,) = noirHelper.generateProof(1);
        assertEq(publicInputs[0], bytes32(uint(79)));
    }

    function test_NoirHelper2(uint128 x, uint128 y) public {
        bound(x, 1, type(uint128).max - 1);
        bound(y, 1, type(uint128).max - 1);
        vm.assume(x != y);
        bytes32[][] memory test = new bytes32[][](2);
        test[0] = new bytes32[](2);
        test[1] = new bytes32[](2);
        test[0][0] = bytes32(uint256(1));
        test[0][1] = bytes32(uint256(4));
        test[1][0] = bytes32(uint256(1));
        test[1][1] = bytes32(uint256(5));
        noirHelper.withInput("x", bytes32(uint256(x))).withInput("b", test).withInput("y", bytes32(uint256(y))).withStruct("test").withStructInput("a", test);
        (bytes32[] memory publicInputs,) = noirHelper.generateProof(1);
    }

}
