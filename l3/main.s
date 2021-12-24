.globl main
        .data
fin:	.asciz "input.csv"
fout:   .asciz "output.txt"
start: .asciz "Adam Jasinski, Bioinformatika, 2 kursas\n"
result: .asciz "Trumpiausias žodis pirmame ir antrame stulpeliuose yra:"
skaitymas: .word 0x0
paskutinisSkaitymas: .word 0x0
rasymas: .word 0x0
buf: .space 0x1000

.macro readSymbol
  li  a7, 63
  lw  a0, skaitymas
  la  a1, buf
  li  a2, 1
  ecall
  ble a0, x0, end
  addi s5, s5, 1
  lbu a0, buf
.end_macro

        .text
  # Atidaryti failą skaitymui
main:
  li   s3, 100
  li   a7, 1024
  la   a0, fin
  li   a1, 0
  ecall
  la   t1, skaitymas    # deskriptoriaus adresas
  sw   a0, (t1)                  # saugome deskriptorių
  # Atidaryti failą rašymui
  li   a7, 1024     
  la   a0, fout    
  li   a1, 1        
  ecall
  la   t1, rasymas    # deskriptoriaus adresas
  sw   a0, (t1)                  # saugome deskriptorių
  # Rašyti į failą
  li   a7, 64
  lw   a0, rasymas       # Rašymo failo deskriptorius
  la   a1, start   # Teksto adresas
  li   a2, 40
  ecall
  j skipLine
  li s4, 0        # Dabartinio žodžio ilgis
  loop:
  	readSymbol
  	jal checkSemicolon
  	jal checkSpace
  	continue:
  	addi s4, s4, 1
  	newResult:
  	j loop
	

	
skipLine:
  li s2, 0
  readSymbol
  jal checkNewLine
  j skipLine
	
checkNewLine:
  li t1, 0x0A
  beq a0, t1, loop
  jr x1
	
checkSemicolon:
  li t1, 0x3B
  beq a0, t1, incSemicolon
  continueSemicolon:
  beq a0, t1, checkWord
  jr x1
  
incSemicolon:
    addi s2, s2, 1
    li t2, 2
    beq s2, t2, skipLine
    j continueSemicolon
	
checkSpace:
  li t1, 0x20
  beq a0, t1, checkWordSpace
  li s11, 0
  jr x1
  
checkWordSpace:
  bnez s11, test
  j checkWord 
  
test:
  li s11, 1
  li s4, 0
  j loop
  
checkWord:
  ble s4, s3, newShortest
  continueRecord:
  li s4, 0
  j loop
	
newShortest:
  beqz s4, loop
  mv s3, s4
  mv s6, s5
  sub s6, s6, s3
  addi s6, s6, -1
  li s4, 0
  j loop
  
end:
  li   a7, 57
  lw   a0, skaitymas	
  ecall
  li   a7, 1024
  la   a0, fin
  li   a1, 0
  ecall
  la   t1, paskutinisSkaitymas    # deskriptoriaus adresas
  sw   a0, (t1)                  # saugome deskriptorių
  
  li a7, 63
  lw a0, paskutinisSkaitymas
  la a1, buf
  mv a2, s6
  ecall 
  
  li a7, 63
  lw a0, paskutinisSkaitymas
  la a1, buf
  mv a2, s3
  ecall
  
  li a7, 64
  lw a0, rasymas
  la a1, result
  li a2, 56
  ecall
  
  li a7, 64
  lw a0, rasymas
  la a1, buf
  mv a2, s3
  ecall
  
  li   a7, 93
  li   a0, 0
  ecall
