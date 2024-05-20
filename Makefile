VIRTUAL_ENV = ${ANSIBLE_VENV}
.DEFAULT_GOAL := rerun
.PHONY = install update push rerun

rerun:
	source $(VIRTUAL_ENV)/bin/activate && \
		ansible-playbook --diff main.yml --skip-tags=packages,plugins

install:
	source $(VIRTUAL_ENV)/bin/activate && \
		ansible-playbook --diff main.yml --ask-become-pass

update:
	source $(VIRTUAL_ENV)/bin/activate && \
		git fetch origin master:master && \
		git merge master

push:
	git push origin master prod
