´´´
.
├── README.md
├── after
│   ├── README.md
│   └── ftplugin
│       ├── README.md
│       ├── go.lua
│       ├── lua.lua
│       └── markdown.lua
├── ideas.md
├── init.lua
├── lazy-lock.json
├── lua
│   └── config
│       ├── lazy.lua
│       ├── plugins
│       │   ├── completion.lua
│       │   ├── dbee.lua
│       │   ├── harpoon.lua
│       │   ├── lsp.lua
│       │   ├── markdown.lua
│       │   ├── mini.lua
│       │   ├── oil.lua
│       │   ├── telescope.lua
│       │   └── treesitter.lua
│       └── telescope
│           ├── README.md
│           └── multigrep.lua
└── plugin
    └── floaterminal.lua
´´´

- To install an use most of the features of nvim one may be better off downloading and installing nightly version by building from (source)[https://github.com/neovim/neovim/blob/master/BUILD.md]. 
- To specify different nvim configurations one could use NVIM_APPNAME=<name> to create a 'namespaced' configuration and then one may even use aliases for this to reduce boilerplate each time one wants to use neovim with this specific config. For example, alias nvim=vim but now alias nvimf=NVIM_APPNAME=f nvim

- wincmd (to look for help)- different commands regarding windows
- In command mode, prepending :! would allow to execute shell commands like, for example, :! ls .
- % is a placeholder for the 'current file', so source % would run the current file.

Key to all --> checkhealth command for plugins

## Tutor
:Tutor shows a tutorial to use certain features that makes neovim usable for newcomers. It doesn't cover all, but enough to get a good grasp and some interesting stuff that at least I was not aware of before, for example, **In normal mode, using K over a function, call or whatever would show a description in a modal popup fashion**. 

useful default shortcuts:
normal mode: gx // opens browser to link
normal mode: <C-f> // moves screen (scroll down). Check difference between the remap for using <C-d>zz
normal mode: <C-o> // goes to previous opened buffer window

useful help sections:
ins-completion // for autocomplete shortcuts
E355 // for a detailed list of every vim option


## LSP
LSP stands for language server protocol, the editor is like the client and this server is running behind the scenes.
So these two are communicating constantly based on the language of the opened file (and if this language server is active)
Neovim comes with lsp by default, but in order to make use of it one would need to install the language server that one wants to activate.
LspAttach attach the server language to whatever file we are currently on.
:echo executable('gopls') should return 1 and if returns 0 means the language server for gopls has not been found by neovim
### LSP keymaps (:help lsp)
- normal mode: =Q // formats for indentation
- normal mode: vim.lsp.buf.format() formats the entire file
- "gcc" comment
- "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
- "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
- "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
- "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
- "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
- CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|
- normal mode: <C-]> // redirects you the definition of the variable, function, or whatever you are situated
- normal mode: <C-t> // redirects you back from the definition of the variable, function or whatever
*these two last keymaps infer that now neovim has a way to get into the language definitions (codebase of the language), thats one of the points of having a language server. By the same token the autocompletion is affordable.*
insert mode: **There is a family of autocompletion


### cool combinations:
V%: on a parenthesis, allows to select a parenthesis thing

## Telescope
:Telescope builtin // shows all possible options
In looking modal, <C-n> and <C-p> help navegate the files (instead of using arrowkeys)
in insert mode (telescope panel) <C-/> would show insert mode key maps


### using windows commands
shortcut gt helps moving between tabs
<C-T> moves current window to a new tab
:help CTRL(tab) to show all possible options regarding windows commands

### quickfix
using grr (lsp references) uses quickfix
using <C-q> in search mode using telescope
:copen or :cclose
cool reeplacement with checks -> :cdo s/something/something-else/gc -- g is for global and c is for check
cdo is like quickfix do 

#### see all errors
:lua vim.diagnostic.setqflist()

### substitutes
:help substitute


### terminal
neovim builtin terminal
:help :term

### Oil
oil is a directory viewer, not a filetree

### nerd fonts
needed for oil glyphs (and because its cool to have a good font) https://www.nerdfonts.com/font-downloads. Depending on the emulator, in kitty there is an issue that is solved by https://github.com/kovidgoyal/kitty/issues/1463#issuecomment-2438394737
