#!/bin/bash

# 設定發生錯誤時停止執行
set -e

echo "🚀 開始建置開發環境..."

# 偵測作業系統
OS="$(uname -s)"
echo "🖥️  偵測到的作業系統: $OS"

# ==========================================
# macOS (Darwin) 環境建置
# ==========================================
if [ "$OS" == "Darwin" ]; then
    echo "🍎 開始 macOS 環境設定..."
    
    # 檢查是否安裝 Homebrew
    if ! command -v brew &> /dev/null; then
        echo "🍺 正在安裝 Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    echo "📦 透過 Homebrew 安裝必備工具..."
    brew update
    brew install git curl wget tree htop tmux
    
    echo "🐳 安裝 Docker & Kubernetes 工具..."
    brew install --cask docker
    brew install kubectl

    echo "🐍 安裝 Python 與環境管理..."
    brew install python3
    
    echo "📝 安裝 LaTeX 環境 (MacTeX)..."
    # 使用 basictex 比較輕量，若空間夠可改裝 mactex
    brew install --cask mactex-no-gui
    eval "$(/usr/libexec/path_helper)"
    sudo tlmgr update --self
    sudo tlmgr install latexmk xecjk fontspec

# ==========================================
# Linux (Ubuntu/Debian) 環境建置
# ==========================================
elif [ "$OS" == "Linux" ]; then
    echo "🐧 開始 Linux 環境設定..."
    
    echo "📦 更新 APT 套件庫並安裝必備工具..."
    sudo apt-get update
    sudo apt-get install -y git curl wget tree htop tmux build-essential software-properties-common

    echo "🐳 安裝 Docker..."
    if ! command -v docker &> /dev/null; then
        curl -fsSL https://get.docker.com -o get-docker.sh
        sudo sh get-docker.sh
        sudo usermod -aG docker $USER
        rm get-docker.sh
    fi

    echo "☸️ 安裝 Kubernetes (kubectl)..."
    if ! command -v kubectl &> /dev/null; then
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
        rm kubectl
    fi

    echo "🐍 安裝 Python 與 pip..."
    sudo apt-get install -y python3 python3-pip python3-venv

    echo "📝 安裝 LaTeX 與字型環境 (包含論文所需字型)..."
    # 自動同意微軟字型授權，避免腳本卡住
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
    sudo apt-get install -y \
        latexmk \
        texlive-xetex \
        texlive-lang-chinese \
        texlive-fonts-recommended \
        texlive-fonts-extra \
        ttf-mscorefonts-installer \
        fonts-cwtex-kai \
        fonts-cwtex-ming \
        fonts-cwtex-heib \
        fonts-cwtex-yen
        
    echo "🔄 更新系統字型快取..."
    fc-cache -fv

else
    echo "❌ 尚未支援此作業系統: $OS"
    exit 1
fi

# ==========================================
# 跨平台共通設定 (Python 數據視覺化與網頁框架)
# ==========================================
echo "📦 安裝 Python 核心數據套件..."
# 確保 pip 是最新版
python3 -m pip install --upgrade pip --break-system-packages || python3 -m pip install --upgrade pip
# 安裝你常用的分析與儀表板套件
python3 -m pip install plotly pandas dash --break-system-packages || python3 -m pip install plotly pandas dash

echo "🎉 環境建置完成！"
echo "👉 溫馨提醒："
if [ "$OS" == "Linux" ]; then
    echo "  1. 為了讓 Docker 免 sudo 執行生效，請『登出並重新登入』或執行 'su - \$USER'。"
fi
echo "  2. LaTeX 環境和中文字型已經安裝完畢，可以直接編譯你的論文了！"