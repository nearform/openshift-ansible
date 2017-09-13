.PHONY: all vagrant-check up clean update
	
.DELETE_ON_ERROR:
all: vagrant-check up

vagrant-check:
	@command -v vagrant >/dev/null 2>&1 || { echo >&2 "vagrant is not available please install it"; exit 1; }

up: vagrant-check update
	vagrant up --provider virtualbox

update: vagrant-check
	vagrant box update

clean: vagrant-check
	vagrant destroy --force
