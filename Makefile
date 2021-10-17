.PHONY:

help:
	cat Makefile


basic:
	brew bundle install --file=brewfiles/basic/Brewfile

dot:
	ansible-playbook playbooks/dotfiles.yml -i "localhost," --tags=dotfiles -K
prezto:
	ansible-playbook playbooks/prezto.yml -i "localhost," --tags=prezto -K
ma:
	ansible-playbook playbooks/mackerel-agent.yml -i "localhost," -e @variables.yaml --tags=mackerel -K
