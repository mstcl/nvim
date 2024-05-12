# nvim

**My opinionated neovim configuration.**

## Features

- A really cool text editor that lives in your terminal.

## Get started

### Cloning

```sh
$ git clone -b master https://github.com/mstcl/nvim
$ cd nvim
```

### Configuration

```sh
$ git checkout -B prod
```

Read through what's available to configure in `host_vars/localhost.yml` and
edit it.

### Installing

When you're happy:

```sh
$ ansible-playbook main.yml
```

## Updating

```sh
$ git checkout master; git pull origin master; git checkout prod; git merge master
```

Work through conflicts if needed.

## Nvim python API

A python "venv" (virtual environment) is created with necessary packages in
`~/.venv/nvim`, especially if the python/notebook stack is detected. Source
this venv in projects that need it with
[direnv](https://github.com/direnv/direnv) or similar tools.

```bash
$ source ~/.venv/nvim/bin/activate
```

## Core keymap groups

- `<C-M>` - Toggle modules
- `<leader>` - Plugin/extra keymaps
- `g` - LSP lookups
- `c` - Code actions, formatting, rename
- `[` & `]`- Go to prev/next * (buffers, diagnostics, functions, conflicts, hunks)

`<C-P>` brings up the which-key cheatsheet.
