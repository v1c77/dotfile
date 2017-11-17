init:

		ln -fs `pwd`/vimrc										~/.vimrc
		ln -fs `pwd`/zshrc    								~/.zshrc
		ln -fs `pwd`/CFUserTextEncoding 			~/.CFUserTextEncoding
		ln -fs `pwd`/flake8						    		~/.flake8
		ln -fs `pwd`/gitignore_global    			~/.gitignore_global
		ln -fs `pwd`/ideavimrc    						~/.ideavimrc

sync:
    git pull
    git push
