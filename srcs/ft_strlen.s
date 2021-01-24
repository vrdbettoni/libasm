# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    ft_strlen.s                                      .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: vroth-di <marvin@le-101.fr>                +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/01/04 19:31:53 by vroth-di     #+#   ##    ##    #+#        #
#    Updated: 2020/01/06 18:32:59 by vroth-di    ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

global _ft_strlen

section .text
_ft_strlen:
	cmp			rdi, 0x0
	jz			_err
	mov			rax, rdi

_loop:
	cmp byte	[rax], 0
	je			_exit
	INC			rax
	jmp			_loop

_err:
	mov			rax, 0x0
	ret

_exit:
	sub			rax, rdi
	ret
