# NeoBim

**lckdscl's opinionated configuration of Neovim.**

<a href="https://dotfyle.com/mstcl/neobim"><img src="https://dotfyle.com/mstcl/neobim/badges/plugins?style=flat-square" /></a>
<a href="https://dotfyle.com/mstcl/neobim"><img src="https://dotfyle.com/mstcl/neobim/badges/leaderkey?style=flat-square" /></a>
<a href="https://dotfyle.com/mstcl/neobim"><img src="https://dotfyle.com/mstcl/neobim/badges/plugin-manager?style=flat-square" /></a>

![preview](pics/preview.png)

## Plugin manager

Requires [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

## Configured language servers

-   Python (jedi)
-   Lua (luals)
-   Tex (texlab)
-   Vim (vimls)
-   Bash (bashls)
-   C/C++ (clangd)
-   CSS/SCSS/LESS (cssls)
-   Markdown (marksman)
-   Typst

## Other linters

-   prettierd
-   prettier
-   black
-   beautysh
-   bibclean
-   cbfmt
-   chktex
-   cppcheck
-   codespell
-   remark
-   vint
-   revive
-   proselint
-   mypy
-   pylint
-   shellcheck
-   stylua
-   latexindent
-   gitsigns

## Navigating

> How do I navigate? There are so many ways!

There are a few choices, they can be used alongside one another, with one or
two method that will typically allow you to get to a file or directory quickly.

Let's say I recently edited `~/.config/nvim/init.lua`, then the obvious way is
to just use the start page (`mini.starter`), depends on what is listed there, I
can get there by either doing `<CR>` or `i<CR>` or `in<CR>`. This is near
instant speed.

If this `init.lua` file hasn't been recently edited. I can choose one of the
following:

### Before entering the editor

Use an fzf alias that opens the selection in nvim and fuzzy search for
`init.lua` (I have this aliased to `fv`), probably will come up first. My fzf
configs for zsh is located at the [bimshell](https://git.bim.boats/bimshell)
repository.

Using zoxide here is redundant as nvim will move into the working directory of
the opened file. Regardless, zoxide is good if you want to remain in the
terminal to do other things after leaving nvim, for example, to use git or
lazygit. I typically zoxide into the directory anyway.

### After entering the editor

I often find myself opening nvim before I know what I want to edit (my fingers
are faster than my brain sometimes). If I did this not in the working
directory, the choices are (in order of priority):

1.  Use Frecency, which uses an algorithm to list you files you edit often. I
    could use it as is (mapped to `<leader>t`) and start typing, but tags are very powerful. I have my config, nvim, projects, etc. declared in `./lua/configs/view/telescope.lua` as tags to use the algorithm on those 'workspaces'. To find my files with the ranking algorithm in my `nvim` configuration directory, I would do `<leader>t` then type `:nvim:` and then the fuzzy search query.

2.  If Frecency fails, use the telescope zoxide integration to move into that directory first, then use the built-in picker `find_files` to fuzzy search. Don't do `:e relative/path/to/file` here because `find_files` does depth traversal already.

3.  If this file isn't in a directory recognized by zoxide, then just use `find_files` straight away if I'm in `~/`. The `fd` command used follows ignore rules from `~/.config/fd/ignore`, so only files belong to this will be searched, although it is hopefully liberal enough to find most things.

4.  Failing the above, result to tab complete with `:e /path/to/file`.

> What about oil.nvim and telescope file browser plugin?

They should only be used to do filesystem tasks like delete, rename, create
files in bulk, etc., they are much slower than `find_files`. Even to traverse
up, using `:e ../path/to/file` is quicker.

> There are no tree view plugins, why?

Admittedly they are useful to navigate an entire project, especially when I'm
in a subfolder and want to access its siblings' content. But if you're working
on a project, then it should be declared in the Frecency configs, so it would
be faster to use the algorithm with the additional project tag. To visualize
the directory though, toggle the nvim terminal with `<C-\>` and use `erdtree`,
`tree`, `eza`, or whatever.
