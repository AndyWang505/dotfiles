return {
  "ibhagwan/fzf-lua",
  opts = {
    -- `files` already defaults to hidden = true; only grep needs the flag, and
    -- `--hidden` alone makes rg descend into .git
    grep = {
      rg_opts = "--hidden -g '!.git' --column --line-number --no-heading "
        .. "--color=always --smart-case --max-columns=4096 -e",
    },
  },
}
