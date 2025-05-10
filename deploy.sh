prompt_install() {
	# Use $1 as the command and check if $2 (package name) is provided; if not, default to $1.
	command_name=$1
	package_name=${2:-$1}

	# Check if the -y flag was provided
	if [ "$auto_yes" = true ]; then
		# Install the package directly without prompting
		install_package "$package_name"
	else
		# Prompt the user to confirm installation if the required package is missing
		echo -n "$command_name is not installed. Would you like to install it? (y/n) " >&2
		# Save the current terminal settings to restore them later
		old_stty_cfg=$(stty -g)
		# Set terminal to raw mode to capture single keystrokes without echoing them to the screen
		stty raw -echo
		# Read a single character input ('y' or 'n') from the user, looping until a valid response is given
		answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
		# Restore the previous terminal settings and print a newline
		stty $old_stty_cfg && echo
		# Check if the answer was "y" (case insensitive)
		if echo "$answer" | grep -iq "^y" ;then
			install_package "$package_name"
		fi
	fi
}

install_package() {
	package_name=$1
	# Try to install the package using different package managers based on availability
	if [ -x "$(command -v apt)" ]; then
		sudo apt install $package_name -y
	elif [ -x "$(command -v brew)" ]; then
		brew install $package_name
	elif [ -x "$(command -v pkg)" ]; then
		sudo pkg install $package_name
	elif [ -x "$(command -v pacman)" ]; then
		sudo pacman -S $package_name
	else
		echo "I'm not sure what your package manager is! Please install $package_name on your own and run this deploy script again. Tests for package managers are in the deploy script you just ran starting at line 13. Feel free to make a pull request at https://github.com/parth/dotfiles :)"
	fi
}

check_for_software() {
	# Use $1 as the command and check if $2 (package name) is provided; if not, default to $1.
	command_name=$1
	package_name=${2:-$1}
	echo "Checking to see if $command_name is installed"
	if ! [ -x "$(command -v $command_name)" ]; then
		prompt_install $package_name
	else
		echo "$1 is installed."
	fi
}

check_default_shell() {
	if [ -z "${SHELL##*zsh*}" ] ;then
		echo "Default shell is zsh."
	else
		if [ "$auto_yes" = true ]; then
			chsh -s $(which zsh)
		else
			echo -n "Default shell is not zsh. Do you want to chsh -s \$(which zsh)? (y/n)"
			old_stty_cfg=$(stty -g)
			stty raw -echo
			answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
			stty $old_stty_cfg && echo
			if echo "$answer" | grep -iq "^y" ;then
				chsh -s $(which zsh)
			else
				echo "Warning: Your configuration won't work properly. If you exec zsh, it'll exec tmux which will exec your default shell which isn't zsh."
			fi
		fi
	fi
}

auto_yes=false
if [ "$1" = "-y" ]; then
	auto_yes=true
	shift
fi

echo "We're going to do the following:"
echo "1. Check to make sure you have zsh, nvim, and tmux installed"
echo "2. We'll help you install them if you don't"
echo "3. We're going to check to see if your default shell is zsh"
echo "4. We'll try to change it if it's not"

if [ "$auto_yes" = true ]; then
	echo "Running in automatic mode (-y flag provided)"
else
	echo "Let's get started? (y/n)"
	old_stty_cfg=$(stty -g)
	stty raw -echo
	answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
	stty $old_stty_cfg
	if echo "$answer" | grep -iq "^y" ;then
		echo
	else
		echo "Quitting, nothing was changed."
		exit 0
	fi
fi

check_for_software zsh
echo
check_for_software nvim neovim
echo
check_for_software tmux
echo
check_for_software curl
echo
check_for_software fzf
echo
check_for_software rg ripgrep
echo
check_for_software imagemagick
echo

echo "Creating symlink for nvim config at ~/.config/nvim"
mkdir -p $HOME/.config
ln -s $HOME/dotfiles/nvim $HOME/.config/nvim

echo "Adding tmux plugin manager"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

check_default_shell

echo
if [ "$auto_yes" = true ]; then
	echo "Backing up old dotfiles..."
	mv ~/.zshrc ~/.zshrc.old
	mv ~/.tmux.conf ~/.tmux.conf.old
	mv ~/.vimrc ~/.vimrc.old
else
	echo -n "Would you like to backup your current dotfiles? (y/n) "
	old_stty_cfg=$(stty -g)
	stty raw -echo
	answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
	stty $old_stty_cfg
	if echo "$answer" | grep -iq "^y" ;then
		mv ~/.zshrc ~/.zshrc.old
		mv ~/.tmux.conf ~/.tmux.conf.old
		mv ~/.vimrc ~/.vimrc.old
	else
		echo -e "\nNot backing up old dotfiles."
	fi
fi

printf "source '$HOME/dotfiles/zsh/zshrc_manager.sh'" > ~/.zshrc
printf "so $HOME/dotfiles/vim/vimrc.vim" > ~/.vimrc
printf "source-file $HOME/dotfiles/tmux/tmux.conf" > ~/.tmux.conf

echo
echo "Please log out and log back in for default shell to be initialized."
