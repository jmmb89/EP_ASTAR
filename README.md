# Programa A*

## Dependencias:

Requer Lua 5.3 ou superior
(se nao tiver instalado, rodar o bat (win) ou shell script (UNIX))

Windows:
- Rodar o win.bat

GNU/Linux e Mac
- Rodar o shell script

chmod +x start.sh \
./start.sh

o script baixa, descompacta, e compila o source do Lua,  bem rapido e leve. (menos de 1MB) \
requer: bash, curl, tar, make. acredito que todos venham instalado por padrao no mac.

se tiver lua instalado pode rodar o script ou o arquivo main.lua direto (o script detecta se voce tem instalado ou ja compilou pelo script e escolhe o binario, dando preferencia ao do sistema.)

-Caso nada disso de certo: \
Vou incluir o binario na pasta bin, entao basta rodar: \
chmod +x start.sh \
./start.sh bin

## Porque Lua?

Escolhemos fazer o trabalho em Lua porque é uma linguagem criada por um brasileiro (PUC-RIO).
Linguagem pouco conhecida e pouco utilizada, porém extremamente verbal, flexivel, eficiente e leve.
Outro ponto para a escolha é a estrutura de dados "Tables" que a linguagem possui, um tipo de "array" flexivel, que permite ser utilizada como
um dicionário, lista, matriz e que também possui diversas funções para trabalhar os dados.

Mais sobre a linguagem Lua: https://www.lua.org/portugues.html#oque

## Alunos:

- Joao Mario Motidome Barradas
- Kauê Sales Barbosa de Sousa
- Leandro Borges de Moura
