; boot.asm - Multiboot-совместимый загрузчик
bits 32

; --- Multiboot заголовок ---
section .multiboot
align 4
    dd 0x1BADB002              ; Magic number
    dd 0x00                    ; Flags
    dd -(0x1BADB002 + 0x00)    ; Checksum 

; --- Код ---
section .text
global start
extern main                    ; Точка входа 

start:
    cli                       ; Запретить прерывания
    mov esp, stack_space      ; Установить указатель стека
    call main                 ; Вызвать основную C функцию
    hlt                       ; Остановить процессор

; --- Секция для стека ---
section .bss
resb 8192                     ; 8KB для стека
stack_space:
