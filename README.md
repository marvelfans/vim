# VIM 配置文件
---

## 功能
* `python`支持。
* `go`支持。
* `markdown`支持。
* 主题和外观。
* 文件查找

## 使用
* 拷贝本文件到自己的电脑。
* 选择`vimrc.now`更命并替换自己的配置文件`.vimrc`。
* 在`$HOME`下建立`$HOME/vim/bundle/`的路径。
* 在`$HOME/vim/bundle/`下执行`git clone https://github.com/VundleVim/Vundle.vim`。
* 在命令行执行`vim +PluginInstall +qall`。

## 文件说明
* `vimrc.now`: 目前自己在用的配置文件。根据目前工作需要自己组合的。
* `vimrc.bundles_comp`, `vimrc.bundles`, `vimrc_comp`, `vimrc_simple` 为以前参考别人修改而成的，目前主要是做纪念，不再维护使用。

## 功能说明

### python支持

#### 语法支持
注意使用以下插件
* vim-syntastic/syntastic
* python-mode/python-mode
* nvie/vim-flake8
* davidhalter/jedi-vim

#### vim 支持python跳转
使用python的`ptags.py`，生成`tags`文件。然后`.c` 和 `.cpp`文件一样使用tags就可以了。需要注意的是，使用时候，需要将`进入目录的时候切换到当前目录`的设置取消。
* 用法
    * `<C-]>` 跳转到定义
    * `<C-T>` 回到原处

* 我是这样使用的:
    * `sudo find . -name ptags.py` 找到`ptags.py`的路径。
    * `find . -regex ".*\.py" | xargs <path-to-ptags.py>` 在当前目录下生成tags文件。
* 如果需要对单个文件生成tags文件，可以这样:
    * `sudo find . -name ptags.py` 找到`ptags.py`的路径。
    * `<path-to-ptags.py> file.py`

### go 支持
目前写go不多，注要使用以下插件
* fatih/vim-go

### 主题和外观
* 主题`liuchengxu/space-vim-dark`
* 状态栏`marvelfans/vim-neatstatus`

### 目录和文件索引
* 目录树: scrooloose/nerdtree
* 文件快速索引: kien/ctrlp.vim
