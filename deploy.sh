prompt_install() {
	# Use $1 as the command and check if $2 (package name) is provided; if not, default to $1.
	command_name=$1
	package_name=${2:-$1}
	# Prompt the user to confirm installation if the required package is missing.
	echo -n "$command_name is not installed. Would you like to install it? (y/n) " >&2
	# Save the current terminal settings to restore them later.
	old_stty_cfg=$(stty -g)
	# Set terminal to raw mode to capture single keystrokes without echoing them to the screen.
	stty raw -echo
	# Read a single character input ('y' or 'n') from the user, looping until a valid response is given.
	answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
	# Restore the previous terminal settings and print a newline.
	stty $old_stty_cfg && echo
	# Check if the answer was "y" (case insensitive).
	if echo "$answer" | grep -iq "^y" ;then
		# Try to install the package using different package managers based on availability.
		# If 'apt' is available (typically on Debian/Ubuntu), use it to install the package.
		if [ -x "$(command -v apt)" ]; then
			sudo apt install $package_name -y
		# If 'brew' is available (macOS), use it to install the package.
		elif [ -x "$(command -v brew)" ]; then
			brew install $package_name
		# If 'pkg' is available (e.g., FreeBSD), use it to install the package.
		elif [ -x "$(command -v pkg)" ]; then
			sudo pkg install $package_name
		# If 'pacman' is available (Arch Linux), use it to install the package.
		elif [ -x "$(command -v pacman)" ]; then
			sudo pacman -S $package_name
		# If none of the above package managers are found, prompt the user to install manually.
		else
			echo "I'm not sure what your package manager is! Please install $package_name on your own and run this deploy script again. Tests for package managers are in the deploy script you just ran starting at line 13. Feel free to make a pull request at https://github.com/parth/dotfiles :)"
		fi 
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
}

echo "We're going to do the following:"
echo "1. Check to make sure you have zsh, nvim, and tmux installed"
echo "2. We'll help you install them if you don't"
echo "3. We're going to check to see if your default shell is zsh"
echo "4. We'll try to change it if it's not" 

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

echo "Creating symlink for nvim config at ~/.config/nvim"
ln -s $HOME/dotfiles/nvim $HOME/.config/nvim

check_default_shell

echo
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

printf "source '$HOME/dotfiles/zsh/zshrc_manager.sh'" > ~/.zshrc
printf "so $HOME/dotfiles/vim/vimrc.vim" > ~/.vimrc
printf "source-file $HOME/dotfiles/tmux/tmux.conf" > ~/.tmux.conf

echo
echo "Please log out and log back in for default shell to be initialized."
