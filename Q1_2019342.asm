; NAME: Vaibhav Saxena
; ROLL NO: 2019342


bits 16
org 0x7c00
start:
    mov ax, 0x3
    int 0x10 ; set vga text mode 3    ; to Clear Console
    lgdt [gdt_pointer]                ; to load GDT
    mov eax, cr0
    or eax,0x1
    mov cr0, eax                      ; to load Protected Mode
    jmp CODE_SEG:boot                 ; to jump to boot function


; to define GDT
gdt_start:
    dq 0x0
gdt_code:
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 10011010b
    db 11001111b
    db 0x0
gdt_data:
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0
gdt_end:
gdt_pointer:
    dw gdt_end - gdt_start
    dd gdt_start
CODE_SEG equ gdt_code - gdt_start
DSEG equ gdt_data - gdt_start


; to open and print in Protected Mode
bits 32
boot:
    mov ax, DSEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esi,string
    mov ebx,0xb8000
    mov edx, cr0
    mov ecx, 32   
    
; to print Hello world!       
.loop:
    lodsb
    or al,al
    jz loop2
    or eax,0x0200
    mov word [ebx], ax
    add ebx,2
    jmp .loop
    
; to print CR0 value    
loop2:  
    mov eax, 00000230h
    shl edx, 1
    adc eax, 0
    mov [ebx], ax
    add ebx, 2
    dec ecx
    jnz loop2
    
; to stop the program when done    
halt:
    cli
    hlt    
  
; the string to be printed 
string: db " Hello world!   CR0 register (32 bits): ",0


; to implement BootLoader
times 510 - ($ - $$) db 0
dw 0xAA55
