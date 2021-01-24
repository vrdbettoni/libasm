# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    ft_list_sort_bonus.s                             .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: vroth-di <marvin@le-101.fr>                +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/01/06 18:16:43 by vroth-di     #+#   ##    ##    #+#        #
#    Updated: 2020/01/06 18:16:44 by vroth-di    ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

global _ft_list_sort

; rdi = t_list **begin / rsi = int (*cmp)())

section .text
_ft_list_sort:
	push		rbp                   ; init stack
	mov			rbp, rsp
	cmp			rdi, 0x0
	jz			_error
	cmp			rsi, 0x0
	jz			_error
	push		rcx
	push		r8
	push		r10
	push		r11
	push		r12
	push		r13
	xor			r10, r10
	xor			r11, r11
	xor			r12, r12
	xor			r13, r13
	mov			r12, rdi              ; r12 = **begin
	mov			rdi, [r12]            ; rdi = *begin
	cmp			rdi, 0x0
	jz			_ret
	push		r12                   ; save **begin
	push		rsi                   ; save *cmp
	jmp			_test_first

_change_ptr:
	mov			[r8], r11             ; **begin = *next
	mov			rax, [r11+8]          ; rax = second->next
	mov			[r11+8], r12          ; second->next = first
	mov			[r12+8], rax          ; first->next = second->next
	mov			rax, r11
	mov			r11, r12              ; r11 = next
	mov			r12, rax              ; r12 = actual
	jmp			_test

_test_first:
	pop			rcx                   ; rcx = *cmp
	pop			r8                    ; r8  = **begin
	mov			r10, rcx              ; r10 = *cmp
	mov			r12, [r8]             ; r12 = *begin
	mov			rdi, [r12]            ; rdi = *actual->data
	mov			r11, [r12+8]          ; r11 = *begin->next
	mov			rsi, [r11]            ; rsi = next->data
	push		r8                    ; save **begin
	push		rcx                   ; save *cmp
	push		r12                   ; save *actual
	push		r11                   ; save *next
	mov			rax, 0x0
	call		r10                   ; test
	pop			r11
	pop			r12
	pop			rcx
	pop			r8
	cmp			rax, 0x0
	jg			_change_ptr
	jmp			_test

; r8 = **begin / r12 = actual / r11 = next

_change:
	mov			rax, [r11+8]          ; rax = second->next
	mov			[r11+8], r12          ; second->next = first
	mov			[r12+8], rax          ; first->next = second->next
	mov			rax, r11
	mov			r11, r12              ; r11 = next
	mov			r12, rax              ; r12 = actual
	mov			[r13+8], r12
	push		r8
	push		rcx
	jmp			_test_first

_test:
	mov			r13, r12          ; r13 = actual
	mov			r12, r11          ; actual = next
	mov			rax, [r11+8]
	mov			r11, rax          ; next = next->next
	cmp			r11, 0x0
	jz			_ret
	mov			rdi, [r12]         ; rdi = actual->data
	mov			rsi, [r11]         ; rsi = next->data
	mov			r10, rcx           ; r10 = *cmp
	push		r8                 ; save **begin
	push		rcx                ; save *cmp
	push		r13                ; save *previous
	push		r12                ; save *actual
	push		r11                ; save *next
	xor			rax, rax
	call		r10                ; test
	pop			r11
	pop			r12
	pop			r13
	pop			rcx
	pop			r8
	cmp			rax, 0x0
	jg			_change
	jmp			_test

_error:
	pop			rbp
	ret

_ret:
	pop			r13
	pop			r12
	pop			r11
	pop			r10
	pop			r8
	pop			rcx
	pop			rbp
	ret
