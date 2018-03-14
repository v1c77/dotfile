define link
ln -fs `pwd`/vimrc ~/.vimrc
ln -fs `pwd`/zshrc ~/.zshrc
ln -fs `pwd`/flake8	~/.flake8
ln -fs `pwd`/gitignore_global	~/.gitignore_global
ln -fs `pwd`/ideavimrc ~/.ideavimrc
endef

init:
		$(link)

sync:
		git pull
		$(link)

upload:
		git add .
		git commit -m "auto upload"
		git push

install-tools:
	chmod +x ./install-in-new-os.sh
	sh ./install-in-new-os.sh
