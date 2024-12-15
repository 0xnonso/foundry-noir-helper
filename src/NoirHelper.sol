pragma solidity 0.8.25;

import { TestBase, Vm } from "forge-std/Base.sol";
import { console2 as console } from "forge-std/console2.sol";
import {LibString} from "solady/utils/LibString.sol";

contract NoirHelper is TestBase {
    using LibString for string;

    enum PlonkFlavour{BBDefault, UltraHonk}

    error RevertWithError(string);

    event FailedConstraintWithError();

    struct StructInputs{
        string name;
        string structValues;
    }

    struct StructOutputs {
        bytes32[] pubInputs;
        bytes proof;
    }

    struct CircuitInput {
        string values;
        StructInputs[] structInputs;
    }

    string constant INPUT_KEY = "input key";

    string public circuitProjectPath = "./circuits";

    CircuitInput public inputs;

    /// Adds an input.
    /// Can be chained.
    ///
    /// # Example
    ///
    /// ```
    /// withInput("x", 1).withInput("y", 2).withStruct("s").withStructInput("b", 4);
    ///
    /// Output toml file would look like so:
    ///
    /// x = 1
    /// y = 2
    ///
    /// [s]
    /// b = 4
    ///
    /// ```

    function withInput(string memory name, bytes32 value) public returns (NoirHelper) {
        inputs.values = vm.serializeBytes32(INPUT_KEY, name, value);
        return this;
    }

    function withInput(string memory name, bytes32[] memory values) public returns (NoirHelper) {
        inputs.values = vm.serializeBytes32(INPUT_KEY, name, values);
        return this;
    }

    function withInput(string memory name, bytes[][] memory values) public returns (NoirHelper) {
        inputs.values = vm.serializeJson(INPUT_KEY, getInputObject(inputs.values, name, values));
        return this;
    }

    function getInputObject(string memory inputValues, string memory name, bytes[][] memory values) 
        internal
        pure
        returns (string memory) 
    {
        string memory obj;
        for(uint256 i; i < values.length; i++){
            string memory value = "";
            for(uint256 j; j < values[i].length; j++){
                value = string.concat(value, '"', vm.toString(values[i][j]), '"');
                if(j < values[i].length - 1){
                    value = string.concat(value, ",");
                }
            }
            obj = string.concat(obj, "[", value, "]");
            if(i < values.length - 1){
                obj = string.concat(obj, ",");
            }
        }
        obj = string.concat("[", obj, "]");
        if(inputValues.eqs("")){
            obj = string.concat("{", '\"', name, '\"', ":", obj, "}");
        } else {
            obj = inputValues.replace("}", string.concat(',\"', name, '\"', ":", obj, "}"));
        }
        return obj;
    }

    function withInput(string memory name, uint256 value) public returns (NoirHelper) {
        inputs.values = vm.serializeUint(INPUT_KEY, name, value);
        return this;
    }

    function withInput(string memory name, uint256[] memory values) public returns (NoirHelper) {
        inputs.values = vm.serializeUint(INPUT_KEY, name, values);
        return this;
    }

    function withInput(string memory name, uint256[][] memory values) public returns (NoirHelper) {
        inputs.values = vm.serializeJson(INPUT_KEY, getInputObject(inputs.values, name, values));
        return this;
    }

    function getInputObject(string memory inputValues, string memory name, uint256[][] memory values) 
        internal
        pure
        returns (string memory) 
    {
        string memory obj;
        for(uint256 i; i < values.length; i++){
            string memory value = "";
            for(uint256 j; j < values[i].length; j++){
                value = string.concat(value, '"', vm.toString(values[i][j]), '"');
                if(j < values[i].length - 1){
                    value = string.concat(value, ",");
                }
            }
            obj = string.concat(obj, "[", value, "]");
            if(i < values.length - 1){
                obj = string.concat(obj, ",");
            }
        }
        obj = string.concat("[", obj, "]");
        if(inputValues.eqs("")){
            obj = string.concat("{", '\"', name, '\"', ":", obj, "}");
        } else {
            obj = inputValues.replace("}", string.concat(',\"', name, '\"', ":", obj, "}"));
        }
        return obj;
    }

    function withInput(string memory name, bool value) public returns (NoirHelper) {
        inputs.values = vm.serializeBool(INPUT_KEY, name, value);
        return this;
    }

    function withInput(string memory name, bool[] memory values) public returns (NoirHelper) {
        inputs.values = vm.serializeBool(INPUT_KEY, name, values);
        return this;
    }

    function withInput(string memory name, bytes memory value) public returns (NoirHelper) {
        inputs.values = vm.serializeBytes(INPUT_KEY, name, value);
        return this;
    }

    function withInput(string memory name, bytes[] memory values) public returns (NoirHelper) {
        inputs.values = vm.serializeBytes(INPUT_KEY, name, values);
        return this;
    }

    function withInput(string memory name, bytes32[][] memory values) public returns (NoirHelper) {
        inputs.values = vm.serializeJson(INPUT_KEY, getInputObject(inputs.values, name, values));
        return this;
    }

    function getInputObject(string memory inputValues, string memory name, bytes32[][] memory values) 
        internal
        pure
        returns (string memory) 
    {
        string memory obj;
        for(uint256 i; i < values.length; i++){
            string memory value = "";
            for(uint256 j; j < values[i].length; j++){
                value = string.concat(value, '"', vm.toString(values[i][j]), '"');
                if(j < values[i].length - 1){
                    value = string.concat(value, ",");
                }
            }
            obj = string.concat(obj, "[", value, "]");
            if(i < values.length - 1){
                obj = string.concat(obj, ",");
            }
        }
        obj = string.concat("[", obj, "]");
        if(inputValues.eqs("")){
            obj = string.concat("{", '\"', name, '\"', ":", obj, "}");
        } else {
            obj = inputValues.replace("}", string.concat(',\"', name, '\"', ":", obj, "}"));
        }
        return obj;
    }

    function withInput(string memory name, string memory value) public returns (NoirHelper) {
        inputs.values = vm.serializeString(INPUT_KEY, name, value);
        return this;
    }

    function withInput(string memory name, string[] memory values) public returns (NoirHelper) {
        inputs.values = vm.serializeString(INPUT_KEY, name, values);
        return this;
    }

    function withInput(string memory name, address value) public returns (NoirHelper) {
        inputs.values = vm.serializeAddress(INPUT_KEY, name, value);
        return this;
    }

    function withInput(string memory name, address[] memory values) public returns (NoirHelper) {
        inputs.values = vm.serializeAddress(INPUT_KEY, name, values);
        return this;
    }

    function withStruct(string memory name) public returns (NoirHelper) {
        StructInputs memory sInputs;
        sInputs.name = string.concat(".", name);
        inputs.structInputs.push(sInputs);
        inputs.values = vm.serializeBytes(INPUT_KEY, name, "{}");
        return this;
    }

    function withStructInput(string memory name, bytes32 value) public returns (NoirHelper) {
        uint256 lastIndex = inputs.structInputs.length - 1;
        inputs.structInputs[lastIndex].structValues = vm.serializeBytes32(string.concat(INPUT_KEY, vm.toString(lastIndex)), name, value);
        return this;
    }

    function withStructInput(string memory name, bytes32[] memory values) public returns (NoirHelper) {
        uint256 lastIndex = inputs.structInputs.length - 1;
        inputs.structInputs[lastIndex].structValues = vm.serializeBytes32(string.concat(INPUT_KEY, vm.toString(lastIndex)), name, values);
        return this;
    }

    function withStructInput(string memory name, bytes32[][] memory values) public returns (NoirHelper) {
        uint256 lastIndex = inputs.structInputs.length - 1;
        inputs.structInputs[lastIndex].structValues = vm.serializeJson(
            string.concat(INPUT_KEY, vm.toString(lastIndex)), 
            getInputObject(inputs.structInputs[lastIndex].structValues, name, values)
        );
        return this;
    }

    function withStructInput(string memory name, uint256 value) public returns (NoirHelper) {
        uint256 lastIndex = inputs.structInputs.length - 1;
        inputs.structInputs[lastIndex].structValues = vm.serializeUint(string.concat(INPUT_KEY, vm.toString(lastIndex)), name, value);
        return this;
    }

    function withStructInput(string memory name, uint256[] memory values) public returns (NoirHelper) {
        uint256 lastIndex = inputs.structInputs.length - 1;
        inputs.structInputs[lastIndex].structValues = vm.serializeUint(string.concat(INPUT_KEY, vm.toString(lastIndex)), name, values);
        return this;
    }

    function withStructInput(string memory name, uint256[][] memory values) public returns (NoirHelper) {
        uint256 lastIndex = inputs.structInputs.length - 1;
        inputs.structInputs[lastIndex].structValues = vm.serializeJson(
            string.concat(INPUT_KEY, vm.toString(lastIndex)), 
            getInputObject(inputs.structInputs[lastIndex].structValues, name, values)
        );
        return this;
    }

    function withStructInput(string memory name, bool value) public returns (NoirHelper) {
        uint256 lastIndex = inputs.structInputs.length - 1;
        inputs.structInputs[lastIndex].structValues = vm.serializeBool(string.concat(INPUT_KEY, vm.toString(lastIndex)), name, value);
        return this;
    }

    function withStructInput(string memory name, bool[] memory values) public returns (NoirHelper) {
        uint256 lastIndex = inputs.structInputs.length - 1;
        inputs.structInputs[lastIndex].structValues = vm.serializeBool(string.concat(INPUT_KEY, vm.toString(lastIndex)), name, values);
        return this;
    }

    function withStructInput(string memory name, bytes memory value) public returns (NoirHelper) {
        uint256 lastIndex = inputs.structInputs.length - 1;
        inputs.structInputs[lastIndex].structValues = vm.serializeBytes(string.concat(INPUT_KEY, vm.toString(lastIndex)), name, value);
        return this;
    }

    function withStructInput(string memory name, bytes[] memory values) public returns (NoirHelper) {
        uint256 lastIndex = inputs.structInputs.length - 1;
        inputs.structInputs[lastIndex].structValues = vm.serializeBytes(string.concat(INPUT_KEY, vm.toString(lastIndex)), name, values);
        return this;
    }

    function withStructInput(string memory name, bytes[][] memory values) public returns (NoirHelper) {
        uint256 lastIndex = inputs.structInputs.length - 1;
        inputs.structInputs[lastIndex].structValues = vm.serializeJson(
            string.concat(INPUT_KEY, vm.toString(lastIndex)), 
            getInputObject(inputs.structInputs[lastIndex].structValues, name, values)
        );
        return this;
    }

    function withStructInput(string memory name, string memory value) public returns (NoirHelper) {
        uint256 lastIndex = inputs.structInputs.length - 1;
        inputs.structInputs[lastIndex].structValues = vm.serializeString(string.concat(INPUT_KEY, vm.toString(lastIndex)), name, value);
        return this;
    }

    function withStructInput(string memory name, string[] memory values) public returns (NoirHelper) {
        uint256 lastIndex = inputs.structInputs.length - 1;
        inputs.structInputs[lastIndex].structValues = vm.serializeString(string.concat(INPUT_KEY, vm.toString(lastIndex)), name, values);
        return this;
    }

    function withStructInput(string memory name, address value) public returns (NoirHelper) {
        uint256 lastIndex = inputs.structInputs.length - 1;
        inputs.structInputs[lastIndex].structValues = vm.serializeAddress(string.concat(INPUT_KEY, vm.toString(lastIndex)), name, value);
        return this;
    }

    function withStructInput(string memory name, address[] memory values) public returns (NoirHelper) {
        uint256 lastIndex = inputs.structInputs.length - 1;
        inputs.structInputs[lastIndex].structValues = vm.serializeAddress(string.concat(INPUT_KEY, vm.toString(lastIndex)), name, values);
        return this;
    }

    function withProjectPath(string memory path) public returns (NoirHelper){
        circuitProjectPath = path;
        return this;
    }

    /// "Empty" the inputs array.
    ///
    /// # Example
    ///
    /// ```
    /// clean();
    /// ```
    function clean() public {
        delete inputs;
    }

    /// Read a proof + public inputs from a file located in {filePath}/target/proofs.
    /// Can read proof for either Ultraplonk or Ultrahonk
    ///
    /// # Example
    ///
    /// ```
    /// (bytes32[] memory pubInputs, bytes memory proof) = readProofFile(filePath, "my_proof");
    /// ```

    function readProofFile(string memory filePath, uint256 pubInputSize) 
        public
        view
        returns (bytes32[] memory, bytes memory) 
    {
        bytes memory proofData = vm.readFileBinary(filePath);
        return readProof(proofData, pubInputSize);
    }

    function readProof(bytes memory proofData, uint256 pubInputSize)
        public
        pure
        returns (bytes32[] memory, bytes memory)
    {
        uint256 _inputSize = pubInputSize * 0x20;
        bytes memory proof = new bytes(proofData.length - _inputSize);
        bytes32[] memory proofInputs = new bytes32[](pubInputSize);
        for(uint256 i = 0; i < pubInputSize; i++){
            assembly {
                let index := mul(0x20, i)
                mstore(
                    add(0x20, add(index, proofInputs)), 
                    mload(add(0x20, add(index, proofData)))
                )
            }
        }
        assembly {
            mcopy(
                add(proof, 0x20), 
                add(add(proofData, _inputSize), 0x20), 
                sub(mload(proofData), _inputSize)
            )
        }
        return (proofInputs, proof);
    }

    function readProofFileHonk(string memory filePath, uint256 pubInputSize) 
        public  
        view
        returns (bytes32[] memory, bytes memory) 
    {
        bytes memory proofData = vm.readFileBinary(filePath);
        return readProofHonk(proofData, pubInputSize);
    }

    /// Modified from https://github.com/AztecProtocol/aztec-packages/blob/master/barretenberg/sol/test/base/TestBase.sol#L56
    function readProofHonk(bytes memory proofData, uint256 pubInputSize)
        public
        pure
        returns(bytes32[] memory, bytes memory)
    {
        uint256 _inputSize = pubInputSize * 0x20;
        bytes memory proof = new bytes((proofData.length - _inputSize) - 4);
        bytes32[] memory publicInputs = new bytes32[](pubInputSize);
        for (uint256 i = 0; i < pubInputSize; i++) {
            assembly {
                let index := mul(0x20, i)
                mstore(
                    add(0x20, add(index, publicInputs)), 
                    mload(add(0x24, add(add(0x60, index), proofData)))
                )
            }
        }
        assembly {
            mstore(add(proof, 0x20), mload(add(proofData, 0x24)))
            mstore(add(proof, 0x40), mload(add(proofData, 0x44)))
            mstore(add(proof, 0x60), mload(add(proofData, 0x64)))
            mcopy(
                add(proof, 0x80), 
                add(0x84, add(proofData, _inputSize)),
                sub(mload(proofData), add(_inputSize, 0x84))
            )
        }

        return(publicInputs, proof);
    }

    /// Generates a proof based on inputs and returns it.
    ///
    /// # Arguments
    /// * `proverName`   - The name of the prover file to be created in circuits/.
    ///                    Also servers as the name of the proof to be generated in {filePath}/target/proofs.
    /// * `pubInputSize` - Number of the circuit public inputs.
    /// * `flavour`      - Barretenberg backend to use. i.e ultraplonk or honk.
    /// * `cleanup`      - To clean up generated files or not?
    ///
    /// # Example
    ///
    /// ```
    /// withInput("x", 1).withInput("y", 2).withInput("z", [1,2]);
    /// (byte32[] memory pubInputs, bytes memory proof) = generateProof(3);
    /// ```
    function _generateProof(
        string memory proverName,
        uint256 pubInputSize, 
        PlonkFlavour flavour, 
        bool cleanup
    ) 
        internal
        returns (bytes32[] memory, bytes memory) 
    {
        string memory prevProverTOML;
        // write prover file
        string memory proverTOML = string.concat(circuitProjectPath, "/", proverName, ".toml");
        if(vm.exists(proverTOML)){
            prevProverTOML = vm.readFile(proverTOML);
        }

        vm.writeFile(proverTOML, "");
        // write all inputs with their values
        vm.writeToml(inputs.values, proverTOML);
        vm.serializeJson(INPUT_KEY, "{}");
        for(uint256 i; i < inputs.structInputs.length; i++){
            vm.writeToml(
                inputs.structInputs[i].structValues, 
                proverTOML, 
                inputs.structInputs[i].name
            );
            vm.serializeJson(string.concat(INPUT_KEY, vm.toString(i)), "{}");
        }

        string memory witnessName = proverName;
        string memory proofName = string.concat(proverName, ".proof");
        if(proverName.eqs("Prover")){
            proofName = "proof";
            witnessName = string(vm.parseTomlString(vm.readFile(string.concat(circuitProjectPath, "/Nargo.toml")), ".package.name"));
        }

        clean();

        // generate proof
        string[] memory ffi_cmds = new string[](7);
        ffi_cmds[0] = "./prove.sh";
        ffi_cmds[1] = circuitProjectPath;
        ffi_cmds[2] = proverName;
        // prevent stack overflow
        ffi_cmds[3] = string(vm.parseTomlString(vm.readFile(string.concat(circuitProjectPath, "/Nargo.toml")), ".package.name"));
        ffi_cmds[4] = witnessName;
        ffi_cmds[5] = proofName;
        ffi_cmds[6] = vm.toString(uint8(flavour));

        Vm.FfiResult memory res = vm.tryFfi(ffi_cmds);
        
        if(res.exitCode == 1){
            if(string(res.stderr).contains("error: Failed constraint")){
                emit FailedConstraintWithError();
                bytes32[] memory emptyPubInputs = new bytes32[](0);
                return(emptyPubInputs, "");
            } else {
                revert RevertWithError(string(res.stderr));
            }
        }

        // read proof
        string memory proofLocation = string.concat(circuitProjectPath, "/target/", proofName);
        // prevent stack overflow
        StructOutputs memory out;

        if(flavour == PlonkFlavour.BBDefault){
            (out.pubInputs, out.proof) = readProofFile(proofLocation, pubInputSize);
        } else {
            (out.pubInputs, out.proof) = readProofFileHonk(proofLocation, pubInputSize);
        }

        if (cleanup) {
            // remove files
            if(proverName.eqs("Prover")){
                if(!prevProverTOML.eqs("")){
                    vm.writeFile(proverTOML, prevProverTOML);
                }
            } else {
                vm.removeFile(proverTOML);
            }
            vm.removeFile(proofLocation);
        }

        return (out.pubInputs, out.proof);
    }

    function generateProofAndClean(string memory proverName, uint256 pubInputSize) 
        public 
        returns (bytes32[] memory, bytes memory) 
    {
        return _generateProof(proverName, pubInputSize, PlonkFlavour.BBDefault, true);
    }

    function generateProofHonkAndClean(string memory proverName, uint256 pubInputSize) 
        public 
        returns (bytes32[] memory, bytes memory) 
    {
        return _generateProof(proverName, pubInputSize, PlonkFlavour.UltraHonk, true);
    }

    function generateProof(string memory proverName, uint256 pubInputSize) 
        public 
        returns (bytes32[] memory, bytes memory) 
    {
        return _generateProof(proverName, pubInputSize, PlonkFlavour.BBDefault, false);
    }

    function generateProofHonk(string memory proverName, uint256 pubInputSize) 
        public 
        returns (bytes32[] memory, bytes memory) 
    {
        return _generateProof(proverName, pubInputSize, PlonkFlavour.UltraHonk, false);
    }

    function generateProofAndClean(uint256 pubInputSize) 
        public 
        returns (bytes32[] memory, bytes memory) 
    {
        return _generateProof("Prover", pubInputSize, PlonkFlavour.BBDefault, true);
    }

    function generateProofHonkAndClean(uint256 pubInputSize) 
        public 
        returns (bytes32[] memory, bytes memory) 
    {
        return _generateProof("Prover", pubInputSize, PlonkFlavour.UltraHonk, true);
    }

    function generateProof(uint256 pubInputSize) 
        public 
        returns (bytes32[] memory, bytes memory)
    {
        return _generateProof("Prover", pubInputSize, PlonkFlavour.BBDefault, false);
    }

    function generateProofHonk(uint256 pubInputSize) 
        public 
        returns (bytes32[] memory, bytes memory) 
    {
        return _generateProof("Prover", pubInputSize, PlonkFlavour.UltraHonk, false);
    }

}