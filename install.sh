#!/bin/sh
# Script para criar links simbólicos do repositório de dotfiles para a pasta ~/.config
# Compatível com sh, bash e zsh.

# Encontra o diretório absoluto onde o script está localizado de forma portável.
REPO_DIR=$(cd "$(dirname "$0")" && pwd)
CONFIG_DIR="$HOME/.config"

# Lista das pastas de configuração a serem linkadas (string separada por espaços).
# Adicione novos itens aqui no futuro.
DIRS_TO_LINK="nvim tmux mise ghostty fish hammerspoon"

echo "Iniciando a configuração dos dotfiles..."
echo "Diretório do repositório: $REPO_DIR"
echo "Diretório de configuração do sistema: $CONFIG_DIR"
echo "---"

# Garante que a pasta ~/.config exista.
mkdir -p "$CONFIG_DIR"

# Itera sobre a lista de pastas e cria os links.
for dir in $DIRS_TO_LINK; do
  source_path="$REPO_DIR/$dir"
  target_path="$CONFIG_DIR/$dir"

  echo "Processando '$dir'..."

  # Se um arquivo ou link com o mesmo nome já existir no destino, faz um backup.
  if [ -e "$target_path" ] || [ -L "$target_path" ]; then
    backup_path="${target_path}.bak"
    echo "  -> Encontrado '$target_path'. Fazendo backup para '$backup_path'."
    # Remove um backup antigo se existir, para evitar erros.
    rm -rf "$backup_path"
    mv "$target_path" "$backup_path"
  fi

  # Cria o link simbólico.
  echo "  -> Criando link simbólico: $target_path -> $source_path"
  ln -s "$source_path" "$target_path"
  echo "  -> Link para '$dir' criado com sucesso."
  echo "---"
done

# Linka o gitconfig
GITCONFIG_SOURCE="$REPO_DIR/git-config"
GITCONFIG_TARGET="$HOME/.gitconfig"
echo "Processando 'git-config'..."
if [ -e "$GITCONFIG_TARGET" ] || [ -L "$GITCONFIG_TARGET" ]; then
    backup_path="${GITCONFIG_TARGET}.bak"
    echo "  -> Encontrado '$GITCONFIG_TARGET'. Fazendo backup para '$backup_path'."
    # Remove um backup antigo se existir, para evitar erros.
    rm -rf "$backup_path"
    mv "$GITCONFIG_TARGET" "$backup_path"
fi
echo "  -> Criando link simbólico: $GITCONFIG_TARGET -> $GITCONFIG_SOURCE"
ln -s "$GITCONFIG_SOURCE" "$GITCONFIG_TARGET"
echo "  -> Link para 'git-config' criado com sucesso."
echo "---"

echo "Configuração dos links simbólicos concluída."
echo ""

# --- Copia Scripts para ~/.local/bin ---
echo "Iniciando a cópia de scripts para o diretório de usuário..."
SCRIPTS_SOURCE_DIR="$REPO_DIR/.scripts"
SCRIPTS_TARGET_DIR="$HOME/.local/bin"

# Garante que o diretório de destino exista
mkdir -p "$SCRIPTS_TARGET_DIR"
echo "  -> Diretório de destino '$SCRIPTS_TARGET_DIR' pronto."

# Itera sobre os scripts no diretório de origem e os copia
for script_file in "$SCRIPTS_SOURCE_DIR"/*; do
    if [ -f "$script_file" ]; then
        script_name=$(basename "$script_file")
        target_file="$SCRIPTS_TARGET_DIR/$script_name"
        
        echo "  -> Copiando '$script_name'..."
        cp "$script_file" "$target_file"
        
        echo "  -> Tornando '$script_name' executável..."
        chmod +x "$target_file"
    fi
done
echo "Cópia de scripts concluída."
echo "---"


echo "Iniciando a instalação de ferramentas via Homebrew..."

# Executa o script de instalação de ferramentas
if [ -f "$REPO_DIR/scripts/install_tools.sh" ]; then
  /bin/bash "$REPO_DIR/scripts/install_tools.sh"
else
  echo "AVISO: Script de instalação de ferramentas não encontrado em 'scripts/install_tools.sh'."
fi

echo ""
echo "Configuração geral concluída!"