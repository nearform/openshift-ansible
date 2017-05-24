.PHONY: all vagrant-check up clean
	
.DELETE_ON_ERROR:

all: up

vagrant-check:
	@command -v vagrant >/dev/null 2>&1 || { echo >&2 "vagrant is not available please install it"; exit 1; }

up:
	vagrant up --provider virtualbox

clean:
	vagrant destroy --force
