# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    ft_strcmp.s                                      .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: vroth-di <marvin@le-101.fr>                +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/01/04 19:31:38 by vroth-di     #+#   ##    ##    #+#        #
#    Updated: 2020/01/04 19:31:39 by vroth-di    ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

global _ft_strcmp
section .text
_ft_strcmp:
	cmp		rdi, 0x0         ; s1 == NULL ?
	jz		_error
	cmp		rsi, 0x0         ; s2 == NULL ?
	jz		_error
	mov		rcx, 0x0
	jmp		loop
	loop:
		cmp		[rdi+rcx], byte 0x0
		jz		_return
		cmp		[rsi+rcx], byte 0x0
		jz		_return
		mov		al, byte [rdi+rcx]
		mov		bl, byte [rsi+rcx]
		inc		rcx
		cmp		al, bl
		jz		loop
		jmp		_return
_return:
	sub		rax, rbx
	ret
_error:
	mov		rax, 0x0
	ret
