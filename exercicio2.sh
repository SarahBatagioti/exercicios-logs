#!/bin/bash

# O wtmp registra sessões de login e pode ser consultado com last.
LOG="/var/log/wtmp"

if [[ ! -f "$LOG" ]]; then
    echo "Arquivo $LOG não encontrado."
    exit 1
fi

echo "Relatório de logins bem-sucedidos:"
echo

# -f seleciona o arquivo.
# -F mostra datas e horários completos de entrada e saída.
# -w evita truncar os nomes dos usuários.
# O awk remove linhas vazias, eventos de boot e o rodapé.
last -F -w -f "$LOG" |
    awk '
        NF == 0 { next }
        $1 == "reboot" { next }
        $1 == "shutdown" { next }
        $1 == "runlevel" { next }
        $1 == "wtmp" { next }
        { print }
    '

# Cada linha contém usuário, terminal, origem e data/hora do login.
# As informações de logout e duração também são preservadas.