# if not path is specified, use current directory
path ?= $(CURDIR)

# TODO: add a script to install all the dependencies


# /home/zarrios/.local/scripts//tmux-sessionizer

git:
	ln -s $(path)/.gitconfig ~/.gitconfig
tmux:
	
	ln -s $(path)/.tmux.conf ~/.tmux.conf
i3:
	ln -s $(path)/i3-conf/i3 ~/.config/i3
	ln -s $(path)/i3-config/.i3status.conf ~/.i3status.conf

clangfmt:
	ln -s $(path)/.clang-format ~/.clang-format
zsh:
	# zsh config
	ln -s $(path)/.zshrc ~/.zshrc
	# clang format
	ln -s $(path)/.clang-format ~/.clang-format
	# tmux sessionizer
	#ln -s $(path)/scripts/tmux-sessionizer ~/.local/scripts/tmux-sessionizer


