#!/bin/bash

# Seleciona o log de autenticação disponível na distribuição.
if [[ -f /var/log/auth.log ]]; then
    LOG="/var/log/auth.log"
elif [[ -f /var/log/secure ]]; then
    LOG="/var/log/secure"
else
    echo "Log de autenticação não encontrado em /var/log."
    exit 1
fi

echo "TENTATIVAS | USUÁRIO"

# O awk extrai o usuário das mensagens de senha incorreta do SSH
# e das falhas de autenticação PAM de outros mecanismos de login.
awk '
/Failed password for / {
    usuario = $0

    # Remove o texto anterior ao nome, incluindo "invalid user", se existir.
    sub(/^.*Failed password for (invalid user )?/, "", usuario)
    sub(/[[:space:]].*$/, "", usuario)

    print usuario
    next
}

/pam_unix\(.*:auth\): authentication failure/ &&
!/sshd/ &&
/user=[^[:space:]]+/ {
    # Ignora mensagens PAM do SSH para não contar o mesmo evento duas vezes.
    usuario = $0
    sub(/^.*user=/, "", usuario)
    sub(/[[:space:]].*$/, "", usuario)

    print usuario
}
' "$LOG" |
    sort |
    uniq -c |
    sort -nr

# sort agrupa os usuários iguais.
# uniq -c conta as ocorrências de cada usuário.
# sort -nr ordena da maior quantidade para a menor.