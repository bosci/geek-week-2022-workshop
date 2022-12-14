# Geek Week 2022 Workshop

*Liability Waiver*

The Georgia Cyber Warfare Range is not liable for any damage or other harmful consequences by the use of (information in) this repositor. It is at your own risk if you undertake any action based on (the information of) this code base.

In this workshop, we will show you how to spot specific vulnerabilities in solidity code, and use open source tooling to automatically test exploits.


## Installation

### Foundry
https://github.com/foundry-rs/foundry

```
curl -L https://foundry.paradigm.xyz | bash
```

```
foundryup
```

### Myth
https://github.com/ConsenSys/mythril

### Solc
https://github.com/crytic/solc-select

## Contracts
- FuzzExample
    - Learn how to use fuzzing to detect basic bugs
- Reentrancy
    - Learn how to perform modifier based reentrancy attacks
- ReentrancyDao
    - Learn how to perform multi-step renentrancy
- Suicide
    - Learn how to use a symbolic execution engine to discover how to destroy a contract

# Commands
## clean, build, test
```
make dev
```

## install foundry deps for testing
```
make install 
```

## clean artifacts
```
make clean
```

## compile contract
```
make build
```

## run tests
```
make t
```

## start ganache
```
make g 
```

## deploy to ganache chain
```
make create
```

## run symbolic execution example
```
make myth 
```

## destroy Suicide contract
```
make deploy_suicide
```

## invoke arbitrary command on contract
```
make call 
```

