.PHONY:

help:
	cat Makefile


ma:
	ansible-playbook playbooks/mackerel-agent.yml -i "localhost," -e @variables.yaml --tags=mackerel -K
