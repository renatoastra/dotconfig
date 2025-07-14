#!/bin/bash

# --- Configurações ---
BREW_PREFIX="/opt/homebrew" # Para Apple Silicon. Use /usr/local para Intel.

# Caminho para os arquivos de lista de pacotes
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd) # Pega o diretório onde o script está
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
BREW_PACKAGES_FILE="$REPO_ROOT/brew/brew_packages.txt"
BREW_CASKS_FILE="$REPO_ROOT/brew/brew_casks.txt"

# --- Funções Auxiliares ---

# Verifica se o Homebrew está instalado
check_homebrew() {
  if ! command -v brew &>/dev/null; then
    echo "Homebrew não encontrado. Instalando Homebrew..."
    /bin/bash -c "$(curl -sSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Adiciona o Homebrew ao PATH para a sessão atual
    if [ -d "$BREW_PREFIX/bin" ]; then
      export PATH="$BREW_PREFIX/bin:$PATH"
    fi
    echo "Homebrew instalado com sucesso."
  else
    echo "Homebrew já está instalado."
  fi
}

# Instala um pacote se ele ainda não estiver instalado
install_package() {
  local package_name=$1
  if brew list --formula | grep -q "^$package_name\$"; then
    echo "✅ $package_name já está instalado."
  else
    echo "📦 Instalando $package_name..."
    brew install "$package_name"
    if [ $? -eq 0 ]; then
      echo "✨ $package_name instalado com sucesso!"
    else
      echo "❌ Falha ao instalar $package_name. Verifique os logs."
    fi
  fi
}

# Instala um cask se ele ainda não estiver instalado
install_cask() {
  local cask_name=$1
  if brew list --cask | grep -q "^$cask_name\$"; then
    echo "✅ $cask_name (Cask) já está instalado."
  else
    echo "📦 Instalando $cask_name (Cask)..."
    brew install --cask "$cask_name"
    if [ $? -eq 0 ]; then
      echo "✨ $cask_name (Cask) instalado com sucesso!"
    else
      echo "❌ Falha ao instalar $cask_name (Cask). Verifique os logs."
    fi
  fi
}

# --- Execução Principal ---

echo "Iniciando instalação de utilitários..."

# 1. Verifica e instala o Homebrew
check_homebrew

# 2. Atualiza o Homebrew antes de instalar novos pacotes
echo "Atualizando Homebrew..."
brew update
brew upgrade

# 3. Instala os pacotes listados em brew_packages.txt
if [ -f "$BREW_PACKAGES_FILE" ]; then
  echo "Instalando pacotes de linha de comando..."
  while IFS= read -r package || [[ -n "$package" ]]; do
    # Ignora linhas vazias e comentários
    if [[ -n "$package" && ! "$package" =~ ^# ]]; then
      install_package "$package"
    fi
  done <"$BREW_PACKAGES_FILE"
else
  echo "Arquivo $BREW_PACKAGES_FILE não encontrado. Nenhum pacote de linha de comando será instalado."
fi

# 4. Instala os Casks listados em brew_casks.txt
if [ -f "$BREW_CASKS_FILE" ]; then
  echo "Instalando Casks (aplicativos GUI)..."
  while IFS= read -r cask || [[ -n "$cask" ]]; do
    # Ignora linhas vazias e comentários
    if [[ -n "$cask" && ! "$cask" =~ ^# ]]; then
      install_cask "$cask"
    fi
  done <"$BREW_CASKS_FILE"
else
  echo "Arquivo $BREW_CASKS_FILE não encontrado. Nenhum Cask será instalado."
fi

# 5. Pós-instalação para fzf
# Embora fzf esteja na lista, a mensagem de pós-instalação é específica e útil.
if brew list --formula | grep -q "^fzf\$"; then
  echo "Configurando fzf para Fish..."
  echo "Lembre-se de adicionar as key-bindings do fzf ao seu config.fish se ainda não o fez."
  echo "Exemplo: fzf --fish | source"
fi

echo "Instalação de utilitários concluída!"
