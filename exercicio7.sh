#!/bin/bash

# O wtmp registra eventos de boot e desligamento.
LOG="/var/log/wtmp"

if [[ ! -f "$LOG" ]]; then
    echo "Arquivo $LOG não encontrado."
    exit 1
fi

echo "Eventos registrados de desligamento e inicialização:"
echo

# last -x inclui eventos do sistema.
# -F mostra os horários completos.
# O awk seleciona registros identificados como shutdown ou reboot.
last -x -F -w -f "$LOG" |
    awk '$1 == "shutdown" || $1 == "reboot" { print }'

# shutdown indica um desligamento registrado.
# reboot indica um boot; ele também pode ocorrer após ligar a máquina.
# Uma interrupção abrupta de energia pode não gerar registro de shutdown.