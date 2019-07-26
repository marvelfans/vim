# VIM 配置文件
---

## 修改记录
* 1.1
    * 废弃`vundle`，使用`vim-plug`
    * 添加注释，修改配置文件组织方式
* 1.2
    * 取消使用频率较少的快捷键
    * 增加ack插件来进行代码搜索
* 1.3
    * 取消ctrlp, bufferexplore, ack插件, 感觉用的不多, 还影响速度.  
* 1.4
    * 添加nerdtree插件.
    * 注释掉一些功能, 不是因为功能不好用, 只为了更专注一些. 如果有需要这些功能, 还会打开的.


## 功能
* `python`支持.
* `go`支持.
* `markdown`支持.
* 主题和外观.
* 文件查找.
* git高亮支持.
* 代码搜索.
* 文件目录.

## 使用
* 拷贝本文件到自己的电脑。
* 选择`vimrc.now`更命并替换自己的配置文件`.vimrc`.
* 在`$HOME`下建立`$HOME/vim/bundle/`的路径.
* 在`$HOME/vim/bundle/`下执行`git clone https://github.com/VundleVim/Vundle.vim`.
* 在命令行执行`vim +PluginInstall +qall`.

## 文件说明
* `vimrc.now`: 目前自己在用的配置文件。根据目前工作需要自己组合的.
* `README.md`: 文件说明.

## 功能说明

### python支持

#### 语法支持
注意使用以下插件
* vim-syntastic/syntastic
* python-mode/python-mode
* nvie/vim-flake8
* davidhalter/jedi-vim

#### vim 支持python跳转
使用python的`ptags.py`，生成`tags`文件。然后`.c` 和 `.cpp`文件一样使用tags就可以了。需要注意的是，使用时候，需要将`进入目录的时候切换到当前目录`的设置取消.
* 用法
    * `<C-]>` 跳转到定义
    * `<C-T>` 回到原处

* 我是这样使用的:
    * `sudo find . -name ptags.py` 找到`ptags.py`的路径.
    * `find . -regex ".*\.py" | xargs <path-to-ptags.py>` 在当前目录下生成tags文件.
    * 或 `find . -regex ".*\.py" | xargs etags`
* 如果需要对单个文件生成tags文件，可以这样:
    * `sudo find . -name ptags.py` 找到`ptags.py`的路径.
    * `<path-to-ptags.py> file.py`

### go 支持
目前写go不多，注要使用以下插件
* fatih/vim-go

### 主题和外观
* 主题`Bundle 'jnurmine/Zenburn'`
* 状态栏`marvelfans/vim-neatstatus`

### git 高亮
* 使用vim-gitgutter, 支持vim高亮

### 文件浏览
* 使用了`scrooloose/nerdtree`插件.
