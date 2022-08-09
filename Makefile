DEFAULT_BALANCE = 9000000000000000000
ALICE_ACCOUNT = 0x2deb08aaf965da17757838c910424c8fe70bb5c7e8fe1171c6b68aebb2cc548b
BOB_ACCOUNT = 0x2deb08aaf965da17757838c910424c8fe70bb5c7e8fe1171c6b68aebb2cc548c
DEPLOYER_ACCOUNT = 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
RPC = http://127.0.0.1:8545
PRIV_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
HARDFORK = london

SUICIDE_CONTRACT = 0xe7f1725e7734ce288f8367e1bb143e90bb3f0512

dev: clean build t
	echo "done building and running tests"
install:
	forge install foundry-rs/forge-std --no-commit
clean:
	forge clean
build:
	forge build 
t:
	forge test -vvvvv --initial-balance ${DEFAULT_BALANCE} --fork-url ${RPC}
g:
	ganache-cli --account "${ALICE_ACCOUNT},${DEFAULT_BALANCE}" --account "${BOB_ACCOUNT},${DEFAULT_BALANCE}" --account "${PRIV_KEY},${DEFAULT_BALANCE}"
create:
	forge create --legacy ${contract} --contracts src/${contract}.sol --private-key ${PRIV_KEY} --rpc-url ${RPC}
deploy_suicide:
	contract=Suicide make create
destroy:
	A=${SUICIDE_CONTRACT} F=init make call;
	A=${SUICIDE_CONTRACT} F=run make call;
call:
	ADDRESS=${A} FUNC=${F} make _invoke 
_invoke:
	cast call ${ADDRESS} "${FUNC}()" --rpc-url ${RPC}
myth:
	contract=Suicide make _myth
_myth:
	myth -v 5 analyze src/${contract}.sol