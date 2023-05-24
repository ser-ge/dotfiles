syntax on

set hidden
set noerrorbells

set shiftwidth=4
set expandtab
set smartindent
set number relativenumber
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set backspace=indent,eol,start
:imap jj <Esc>
set path+=**
" set wildmenu
filetype plugin on
:let maplocalleader = "\\"
:let g:latex_to_unicode_keymap = 1

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
"
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
 " XYG534-H9YKRAA5V2
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey
" let g:python3_host_prog ='/Users/serge/.pyenv/shims/python'
"Install Plug
" if empty(glob('~/.vim/autoload/plug.vim'))
"   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

"float term

" tnoremap <silent> <C-j> :FloatermToggle <CR>
" let g:floaterm_keymap_toggle = '<C-\>'
call plug#begin('~/.local/share/nvim/plugged')
Plug 'kiyoon/jupynium.nvim', { 'do': 'pip3 install --user .' }
" Plug 'kiyoon/jupynium.nvim', { 'do': 'conda run --no-capture-output -n jupynium pip install .' }
Plug 'hrsh7th/nvim-cmp'       " optional, for completion
Plug 'rcarriga/nvim-notify'   " optional
Plug 'stevearc/dressing.nvim' " optional, UI for :JupyniumKernelSelect
Plug 'projekt0n/github-nvim-theme'
Plug 'hrsh7th/nvim-cmp'
Plug 'rcarriga/cmp-dap'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'f3fora/cmp-spell'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
Plug 'vim-test/vim-test'
Plug 'sagi-z/vimspectorpy', { 'do': { -> vimspectorpy#update() } }
" Plug 'puremourning/vimspector'
Plug 'aduros/ai.vim'
Plug 'othree/html5.vim'
Plug 'evanleck/vim-svelte'
Plug 'justinmk/vim-sneak'
Plug 'voldikss/vim-floaterm'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'JuliaEditorSupport/julia-vim'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'zchee/deoplete-jedi'
" Plug 'davidhalter/jedi-vim'
Plug 'psf/black'
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdtree'
Plug 'lervag/vimtex'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'pangloss/vim-javascript'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mxw/vim-jsx'
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'
Plug 'vimwiki/vimwiki'
Plug 'https://github.com/alok/notational-fzf-vim'
Plug 'sirver/ultisnips'
Plug 'vim-syntastic/syntastic'
Plug 'hanschen/vim-ipython-cell', { 'for': 'python'  }
Plug 'jpalardy/vim-slime'
Plug 'tpope/vim-surround'
Plug 'guns/vim-sexp',    {'for': 'clojure'}
Plug 'liquidz/vim-iced'
Plug 'preservim/vimux'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap'
Plug 'jay-babu/mason-nvim-dap.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
Plug 'folke/neodev.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'nvim-neotest/neotest'
Plug 'nvim-neotest/neotest-python'
Plug 'wuelnerdotexe/vim-astro'
call plug#end()
set statusline=
set statusline+=%#PmenuSel#
" set statusline+=%{StatuslineGit()}
set statusline+=%#CursorLineNr#

set statusline=
set statusline+=%#PmenuSel#
" set statusline+=%{StatuslineGit()}
set statusline+=%#CursorLineNr#

" set termguicolors
" colorscheme gruvbox
"let g:gruvbox_contrast_dark='soft'
" set background=dark

colorscheme github_dark
if executable('rg')
    let g:rg_derive_root='true'
endif

let g:tex_flavor='latex'


""Autocompletion
"let g:deoplete#enable_at_startup = 1
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif "close preview"
""tab completion
"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"" disable autocompletion, cause we use deoplete for completion
"let g:jedi#completions_enabled = 0

"" open the go-to function in split, not another buffer
"let g:jedi#use_splits_not_buffers = "right"
"let g:jedi#rename =""

let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

" let g:ctrlp_use_caching = 0

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <leader>m :NERDTreeToggle <CR>
nnoremap <leader>u :UndotreeShow<CR>
nmap <leader>f <Plug>SlimeSendCell

nnoremap <leader><leader> :Files<CR>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" fun! GoCoc()
"     inoremap <buffer> <silent><expr> <TAB>
"                 \ pumvisible() ? "\<C-n>" :
"                 \ <SID>check_back_space() ? "\<TAB>" :
"                 \ coc#refresh()
"     inoremap <buffer> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"     inoremap <buffer> <silent><expr> <C-space> coc#refresh()
"     " GoTo code navigation.
"     nmap <buffer> <leader>gd <Plug>(coc-definition)
"     nmap <buffer> <leader>gy <Plug>(coc-type-definition)
"     nmap <buffer> <leader>gi <Plug>(coc-implementation)
"     nmap <buffer> <leader>gr <Plug>(coc-references)
"     nnoremap <buffer> <leader>cr :CocRestart
" endfun

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

" Markdown
let g:vim_markdown_folding_disabled = 1
set t_ZH=^[[3m
set t_ZR=^[[23m

" FORMATTERS
au FileType javascript setlocal formatprg=prettier
au FileType javascript.jsx setlocal formatprg=prettier
au FileType typescript setlocal formatprg=prettier\ --parser\ typescript
au FileType html setlocal formatprg=js-beautify\ --type\ html
au FileType scss setlocal formatprg=prettier\ --parser\ css
au FileType css setlocal formatprg=prettier\ --parser\ css

" GIT  https://jakobgm.com/posts/vim/git-integration/
" Open vimagit pane git status
nnoremap <leader>gs :Magit<CR>

" Jump between hunks
nmap <Leader>gn <Plug>(GitGutterNextHunk)
nmap <Leader>gp <Plug>(GitGutterPrevHunk)

" Hunk-add and hunk-revert for chunk staging
nmap <Leader>ga <Plug>(GitGutterStageHunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)

" Update sign column every quarter second
set updatetime=250


"GIT - Aesthetics
let g:gitgutter_override_sign_column_highlight = 1
highlight SignColumn guibg=bg
highlight SignColumn ctermbg=bg
" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'

"Vim Wiki
set nocompatible
filetype plugin on
let g:vimwiki_global_ext = 0

let g:vimwiki_list = [{
            \'path': '~/drop/Dropbox/wiki/notes/',
            \'syntax': 'markdown',
            \'ext':'.md',
	\ 'path_html': '~/drop/Dropbox/wiki/html/',
    \ 'custom_wiki2html':'~/Dropbox/wiki/scripts/convert.py',}]

" let g:vimwiki_list = [{
"   \ 'auto_export': 1,
"   \ 'automatic_nested_syntaxes':1,
"   \ 'path_html': '$HOME/Dropbox/wiki/_site',
"   \ 'path': '$HOME/DDropbox/wiki/content',
"   \ 'template_path': '$HOME/Documents/vimwiki/templates/',
"   \ 'syntax': 'markdown',
"   \ 'ext':'.md',
"   \ 'template_default':'markdown',
"   \ 'custom_wiki2html': '$HOME/.dotfiles/wiki2html.sh',
"   \ 'template_ext':'.html'
" \}]
" correct spelling in insert mode
inoremap <C-g> <c-g>u<Esc>[s1z=`]a<c-g>

"fzf / nv
let g:nv_search_paths = ['~/Dropbox/wiki/notes/', './notes/*']
let g:nv_window_direction = 'left'
let g:nv_window_width = '100%'

"Satus bar
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%#LineNr#
set statusline+=\ %3l
set statusline+=/
set statusline+=%L

"let g:airline#extensions#tabline#enabled = 0
""set noshowmode

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
endif

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle terminal on/off (neovim)
" nnoremap <leader>t :call TermToggle(8)<CR>
" inoremap  <leader>t <Esc>:call TermToggle(8)<CR>
" tnoremap <leader>t <C-\><C-n>:call TermToggle(8)<CR>
"
"jkjksdf
" Latex plugs
function! InstallPackages()
    let winview = winsaveview()
    call inputsave()
    let cmd = ['sudo -S tlmgr install']
    %call add(cmd, matchstr(getline('.'), '\\usepackage\(\[.*\]\)\?{\zs.*\ze\}'))
    echomsg join(cmd)
    let pass = inputsecret('Enter sudo password:') . "\n"
    echo system(join(cmd), pass)
    call inputrestore()
    call winrestview(winview)
endfunction

" let g:UltiSnipsExpandTrigger = '<S-tab>'
" let g:UltiSnipsJumpForwardTrigger = '<S-tab>'
" let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'


let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='sabdmg'

set encoding=utf-8
let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"
let g:tex_conceal_frac=1
let g:vimtex_view_method = 'zathura'

let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : '',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \   '-shell-escape',
    \ ],
    \}



let g:vimtex_fold_enabled = 1
"------------------------------------------------------------------------------
" slime configuration
"------------------------------------------------------------------------------
" always use tmux
let g:slime_target = 'tmux'

" fix paste issues in ipython
let g:slime_python_ipython = 1

" always send text to the top-right pane in the current tmux tab without asking
let g:slime_default_config = {
            \ 'socket_name': get(split($TMUX, ','), 0),
            \ 'target_pane': '{top-right}' }
let g:slime_dont_ask_default = 1

let g:slime_cell_delimiter = "# %%"
let g:ipython_cell_delimit_cells_by = 'tags'
let g:ipython_cell_tag = "# %%"

"------------------------------------------------------------------------------
" ipython-cell configuration
"------------------------------------------------------------------------------
" Keyboard mappings. <Leader> is \ (backslash) by default

" " map <Leader>s to start IPython
" nnoremap <Leader>s :SlimeSend1 ipython --matplotlib<CR>

" map <Leader>r to run script
nnoremap <Leader>r :IPythonCellRun<CR>

" map <Leader>R to run script and time the execution
nnoremap <Leader>R :IPythonCellRunTime<CR>

" map <Leader>c to execute the current cell
nnoremap <Leader>c :IPythonCellExecuteCell<CR>

" map <Leader>C to execute the current cell and jump to the next cell
nnoremap <Leader>C :IPythonCellExecuteCellJump<CR>

" map <Leader>l to clear IPython screen
" nnoremap <Leader>l :IPythonCellClear<CR>

" map <Leader>x to close all Matplotlib figure windows
nnoremap <Leader>x :IPythonCellClose<CR>

" map [c and ]c to jump to the previous and next cell header
nnoremap [c :IPythonCellPrevCell<CR>
nnoremap ]c :IPythoCellNextCell<CR>

" map <Leader>h to send the current line or current selection to IPython
" nmap <Leader>c <Plug>SlimeLineSend
" xmap <Leader>h <Plug>SlimeRegionSend

" map <Leader>p to run the previous command
nnoremap <Leader>p :IPythonCellPrevCommand<CR>

" map <Leader>Q to restart ipython
nnoremap <Leader>Q :IPythonCellRestart<CR>

" map <Leader>d to start debug mode
" nnoremap <Leader>d :SlimeSend1 %debug<CR>

" map <Leader>q to exit debug mode or IPython
nnoremap <Leader>q :SlimeSend1 exit<CR>n

" Float Term

" function! floaterm#wrapper#ranger#(cmd) abort
"   let s:ranger_tmpfile = tempname()
"   let original_dir = getcwd()
"   lcd %:p:h

  " let cmdlist = split(a:cmd)
  " let cmd = 'ranger --choosefiles="' . s:ranger_tmpfile . '"'
  " if len(cmdlist) > 1
  "   let cmd .= ' ' . join(cmdlist[1:], ' ')
  " else
  "   if expand('%:p') != ''
  "     let cmd .= ' --selectfile="' . expand('%:p') . '"'
  "   else
  "   let cmd .= ' "' . getcwd() . '"'
  "   endif
  " endif

  " exe "lcd " . original_dir
  " return [cmd, {'on_exit': funcref('s:ranger_callback')}, v:false]
" endfunction

function! s:ranger_callback(...) abort
  if filereadable(s:ranger_tmpfile)
    let filenames = readfile(s:ranger_tmpfile)
    if !empty(filenames)
      if has('nvim')
        call floaterm#window#hide(bufnr('%'))
      endif
      for filename in filenames
        execute g:floaterm_open_command . ' ' . fnameescape(filename)
      endfor
    endif
  endif
endfunction
" let g:floaterm_keymap_toggle  = '<C-j>'


" :tmap <silent> ,, <Esc> :FloatermToggle <CR>
" nnoremap <silent> <Leader>pp :FloatermNew --height=0.8 --width=0.8 --wintype=floating --name=ipy --autoclose=2 poetry run ptipython <CR>
" noremap <Leader>T :FloatermNew --height=0.4 --width=0.98 --wintype=floating --position=bottom --autoclose=2 <CR>
" noremap <Leader>t :FloatermToggle <CR>

let g:iced_enable_default_key_mappings = v:true

nmap <Leader>ss <Plug>VimspectorBalloonEval
nmap <Leader>] <Plug>VimspectorRunToCursor
" for normal mode - the word under the cursor
nmap <Leader>t <Plug>VimspectorToggleBreakpoint
nmap <C-n> <Plug>VimspectorStepOver
" for visual mode, the visually selected text
"
augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END

" require("nvim-dap-virtual-text").setup()
" https://smarttech101.com/nvim-lsp-configure-language-servers-shortcuts-highlights/
    " vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    "

lua << EOF



require("jupynium").setup({
  --- For Conda environment named "jupynium",
  python_host = { "poetry", "run", "python" }


  default_notebook_URL = "localhost:8888",

  -- Write jupyter command but without "notebook"
  -- When you call :JupyniumStartAndAttachToServer and no notebook is open,
  -- then Jupynium will open the server for you using this command. (only when notebook_URL is localhost)
  jupyter_command = "jupyter",
  --- For Conda, maybe use base environment
  --- then you can `conda install -n base nb_conda_kernels` to switch environment in Jupyter Notebook
  -- jupyter_command = { "conda", "run", "--no-capture-output", "-n", "base", "jupyter" },

  -- Used when notebook is launched by using jupyter_command.
  -- If nil or "", it will open at the git directory of the current buffer,
  -- but still navigate to the directory of the current buffer. (e.g. localhost:8888/tree/path/to/buffer)
  notebook_dir = nil,

  -- Used to remember the last session (password etc.).
  -- e.g. '~/.mozilla/firefox/profiles.ini'
  -- or '~/snap/firefox/common/.mozilla/firefox/profiles.ini'
  firefox_profiles_ini_path = nil,
  -- nil means the profile with Default=1
  -- or set to something like 'default-release'
  firefox_profile_name = nil,

  -- Open the Jupynium server if it is not already running
  -- which means that it will open the Selenium browser when you open this file.
  -- Related command :JupyniumStartAndAttachToServer
  auto_start_server = {
    enable = false,
    file_pattern = { "*.ju.*" },
  },

  -- Attach current nvim to the Jupynium server
  -- Without this step, you can't use :JupyniumStartSync
  -- Related command :JupyniumAttachToServer
  auto_attach_to_server = {
    enable = true,
    file_pattern = { "*.ju.*", "*.md" },
  },

  -- Automatically open an Untitled.ipynb file on Notebook
  -- when you open a .ju.py file on nvim.
  -- Related command :JupyniumStartSync
  auto_start_sync = {
    enable = false,
    file_pattern = { "*.ju.*", "*.md" },
  },

  -- Automatically keep filename.ipynb copy of filename.ju.py
  -- by downloading from the Jupyter Notebook server.
  -- WARNING: this will overwrite the file without asking
  -- Related command :JupyniumDownloadIpynb
  auto_download_ipynb = true,

  -- Automatically close tab that is in sync when you close buffer in vim.
  auto_close_tab = true,

  -- Always scroll to the current cell.
  -- Related command :JupyniumScrollToCell
  autoscroll = {
    enable = true,
    mode = "always", -- "always" or "invisible"
    cell = {
      top_margin_percent = 20,
    },
  },

  scroll = {
    page = { step = 0.5 },
    cell = {
      top_margin_percent = 20,
    },
  },

  -- Files to be detected as a jupynium file.
  -- Add highlighting, keybindings, commands (e.g. :JupyniumStartAndAttachToServer)
  -- Modify this if you already have lots of files in Jupytext format, for example.
  jupynium_file_pattern = { "*.ju.*" },

  use_default_keybindings = true,
  textobjects = {
    use_default_keybindings = true,
  },

  syntax_highlight = {
    enable = true,
  },

  -- Dim all cells except the current one
  -- Related command :JupyniumShortsightedToggle
  shortsighted = false,

  -- Configure floating window options
  -- Related command :JupyniumKernelHover
  kernel_hover = {
    floating_win_opts = {
      max_width = 84,
      border = "none",
    },
  },
})

-- You can link highlighting groups.
-- This is the default (when colour scheme is unknown)
-- Try with CursorColumn, Pmenu, Folded etc.
vim.cmd [[
hi! link JupyniumCodeCellSeparator CursorLine
hi! link JupyniumMarkdownCellSeparator CursorLine
hi! link JupyniumMarkdownCellContent CursorLine
hi! link JupyniumMagicCommand Keyword
]]

-- Please share your favourite settings on other colour schemes, so I can add defaults.
-- Currently, tokyonight is supported.
require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
  ...
})
    require("mason").setup()
    require("mason-lspconfig").setup()
    require('lspconfig').pyright.setup{}
    require("mason-nvim-dap").setup()
    require("mason-nvim-dap").setup({
        ensure_installed = { "python"}
})

    require("dapui").setup()



     require("neotest").setup({
  adapters = {
    require("neotest-python"),
    require("neotest-plenary")
  }
})



 require("nvim-treesitter.configs").setup {
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = {}, -- list of language that will be disabled
    },
  }


        local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    local dap = require('dap')
    dap.configurations.python = {
      {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        pythonPath = function()
          return 'python'
        end;
      },
    }

    dap.adapters.python = {
        type = 'executable',
        command = vim.fn.stdpath('data')..'/mason/packages/debugpy/venv/bin/python',
        args = { '-m', 'debugpy.adapter' },
    }

    vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
    vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
    vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
    vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
    vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
    vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
    vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
    vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
    vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end)
    vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
      require('dap.ui.widgets').preview()
    end)
    vim.keymap.set('n', '<Leader>df', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end)
    vim.keymap.set('n', '<Leader>ds', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end)

    require("nvim-dap-virtual-text").setup { all_frames = true, highlight_changed_variables = true  }

    local function configure_exts()
      require("nvim-dap-virtual-text").setup {
        commented = true,
      }

      local dap, dapui = require "dap", require "dapui"
      dapui.setup {} -- use default
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end

EOF
let g:python_highlight_string_format = 1
let g:python_highlight_builtin_objs  = 1

source $HOME/.config/nvim/plug-config/lspconfig.lua
source ~/.config/nvim/plug-config/auto-cmp.lua
