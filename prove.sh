#!/bin/sh
cd $1

PROVER_NAME=$2
CIRCUIT_NAME=$3
WITNESS_NAME=$4
PROOF_NAME=$5

nargo execute -p $PROVER_NAME $WITNESS_NAME

JSON_FILE="./target/${CIRCUIT_NAME}.json"
WITNESS_FILE="./target/${WITNESS_NAME}.gz"
PROOF_FILE="./target/${PROOF_NAME}"


if [ "$6" == 0 ]; then
    bb prove -b $JSON_FILE -w $WITNESS_FILE -o $PROOF_FILE
else
    bb prove_ultra_honk -b $JSON_FILE -w $WITNESS_FILE -o $PROOF_FILE
fi