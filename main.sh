#!/bin/bash

# 定义压缩包 URL
ZIP_URL="https://github.com/EthanCarterPromise/Serv00-Bash-Tools/archive/refs/heads/master.zip"
TARGET_DIR="$HOME/Serv00-Bash-Tools"  # 使用 $HOME 确保路径正确
MODULES_DIR="$TARGET_DIR/Serv00-Bash-Tools-master/modules"  # 解压后的模块路径

# 检查并创建目标目录
if [ ! -d "$TARGET_DIR" ]; then
    echo "创建目标目录: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
fi

# 下载压缩包
download_and_extract() {
    echo "正在下载压缩包..."
    if command -v wget &> /dev/null; then
        wget -O "$TARGET_DIR/master.zip" "$ZIP_URL"
    elif command -v curl &> /dev/null; then
        curl -o "$TARGET_DIR/master.zip" "$ZIP_URL"
    else
        echo "错误：未找到 wget 或 curl，请安装其中之一。"
        exit 1
    fi

    # 解压压缩包
    echo "正在解压压缩包..."
    unzip -q "$TARGET_DIR/master.zip" -d "$TARGET_DIR"
    rm "$TARGET_DIR/master.zip"  # 删除压缩包
    echo "压缩包已解压到 $TARGET_DIR。"
}

# 检查模块目录是否存在
if [ ! -d "$MODULES_DIR" ]; then
    echo "未找到模块目录，正在下载并解压模块..."
    download_and_extract
fi

# 显示菜单函数
show_menu() {
    clear
    echo "╔────────────────────────────────────────────────╗"
    echo "│   Serv00 环境配置管理脚本                       │"
    echo "│   0. 退出脚本                                   │"
    echo "│────────────────────────────────────────────────│"
    echo "│   1. 安装环境配置                               │"
    echo "│   2. 更新环境配置                               │"
    echo "│   3. 查看当前配置                               │"
    echo "│   4. 加载配置文件                               │"
    echo "╚────────────────────────────────────────────────╝"
}

# 主循环
while true; do
    show_menu
    read -p "请输入您的选择 [0-4]: " choice

    case $choice in
        0)
            echo "退出脚本。"
            break
            ;;
        1)
            echo "正在安装环境配置..."
            "$MODULES_DIR/setup_environment.sh"
            ;;
        2)
            echo "正在更新环境配置..."
            # 这里可以添加更新逻辑
            echo "更新功能尚未实现。"
            ;;
        3)
            echo "当前配置如下："
            echo "----------------------------------------"
            cat ~/.bashrc ~/.bash_profile ~/.profile 2>/dev/null
            echo "----------------------------------------"
            read -p "按 Enter 键继续..."
            ;;
        4)
            echo "正在加载配置文件..."
            source ~/.profile
            source ~/.bash_profile
            source ~/.bashrc
            echo "配置文件已加载。"
            read -p "按 Enter 键继续..."
            ;;
        *)
            echo "无效的选择，请输入 0 到 4 之间的数字。"
            read -p "按 Enter 键继续..."
            ;;
    esac
done
