" nvim 普通配置
source ~/.config/nvim/config/general/config.vim

" nvim 普通键位设置
source ~/.config/nvim/config/general/keys_bindings.vim

" nvim 插件
source ~/.config/nvim/config/plugs.vim

if !empty(glob('~/.config/nvim/_machine_specific.vim'))
	source ~/.config/nvim/_machine_specific.vim
endif
