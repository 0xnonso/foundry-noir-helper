# foundry-noir-helper
## install
install with [forge](https://github.com/foundry-rs/foundry):

```
forge install 0xnonso/foundry-noir-helper
```

## usage
```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {NoirHelper} from "foundry-noir-helper/NoirHelper.sol";

contract NoirExampleTest is Test {
    NoirHelper public noirHelper;

    function setUp() public {
        noirHelper = new NoirHelper();
    }

    function testGenerateProofWithVarInput() public {
        noirHelper.withInput("x", 1).withInput("y", 2);

        (bytes32[] memory publicInputs, bytes memory proof) = noirHelper.generateProof(2);
    }

    function testGenerateProofWithStructInput() public {
        noirHelper.withInput("x", 1).withStruct("struct").withStructInput("a", [1, 3]);

        (bytes32[] memory publicInputs, bytes memory proof) = noirHelper.generateProof(2);
    }

    function testGenerateProofWithArrInput() public {
        noirHelper.withInput("x", [2, 7, 6]).withInput("y", [1, 2, 3, 4, 5]);

        (bytes32[] memory publicInputs, bytes memory proof) = noirHelper.generateProof(2);
    }

    function testGenerateProofFromCircuitDir() public {
        noirHelper.withInput("x", 1).withInput("y", 2).withProjectPath("custom_file_path/");

        (bytes32[] memory publicInputs, bytes memory proof) = noirHelper.generateProof(2);
    }
}
```

## acknowledgements

- [nplate](https://github.com/exp-table/nplate)
- [foundry-noir](https://github.com/Maddiaa0/foundry-noir)

## Disclaimer

_These smart contracts are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of the user interface or the smart contracts. They have not been audited and as such there can be no assurance they will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk._