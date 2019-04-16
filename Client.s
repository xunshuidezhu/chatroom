	.file	"Client.cpp"
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.section	.rodata
.LC0:
	.string	"fd added to epoll "
	.text
	.type	_ZL5addfdiib, @function
_ZL5addfdiib:
.LFB1132:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movl	%esi, -40(%rbp)
	movl	%edx, %eax
	movb	%al, -44(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	-40(%rbp), %eax
	movl	%eax, -28(%rbp)
	movl	$1, -32(%rbp)
	cmpb	$0, -44(%rbp)
	je	.L2
	movl	$-2147483647, -32(%rbp)
.L2:
	leaq	-32(%rbp), %rcx
	movl	-40(%rbp), %edx
	movl	-36(%rbp), %eax
	movl	$1, %esi
	movl	%eax, %edi
	call	epoll_ctl
	movl	-40(%rbp), %eax
	movl	$0, %edx
	movl	$1, %esi
	movl	%eax, %edi
	movl	$0, %eax
	call	fcntl
	orb	$8, %ah
	movl	%eax, %edx
	movl	-40(%rbp), %eax
	movl	$4, %esi
	movl	%eax, %edi
	movl	$0, %eax
	call	fcntl
	movl	$.LC0, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L3
	call	__stack_chk_fail
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1132:
	.size	_ZL5addfdiib, .-_ZL5addfdiib
	.section	.rodata
.LC1:
	.string	"127.0.0.1"
	.text
	.align 2
	.globl	_ZN6ClientC2Ev
	.type	_ZN6ClientC2Ev, @function
_ZN6ClientC2Ev:
.LFB1134:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movw	$2, 65556(%rax)
	movl	$8080, %edi
	call	htons
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movw	%dx, 65558(%rax)
	movl	$.LC1, %edi
	call	inet_addr
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	%edx, 65560(%rax)
	movq	-8(%rbp), %rax
	movl	$0, (%rax)
	movq	-8(%rbp), %rax
	movl	$0, 4(%rax)
	movq	-8(%rbp), %rax
	movb	$1, 20(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 8(%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1134:
	.size	_ZN6ClientC2Ev, .-_ZN6ClientC2Ev
	.globl	_ZN6ClientC1Ev
	.set	_ZN6ClientC1Ev,_ZN6ClientC2Ev
	.section	.rodata
.LC2:
	.string	"Connect server: "
.LC3:
	.string	" : "
.LC4:
	.string	"sock error"
.LC5:
	.string	"connect error"
.LC6:
	.string	"pipe error"
.LC7:
	.string	"epfd error"
	.text
	.align 2
	.globl	_ZN6Client7ConnectEv
	.type	_ZN6Client7ConnectEv, @function
_ZN6Client7ConnectEv:
.LFB1136:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$.LC2, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.LC1, %esi
	movq	%rax, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$.LC3, %esi
	movq	%rax, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$8080, %esi
	movq	%rax, %rdi
	call	_ZNSolsEi
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	movl	$0, %edx
	movl	$1, %esi
	movl	$2, %edi
	call	socket
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	%edx, (%rax)
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	jns	.L6
	movl	$.LC4, %edi
	call	perror
	movl	$-1, %edi
	call	exit
.L6:
	movl	$16, %edx
	movq	-8(%rbp), %rax
	leaq	65556(%rax), %rcx
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	connect
	shrl	$31, %eax
	testb	%al, %al
	je	.L7
	movl	$.LC5, %edi
	call	perror
	movl	$-1, %edi
	call	exit
.L7:
	movq	-8(%rbp), %rax
	addq	$12, %rax
	movq	%rax, %rdi
	call	pipe
	shrl	$31, %eax
	testb	%al, %al
	je	.L8
	movl	$.LC6, %edi
	call	perror
	movl	$-1, %edi
	call	exit
.L8:
	movl	$5000, %edi
	call	epoll_create
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	%edx, 8(%rax)
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	testl	%eax, %eax
	jns	.L9
	movl	$.LC7, %edi
	call	perror
	movl	$-1, %edi
	call	exit
.L9:
	movq	-8(%rbp), %rax
	movl	(%rax), %ecx
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	movl	$1, %edx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	_ZL5addfdiib
	movq	-8(%rbp), %rax
	movl	12(%rax), %ecx
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	movl	$1, %edx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	_ZL5addfdiib
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1136:
	.size	_ZN6Client7ConnectEv, .-_ZN6Client7ConnectEv
	.align 2
	.globl	_ZN6Client5CloseEv
	.type	_ZN6Client5CloseEv, @function
_ZN6Client5CloseEv:
.LFB1137:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	4(%rax), %eax
	testl	%eax, %eax
	je	.L11
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	movl	%eax, %edi
	call	close
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %edi
	call	close
	jmp	.L13
.L11:
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, %edi
	call	close
.L13:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1137:
	.size	_ZN6Client5CloseEv, .-_ZN6Client5CloseEv
	.section	.rodata
.LC8:
	.string	"fork error"
	.align 8
.LC9:
	.string	"input 'exit' to  exit the chatroom"
.LC10:
	.string	"EXIT"
.LC11:
	.string	"Server closed connection: "
	.text
	.align 2
	.globl	_ZN6Client5StartEv
	.type	_ZN6Client5StartEv, @function
_ZN6Client5StartEv:
.LFB1138:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN6Client7ConnectEv
	call	fork
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	movl	%edx, 4(%rax)
	movq	-40(%rbp), %rax
	movl	4(%rax), %eax
	testl	%eax, %eax
	jns	.L15
	movl	$.LC8, %edi
	call	perror
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %edi
	call	close
	movl	$-1, %edi
	call	exit
.L15:
	movq	-40(%rbp), %rax
	movl	4(%rax), %eax
	testl	%eax, %eax
	jne	.L16
	movq	-40(%rbp), %rax
	movl	12(%rax), %eax
	movl	%eax, %edi
	call	close
	movl	$.LC9, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
.L20:
	movq	-40(%rbp), %rax
	movzbl	20(%rax), %eax
	testb	%al, %al
	je	.L17
	movq	-40(%rbp), %rax
	addq	$21, %rax
	movl	$65535, %esi
	movq	%rax, %rdi
	call	bzero
	movq	stdin(%rip), %rax
	movq	-40(%rbp), %rdx
	leaq	21(%rdx), %rcx
	movq	%rax, %rdx
	movl	$65535, %esi
	movq	%rcx, %rdi
	call	fgets
	movq	-40(%rbp), %rax
	addq	$21, %rax
	movl	$4, %edx
	movl	$.LC10, %esi
	movq	%rax, %rdi
	call	strncasecmp
	testl	%eax, %eax
	jne	.L18
	movq	-40(%rbp), %rax
	movb	$0, 20(%rax)
	jmp	.L20
.L18:
	movq	-40(%rbp), %rax
	addq	$21, %rax
	movq	%rax, %rdi
	call	strlen
	leaq	-1(%rax), %rdx
	movq	-40(%rbp), %rax
	leaq	21(%rax), %rcx
	movq	-40(%rbp), %rax
	movl	16(%rax), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write
	shrq	$63, %rax
	testb	%al, %al
	je	.L20
	movl	$.LC8, %edi
	call	perror
	movl	$-1, %edi
	call	exit
.L16:
	movq	-40(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, %edi
	call	close
.L28:
	movq	-40(%rbp), %rax
	movzbl	20(%rax), %eax
	testb	%al, %al
	je	.L17
	movq	-40(%rbp), %rax
	movl	8(%rax), %eax
	movl	$-1, %ecx
	movl	$2, %edx
	movl	$_ZZN6Client5StartEvE6events, %esi
	movl	%eax, %edi
	call	epoll_wait
	movl	%eax, -28(%rbp)
	movl	$0, -32(%rbp)
.L27:
	movl	-32(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jge	.L28
	movq	-40(%rbp), %rax
	addq	$21, %rax
	movl	$65535, %esi
	movq	%rax, %rdi
	call	bzero
	movl	-32(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$2, %rax
	addq	$_ZZN6Client5StartEvE6events+4, %rax
	movl	(%rax), %edx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, %edx
	jne	.L22
	movq	-40(%rbp), %rax
	leaq	21(%rax), %rsi
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	movl	$0, %ecx
	movl	$65535, %edx
	movl	%eax, %edi
	call	recv
	movl	%eax, -24(%rbp)
	cmpl	$0, -24(%rbp)
	jne	.L23
	movq	-40(%rbp), %rax
	movl	(%rax), %ebx
	movl	$.LC11, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	%ebx, %esi
	movq	%rax, %rdi
	call	_ZNSolsEi
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %edi
	call	close
	movq	-40(%rbp), %rax
	movb	$0, 20(%rax)
	jmp	.L25
.L23:
	movq	-40(%rbp), %rax
	addq	$21, %rax
	movq	%rax, %rsi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	jmp	.L25
.L22:
	movq	-40(%rbp), %rax
	leaq	21(%rax), %rcx
	movl	-32(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$2, %rax
	addq	$_ZZN6Client5StartEvE6events+4, %rax
	movl	(%rax), %eax
	movl	$65535, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	jne	.L26
	movq	-40(%rbp), %rax
	movb	$0, 20(%rax)
	jmp	.L25
.L26:
	movq	-40(%rbp), %rax
	leaq	21(%rax), %rsi
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	movl	$0, %ecx
	movl	$65535, %edx
	movl	%eax, %edi
	call	send
.L25:
	addl	$1, -32(%rbp)
	jmp	.L27
.L17:
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN6Client5CloseEv
	nop
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1138:
	.size	_ZN6Client5StartEv, .-_ZN6Client5StartEv
	.type	_Z41__static_initialization_and_destruction_0ii, @function
_Z41__static_initialization_and_destruction_0ii:
.LFB1147:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	cmpl	$1, -4(%rbp)
	jne	.L31
	cmpl	$65535, -8(%rbp)
	jne	.L31
	movl	$_ZStL8__ioinit, %edi
	call	_ZNSt8ios_base4InitC1Ev
	movl	$__dso_handle, %edx
	movl	$_ZStL8__ioinit, %esi
	movl	$_ZNSt8ios_base4InitD1Ev, %edi
	call	__cxa_atexit
.L31:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1147:
	.size	_Z41__static_initialization_and_destruction_0ii, .-_Z41__static_initialization_and_destruction_0ii
	.type	_GLOBAL__sub_I__ZN6ClientC2Ev, @function
_GLOBAL__sub_I__ZN6ClientC2Ev:
.LFB1148:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$65535, %esi
	movl	$1, %edi
	call	_Z41__static_initialization_and_destruction_0ii
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1148:
	.size	_GLOBAL__sub_I__ZN6ClientC2Ev, .-_GLOBAL__sub_I__ZN6ClientC2Ev
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I__ZN6ClientC2Ev
	.local	_ZZN6Client5StartEvE6events
	.comm	_ZZN6Client5StartEvE6events,24,16
	.hidden	__dso_handle
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
