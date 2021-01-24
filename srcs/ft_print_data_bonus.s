# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    ft_print_data_bonus.s                            .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: vroth-di <marvin@le-101.fr>                +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/01/06 18:15:08 by vroth-di     #+#   ##    ##    #+#        #
#    Updated: 2020/01/06 18:17:04 by vroth-di    ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

global _ft_print_data
extern _ft_strlen
extern _ft_write

section .data
nl : db 10

section .text
_ft_print_data:
	mov		rax, 0x0
	cmp		rdi, 0x0
	jz		_return
	loop:
		cmp		rdi, 0x0
		je		_return

		push	rax               ; sauvegarde rax
		mov		rax, 0            ; init pour len
		mov		rsi, rdi          ; sauvegarde rdi
		mov		rdi, [rdi]        ; rdi = struct->data
		call	_ft_strlen        ; longueur rdi --> rax
		mov		rdi, rsi          ; rdi = struct

		mov		rsi, [rdi]        ; rsi = struct->data
		push	rdi               ; sauvegarde rdi
		mov		rdi, 1            ; fd 1 pour appel write
		mov		rdx, rax          ; arg 3 write --> longueur
		call	_ft_write

		mov		rax, 0x2000004    ; print \n
		mov		rdi, 1
		mov		rsi, nl
		mov		rdx, 2
		syscall

		pop		rdi               ; recupere rdi
		pop		rax               ; recupere rax

		inc		rax               ; inc compteur
		mov		rdi, [rdi+8]      ; rdi = struct->next
		jmp		loop
		_return:
			ret
