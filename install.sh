#!/bin/sh
# Script para criar links simbólicos do repositório de dotfiles para a pasta ~/.config
# Compatível com sh, bash e zsh.

# Encontra o diretório absoluto onde o script está localizado de forma portável.
REPO_DIR=$(cd "$(dirname "$0")" && pwd)
CONFIG_DIR="$HOME/.config"

# Lista das pastas de configuração a serem linkadas (string separada por espaços).
# Adicione novos itens aqui no futuro.
DIRS_TO_LINK="nvim tmux mise"

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

echo "Configuração concluída! Todos os links foram criados." 