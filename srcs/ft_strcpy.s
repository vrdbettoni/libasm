# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    ft_strcpy.s                                      .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: vroth-di <marvin@le-101.fr>                +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/01/04 19:31:42 by vroth-di     #+#   ##    ##    #+#        #
#    Updated: 2020/01/04 19:31:44 by vroth-di    ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

global _ft_strcpy
section .text
_ft_strcpy:
	mov		rcx, 0
	cmp		rsi, 0
	je		null
	cmp		rdi, 0
	je		null
	loop:
		cmp		byte [rsi+rcx], 0
		je		end_cpy
		mov		al, byte [rsi+rcx]
		mov		byte [rdi+rcx], al
		inc		rcx
		jmp		loop
	end_cpy:
		mov		byte [rdi+rcx], 0
		mov		rax, rdi
		ret
	null:
		mov		rax, 0
		ret
