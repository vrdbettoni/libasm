# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    ft_list_push_front_bonus.s                       .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: vroth-di <marvin@le-101.fr>                +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/01/08 18:52:11 by vroth-di     #+#   ##    ##    #+#        #
#    Updated: 2020/01/08 18:52:11 by vroth-di    ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    ft_list_push_front.s                             .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: vroth-di <marvin@le-101.fr>                +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/01/04 19:30:58 by vroth-di     #+#   ##    ##    #+#        #
#    Updated: 2020/01/04 19:31:01 by vroth-di    ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

global _ft_list_push_front
extern _malloc

section .text
_ft_list_push_front:
	push		rsp
	cmp			rdi, 0x0
	jz			_return
	push		rdi               ; sauvegarde **begin_list
	push		rsi               ; sauvegarde *data
	mov			rdi, 16           ; malloc(16)
	mov			rax, 0x0
	call		_malloc           ; rax = struct
	cmp			rax, 0x0
	jz			_return            ; malloc error
	pop			rdx               ; recup data
	mov			[rax], rdx        ; struct->data = data
	pop			rdi
	cmp byte	[rdi], 0x0        ; test *begin_list
	jz			_null
	mov			rsi, [rdi]
	mov			[rax + 8], rsi  ; struct->next = *begin_list
	mov			[rdi], rax        ; *begin_list = struct
	pop			rsp
	ret

_null:
	mov	byte	[rax + 8], 0x0
	mov			[rdi], rax
	pop			rsp
	ret

_return:
	pop			rsp
	ret
