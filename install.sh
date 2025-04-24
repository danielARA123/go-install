#!/bin/bash

# Define a versão e o diretório de instalação
GO_VERSION="1.24.2"
INSTALL_DIR="$HOME/go"
TAR_FILE="go${GO_VERSION}.linux-amd64.tar.gz"
DOWNLOAD_URL="https://go.dev/dl/${TAR_FILE}"

echo "Instalando Go $GO_VERSION em $INSTALL_DIR"

# Remove instalação anterior, se existir
rm -rf "$INSTALL_DIR"

# Baixa o tarball
wget "$DOWNLOAD_URL" -O "/tmp/${TAR_FILE}"

# Cria o diretório e extrai o conteúdo removendo o primeiro nível da pasta
mkdir -p "$INSTALL_DIR"
tar -C "$INSTALL_DIR" --strip-components=1 -xzf "/tmp/${TAR_FILE}"

# Detecta shell e adiciona as variáveis de ambiente
if [ -n "$ZSH_VERSION" ]; then
    SHELL_RC="$HOME/.zshrc"
else
    SHELL_RC="$HOME/.bashrc"
fi

# Adiciona configs ao shell rc
{
    echo ""
    echo "# Configurações do GoLang"
    echo "export GOROOT=\"$INSTALL_DIR\""
    echo "export GOPATH=\"\$HOME/go_projects\""
    echo "export PATH=\"\$GOROOT/bin:\$GOPATH/bin:\$PATH\""
} >> "$SHELL_RC"

echo "✅ Go $GO_VERSION instalado com sucesso!"
echo "📁 Diretório de instalação: $INSTALL_DIR"
echo "⚙️  Variáveis adicionadas em: $SHELL_RC"
echo "🔁 Execute 'source $SHELL_RC' ou reinicie o terminal pra aplicar as configs"
