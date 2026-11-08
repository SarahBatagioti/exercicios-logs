#!/bin/bash

# Eventos de inicialização ficam registrados no arquivo wtmp.
LOG="/var/log/wtmp"

if [[ ! -f "$LOG" ]]; then
    echo "Arquivo $LOG não encontrado."
    exit 1
fi

echo "Última inicialização registrada:"
echo

# -x inclui eventos do sistema.
# -F exibe a data e a hora completas.
# last apresenta os eventos mais recentes primeiro.
# O awk mostra somente o primeiro registro de reboot.
last -x -F -w -f "$LOG" reboot |
    awk '
        $1 == "reboot" {
            print
            encontrado = 1
            exit
        }

        END {
            if (!encontrado)
                print "Nenhum boot registrado no arquivo."
        }
    '