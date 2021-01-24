# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    ft_strdup.s                                      .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: vroth-di <marvin@le-101.fr>                +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/01/04 19:31:48 by vroth-di     #+#   ##    ##    #+#        #
#    Updated: 2020/01/05 19:47:17 by vroth-di    ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

global _ft_strdup
extern _malloc
extern _ft_strlen
extern _ft_strcpy
section .text
_ft_strdup:
	cmp		rdi, 0x0        ; str == NULL ?
	jz		error           ; return NULL
	call	_ft_strlen      ; --> len in rax
	inc		rax             ; ++ '\0'
	push	rdi
	mov		rdi, rax        ; len --> rdi malloc
	call	_malloc
	cmp		rax, 0x0
	jz		error
	pop		rdi
	push	rsi
	mov		rsi, rdi
	mov		rdi, rax
	call	_ft_strcpy
	pop		rsi
	ret
error:
	mov		rax, 0x0
	ret
