global _ft_atoi_base

; rdi = nb / rsi = base

section .text
_ft_atoi_base:
	push			rbx
	push			r8
	push			r9
	push			r12
	xor				rax, rax              ; rax = ret
	xor				rbx, rbx              ; rbx = sign
	xor				r12, r12              ; r12 = base lenght
	jmp				_base_check

_base_inc:
	inc				r12

_base_check:
	cmp byte		[rsi+r12], 0x0        ; end base ?
	jz				_base_check_end       ; jmp end
	mov				r8, r12

_base_check_2_inc:
	inc				r8

_base_check_2:
	cmp byte		[rsi+r8], 0x0         ; !base[i]
	jz				_base_check_correct
	mov				r9b, [rsi+r8]
	cmp byte		[rsi+r12], r9b        ; base[base_length] == base[i]
	je				_set_rax
	jmp				_base_check_2_inc

_base_check_correct:
	cmp byte		[rsi+r12], 32        ; == ' '
	je				_set_rax
	cmp byte		[rsi+r12], 43        ; == '+'
	je				_set_rax
	cmp byte		[rsi+r12], 45        ;  == '-'
	je				_set_rax
	cmp byte		[rsi+r12], 9         ; == '\t'
	je				_set_rax
	cmp byte		[rsi+r12], 10        ; == '\n'
	je				_set_rax
	cmp byte		[rsi+r12], 13        ; == '\r'
	je				_set_rax
	cmp byte		[rsi+r12], 11        ; == '\v'
	je				_set_rax
	cmp byte		[rsi+r12], 12        ; == '\f'
	je				_set_rax
	jmp				_base_inc

_base_check_end:
	cmp				r12, 1                 ; base_length <= 1
	jle				_set_rax
	xor				r8, r8                 ; i = 0
	jmp				_skip_whitespaces

_skip_inc:
	inc				r8                     ; i++

_skip_whitespaces:
	cmp byte		[rdi+r8], 32           ; str[i] == ' '
	je				_skip_inc
	cmp byte		[rdi+r8], 9            ; str[i] == '\t'
	je				_skip_inc
	cmp byte		[rdi+r8], 10           ; str[i] == '\n'
	je				_skip_inc
	cmp byte		[rdi+r8], 13           ; str[i] == '\r'
	je				_skip_inc
	cmp byte		[rdi+r8], 11           ; str[i] == '\v'
	je				_skip_inc
	cmp byte		[rdi+r8], 12           ; str[i] == '\f'
	je				_skip_inc
	jmp				_check_sign

_neg:
	xor				bl, 1

_pos:
	inc				r8

_check_sign:
	cmp byte		[rdi+r8], 45         ; str[i] == '-'
	je				_neg
	cmp byte		[rdi+r8], 43         ; str[i] == '+'
	je				_pos
	jmp				_atoi_loop

_atoi_increment:
	inc				r8                     ; i++

_atoi_loop:
	cmp byte		[rdi+r8], 0            ; str[i] == 0
	je				_set_rax
	xor				r9, r9                 ; r9 = j = 0
	jmp				_atoi_idx

_atoi_idx_inc:
	inc				r9                     ; j++

_atoi_idx:
	mov				r10b, byte [rsi+r9]
	cmp				r10b, 0                ; base[j] == 0
	je				_set_rax
	cmp byte		[rdi+r8], r10b         ; base[j] == str[i]
	jne				_atoi_idx_inc

_add_to_total:
	mul				r12                    ; rax *= base_length
	add				rax, r9                ; rax += j
	jmp				_atoi_increment

_set_rax:
	cmp				rbx, 0                  ; sign is negative
	jz				_return
	neg				rax                     ; ret = -ret

_return:
	pop				r9
	pop				r8
	pop				r12                     ; restore r12
	pop				rbx                     ; restore rbx
	ret
