# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    ft_list_remove_if_bonus.s                        .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: vroth-di <marvin@le-101.fr>                +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/01/06 18:19:13 by vroth-di     #+#   ##    ##    #+#        #
#    Updated: 2020/01/06 18:19:46 by vroth-di    ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

global _ft_list_remove_if
extern _free

; rdi = **begin / rsi = data_ref / rdx = int (*cmp)()
;                                / rcx void(*free_fct)(void *))

section .text
_ft_list_remove_if:
	push		rbp               ; init stack
	mov			rbp, rsp
	push		rbx
	xor			r8, r8
	xor			r11, r11
	xor			r12, r12
	xor			rbx, rbx
	cmp			rdi, 0x0         ; check **begin
	jz			_error
	cmp			rdx, 0x0         ; check int (*cmp)()
	jz			_error
	cmp			rcx, 0x0         ; check void(*free_fct)(void *))
	jz			_error
	push		rcx              ; save free_fct
	mov			r11, rdi
	push		r11
	mov			r8, [rdi]         ; r8 = *begin
	push		rdi               ; save **begin
	push		r8                ; save *begin
	push		rsi               ; save data_ref
	push		rdx               ; save comp_fct
	jmp			_start

_start:
	pop			rdx               ; fonction
	pop			rsi               ; data_ref
	pop			rbx               ; actual
	cmp			rbx, 0x0
	jz			_return
	mov			r12, rsi          ; save data_ref
	push		rsi
	mov			rsi, r12
	mov			rdi, [rbx]        ; rdi = *begin->data
	cmp			rdi, 0x0
	jz			_return           ; data = NULL / ret
	mov			rax, 0x0
	mov			r12, rdx
	push		r12
	call		rdx               ; cmp function
	pop			rdx
	pop			rsi               ; load save
	pop			r8                ; previous
	cmp			rax, 0x0          ; result
	jz			_to_free
	jmp			_next

_to_free:
	pop			r11
	pop			rcx               ; restore free_fct
	push		r11
	mov			rdi, [rbx]        ; rdi = actual->data
	push		r8
	push		rbx
	push		rsi
	push		rdx
	mov			r12, rcx
	push		r12
	call		rcx               ; free actual->data
	pop			rcx
	pop			rdx
	pop			rsi
	pop			rbx
	pop			r8
	pop			r11
	push		rcx
	cmp			[r11], rbx        ; **begin == *actual
	jz			_first
	push		r11
	mov			rdi, [rbx+8]      ; actual->next = NULL
	cmp			rdi, 0x0
	jz			_last
	mov			r12, [rbx+8]
	mov			[r8+8], r12     ; previous->next = actual->next
	mov			rdi, rbx          ; rdi = actual
	push		r8
	mov			rbx, [r8+8]
	push		rbx
	push		rsi
	push		rdx
	call		_free             ; free rdi
	jmp			_start

_next:
	mov			r8, rbx
	mov			rbx, [rbx+8]
	cmp			rbx, 0x0
	jz			_return
	push		r8
	push		rbx
	push		rsi
	push		rdx
	jmp			_start

_first:                          ; free and del when (**begin)->data = data_ref
	mov			r12, [rbx+8]
	mov			[r11], r12
	push		r11
	mov			rdi, rbx
	mov			r8, r12
	mov			rbx, r12
	cmp byte	[r11], 0x0
	jz			_all_del
	push		r8
	push		rbx
	push		rsi
	push		rdx
	call		_free
	jmp			_start

_all_del:
	pop		r11
	mov		r11, 0x0
	push	r11
	jmp		_return

_last:
	mov		rdi, 0x0
	mov		[r8+8], rdi
	mov		rdi, rbx
	call	_free
	jmp		_return

_error:
	pop			rbx
	pop			rbp
	ret

_return:
	pop			r11
	pop			rcx
	pop			rbx
	pop			rbp
	ret
