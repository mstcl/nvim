# nvim

**My opinionated neovim configuration.**

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
