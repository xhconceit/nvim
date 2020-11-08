
# 检查 neovim 配置问题

执行 `:checkhealth` 检查配置问题

## Clipboard (optional)

报错：

```
## Clipboard (optional)
  - WARNING: No clipboard tool found. Clipboard registers (`"+` and `"*`) will not work.
    - ADVICE:
      - :help clipboard


```

解决：

```shell
sudo pacman -S clipmenu
```

## Python 2 provider (optional)

报错：

```
## Python 2 provider (optional)
  - WARNING: No Python executable found that can `import neovim`. Using the first available executable for diagnostics.
  - ERROR: Python provider error:
    - ADVICE:
      - provider/pythonx: Could not load Python 2:
          python2 not found in search path or not executable.
          python2.7 not found in search path or not executable.
          python2.6 not found in search path or not executable.
          /usr/bin/python is Python 3.8 and cannot provide Python 2.
  - INFO: Executable: Not found
```

解决：

```shell
sudo pacman -S python2
sudo pacman -S python2-pip
pip2 install pynvim
pip2 install neovim
```

设置 python2 安装位置

```vim
let g:python_host_prog=/usr/bin/python2
```

## Python 3 provider (optional)

报错：

```
## Python 3 provider (optional)
  - WARNING: No Python executable found that can `import neovim`. Using the first available executable for diagnostics.
  - ERROR: Python provider error:
    - ADVICE:
      - provider/pythonx: Could not load Python 3:
          /usr/bin/python3 does not have the "neovim" module. :help provider-python
          python3.7 not found in search path or not executable.
          python3.6 not found in search path or not executable.
          python3.5 not found in search path or not executable.
          python3.4 not found in search path or not executable.
          python3.3 not found in search path or not executable.
          /usr/bin/python does not have the "neovim" module. :help provider-python
  - INFO: Executable: Not found
```

解决：

```shell
sudo pacman -S python
sudo pacman -S python-pip
pip install pynvim
pip install neovim
```

设置 python3 安装位置

```vim
let g:python3_host_prog = "/usr/bin/python3"
```

## Ruby provider (optional)

报错：

```
## Ruby provider (optional)
  - WARNING: `neovim-ruby-host` not found.
    - ADVICE:
    - Run `gem install neovim` to ensure the neovim RubyGem is installed.
    - Run `gem environment` to ensure the gem bin directory is in $PATH.
    - If you are using rvm/rbenv/chruby, try "rehashing".
    - See :help g:ruby_host_prog for non-standard gem installations.
```

解决：

```shell
sudo pacman -S ruby	# 安装 ruby
gem sources --remove https://rubygems.org/	# 移除 https://rubygems.org/ 源
gem sources -a https://gems.ruby-china.com/	#设置国内镜像源 https://gems.ruby-china.com/
gem install neovim
```

设置 neovim-ruby-host 安装位置

```
let g:ruby_host_prog = '~/.gem/ruby/2.7.0/bin/neovim-ruby-host'
```

