#!/bin/bash

# 获取当前用户名
CURRENT_USER=$(whoami)

# 定义目标目录
TARGET_DIR="/home/$CURRENT_USER"

# 检查当前目录是否是目标目录
if [ "$(pwd)" != "$TARGET_DIR" ]; then
    echo "当前目录不是 $TARGET_DIR，正在切换到 $TARGET_DIR ..."
    cd "$TARGET_DIR" || { echo "切换目录失败，请检查路径是否正确。"; exit 1; }
    echo "已切换到 $TARGET_DIR。"
fi

# 任务一：创建并写入 ~/.bashrc
cat > ~/.bashrc <<EOF
# ~/.bashrc - Bash 交互式 Shell 配置文件

# 设置中文 UTF-8 语言环境
export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8

# 添加一些别名（可选）
alias ll='ls -alh --color=auto'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

EOF
echo "~/.bashrc 文件已创建并写入内容。"

# 任务二：创建并写入 ~/.bash_profile
cat > ~/.bash_profile <<EOF
# ~/.bash_profile - Bash 登录 Shell 配置文件

# 让 Bash 读取 .bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

EOF
echo "~/.bash_profile 文件已创建并写入内容。"

# 任务三：创建并写入 ~/.profile
cat > ~/.profile <<EOF
# ~/.profile - 用户环境配置文件

# 设置默认语言环境为中文 UTF-8
export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8

# 如果 Bash 存在，则使用 Bash
if [ -x /usr/local/bin/bash ]; then
    exec /usr/local/bin/bash
fi

EOF
echo "~/.profile 文件已创建并写入内容。"

# 任务四：加载配置文件
source ~/.profile
source ~/.bash_profile
source ~/.bashrc
echo "配置文件已加载。"

# 提示用户脚本执行完毕
echo "所有任务执行完毕。"
