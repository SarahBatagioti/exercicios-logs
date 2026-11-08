# Exercício Análise de Logs Internos do Sistema

## Instruções para solução dos exercícios

Para cada desafio, você deve:

1. Identificar qual arquivo de log em `/var/log` é o mais apropriado para a tarefa.
2. Criar um script shell que resolva o problema.
3. Utilizar comandos do Linux (`grep`, `awk`, `sort`, `uniq`, etc.) e Expressões Regulares (Regex) para filtrar e manipular os dados.
4. Comentar o script, explicando o raciocínio utilizado da aplicação de cada comando/solução.

## Tentativas de Senha Incorreta

**1.** Crie um script que liste todos os usuários que tentaram fazer login com a senha incorreta. O script deve mostrar o nome do usuário e o número de tentativas de login falhas para cada um.

**2.** Crie um script que gere um relatório de todos os logins bem-sucedidos no sistema, incluindo o nome do usuário e a data/hora do acesso.

**3.** Crie um script para auditar o uso do sudo. O resultado deve incluir o usuário que executou o comando sudo e a data/hora do evento.

**4.** Crie um script para identificar logins que foram rejeitados por outros motivos além da senha incorreta, como usuários inexistentes ou falta de permissão.

## Análise de Atividade do Sistema

**6.** Quando o sistema foi inicializado pela última vez? Crie um script que mostre a data e a hora do último boot.

**7.** Crie um script que encontre e liste todos os eventos de desligamento (shutdown) ou reinicialização do sistema.

**8.** Verifique se algum serviço (service) foi iniciado ou parado recentemente. Crie um script que liste a data e o nome dos serviços que tiveram seu status alterado.