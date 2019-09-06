.equ switches, 0x00003030
.equ delay15ms, 0xF424
.equ delay4_1ms, 0x42BB
.equ delay0_1ms, 0x1A0
.equ delay100ms, 0x65B9A
.equ delay0_053ms, 0xDC
.equ delay1s, 0x3F940B

.global _start

# r2->Switches
# r4 -> carrega o valor de botões
# delay -> r8, r9
# r11 -> contador
# r16 -> Escrita na função
# r17 -> instruções do LCD
# r18 -> comparação de valores
# r21 -> escrita player one
# r22 -> escrita player two

_start:
	movia r2, switches # Move para r2 o endereço dos switches
	movia r16, 0x0
	movia r14, 0x7
	movia r20, 0xB
	movia r10, 0xD
	movia r12, 0xE
	call loopMoveBar
#	call turn_led_off # Chama a função que desligará todos os leds
#	call set_constants # Chama a função que seta as constantes para os delays utilizados
#	call initialize_lcd # Chama a função que inicializa o LCD

loopMoveBar:
	ldbio r3, 0(r2)
	beq r3, r14, moveUpBar1
	beq r3, r20, moveDownBar1
	beq r3, r10, moveUpBar2
	beq r3, r12, moveDownBar2
	call loopMoveBar

moveUpBar1:
	# Subir/Descer barra | barra para mover | quantidade p mover
	#					0										0								000001010
	movia r17, 0x80a
	custom 1, r23, r17, r16
	call loopMoveBar

moveDownBar1:
	# Subir/Descer barra | barra para mover | quantidade p mover
	#					1										0								000001010
	movia r17, 0xc0a
	custom 1, r23, r17, r16
	call loopMoveBar

moveUpBar2:
	# Subir/Descer barra | barra para mover | quantidade p mover
	#					0										1								000001010
	movia r17, 0xa0a
	custom 1, r23, r17, r16
	call loopMoveBar

moveDownBar2:
	# Subir/Descer barra | barra para mover | quantidade p mover
	#					1										1								000001010
	movia r17, 0xe0a
	custom 1, r23, r17, r16
	call loopMoveBar

score:
	ldbio r4, 0(r2) # Carrega o valor do button em r4
	movia r15, 0x7 # Usa o registrador r15 para carregar os valores que serão comparados para branch
	beq r4, r15, add_score_player_1 # Caso o botão de descer a seleção seja selecionado, dá branch para atualizar placar
	movia r15, 0xB # Usa o registrador r15 para carregar os valores que serão comparados para branch
	beq r4, r15, add_score_player_2 # Caso o botão de descer a seleção seja selecionado, dá branch para atualizar placar
	addi r22, r22, 1
	call score

set_constants:
	movia r11, 0x0 # r11 -> contador, inicializado como 0
	movia r8, 0xF424 # r8 -> valor para o delay de 15ms
	movia r9, 0x42BB # r9 -> valor para o delay de 4.1ms
	movia r10, 0x1A0 # r10 -> valor para o delay de 0.1ms
	movia r12, 0x65B9A # r12 -> valor para o delay de 100ms
	movia r13, 0xDC # r13 -> valor para o delay de 0.053ms
	ret # Retorna para a rotina que chamou essa label

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

# -------------- Adiciona 1 ao score do player 1 ----------------#

add_score_player_1:
  addi r27, r27, -4 # Aloca espaço na pilha
  stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
  addi r21, r21, 1 # Aumenta o placar do jogador 1 em um ponto
  call write_score # Chama a função que escreve o placar na LCD
  ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
ret

# -------------- Soma 1 no score 2 ----------------#

add_score_player_2:
  addi r27, r27, -4 # Aloca espaço na pilha
  stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
  addi r22, r22, 1 # Aumenta o placar do jogador 2 em um ponto
  call write_score # Chama a função que escreve o placar na LCD
  ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
ret

# -------------- Escreve o placar no LCD ----------------#
write_score:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	mov r16, r21 # Placar do jogador 1
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x58 # Caractere X
	call write # Escreve o valor armazenado no registrador de r16
	mov r16, r22 # Placar do jogador 2
	call write # Escreve o valor armazenado no registrador de r16
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
ret # Retorna para a rotina que chamou essa label
