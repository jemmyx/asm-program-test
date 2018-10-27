; Define variables in the data section
SECTION .DATA
        title    		db 10,9,'FIRST NASM PROGRAM',10
        titleLen 		equ $-title
		marks TIMES 9 dw 0					; TIMES directive allows multiple initialization to the same value, here an array 'marks' and set to zero
		stars TIMES 60 db '*'				; array set wit '*'
		starsLen		db 15				; 0xf
		nombre1			dw 12345			; 0x3039
		nombre2			dw 14322			; ox37F2
		msg2			db 9,'Author: Fabio Meyer<fabio.meyer@gmail.com>',10,
		msg2Len			equ $-msg2
		msg3			db 9,'Date: octobre 2018',10
		msg3Len			equ $-msg3

; Code goes in the text section

SECTION .TEXT
	GLOBAL _start			; must be declared for linker
	
_start:
	
	call printstarts
	
	mov eax,4				; write system call = 4
	mov ebx,1				; file descriptor 1 = STDOUT
	mov ecx,title			; string to write
	mov edx,titleLen		; length of the string to write
	int 80h					; call the kernel
	
	mov edx,msg2Len			; msg len
	mov ecx,msg2			; message to write
	call writestdout
	
	mov edx,msg3Len			; msg len
	mov ecx,msg3
	call writestdout
	
	call printstarts
	
	;terminate the prog - si non present --> ERREUR: segmentation fault
	mov eax,1				; exit system call
	mov ebx,0				; exit with error = 0
	int 80h					;call the kernel


;Functions definitions

writestdout:
	mov ebx,1				; file description STDOUT
	mov eax,4				; system call (sys_write)
	int 0x80				; call kernel
	ret

printstarts:
	;affiche les etoiles
	mov edx,60				; message length
	mov ecx,stars			; message to write
	mov ebx, 1				; file descriptor STDOUT
	mov eax,4				; system call number (sys_write)
	int 80h					; call the kernel
	ret
	
