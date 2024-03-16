VIRTUAL_ENV = ${ANSIBLE_VENV}

install:
	ansible-playbook --diff main.yml --ask-become-pass

push:
	git push origin master prod
