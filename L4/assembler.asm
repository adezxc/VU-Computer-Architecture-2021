; Paprastos funkcijos su slankaus kablelio skaičiais
        global  _opt, _suma    ; , normalizavimas
        section .text
;-----------------------------------------------------------------------------
;   double opt(double* masyvas, uint64_t kiek)
;                         rdi          rsi  
;-----------------------------------------------------------------------------
_opt:
        push rbx
        xorpd   xmm0, xmm0 ; xmm0 <- 0
        xorpd xmm1, xmm1
        xorpd xmm3, xmm3
        cmp     rsi, 0                  ; jeigu kiek yra 0...
        je      .pab
    .toliau:
        movsd xmm2, [rdi]
        cmpsd xmm2, xmm1, 1
        je .mazesnis
        .tesk:
        add     rdi, 8                  ; i++
        dec     rsi                     ; kiek--
        jnz     .toliau                 ; jeigu dar yra skaičių
    .pab:
        movsd xmm0, xmm1
        pop rbx
        ret 
    .mazesnis:
          cmpsd xmm1, xmm3, 0
          je .naujas
          jmp .tesk
          .naujas:
          movsd xmm1, [rdi]
          jmp .tesk  
        
_suma:
        push rbx
        xorpd   xmm0, xmm0              ; xmm0 <- 0
        cmp     rsi, 0                  ; jeigu kiek yra 0... 
        je      .pab
    .toliau:
        addsd   xmm0, [rdi]             ; xmm0 += masyvas[i] 
        add     rdi, 8                  ; i++
        dec     rsi                     ; kiek--
        jnz     .toliau                 ; jeigu dar yra skaičių
    .pab:
        pop rbx
        ret   
;-----------------------------------------------------------------------------
;   double arvisi(double* masyvas1, uint64_t kiek)
;                      rdi             rsi                
;-----------------------------------------------------------------------------

        