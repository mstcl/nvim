VIRTUAL_ENV = ${ANSIBLE_VENV}

install:
	source $(VIRTUAL_ENV)/bin/activate && \
		ansible-playbook --diff main.yml --ask-become-pass

update:
	source $(VIRTUAL_ENV)/bin/activate && \
		git fetch origin master:master && \
		git merge master

push:
	git push origin master prod
