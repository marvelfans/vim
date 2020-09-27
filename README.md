# VIM 配置文件
<font face=Cour size=3>

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
* 1.5
    * 添加一些常用功能技巧
* 1.6
    * 增加简单版，基础配置，无插件


## 功能
* `python`支持.
* `go`支持.
* `Markdown`支持.
* 主题和外观.
* 文件查找.
* git高亮支持.
* 文件浏览.
* VIM常用技巧使用.

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
使用python的`ptags.py`，生成`tags`文件。然后和`.c`及`.cpp`文件一样使用tags就可以了。需要注意的是，使用时候，需要将`进入目录的时候切换到当前目录`的设置取消.
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

### Markdown支持
Vim支持markdown语法。当然，如若需要实时预览，还需要其它支持，因目前已经满足需要，故暂时这样就可以了。

### 主题和外观
* 主题`Bundle 'jnurmine/Zenburn'`
* 状态栏`marvelfans/vim-neatstatus`

### GIT高亮
* 使用vim-gitgutter, 支持vim高亮

### 文件浏览
* 使用了`scrooloose/nerdtree`插件.

### VIM常用使用技巧
#### vimgrep搜索代码
之前一个比较好的办法就是`grep`或`ack-grep`，配合vim去查找，效果当然也不错。
这里主要介绍使用vim快速寻找。

- 命令: vim或vimgrep.
- 用法: vim /str/[gj] [dir]

```
:vim /string/j %   # 当在前文件查找(%)，并跳转到第一个(j)
:vim /string/j *   # 在当前目录下查找所有文件(*)，并跳转到第一个(j)
:vim /string/j **  # 在当前目录及子目录下查找，并跳转到第一个(j)
:vim /string/j % | copen  # 在前当目录下查找，并跳转到第一个。并打开quickfix窗口。
```

#### 标记
跳转除了tags，还可以使用mark, mark是自己添加之后，方便再次跳转回来。
用法:[a-zA-Z0-9']可以是我们用于标记的容器(暂时这么称呼)

- 一个使用场景
在代码的`324`行，有一个方法`function`， 这时候我想去看`function`定义，跳到function之后，再回到这个地方，通过记忆，搜索或其它方式可以跳转回来，但是在没有tags的时候，怎么做呢.

```
m[a-z...]    # 没有:，比如ma, 这样a就标记在了324行
'a           # 同样没有:, 可以回到a这个地方，也就是324行
```
