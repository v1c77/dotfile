#!/usr/bin/env bash

# shell env
set -ex

# set dir
begin_dir="$(pwd)"
home_dir="${HOME}"
work_dir=${home_dir}/.temp_work
mkdir -p ${work_dir}
echo 'You are in dir:' ${begin_dir}
echo 'the work dir is' ${work_dir}

unamestr=`uname`
platform='unknown'
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='Darwin'
fi

# checkout centos version
# git checkout origin/centos-7-version

# install yum depend
sudo -S bash -c "wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo &&
    yum makecache &&\
    yum install -y libxslt-devel libxml2-devel lapack-devel blas-devel \
    gcc-fortran swig libssl-dev mysql-devel redis python-devel ruby gcc \
    g++ make automake autoconf curl-devel openssl-devel zlib-devel \
    httpd-devel apr-devel apr-util-devel sqlite-devel ruby-rdoc ruby-devel \
    rubygems perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker libjpeg-devel  \
    devtoolset-3-toolchain centos-release-scl ncurses-devel gcc-c++\
    python-pip htop"


# install python dependent
sudo -S bash -c "pip install -i http://mirrors.aliyun.com/pypi/simple/ \
    --trusted-host mirrors.aliyun.com --upgrade pip && \
    pip install -i http://mirrors.aliyun.com/pypi/simple/ \
    --trusted-host mirrors.aliyun.com \
    python-config \
    requests \
    ipython==5.5.0"


# upgrade vim
if pushd ${work_dir}; then
    sudo -S bash -c "curl -L https://copr.fedorainfracloud.org/coprs/mcepl/vim8/repo/epel-7/mcepl-vim8-epel-7.repo -o /etc/yum.repos.d/mcepl-vim8-epel-7.repo && \
        yum upgrade -y || true &&\
        yum update vim* -y || echo 'vim update complete'"
    vim --version
    popd
fi

# install vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install zsh & oh-my-zsh

 if pushd ${home_dir}; then
     sudo -S yum install -y zsh
     sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || echo 'install omz complete'
     chsh -s /bin/zsh
     popd
 fi

# insstall golang
if pushd ${work_dir}; then
    curl -LO https://dl.google.com/go/go1.10.linux-amd64.tar.gz
    sudo -S tar -C /usr/local -xvzf go1.10.linux-amd64.tar.gz
    mkdir -p ~/go_home/{bin,pkg,src}
    echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee -a /etc/profile.d/path.sh
    echo 'export GOBIN="$HOME/go_home/bin"' | tee -a ~/.zshrc
    echo 'export GOPATH="$HOME/go_home/src"' | tee -a ~/.zshrc
    source /etc/profile && source ~/.zshrc
    popd
fi

# install hub
sudo -S gem install bundler
if pushd ${work_dir}; then
    git clone https://github.com/github/hub.git || true
    cd hub
    sudo -S make install prefix=/usr/local
    popd
fi


# finish
cd ${begin_dir}
sudo -S rm -rf ${work_dir}
source ${home_dir}/.zshrc
