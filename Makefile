.PHONY:

help:
	cat Makefile


prezto:
	ansible-playbook playbooks/prezto.yml -i "localhost," --tags=prezto -K
ma:
	ansible-playbook playbooks/mackerel-agent.yml -i "localhost," -e @variables.yaml --tags=mackerel -K
