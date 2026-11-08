#!/bin/bash

# Seleciona o log de autenticação do sistema.
if [[ -f /var/log/auth.log ]]; then
    LOG="/var/log/auth.log"
elif [[ -f /var/log/secure ]]; then
    LOG="/var/log/secure"
else
    echo "Log de autenticação não encontrado em /var/log."
    exit 1
fi

echo "Uso do sudo — data/hora, usuário e comando:"
echo

# A expressão regular encontra registros do sudo com COMMAND=.
# Isso evita listar mensagens de abertura e fechamento da mesma sessão.
grep -E 'sudo(\[[0-9]+\])?:.*COMMAND=' "$LOG"

# A linha original preserva a data/hora, o usuário que chamou sudo,
# o usuário de destino e o comando registrado.