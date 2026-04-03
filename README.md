# nvim

**My opinionated neovim configuration.**

## Customisation

I'm running my own custom:

- Dark/light colorscheme
- Statusline
- Statuscolumn
- Foldtext

In addition, there are also some nice commands:

- `:Toggle <xyz>` user command
- `:Mode <xyz>` user command
- `:Pack up(date)/del/add` user command to wrap around Neovim 0.12 `vim.pack`

## Dependencies

A lot of external tools are required for a complete experience.
We manage this with [mise](https://mise.jdx.dev/).
See the [configuration file for more](https://github.com/mstcl/dotfiles/blob/master/.config/mise/config.toml).

## Troubleshooting

### Issues with treesitter parsers after major version upgrades

Remove all parsers and recompile them:

```bash
rm -rf ~/.cache/nvim/treesitter
rm -rf ~/.local/share/nvim/site/queries
rm -rf ~/.local/share/nvim/site/parser
rm -rf ~/.local/share/nvim/site/parser-info
```
