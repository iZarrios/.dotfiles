# if not path is specified, use current directory
path ?= $(CURDIR)

# TODO: add a script to install all the dependencies


# /home/zarrios/.local/scripts//tmux-sessionizer


all:
	# git config
	ln -s $(path)/.gitconfig ~/.gitconfig
	# zsh config
	ln -s $(path)/.zshrc ~/.zshrc
	# nvim config
	ln -s $(path)/nvim  ~/.config/nvim
	# tmux config
	ln -s $(path)/.tmux.conf ~/.tmux.conf
	# clang format
	ln -s $(path)/.clang-format ~/.clang-format
	# i3 config
	ln -s $(path)/i3-conf/i3 ~/.i3/config
	# i3 stauts
	ln -s $(path)/i3-config/.i3status.conf ~/.i3status.conf
	# alacritty config
	ln -s $(path)/alacritty ~/.config/alacritty/alacritty.yml
	# tmux sessionizer
	ln -s $(path)/scripts/tmux-sessionizer ~/.local/scripts/tmux-sessionizer


