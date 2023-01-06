

extrn ExitProcess: PROC

arr_size equ 5
arr_element_size equ 4

.data
arr dd 5, 8, 6, 9, 2

.code
;bubblingSort(arr, length)
bubblingSort proc

  push rbx
  push rcx
  push rdx
  push r11

  mov r11, rcx
  mov rcx, rdx 
  sub rcx, 1
mloop:
    mov rbx, r11

    mov rax, rcx
    mov rdx, 4
    mul rdx
    add rax, rbx
    mov rdi, rax
    sort:

        cmp rbx, rdi

        jge sort_end

        mov eax, dword ptr [rbx]
        mov edx, dword ptr [rbx + arr_element_size]

        cmp rax, rdx
        jle inc_addr
        mov dword ptr[rbx], edx
        mov dword ptr[rbx+arr_element_size], eax

    inc_addr:
        add rbx, arr_element_size

        jmp sort
    sort_end:

loop mloop

  pop r11
  pop rdx
  pop rcx
  pop rbx
  ret
  
bubblingSort endp

main proc
    lea rcx, arr
    mov rdx, arr_size

    call bubblingSort

    mov rcx, 100; process return 100
    call ExitProcess
main endp

End