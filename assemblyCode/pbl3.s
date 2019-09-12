.equ switches, 0x00003010
.equ delay15ms, 0xF424
.equ delay4_1ms, 0x42BB
.equ delay0_1ms, 0x1A0
.equ delay100ms, 0x65B9A
.equ delay0_053ms, 0xDC
.equ delay1s, 0x3F940B
.equ uart1, 0x00003040
.equ uart2, 0x00003038

.global _start

# r2->Switches
# delay -> r8, r9
# r16 -> Escrita na função
# r17 -> instruções do LCD
# r21 -> escrita player one
# r22 -> escrita player two

_start:
	movia r2, switches # Move para r2 o endereço dos switches
	movia r4, uart2 # Move para r4 o endereço base da uart
	movia r5, uart1 # Move para r5 o endereço base da uart
	call initialize_lcd # Chama a função que inicializa o LCD
	call loopMoveBar

loopMoveBar:
	call read_uart1
	movia r18, 0x2
	sll r18, r12, r18
	custom 1, r23, r18, r16
	call read_uart2
	movia r18, 0x2
	sll r18, r12, r18
	custom 1, r23, r18, r16
	# call write_score
	call loopMoveBar

# --------------------------------------------   INICIALIZAÇÃO DO LCD ----------------------------------------------- #
initialize_lcd:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call delay_100ms # Delay de 100ms quando o LCD é ligado
	movia r16, 0x30 # Código que define o function set do LCD
	call delay_0_1ms # Delay de 0.1ms
	movia r17, 0x0 # Código que vai ser armazenado no PINRS, indica que instruções serão enviadas
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Definindo function set do LCD
	call delay_15ms # Delay de 15ms
	custom 0, r23, r17, r16 # Definindo function set do LCD novamente
	call delay_15ms # Delay de 15ms
	custom 0, r23, r17, r16 # Definindo function set do LCD novamente
	call delay_100ms # Delay de 100ms
	movia r16, 0x38 # Function set real do LCD
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Definindo function set real do LCD
	call delay_100ms # Delay de 100ms
	movia r16, 0x08 # Código para desligar o LCD
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Desligando o LCD
	call delay_100ms # Delay de 100ms
	movia r16, 0x01 # Código para limpar LCD
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Limpando o LCD
	call delay_100ms # Delay de 100ms
	movia r16, 0x06 # Código para definir o Entry Mode Set do LCD
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Definindo Entry Mode Set do LCD
	call delay_0_053ms # Delay de 0.053ms
	movia r16, 0x0C # Código para ligar o LCD
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Ligando o LCD
	call delay_0_053ms # Delay de 0.53ms
	movia r17, 0x1 # Mudando PINRS para envio de dados
	call delay_4_1ms # Delay de 4.1ms
	movia r16, 0x58
	call delay_4_1ms
	custom 0, r23, r17, r16 # Envia dado armazenado em R16 para ser escrito
	call delay_0_053ms # Delay de 0.053ms
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label

# -------------------------------------------------  FUNÇÕES DE DELAY --------------------------------------------------- #

delay_15ms:
	movia r8, delay15ms # Armazena o valor usado para o delay de 15ms em r8
	loop15ms:
		addi r9, r9, 1 # Adiciona 1 no registrador r9
		bne r9, r8, loop15ms # Verifica se r9 armazena mesmo valor que r8 (se não, volta pro início do looping)
		addi r9, r0, 0 # Zera o registrador r9
	ret

delay_4_1ms:
	movia r8, delay4_1ms # Armazena o valor usado para o delay de 4.1ms em r8
	loop4_1ms:
		addi r9, r9, 1 # Adiciona 1 no registrador r9
		bne r9, r8, loop4_1ms # Verifica se r9 armazena mesmo valor que r8 (se não, volta pro início do looping)
		addi r9, r0, 0 # Zera o registrador r9
	ret

delay_0_1ms:
	movia r8, delay0_1ms # Armazena o valor usado para o delay de 0.1ms em r8
	loop0_1ms:
		addi r9, r9, 1 # Adiciona 1 no registrador r9
		bne r9, r8, loop0_1ms # Verifica se r9 armazena mesmo valor que r8 (se não, volta pro início do looping)
		addi r9, r0, 0 # Zera o registrador r9
	ret

delay_100ms:
	movia r8, delay100ms # Armazena o valor usado para o delay de 100ms em r8
	loop100ms:
		addi r9, r9, 1 # Adiciona 1 no registrador r9
		bne r9, r8, loop100ms # Verifica se r9 armazena mesmo valor que r8 (se não, volta pro início do looping)
		addi r9, r0, 0 # Zera o registrador r9
	ret

