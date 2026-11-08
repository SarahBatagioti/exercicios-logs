#!/bin/bash

# Este script utiliza o journal do systemd.
# Quando persistente, ele é armazenado em /var/log/journal.
# Neste exercício, "recentemente" significa os últimos sete dias.

if ! command -v journalctl > /dev/null 2>&1; then
    echo "Este script requer Linux com systemd e journalctl."
    exit 1
fi

echo "Serviços iniciados ou parados nos últimos sete dias:"
echo

# --since limita o período analisado.
# _PID=1 seleciona mensagens do gerenciador systemd.
# --output=short-iso apresenta data/hora em formato ISO.
# --no-pager imprime o resultado diretamente no terminal.
# LC_ALL=C solicita as mensagens de apresentação em inglês.
LC_ALL=C journalctl \
    --since "7 days ago" \
    _PID=1 \
    --output=short-iso \
    --no-pager |
    grep -E 'systemd\[1\]: (Started|Stopped) '

# A expressão regular seleciona eventos concluídos de início ou parada.
# Cada linha mantém a data/hora e o nome ou a descrição do serviço.