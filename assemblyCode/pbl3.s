.equ uart1, 0x00003050
.equ uart2, 0x00003048
.equ uart3, 0x00003040

.global _start

# delay -> r8, r9
# r16 -> Escrita na função
# r17 -> instruções do LCD
# r21 -> escrita player one
# r22 -> escrita player two

_start:
	movia r4, uart2 # Move para r4 o endereço base da uart
	movia r5, uart1 # Move para r5 o endereço base da uart
	movia r6, uart3 # Move para r6 o endereço base da uart
	call loopMoveBar

loopMoveBar:
	call read_uart1
	movia r18, 0x2
	sll r18, r12, r18
	custom 1, r23, r18, r16
	mov r10, r23
	call write_uart3
	call read_uart2
	movia r18, 0x2
	sll r18, r12, r18
	custom 1, r23, r18, r16
	mov r10, r23
	call write_uart3
	call loopMoveBar

# ------------------------------------------ LÊ r12 DA UART --------------------------------------------------------------------------- #
read_uart1:
	get_char:
		ldwio r12, 0(r5) # Lê o registrador de dados do JTAG UART, armazenado em r5
		andi r13, r12, 0x8000 # Checa se chegou algum dado novo
		beq r13, r0, get_char # Se não chegou, irá tentar ler novamente
	andi r13, r12, 0x00ff # O dado novo estará no bit menos significativo
	mov r12, r13 # Coloco em r12 o dado que preciso retornar
	ret

read_uart2:
	get_char2:
		ldwio r12, 0(r4) # Lê o registrador de dados do JTAG UART, armazenado em r5
		andi r13, r12, 0x8000 # Checa se chegou algum dado novo
		beq r13, r0, get_char2 # Se não chegou, irá tentar ler novamente
	andi r13, r12, 0x00ff # O dado novo estará no bit menos significativo
	mov r12, r13 # Coloco em r12 o dado que preciso retornar
	ret

write_uart3:
	put_char:
		ldwio r22, 4(r6) # Lê o registrador de controle do JTAG UART, armazenado em r6
		andhi r22, r22, 0x00ff # Checa se existe espaço pra escrever
		beq r22, r0, put_char # Se não há espaço, não escreve e tenta escrever novamente
	stwio r10, 0(r6) # Se há espaço, manda o caractere
	ret