delay_1s:
	movia r8, delay1s # Armazena o valor usado para o delay de 1s em r8
	loop1s:
		addi r9, r9, 1 # Adiciona 1 no registrador r9
		bne r9, r8, loop1s # Verifica se r9 armazena mesmo valor que r8 (se não, volta pro início do looping)
		addi r9, r0, 0 # Zera o registrador r9
	ret

delay_0_053ms:
	movia r8, delay0_053ms # Armazena o valor usado para o delay de 0.053ms em r8
	loop0_053ms:
		addi r9, r9, 1 # Adiciona 1 no registrador r9
		bne r9, r8, loop0_053ms # Verifica se r9 armazena mesmo valor que r8 (se não, volta pro início do looping)
		addi r9, r0, 0 # Zera o registrador r9
	ret

# ---------------------------------------------   ALTERNÂNCIA ENTRE LINHAS -------------------------------------------------- #
line_one: # Muda o cursor do display para a primeira linha
	movia r17, 0x0 # Mudando PINRS para envio de instruções
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call delay_4_1ms # Delay de 4.1ms
	movia r16, 0x80 # Código para mudar cursor para primeira linha
	call delay_4_1ms # Delay de 4.1ms
	custom 0, r23, r17, r16 # Mudando cursor para primeira linha
	call delay_100ms # Delay de 100ms
	movia r17, 0x1 # Mudando PINRS para envio de dados
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label


line_two: # Muda o cursor do display para a segunda linha
	movia r17, 0x0 # Mudando PINRS para envio de instruções
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call delay_4_1ms # Delay de 4.1ms
	movia r16, 0xC0 # Código para mudar cursor para segunda linha
	call delay_4_1ms # Delay de 4.1ms
	custom 0, r23, r17, r16 # Mudando cursor para segunda linha
	call delay_100ms # Delay de 100ms
	movia r17, 0x1 # Mudando PINRS para envio de dados
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label


line_three: # Muda o cursor do LCD para o terceira linha
	movia r17, 0x0 # Mudando PINRS para envio de instruções
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call delay_4_1ms # Delay de 4.1ms
	movia r16, 0x94 # Código para mudar cursor para terceira linha
	call delay_4_1ms # Delay de 4.1ms
	custom 0, r23, r17, r16 # Mudando cursor para terceira linha
	call delay_100ms # Delay de 100ms
	movia r17, 0x1 # Mudando PINRS para envio de dados
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label


line_four: # Muda o cursor do lcd para a quarta linha do display
	movia r17, 0x0 # Mudando PINRS para envio de instruções
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call delay_4_1ms # Delay de 4.1ms
	movia r16, 0xD4 # Código para mudar cursor para quarta linha
	call delay_4_1ms # Delay de 4.1ms
	custom 0, r23, r17, r16 # Mudando cursor para quarta linha
	call delay_100ms # Delay de 100ms
	movia r17, 0x1 # Mudando PINRS para envio de dados
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label

# -------------------------------------------------  LIMPA O DISPLAY --------------------------------------------------- #
clear_lcd:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	movia r17, 0x0 # Mudando PINRS para envio de instruções
	movia r16, 0x01 # Código para limpar LCD
	call delay_0_053ms # Delay de 0.053ms
	custom 0, r23, r17, r16 # Limpando LCD
	movia r17, 0x1 # Mudando PINRS para envio de dados
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label

	# ----------------------------------------------  ESCREVE O QUE HÁ EM R16 NO LCD ------------------------------------------------- #
write:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	custom 0, r23, r17, r16 # Envia dado armazenado em R16 para ser escrito
	call delay_0_053ms # Delay de 0.053ms
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label


# -------------- Escreve o placar no LCD ----------------#
write_score:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	mov r24, r23
	call clear_lcd
	call line_one
	movia r21, 0x2
	sra r16, r24, r21 # Placar do jogador 1
	call chooseHex
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x58 # Caractere X
	call write # Escreve o valor armazenado no registrador de r16
	movia r21, 0x1E
	sll r16, r24, r21
	sra r16, r16, r21 # Placar do jogador 2
	call chooseHex
	call write # Escreve o valor armazenado no registrador de r16
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label

chooseHex:
	movia r7, 0x1
	beq r16, r7, umPonto
	movia r7, 0x2
	beq r16, r7, doisPontos
	movia r7, 0x3
	beq r16, r7, tresPontos
	movia r16, 0x30
	ret
	umPonto:
		movia r16, 0x31
		ret
	doisPontos:
		movia r16, 0x32
		ret
	tresPontos:
		movia r16, 0x33
		ret

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
