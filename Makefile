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

centos-init:
		chmod +x ./install-in-centos.sh
		sh ./install-in-centos.sh

rollback:

		git reset --hard origin/master
		git checkout -- .
		git fetch --all
		git checkout origin/centos-7-version
