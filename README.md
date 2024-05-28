# nvim

**My opinionated neovim configuration.**

## Features

A really cool text editor that lives in your terminal.

## Installing

```sh
$ git clone -b master https://github.com/mstcl/nvim
$ cd nvim
$ git checkout -B prod
```

Variables are in `host_vars/localhost.yml`.

```sh
# Run whole playbook
$ make install

# Pull upstream
$ make update

# Rerun without installing packages
$ make rerun
```

## Nvim python API

A python "venv" (virtual environment) is created with necessary packages in
`~/.venv/nvim`, especially if the python/notebook stack is detected. Source
this venv in projects that need it with
[direnv](https://github.com/direnv/direnv) or similar tools.

```bash
$ source ~/.venv/nvim/bin/activate
```

## Colorschemes

None come installed by default. I made [dmg](https://github.com/mstcl/dmg) and
[ivory](https://github.com/mstcl/ivory) with
[lush](https://github.com/rktjmp/lush.nvim) for my own usage so they are
compiled to Vimscript in `colors` with extensions enabled.

To build these colorschemes, navigate to `~/.config/nvim`, open up neovim and
run `:Shipwright`.

## Additional keymaps

- `<C-M>` - Toggle modules
- `<leader>` - Plugin, fuzzy picker keymaps
- `g` - LSP lookups
- `gs` - Surround
- `[` & `]`- Go to prev/next (buffers, diagnostics, functions, conflicts, hunks)
