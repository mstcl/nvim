# nvim

**My opinionated neovim configuration.**

## Features

- A really cool text editor that lives in your terminal.

### Core keymap groups

- `<C-M>` - Toggle window UI components
- `<leader>` - Plugin related keymaps (e.g. FzfLua pickers)
- `g` - LSP lookups
- `c` - Code actions, formatting, rename

`<C-P>` brings up the which-key cheatsheet.

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
