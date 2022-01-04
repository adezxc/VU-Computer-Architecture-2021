; Paprastos funkcijos su slankaus kablelio skaičiais

                global  opt, arvisi    ; , normalizavimas
                
        section .text
;-----------------------------------------------------------------------------
;   double opt(double* masyvas, uint64_t kiek)
;                         rdi          rsi  
;-----------------------------------------------------------------------------
opt:
        push rbx
        xorpd xmm0, xmm0
        xorpd xmm1, xmm1
        xorpd xmm3, xmm3
        cmp     rsi, 0
        je      .pab
    .toliau:
        movsd xmm2, [rdi]
        comisd xmm2, xmm3
        jnb .tesk
        comisd xmm0, xmm3
        je .zero
        comisd xmm0, xmm2
        jb .mazesnis
        .tesk:
        add     rdi, 8
        dec     rsi
        jnz     .toliau
    .pab:
        pop rbx
        ret
    .zero:
        comisd xmm2, xmm0
        jb .naujas
    .mazesnis:
          comisd xmm2, xmm0
          jnb .naujas
          jmp .tesk
          .naujas:
          movsd xmm0, xmm2
          jmp .tesk

;-----------------------------------------------------------------------------
;   uint64_t arvisi(double* masyvas1, uint64_t kiek)
;                      rdi             rsi                
;-----------------------------------------------------------------------------
.data

upperbound dq 10.0        

arvisi:
	    push    rbx
	    movsd   xmm0, [upperbound]
        xorpd   xmm3, xmm3
        mov     rax, 0
        cmp     rsi, 0 
        je      .end

    .next:
        movsd   xmm2, qword [rdi]
	    ucomisd xmm1, xmm2
	    jnz	.check
        add     rdi, 8
        dec     rsi
        jnz     .next
    .end:
        pop rbx
        ret   
    .check
	movsd	xmm1, xmm2
	mulsd	xmm2, xmm1
	mulsd	xmm2, xmm1

	comisd	xmm2, xmm0
	ja	.next
	
	comisd	xmm2, xmm3
	jb	.next

	inc rax
	jmp	.next

