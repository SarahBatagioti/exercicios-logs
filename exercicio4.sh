#!/bin/bash

# Seleciona o log de autenticação.
if [[ -f /var/log/auth.log ]]; then
    LOG="/var/log/auth.log"
elif [[ -f /var/log/secure ]]; then
    LOG="/var/log/secure"
else
    echo "Log de autenticação não encontrado em /var/log."
    exit 1
fi

echo "Logins rejeitados por usuário inexistente ou restrições de acesso:"
echo

# Procura motivos explícitos diferentes de uma simples senha incorreta:
# usuário inexistente, conta bloqueada/expirada e restrições de acesso.
# -i ignora diferenças entre letras maiúsculas e minúsculas.
grep -Ei \
    'invalid user|illegal user|user unknown|unknown user|not allowed|access denied|permission denied|account.*(locked|expired|disabled)|authentication refused|pam_access.*denied' \
    "$LOG" |
    grep -Eiv 'Failed password|incorrect password'

# As linhas completas mantêm a data/hora e o motivo registrado.
# O segundo grep exclui mensagens explícitas de senha incorreta.