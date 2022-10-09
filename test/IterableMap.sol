// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/IterableMap.sol";

contract TestIterableMap is Test {
    using IterableMapping for IterableMapping.Map;

    IterableMapping.Map private map;

    function testGetandSet() public {
        map.set(address(0), 0);
        map.set(address(1), 100);

        assertEq(map.get(address(0)), 0);
        assertEq(map.get(address(1)), 100);
    }

    function testSize() public {
        map.set(address(0), 0);
        map.set(address(1), 100);
        assertEq(map.size(), 2);
    }

    function testRemove() public {
        map.set(address(0), 0);
        map.set(address(1), 100);
        map.set(address(2), 200);
        map.set(address(3), 300);

        map.remove(address(1));

        assertEq(map.size(), 3);
        assertEq(map.getKeyAtIndex(0), address(0));
        assertEq(map.getKeyAtIndex(1), address(3));
        assertEq(map.getKeyAtIndex(2), address(2));
    }

    function testIterableMap() public {
        map.set(address(0), 0);
        map.set(address(1), 100);
        map.set(address(2), 200); // insert
        map.set(address(2), 200); // update
        map.set(address(3), 300);

        for (uint i = 0; i < map.size(); i++) {
            address key = map.getKeyAtIndex(i);

            assertEq(map.get(key), i * 100);
        }

        map.remove(address(1));

        // keys = [address(0), address(3), address(2)]
        assertEq(map.size(), 3);
        assertEq(map.getKeyAtIndex(0), address(0));
        assertEq(map.getKeyAtIndex(1), address(3));
        assertEq(map.getKeyAtIndex(2), address(2));
    }
}
