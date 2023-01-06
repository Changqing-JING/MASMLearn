

extrn ExitProcess: PROC

.data
a qword  1.55
b qword 8.7
c qword 2.9
d qword 3.3
e qword 0.2
ll qword 5

.code
;double fx(double a, double b, double c, double d, e) {
;double r = (a+b-c)*d/e
;if(r>5){return r+a;}else{return b;}
;}
fx proc
  push rbp
  mov rbp, rsp

  sub rsp, 8
  movsd mmword ptr[rsp], xmm4

  sub rsp, 8
  movsd mmword ptr[rsp], xmm5

  movsd xmm5, xmm0

  addsd xmm0, xmm1
  subsd xmm0, xmm2
  mulsd xmm0, xmm3

  movsd xmm4, mmword ptr[rbp+8+8 + 2*8]

  divsd xmm0, xmm4
 
  comisd xmm0, mmword ptr[ll]
  ja return_a
  movsd xmm0, xmm1
  jmp end_ll
  return_a:
  addsd xmm0, xmm5
  end_ll:

  movsd xmm5, mmword ptr[rsp]
  add rsp, 8

  movsd xmm4, mmword ptr[rsp]
  add rsp, 8

  pop rbp
  ret
  
fx endp

main proc
    push 5
    call rax
    mov qword ptr[ll], rbx

    movsd xmm0, mmword ptr [a]
    movsd xmm1, mmword ptr [b]
    movsd xmm2, mmword ptr [c]
    movsd xmm3, mmword ptr [d]
    movsd xmm4, mmword ptr [e]

    sub rsp, 8
    movsd mmword ptr [rsp], xmm4

    call rax

    add rsp, 8

    mov rcx, 100; process return 100
    call ExitProcess
main endp

End