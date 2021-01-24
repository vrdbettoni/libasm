# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    ft_list_size.s                                   .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: vroth-di <marvin@le-101.fr>                +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/01/04 19:31:10 by vroth-di     #+#   ##    ##    #+#        #
#    Updated: 2020/01/04 19:31:12 by vroth-di    ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

global _ft_list_size
section .text
_ft_list_size:
	mov		rax, 0x0
	cmp		rdi, 0x0
	jz		_return
	loop:
		cmp		rdi, 0x0
		je		_return
		inc		rax
		mov		rdi, [rdi+8]
		jmp		loop
	_return:
		ret
