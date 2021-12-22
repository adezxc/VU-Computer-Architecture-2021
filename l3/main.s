.globl main
        .data
fin:	.asciz "input.csv"
fout:   .asciz "output.txt"
start: .asciz "Adam Jasinski, Bioinformatika, 2 kursas\n"
nl:     .asciz "\n"
result: .asciz "Trumpiausias žodis pirmame ir antrame stulpeliuose yra: "
skaitymas: .word 0x0
rasymas: .word 0x0
buf: .space 0x1000
shortestWord: .space 0x1000

.macro readSymbol
  li  a7, 63
  lw  a0, skaitymas
  la  a1, buf
  li  a2, 1
  ecall
  ble a0, x0, end
  lbu a0, buf
.end_macro

        .text
  # Atidaryti failą skaitymui
main:
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
  	li t2, 2
  	readSymbol
  	jal checkSemicolon
  	jal checkSpace
  	addi s4, s4, 1
  	beq s2, t2, skipLine
  	
  	j loop


	
skipLine:
  li s2, 0
  readSymbol
  jal checkNewLine
  j skipLine
	
checkSpace:
  li t1, 0x20
  beq a0, t1, recordWord
  jr x1
  
recordWord:
  li a7, 62
  la a0, skaitymas
  li a1, 0
  li a2, 1
  ecall
  li a7, 63
  la a1, shortestWord
  mv a2, s4
  ecall
  li a7, 64
  la a0, rasymas
  la a1, shortestWord
  mv a2, s4
  ecall
  jr x1
	
checkNewLine:
  li t1, 0x0A
  beq a0, t1, loop
  jr x1
  
checkSemicolon:
  li t1, 0x3B
  beq a0, t1, incSemicolon
  jr x1
  
incSemicolon:
    addi s2, s2, 1
    jr x1
  
end:
  li   a7, 57
  mv   a0, s6
  ecall
  li   a7, 93
  li   a0, 0
  ecall
  
