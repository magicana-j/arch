sudo pacman -S zsh pkgfile zsh-completions grml-zsh-config zsh-syntax-highlighting zsh-autosuggestions
echo 'source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'  >> ~/.zshrc.local
echo 'source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc.local
echo 'source /usr/share/doc/pkgfile/command-not-found.zsh' >> ~/.zshrc.local
chsh -s $(which zsh) $USER
