#!/bin/sh

# DESC: Vim Version >= 7.04

GIT_BIN=`which git`
REMOTE_PATH='https://github.com/marvelfans/vim.git'
URL_BASE='https://github.com/'
DEFAULT_PLUGIN_URL_BASE='vim-scripts/'
VIM_CONF_PATH=${HOME}/.vim/conf
CURRENT_PATH=`pwd`
PLUGIN_PATH=${HOME}/.vim/bundle/

# 获取git路径
if [ -z "$GIT_BIN" ]; then
	echo "Please install <git> and retry."
	exit
fi
echo "git has installed."

# 创建插件目录
if [ -d "$PLUGIN_PATH" ]; then
	echo "directory: $HOME/.vim/bundle/ has exists."
else
	mkdir -p ${PLUGIN_PATH}
	echo "directory: $HOME/.vim/bundle/ has create. "
fi

# 获取vim配置文件 在github上的路径
# 配置文件存放路径
if [ -d "$VIM_CONF_PATH" ]; then
	echo "directory: $VIM_CONF_PATH has exists"
else
	mkdir -p ${VIM_CONF_PATH}
	echo "directory: $VIM_CONF_PATH has create."
fi

# 判断是否存在已下载的配置文件目录 有就删除，然后重新git clone
if [ -d "$CURRENT_PATH/vim" ]; then
	echo "vim conf has exists."
	rm -rf $CURRENT_PATH/vim
	echo "old vim conf has deleted."
fi
# My Vim configuration
$GIT_BIN clone $REMOTE_PATH
mv $CURRENT_PATH/vim/* $VIM_CONF_PATH
rm -rf $CURRENT_PATH/vim

# TODO:软链地址需要修改一下 在此仅为测试
if [ -d "$HOME/.vimrc" ]; then
	rm -rf $HOME/.vimrc
fi
if [ -d "$HOME/.vimrc.bundles" ]; then
	rm -rf $HOME/.vimrc.bundles
fi
ln -s $VIM_CONF_PATH/vimrc $HOME/.vimrc	
ln -s $VIM_CONF_PATH/vimrc.bundles $HOME/.vimrc.bundles

# TODO:插件目录需要修改到默认目录
while read line
do
	result=$(echo $line | grep "Bundle" | grep [Bundle])
	STRLEN=`echo ${#result}`
	if [ $STRLEN != 0 ]; then
		mark=`echo $result | awk -F' ' '{print $1}'`
		if [ "$mark" == "Bundle" ]; then
			END_STR=$STRLEN-9
			URL_PLUGIN=`echo ${line:8:$END_STR}`
			flag_c=`echo $URL_PLUGIN | grep '/'`
			if [ -z "$flag_c" ]; then
				FILE=`echo $URL_PLUGIN`
				URL=${URL_BASE}${DEFAULT_PLUGIN_URL_BASE}${URL_PLUGIN}
			else 
				FILE=`echo ${URL_PLUGIN##*/}`
				URL=${URL_BASE}${URL_PLUGIN}
			fi
			if [ ! -d "${PLUGIN_PATH}${FILE}" ]; then
				$GIT_BIN clone $URL ${PLUGIN_PATH}${FILE}
			fi
		fi
	fi
done < $VIM_CONF_PATH/vimrc.bundles
