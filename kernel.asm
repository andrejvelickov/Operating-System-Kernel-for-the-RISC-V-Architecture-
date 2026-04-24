
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	58013103          	ld	sp,1408(sp) # 8000b580 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	0a4060ef          	jal	ra,800060c0 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <_ZN5Riscv14supervisorTrapEv>:
.align 4
.global _ZN5Riscv14supervisorTrapEv
.type _ZN5Riscv14supervisorTrapEv, @function
_ZN5Riscv14supervisorTrapEv:
    # push all registers to stack
    addi sp, sp, -256
    80001020:	f0010113          	addi	sp,sp,-256
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001024:	00013023          	sd	zero,0(sp)
    80001028:	00113423          	sd	ra,8(sp)
    8000102c:	00213823          	sd	sp,16(sp)
    80001030:	00313c23          	sd	gp,24(sp)
    80001034:	02413023          	sd	tp,32(sp)
    80001038:	02513423          	sd	t0,40(sp)
    8000103c:	02613823          	sd	t1,48(sp)
    80001040:	02713c23          	sd	t2,56(sp)
    80001044:	04813023          	sd	s0,64(sp)
    80001048:	04913423          	sd	s1,72(sp)
    8000104c:	04a13823          	sd	a0,80(sp)
    80001050:	04b13c23          	sd	a1,88(sp)
    80001054:	06c13023          	sd	a2,96(sp)
    80001058:	06d13423          	sd	a3,104(sp)
    8000105c:	06e13823          	sd	a4,112(sp)
    80001060:	06f13c23          	sd	a5,120(sp)
    80001064:	09013023          	sd	a6,128(sp)
    80001068:	09113423          	sd	a7,136(sp)
    8000106c:	09213823          	sd	s2,144(sp)
    80001070:	09313c23          	sd	s3,152(sp)
    80001074:	0b413023          	sd	s4,160(sp)
    80001078:	0b513423          	sd	s5,168(sp)
    8000107c:	0b613823          	sd	s6,176(sp)
    80001080:	0b713c23          	sd	s7,184(sp)
    80001084:	0d813023          	sd	s8,192(sp)
    80001088:	0d913423          	sd	s9,200(sp)
    8000108c:	0da13823          	sd	s10,208(sp)
    80001090:	0db13c23          	sd	s11,216(sp)
    80001094:	0fc13023          	sd	t3,224(sp)
    80001098:	0fd13423          	sd	t4,232(sp)
    8000109c:	0fe13823          	sd	t5,240(sp)
    800010a0:	0ff13c23          	sd	t6,248(sp)

    call _ZN5Riscv20handleSupervisorTrapEv
    800010a4:	185030ef          	jal	ra,80004a28 <_ZN5Riscv20handleSupervisorTrapEv>

    # pop all registers from stack
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800010a8:	00013003          	ld	zero,0(sp)
    800010ac:	00813083          	ld	ra,8(sp)
    800010b0:	01013103          	ld	sp,16(sp)
    800010b4:	01813183          	ld	gp,24(sp)
    800010b8:	02013203          	ld	tp,32(sp)
    800010bc:	02813283          	ld	t0,40(sp)
    800010c0:	03013303          	ld	t1,48(sp)
    800010c4:	03813383          	ld	t2,56(sp)
    800010c8:	04013403          	ld	s0,64(sp)
    800010cc:	04813483          	ld	s1,72(sp)
    800010d0:	05013503          	ld	a0,80(sp)
    800010d4:	05813583          	ld	a1,88(sp)
    800010d8:	06013603          	ld	a2,96(sp)
    800010dc:	06813683          	ld	a3,104(sp)
    800010e0:	07013703          	ld	a4,112(sp)
    800010e4:	07813783          	ld	a5,120(sp)
    800010e8:	08013803          	ld	a6,128(sp)
    800010ec:	08813883          	ld	a7,136(sp)
    800010f0:	09013903          	ld	s2,144(sp)
    800010f4:	09813983          	ld	s3,152(sp)
    800010f8:	0a013a03          	ld	s4,160(sp)
    800010fc:	0a813a83          	ld	s5,168(sp)
    80001100:	0b013b03          	ld	s6,176(sp)
    80001104:	0b813b83          	ld	s7,184(sp)
    80001108:	0c013c03          	ld	s8,192(sp)
    8000110c:	0c813c83          	ld	s9,200(sp)
    80001110:	0d013d03          	ld	s10,208(sp)
    80001114:	0d813d83          	ld	s11,216(sp)
    80001118:	0e013e03          	ld	t3,224(sp)
    8000111c:	0e813e83          	ld	t4,232(sp)
    80001120:	0f013f03          	ld	t5,240(sp)
    80001124:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001128:	10010113          	addi	sp,sp,256

    sret
    8000112c:	10200073          	sret

0000000080001130 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>:
.global _ZN3TCB13contextSwitchEPNS_7ContextES1_
.type _ZN3TCB13contextSwitchEPNS_7ContextES1_, @function
_ZN3TCB13contextSwitchEPNS_7ContextES1_:
    sd ra, 0 * 8(a0)
    80001130:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    80001134:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001138:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    8000113c:	0085b103          	ld	sp,8(a1)

    80001140:	00008067          	ret

0000000080001144 <_Z9mem_allocm>:

#include "../h/syscall_c.hpp"
#include "../h/printing.hpp"

void* mem_alloc(size_t size)
{
    80001144:	fd010113          	addi	sp,sp,-48
    80001148:	02813423          	sd	s0,40(sp)
    8000114c:	03010413          	addi	s0,sp,48

    void* volatile address = nullptr;
    80001150:	fe043423          	sd	zero,-24(s0)
    uint64 volatile number = 0x01;
    80001154:	00100793          	li	a5,1
    80001158:	fef43023          	sd	a5,-32(s0)
    uint64 volatile numberOfBlocks = (size + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE;
    8000115c:	03f50513          	addi	a0,a0,63
    80001160:	00655513          	srli	a0,a0,0x6
    80001164:	fca43c23          	sd	a0,-40(s0)
    //printString("x");
    //printInteger( numberOfBlocks);
    //printString("x");
    //printString("\n");
    __asm__ volatile("mv a0, %0" : : "r" (number));
    80001168:	fe043783          	ld	a5,-32(s0)
    8000116c:	00078513          	mv	a0,a5
    __asm__ volatile("mv a1, %0" : : "r" (numberOfBlocks));
    80001170:	fd843783          	ld	a5,-40(s0)
    80001174:	00078593          	mv	a1,a5

    __asm__ volatile("ecall");
    80001178:	00000073          	ecall

    __asm__ volatile("mv %0, a0" : "=r" (address));
    8000117c:	00050793          	mv	a5,a0
    80001180:	fef43423          	sd	a5,-24(s0)

    return address;
    80001184:	fe843503          	ld	a0,-24(s0)

    //return __mem_alloc(size);
}
    80001188:	02813403          	ld	s0,40(sp)
    8000118c:	03010113          	addi	sp,sp,48
    80001190:	00008067          	ret

0000000080001194 <_Z8mem_freePv>:

int mem_free(void* address)
{
    80001194:	fe010113          	addi	sp,sp,-32
    80001198:	00813c23          	sd	s0,24(sp)
    8000119c:	02010413          	addi	s0,sp,32
    int volatile returnValue;
    uint64 volatile number = 0x02;
    800011a0:	00200793          	li	a5,2
    800011a4:	fef43023          	sd	a5,-32(s0)

    __asm__ volatile("mv a1, %0" : : "r" (address));
    800011a8:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r" (number));
    800011ac:	fe043783          	ld	a5,-32(s0)
    800011b0:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    800011b4:	00000073          	ecall


    __asm__ volatile("mv %0, a0" : "=r" (returnValue));
    800011b8:	00050793          	mv	a5,a0
    800011bc:	fef42623          	sw	a5,-20(s0)

    return returnValue;
    800011c0:	fec42503          	lw	a0,-20(s0)

    //return __mem_free(address);
}
    800011c4:	0005051b          	sext.w	a0,a0
    800011c8:	01813403          	ld	s0,24(sp)
    800011cc:	02010113          	addi	sp,sp,32
    800011d0:	00008067          	ret

00000000800011d4 <_Z13thread_createPP3TCBPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg)
{
    800011d4:	fb010113          	addi	sp,sp,-80
    800011d8:	04113423          	sd	ra,72(sp)
    800011dc:	04813023          	sd	s0,64(sp)
    800011e0:	02913c23          	sd	s1,56(sp)
    800011e4:	05010413          	addi	s0,sp,80
    800011e8:	00058493          	mv	s1,a1
    thread_t* volatile local_handle = handle;
    800011ec:	fca43c23          	sd	a0,-40(s0)
    void(*local_start_routine)(void*) = start_routine;
    void* volatile local_arg = arg;
    800011f0:	fcc43823          	sd	a2,-48(s0)

    //mem_alloc stack-a

    void* volatile stack;
    stack = mem_alloc(DEFAULT_STACK_SIZE * sizeof(uint64));
    800011f4:	00008537          	lui	a0,0x8
    800011f8:	00000097          	auipc	ra,0x0
    800011fc:	f4c080e7          	jalr	-180(ra) # 80001144 <_Z9mem_allocm>
    80001200:	fca43423          	sd	a0,-56(s0)

    //thread_create

    int volatile returnValue;
    uint64 volatile number = 0x11;
    80001204:	01100793          	li	a5,17
    80001208:	faf43c23          	sd	a5,-72(s0)

    __asm__ volatile("mv a0, %0" : : "r" (number));
    8000120c:	fb843783          	ld	a5,-72(s0)
    80001210:	00078513          	mv	a0,a5
    __asm__ volatile("mv a1, %0" : : "r" (local_handle));
    80001214:	fd843783          	ld	a5,-40(s0)
    80001218:	00078593          	mv	a1,a5
    __asm__ volatile("mv a2, %0" : : "r" (local_start_routine));
    8000121c:	00048613          	mv	a2,s1
    __asm__ volatile("mv a3, %0" : : "r" (local_arg));
    80001220:	fd043783          	ld	a5,-48(s0)
    80001224:	00078693          	mv	a3,a5
    __asm__ volatile("mv a4, %0" : : "r" (stack));
    80001228:	fc843783          	ld	a5,-56(s0)
    8000122c:	00078713          	mv	a4,a5

    __asm__ volatile("ecall");
    80001230:	00000073          	ecall

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));
    80001234:	00050793          	mv	a5,a0
    80001238:	fcf42223          	sw	a5,-60(s0)

    return returnValue;
    8000123c:	fc442503          	lw	a0,-60(s0)
}
    80001240:	0005051b          	sext.w	a0,a0
    80001244:	04813083          	ld	ra,72(sp)
    80001248:	04013403          	ld	s0,64(sp)
    8000124c:	03813483          	ld	s1,56(sp)
    80001250:	05010113          	addi	sp,sp,80
    80001254:	00008067          	ret

0000000080001258 <_Z11thread_exitv>:

int thread_exit()
{
    80001258:	fe010113          	addi	sp,sp,-32
    8000125c:	00813c23          	sd	s0,24(sp)
    80001260:	02010413          	addi	s0,sp,32
    int volatile returnValue;
    uint64 volatile number = 0x12;
    80001264:	01200793          	li	a5,18
    80001268:	fef43023          	sd	a5,-32(s0)

    __asm__ volatile("mv a0, %0" : : "r" (number));
    8000126c:	fe043783          	ld	a5,-32(s0)
    80001270:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    80001274:	00000073          	ecall

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));
    80001278:	00050793          	mv	a5,a0
    8000127c:	fef42623          	sw	a5,-20(s0)

    return returnValue;
    80001280:	fec42503          	lw	a0,-20(s0)
}
    80001284:	0005051b          	sext.w	a0,a0
    80001288:	01813403          	ld	s0,24(sp)
    8000128c:	02010113          	addi	sp,sp,32
    80001290:	00008067          	ret

0000000080001294 <_Z15thread_dispatchv>:

void thread_dispatch()
{
    80001294:	fe010113          	addi	sp,sp,-32
    80001298:	00813c23          	sd	s0,24(sp)
    8000129c:	02010413          	addi	s0,sp,32
    uint64 volatile number = 0x13;
    800012a0:	01300793          	li	a5,19
    800012a4:	fef43423          	sd	a5,-24(s0)

    __asm__ volatile("mv a0, %0" : : "r" (number));
    800012a8:	fe843783          	ld	a5,-24(s0)
    800012ac:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    800012b0:	00000073          	ecall
}
    800012b4:	01813403          	ld	s0,24(sp)
    800012b8:	02010113          	addi	sp,sp,32
    800012bc:	00008067          	ret

00000000800012c0 <_Z4sendP3TCBPc>:

void send(thread_t handle, char* message)
{
    800012c0:	fe010113          	addi	sp,sp,-32
    800012c4:	00813c23          	sd	s0,24(sp)
    800012c8:	02010413          	addi	s0,sp,32
    uint64 volatile number = 0x14;
    800012cc:	01400793          	li	a5,20
    800012d0:	fef43423          	sd	a5,-24(s0)

    __asm__ volatile("mv a2, %0" : : "r" (message));
    800012d4:	00058613          	mv	a2,a1
    __asm__ volatile("mv a1, %0" : : "r" (handle));
    800012d8:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r" (number));
    800012dc:	fe843783          	ld	a5,-24(s0)
    800012e0:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    800012e4:	00000073          	ecall
}
    800012e8:	01813403          	ld	s0,24(sp)
    800012ec:	02010113          	addi	sp,sp,32
    800012f0:	00008067          	ret

00000000800012f4 <_Z7receivev>:

char* receive()
{
    800012f4:	fe010113          	addi	sp,sp,-32
    800012f8:	00813c23          	sd	s0,24(sp)
    800012fc:	02010413          	addi	s0,sp,32
    char* volatile returnValue;
    uint64 volatile number = 0x15;
    80001300:	01500793          	li	a5,21
    80001304:	fef43023          	sd	a5,-32(s0)

    __asm__ volatile("mv a0, %0" : : "r" (number));
    80001308:	fe043783          	ld	a5,-32(s0)
    8000130c:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    80001310:	00000073          	ecall

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));
    80001314:	00050793          	mv	a5,a0
    80001318:	fef43423          	sd	a5,-24(s0)

    return returnValue;
    8000131c:	fe843503          	ld	a0,-24(s0)
}
    80001320:	01813403          	ld	s0,24(sp)
    80001324:	02010113          	addi	sp,sp,32
    80001328:	00008067          	ret

000000008000132c <_Z8sem_openPP11MySemaphorej>:

int sem_open(sem_t* handle, unsigned init)
{
    8000132c:	fe010113          	addi	sp,sp,-32
    80001330:	00813c23          	sd	s0,24(sp)
    80001334:	02010413          	addi	s0,sp,32
    int volatile returnValue;
    uint64 volatile number = 0x21;
    80001338:	02100793          	li	a5,33
    8000133c:	fef43023          	sd	a5,-32(s0)

    __asm__ volatile("mv a2, %0" : : "r" (init));
    80001340:	00058613          	mv	a2,a1
    __asm__ volatile("mv a1, %0" : : "r" (handle));
    80001344:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r" (number));
    80001348:	fe043783          	ld	a5,-32(s0)
    8000134c:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    80001350:	00000073          	ecall

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));
    80001354:	00050793          	mv	a5,a0
    80001358:	fef42623          	sw	a5,-20(s0)

    return returnValue;
    8000135c:	fec42503          	lw	a0,-20(s0)
}
    80001360:	0005051b          	sext.w	a0,a0
    80001364:	01813403          	ld	s0,24(sp)
    80001368:	02010113          	addi	sp,sp,32
    8000136c:	00008067          	ret

0000000080001370 <_Z9sem_closeP11MySemaphore>:

int sem_close(sem_t handle)
{
    80001370:	fe010113          	addi	sp,sp,-32
    80001374:	00813c23          	sd	s0,24(sp)
    80001378:	02010413          	addi	s0,sp,32
    int volatile returnValue;
    uint64 volatile number = 0x22;
    8000137c:	02200793          	li	a5,34
    80001380:	fef43023          	sd	a5,-32(s0)

    __asm__ volatile("mv a1, %0" : : "r" (handle));
    80001384:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r" (number));
    80001388:	fe043783          	ld	a5,-32(s0)
    8000138c:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    80001390:	00000073          	ecall

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));
    80001394:	00050793          	mv	a5,a0
    80001398:	fef42623          	sw	a5,-20(s0)

    return returnValue;
    8000139c:	fec42503          	lw	a0,-20(s0)
}
    800013a0:	0005051b          	sext.w	a0,a0
    800013a4:	01813403          	ld	s0,24(sp)
    800013a8:	02010113          	addi	sp,sp,32
    800013ac:	00008067          	ret

00000000800013b0 <_Z8sem_waitP11MySemaphore>:

int sem_wait(sem_t id)
{
    800013b0:	fe010113          	addi	sp,sp,-32
    800013b4:	00813c23          	sd	s0,24(sp)
    800013b8:	02010413          	addi	s0,sp,32
    int volatile returnValue;
    uint64 volatile number = 0x23;
    800013bc:	02300793          	li	a5,35
    800013c0:	fef43023          	sd	a5,-32(s0)

    __asm__ volatile("mv a1, %0" : : "r" (id));
    800013c4:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r" (number));
    800013c8:	fe043783          	ld	a5,-32(s0)
    800013cc:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    800013d0:	00000073          	ecall

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));
    800013d4:	00050793          	mv	a5,a0
    800013d8:	fef42623          	sw	a5,-20(s0)

    return returnValue;
    800013dc:	fec42503          	lw	a0,-20(s0)
}
    800013e0:	0005051b          	sext.w	a0,a0
    800013e4:	01813403          	ld	s0,24(sp)
    800013e8:	02010113          	addi	sp,sp,32
    800013ec:	00008067          	ret

00000000800013f0 <_Z10sem_signalP11MySemaphore>:

int sem_signal(sem_t id)
{
    800013f0:	fe010113          	addi	sp,sp,-32
    800013f4:	00813c23          	sd	s0,24(sp)
    800013f8:	02010413          	addi	s0,sp,32
    int volatile returnValue;
    uint64 volatile number = 0x24;
    800013fc:	02400793          	li	a5,36
    80001400:	fef43023          	sd	a5,-32(s0)

    __asm__ volatile("mv a1, %0" : : "r" (id));
    80001404:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r" (number));
    80001408:	fe043783          	ld	a5,-32(s0)
    8000140c:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    80001410:	00000073          	ecall

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));
    80001414:	00050793          	mv	a5,a0
    80001418:	fef42623          	sw	a5,-20(s0)

    return returnValue;
    8000141c:	fec42503          	lw	a0,-20(s0)
}
    80001420:	0005051b          	sext.w	a0,a0
    80001424:	01813403          	ld	s0,24(sp)
    80001428:	02010113          	addi	sp,sp,32
    8000142c:	00008067          	ret

0000000080001430 <_Z11sem_trywaitP11MySemaphore>:

int sem_trywait(sem_t id)
{
    80001430:	fe010113          	addi	sp,sp,-32
    80001434:	00813c23          	sd	s0,24(sp)
    80001438:	02010413          	addi	s0,sp,32
    int volatile returnValue;
    uint64 volatile number = 0x26;
    8000143c:	02600793          	li	a5,38
    80001440:	fef43023          	sd	a5,-32(s0)

    __asm__ volatile("mv a1, %0" : : "r" (id));
    80001444:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r" (number));
    80001448:	fe043783          	ld	a5,-32(s0)
    8000144c:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    80001450:	00000073          	ecall

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));
    80001454:	00050793          	mv	a5,a0
    80001458:	fef42623          	sw	a5,-20(s0)

    return returnValue;
    8000145c:	fec42503          	lw	a0,-20(s0)
}
    80001460:	0005051b          	sext.w	a0,a0
    80001464:	01813403          	ld	s0,24(sp)
    80001468:	02010113          	addi	sp,sp,32
    8000146c:	00008067          	ret

0000000080001470 <_Z4getcv>:

char getc()
{
    80001470:	fe010113          	addi	sp,sp,-32
    80001474:	00813c23          	sd	s0,24(sp)
    80001478:	02010413          	addi	s0,sp,32
    char volatile returnValue;
    uint64 volatile number = 0x41;
    8000147c:	04100793          	li	a5,65
    80001480:	fef43023          	sd	a5,-32(s0)

    __asm__ volatile("mv a0, %0" : : "r" (number));
    80001484:	fe043783          	ld	a5,-32(s0)
    80001488:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    8000148c:	00000073          	ecall

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));
    80001490:	00050793          	mv	a5,a0
    80001494:	fef407a3          	sb	a5,-17(s0)

    return returnValue;
    80001498:	fef44503          	lbu	a0,-17(s0)
}
    8000149c:	0ff57513          	andi	a0,a0,255
    800014a0:	01813403          	ld	s0,24(sp)
    800014a4:	02010113          	addi	sp,sp,32
    800014a8:	00008067          	ret

00000000800014ac <_Z4putcc>:

void putc(char c)
{
    800014ac:	fe010113          	addi	sp,sp,-32
    800014b0:	00813c23          	sd	s0,24(sp)
    800014b4:	02010413          	addi	s0,sp,32
    uint64 volatile number = 0x42;
    800014b8:	04200793          	li	a5,66
    800014bc:	fef43423          	sd	a5,-24(s0)

    __asm__ volatile("mv a1, %0" : : "r" (c));
    800014c0:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r" (number));
    800014c4:	fe843783          	ld	a5,-24(s0)
    800014c8:	00078513          	mv	a0,a5

    __asm__ volatile("ecall");
    800014cc:	00000073          	ecall

    800014d0:	01813403          	ld	s0,24(sp)
    800014d4:	02010113          	addi	sp,sp,32
    800014d8:	00008067          	ret

00000000800014dc <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    800014dc:	fe010113          	addi	sp,sp,-32
    800014e0:	00113c23          	sd	ra,24(sp)
    800014e4:	00813823          	sd	s0,16(sp)
    800014e8:	00913423          	sd	s1,8(sp)
    800014ec:	01213023          	sd	s2,0(sp)
    800014f0:	02010413          	addi	s0,sp,32
    800014f4:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    800014f8:	00000913          	li	s2,0
    800014fc:	00c0006f          	j	80001508 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 'a') {//0x1b
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80001500:	00000097          	auipc	ra,0x0
    80001504:	d94080e7          	jalr	-620(ra) # 80001294 <_Z15thread_dispatchv>
    while ((key = getc()) != 'a') {//0x1b
    80001508:	00000097          	auipc	ra,0x0
    8000150c:	f68080e7          	jalr	-152(ra) # 80001470 <_Z4getcv>
    80001510:	0005059b          	sext.w	a1,a0
    80001514:	06100793          	li	a5,97
    80001518:	02f58a63          	beq	a1,a5,8000154c <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    8000151c:	0084b503          	ld	a0,8(s1)
    80001520:	00004097          	auipc	ra,0x4
    80001524:	364080e7          	jalr	868(ra) # 80005884 <_ZN6Buffer3putEi>
        i++;
    80001528:	0019071b          	addiw	a4,s2,1
    8000152c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80001530:	0004a683          	lw	a3,0(s1)
    80001534:	0026979b          	slliw	a5,a3,0x2
    80001538:	00d787bb          	addw	a5,a5,a3
    8000153c:	0017979b          	slliw	a5,a5,0x1
    80001540:	02f767bb          	remw	a5,a4,a5
    80001544:	fc0792e3          	bnez	a5,80001508 <_ZL16producerKeyboardPv+0x2c>
    80001548:	fb9ff06f          	j	80001500 <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    8000154c:	00100793          	li	a5,1
    80001550:	0000a717          	auipc	a4,0xa
    80001554:	08f72823          	sw	a5,144(a4) # 8000b5e0 <_ZL9threadEnd>
    data->buffer->put('!');
    80001558:	02100593          	li	a1,33
    8000155c:	0084b503          	ld	a0,8(s1)
    80001560:	00004097          	auipc	ra,0x4
    80001564:	324080e7          	jalr	804(ra) # 80005884 <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    80001568:	0104b503          	ld	a0,16(s1)
    8000156c:	00000097          	auipc	ra,0x0
    80001570:	e84080e7          	jalr	-380(ra) # 800013f0 <_Z10sem_signalP11MySemaphore>
}
    80001574:	01813083          	ld	ra,24(sp)
    80001578:	01013403          	ld	s0,16(sp)
    8000157c:	00813483          	ld	s1,8(sp)
    80001580:	00013903          	ld	s2,0(sp)
    80001584:	02010113          	addi	sp,sp,32
    80001588:	00008067          	ret

000000008000158c <_ZL8producerPv>:

static void producer(void *arg) {
    8000158c:	fe010113          	addi	sp,sp,-32
    80001590:	00113c23          	sd	ra,24(sp)
    80001594:	00813823          	sd	s0,16(sp)
    80001598:	00913423          	sd	s1,8(sp)
    8000159c:	01213023          	sd	s2,0(sp)
    800015a0:	02010413          	addi	s0,sp,32
    800015a4:	00050493          	mv	s1,a0

    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800015a8:	00000913          	li	s2,0
    800015ac:	00c0006f          	j	800015b8 <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    800015b0:	00000097          	auipc	ra,0x0
    800015b4:	ce4080e7          	jalr	-796(ra) # 80001294 <_Z15thread_dispatchv>
    while (!threadEnd) {
    800015b8:	0000a797          	auipc	a5,0xa
    800015bc:	0287a783          	lw	a5,40(a5) # 8000b5e0 <_ZL9threadEnd>
    800015c0:	02079e63          	bnez	a5,800015fc <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    800015c4:	0004a583          	lw	a1,0(s1)
    800015c8:	0305859b          	addiw	a1,a1,48
    800015cc:	0084b503          	ld	a0,8(s1)
    800015d0:	00004097          	auipc	ra,0x4
    800015d4:	2b4080e7          	jalr	692(ra) # 80005884 <_ZN6Buffer3putEi>
        i++;
    800015d8:	0019071b          	addiw	a4,s2,1
    800015dc:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800015e0:	0004a683          	lw	a3,0(s1)
    800015e4:	0026979b          	slliw	a5,a3,0x2
    800015e8:	00d787bb          	addw	a5,a5,a3
    800015ec:	0017979b          	slliw	a5,a5,0x1
    800015f0:	02f767bb          	remw	a5,a4,a5
    800015f4:	fc0792e3          	bnez	a5,800015b8 <_ZL8producerPv+0x2c>
    800015f8:	fb9ff06f          	j	800015b0 <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    800015fc:	0104b503          	ld	a0,16(s1)
    80001600:	00000097          	auipc	ra,0x0
    80001604:	df0080e7          	jalr	-528(ra) # 800013f0 <_Z10sem_signalP11MySemaphore>
}
    80001608:	01813083          	ld	ra,24(sp)
    8000160c:	01013403          	ld	s0,16(sp)
    80001610:	00813483          	ld	s1,8(sp)
    80001614:	00013903          	ld	s2,0(sp)
    80001618:	02010113          	addi	sp,sp,32
    8000161c:	00008067          	ret

0000000080001620 <_ZL8consumerPv>:

static void consumer(void *arg) {
    80001620:	fd010113          	addi	sp,sp,-48
    80001624:	02113423          	sd	ra,40(sp)
    80001628:	02813023          	sd	s0,32(sp)
    8000162c:	00913c23          	sd	s1,24(sp)
    80001630:	01213823          	sd	s2,16(sp)
    80001634:	01313423          	sd	s3,8(sp)
    80001638:	03010413          	addi	s0,sp,48
    8000163c:	00050913          	mv	s2,a0

    struct thread_data *data = (struct thread_data *) arg;
    //printInt((uint64) TCB::running);
    int i = 0;
    80001640:	00000993          	li	s3,0
    80001644:	01c0006f          	j	80001660 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    80001648:	00000097          	auipc	ra,0x0
    8000164c:	c4c080e7          	jalr	-948(ra) # 80001294 <_Z15thread_dispatchv>
    80001650:	0500006f          	j	800016a0 <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    80001654:	00a00513          	li	a0,10
    80001658:	00000097          	auipc	ra,0x0
    8000165c:	e54080e7          	jalr	-428(ra) # 800014ac <_Z4putcc>
    while (!threadEnd) {
    80001660:	0000a797          	auipc	a5,0xa
    80001664:	f807a783          	lw	a5,-128(a5) # 8000b5e0 <_ZL9threadEnd>
    80001668:	06079063          	bnez	a5,800016c8 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    8000166c:	00893503          	ld	a0,8(s2)
    80001670:	00004097          	auipc	ra,0x4
    80001674:	2a4080e7          	jalr	676(ra) # 80005914 <_ZN6Buffer3getEv>
        i++;
    80001678:	0019849b          	addiw	s1,s3,1
    8000167c:	0004899b          	sext.w	s3,s1
        putc(key);
    80001680:	0ff57513          	andi	a0,a0,255
    80001684:	00000097          	auipc	ra,0x0
    80001688:	e28080e7          	jalr	-472(ra) # 800014ac <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    8000168c:	00092703          	lw	a4,0(s2)
    80001690:	0027179b          	slliw	a5,a4,0x2
    80001694:	00e787bb          	addw	a5,a5,a4
    80001698:	02f4e7bb          	remw	a5,s1,a5
    8000169c:	fa0786e3          	beqz	a5,80001648 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    800016a0:	05000793          	li	a5,80
    800016a4:	02f4e4bb          	remw	s1,s1,a5
    800016a8:	fa049ce3          	bnez	s1,80001660 <_ZL8consumerPv+0x40>
    800016ac:	fa9ff06f          	j	80001654 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    800016b0:	00893503          	ld	a0,8(s2)
    800016b4:	00004097          	auipc	ra,0x4
    800016b8:	260080e7          	jalr	608(ra) # 80005914 <_ZN6Buffer3getEv>
        putc(key);
    800016bc:	0ff57513          	andi	a0,a0,255
    800016c0:	00000097          	auipc	ra,0x0
    800016c4:	dec080e7          	jalr	-532(ra) # 800014ac <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    800016c8:	00893503          	ld	a0,8(s2)
    800016cc:	00004097          	auipc	ra,0x4
    800016d0:	2d4080e7          	jalr	724(ra) # 800059a0 <_ZN6Buffer6getCntEv>
    800016d4:	fca04ee3          	bgtz	a0,800016b0 <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    800016d8:	01093503          	ld	a0,16(s2)
    800016dc:	00000097          	auipc	ra,0x0
    800016e0:	d14080e7          	jalr	-748(ra) # 800013f0 <_Z10sem_signalP11MySemaphore>
}
    800016e4:	02813083          	ld	ra,40(sp)
    800016e8:	02013403          	ld	s0,32(sp)
    800016ec:	01813483          	ld	s1,24(sp)
    800016f0:	01013903          	ld	s2,16(sp)
    800016f4:	00813983          	ld	s3,8(sp)
    800016f8:	03010113          	addi	sp,sp,48
    800016fc:	00008067          	ret

0000000080001700 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    80001700:	f9010113          	addi	sp,sp,-112
    80001704:	06113423          	sd	ra,104(sp)
    80001708:	06813023          	sd	s0,96(sp)
    8000170c:	04913c23          	sd	s1,88(sp)
    80001710:	05213823          	sd	s2,80(sp)
    80001714:	05313423          	sd	s3,72(sp)
    80001718:	05413023          	sd	s4,64(sp)
    8000171c:	03513c23          	sd	s5,56(sp)
    80001720:	03613823          	sd	s6,48(sp)
    80001724:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    80001728:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    8000172c:	00008517          	auipc	a0,0x8
    80001730:	8f450513          	addi	a0,a0,-1804 # 80009020 <CONSOLE_STATUS+0x10>
    80001734:	00002097          	auipc	ra,0x2
    80001738:	168080e7          	jalr	360(ra) # 8000389c <_Z11printStringPKc>
    getString(input, 30);
    8000173c:	01e00593          	li	a1,30
    80001740:	fa040493          	addi	s1,s0,-96
    80001744:	00048513          	mv	a0,s1
    80001748:	00002097          	auipc	ra,0x2
    8000174c:	1dc080e7          	jalr	476(ra) # 80003924 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80001750:	00048513          	mv	a0,s1
    80001754:	00002097          	auipc	ra,0x2
    80001758:	2a8080e7          	jalr	680(ra) # 800039fc <_Z11stringToIntPKc>
    8000175c:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80001760:	00008517          	auipc	a0,0x8
    80001764:	8e050513          	addi	a0,a0,-1824 # 80009040 <CONSOLE_STATUS+0x30>
    80001768:	00002097          	auipc	ra,0x2
    8000176c:	134080e7          	jalr	308(ra) # 8000389c <_Z11printStringPKc>
    getString(input, 30);
    80001770:	01e00593          	li	a1,30
    80001774:	00048513          	mv	a0,s1
    80001778:	00002097          	auipc	ra,0x2
    8000177c:	1ac080e7          	jalr	428(ra) # 80003924 <_Z9getStringPci>
    n = stringToInt(input);
    80001780:	00048513          	mv	a0,s1
    80001784:	00002097          	auipc	ra,0x2
    80001788:	278080e7          	jalr	632(ra) # 800039fc <_Z11stringToIntPKc>
    8000178c:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80001790:	00008517          	auipc	a0,0x8
    80001794:	8d050513          	addi	a0,a0,-1840 # 80009060 <CONSOLE_STATUS+0x50>
    80001798:	00002097          	auipc	ra,0x2
    8000179c:	104080e7          	jalr	260(ra) # 8000389c <_Z11printStringPKc>
    800017a0:	00000613          	li	a2,0
    800017a4:	00a00593          	li	a1,10
    800017a8:	00090513          	mv	a0,s2
    800017ac:	00002097          	auipc	ra,0x2
    800017b0:	2a0080e7          	jalr	672(ra) # 80003a4c <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    800017b4:	00008517          	auipc	a0,0x8
    800017b8:	8c450513          	addi	a0,a0,-1852 # 80009078 <CONSOLE_STATUS+0x68>
    800017bc:	00002097          	auipc	ra,0x2
    800017c0:	0e0080e7          	jalr	224(ra) # 8000389c <_Z11printStringPKc>
    800017c4:	00000613          	li	a2,0
    800017c8:	00a00593          	li	a1,10
    800017cc:	00048513          	mv	a0,s1
    800017d0:	00002097          	auipc	ra,0x2
    800017d4:	27c080e7          	jalr	636(ra) # 80003a4c <_Z8printIntiii>
    printString(".\n");
    800017d8:	00008517          	auipc	a0,0x8
    800017dc:	8b850513          	addi	a0,a0,-1864 # 80009090 <CONSOLE_STATUS+0x80>
    800017e0:	00002097          	auipc	ra,0x2
    800017e4:	0bc080e7          	jalr	188(ra) # 8000389c <_Z11printStringPKc>
    if(threadNum > n) {
    800017e8:	0324c463          	blt	s1,s2,80001810 <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    800017ec:	03205c63          	blez	s2,80001824 <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    800017f0:	03800513          	li	a0,56
    800017f4:	00003097          	auipc	ra,0x3
    800017f8:	e6c080e7          	jalr	-404(ra) # 80004660 <_Znwm>
    800017fc:	00050a13          	mv	s4,a0
    80001800:	00048593          	mv	a1,s1
    80001804:	00004097          	auipc	ra,0x4
    80001808:	fe4080e7          	jalr	-28(ra) # 800057e8 <_ZN6BufferC1Ei>
    8000180c:	0300006f          	j	8000183c <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80001810:	00008517          	auipc	a0,0x8
    80001814:	88850513          	addi	a0,a0,-1912 # 80009098 <CONSOLE_STATUS+0x88>
    80001818:	00002097          	auipc	ra,0x2
    8000181c:	084080e7          	jalr	132(ra) # 8000389c <_Z11printStringPKc>
        return;
    80001820:	0140006f          	j	80001834 <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80001824:	00008517          	auipc	a0,0x8
    80001828:	8b450513          	addi	a0,a0,-1868 # 800090d8 <CONSOLE_STATUS+0xc8>
    8000182c:	00002097          	auipc	ra,0x2
    80001830:	070080e7          	jalr	112(ra) # 8000389c <_Z11printStringPKc>
        return;
    80001834:	000b0113          	mv	sp,s6
    80001838:	1500006f          	j	80001988 <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    8000183c:	00000593          	li	a1,0
    80001840:	0000a517          	auipc	a0,0xa
    80001844:	da850513          	addi	a0,a0,-600 # 8000b5e8 <_ZL10waitForAll>
    80001848:	00000097          	auipc	ra,0x0
    8000184c:	ae4080e7          	jalr	-1308(ra) # 8000132c <_Z8sem_openPP11MySemaphorej>
    thread_t threads[threadNum];
    80001850:	00391793          	slli	a5,s2,0x3
    80001854:	00f78793          	addi	a5,a5,15
    80001858:	ff07f793          	andi	a5,a5,-16
    8000185c:	40f10133          	sub	sp,sp,a5
    80001860:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    80001864:	0019071b          	addiw	a4,s2,1
    80001868:	00171793          	slli	a5,a4,0x1
    8000186c:	00e787b3          	add	a5,a5,a4
    80001870:	00379793          	slli	a5,a5,0x3
    80001874:	00f78793          	addi	a5,a5,15
    80001878:	ff07f793          	andi	a5,a5,-16
    8000187c:	40f10133          	sub	sp,sp,a5
    80001880:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    80001884:	00191613          	slli	a2,s2,0x1
    80001888:	012607b3          	add	a5,a2,s2
    8000188c:	00379793          	slli	a5,a5,0x3
    80001890:	00f987b3          	add	a5,s3,a5
    80001894:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80001898:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    8000189c:	0000a717          	auipc	a4,0xa
    800018a0:	d4c73703          	ld	a4,-692(a4) # 8000b5e8 <_ZL10waitForAll>
    800018a4:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    800018a8:	00078613          	mv	a2,a5
    800018ac:	00000597          	auipc	a1,0x0
    800018b0:	d7458593          	addi	a1,a1,-652 # 80001620 <_ZL8consumerPv>
    800018b4:	f9840513          	addi	a0,s0,-104
    800018b8:	00000097          	auipc	ra,0x0
    800018bc:	91c080e7          	jalr	-1764(ra) # 800011d4 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    800018c0:	00000493          	li	s1,0
    800018c4:	0280006f          	j	800018ec <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    800018c8:	00000597          	auipc	a1,0x0
    800018cc:	c1458593          	addi	a1,a1,-1004 # 800014dc <_ZL16producerKeyboardPv>
                      data + i);
    800018d0:	00179613          	slli	a2,a5,0x1
    800018d4:	00f60633          	add	a2,a2,a5
    800018d8:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    800018dc:	00c98633          	add	a2,s3,a2
    800018e0:	00000097          	auipc	ra,0x0
    800018e4:	8f4080e7          	jalr	-1804(ra) # 800011d4 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    800018e8:	0014849b          	addiw	s1,s1,1
    800018ec:	0524d263          	bge	s1,s2,80001930 <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    800018f0:	00149793          	slli	a5,s1,0x1
    800018f4:	009787b3          	add	a5,a5,s1
    800018f8:	00379793          	slli	a5,a5,0x3
    800018fc:	00f987b3          	add	a5,s3,a5
    80001900:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80001904:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80001908:	0000a717          	auipc	a4,0xa
    8000190c:	ce073703          	ld	a4,-800(a4) # 8000b5e8 <_ZL10waitForAll>
    80001910:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80001914:	00048793          	mv	a5,s1
    80001918:	00349513          	slli	a0,s1,0x3
    8000191c:	00aa8533          	add	a0,s5,a0
    80001920:	fa9054e3          	blez	s1,800018c8 <_Z22producerConsumer_C_APIv+0x1c8>
    80001924:	00000597          	auipc	a1,0x0
    80001928:	c6858593          	addi	a1,a1,-920 # 8000158c <_ZL8producerPv>
    8000192c:	fa5ff06f          	j	800018d0 <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    80001930:	00000097          	auipc	ra,0x0
    80001934:	964080e7          	jalr	-1692(ra) # 80001294 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80001938:	00000493          	li	s1,0
    8000193c:	00994e63          	blt	s2,s1,80001958 <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    80001940:	0000a517          	auipc	a0,0xa
    80001944:	ca853503          	ld	a0,-856(a0) # 8000b5e8 <_ZL10waitForAll>
    80001948:	00000097          	auipc	ra,0x0
    8000194c:	a68080e7          	jalr	-1432(ra) # 800013b0 <_Z8sem_waitP11MySemaphore>
    for (int i = 0; i <= threadNum; i++) {
    80001950:	0014849b          	addiw	s1,s1,1
    80001954:	fe9ff06f          	j	8000193c <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    80001958:	0000a517          	auipc	a0,0xa
    8000195c:	c9053503          	ld	a0,-880(a0) # 8000b5e8 <_ZL10waitForAll>
    80001960:	00000097          	auipc	ra,0x0
    80001964:	a10080e7          	jalr	-1520(ra) # 80001370 <_Z9sem_closeP11MySemaphore>
    delete buffer;
    80001968:	000a0e63          	beqz	s4,80001984 <_Z22producerConsumer_C_APIv+0x284>
    8000196c:	000a0513          	mv	a0,s4
    80001970:	00004097          	auipc	ra,0x4
    80001974:	0b8080e7          	jalr	184(ra) # 80005a28 <_ZN6BufferD1Ev>
    80001978:	000a0513          	mv	a0,s4
    8000197c:	00003097          	auipc	ra,0x3
    80001980:	d34080e7          	jalr	-716(ra) # 800046b0 <_ZdlPv>
    80001984:	000b0113          	mv	sp,s6

}
    80001988:	f9040113          	addi	sp,s0,-112
    8000198c:	06813083          	ld	ra,104(sp)
    80001990:	06013403          	ld	s0,96(sp)
    80001994:	05813483          	ld	s1,88(sp)
    80001998:	05013903          	ld	s2,80(sp)
    8000199c:	04813983          	ld	s3,72(sp)
    800019a0:	04013a03          	ld	s4,64(sp)
    800019a4:	03813a83          	ld	s5,56(sp)
    800019a8:	03013b03          	ld	s6,48(sp)
    800019ac:	07010113          	addi	sp,sp,112
    800019b0:	00008067          	ret
    800019b4:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    800019b8:	000a0513          	mv	a0,s4
    800019bc:	00003097          	auipc	ra,0x3
    800019c0:	cf4080e7          	jalr	-780(ra) # 800046b0 <_ZdlPv>
    800019c4:	00048513          	mv	a0,s1
    800019c8:	0000b097          	auipc	ra,0xb
    800019cc:	d80080e7          	jalr	-640(ra) # 8000c748 <_Unwind_Resume>

00000000800019d0 <_ZL9fibonaccim>:
    }

}

static uint64 fibonacci(uint64 n)
{
    800019d0:	fe010113          	addi	sp,sp,-32
    800019d4:	00113c23          	sd	ra,24(sp)
    800019d8:	00813823          	sd	s0,16(sp)
    800019dc:	00913423          	sd	s1,8(sp)
    800019e0:	01213023          	sd	s2,0(sp)
    800019e4:	02010413          	addi	s0,sp,32
    800019e8:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800019ec:	00100793          	li	a5,1
    800019f0:	02a7f863          	bgeu	a5,a0,80001a20 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800019f4:	00a00793          	li	a5,10
    800019f8:	02f577b3          	remu	a5,a0,a5
    800019fc:	02078e63          	beqz	a5,80001a38 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80001a00:	fff48513          	addi	a0,s1,-1
    80001a04:	00000097          	auipc	ra,0x0
    80001a08:	fcc080e7          	jalr	-52(ra) # 800019d0 <_ZL9fibonaccim>
    80001a0c:	00050913          	mv	s2,a0
    80001a10:	ffe48513          	addi	a0,s1,-2
    80001a14:	00000097          	auipc	ra,0x0
    80001a18:	fbc080e7          	jalr	-68(ra) # 800019d0 <_ZL9fibonaccim>
    80001a1c:	00a90533          	add	a0,s2,a0
}
    80001a20:	01813083          	ld	ra,24(sp)
    80001a24:	01013403          	ld	s0,16(sp)
    80001a28:	00813483          	ld	s1,8(sp)
    80001a2c:	00013903          	ld	s2,0(sp)
    80001a30:	02010113          	addi	sp,sp,32
    80001a34:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80001a38:	00000097          	auipc	ra,0x0
    80001a3c:	85c080e7          	jalr	-1956(ra) # 80001294 <_Z15thread_dispatchv>
    80001a40:	fc1ff06f          	j	80001a00 <_ZL9fibonaccim+0x30>

0000000080001a44 <_Z11workerBodyAPv>:
{
    80001a44:	fe010113          	addi	sp,sp,-32
    80001a48:	00113c23          	sd	ra,24(sp)
    80001a4c:	00813823          	sd	s0,16(sp)
    80001a50:	00913423          	sd	s1,8(sp)
    80001a54:	01213023          	sd	s2,0(sp)
    80001a58:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++)
    80001a5c:	00000913          	li	s2,0
    80001a60:	0380006f          	j	80001a98 <_Z11workerBodyAPv+0x54>
            thread_dispatch();
    80001a64:	00000097          	auipc	ra,0x0
    80001a68:	830080e7          	jalr	-2000(ra) # 80001294 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++)
    80001a6c:	00148493          	addi	s1,s1,1
    80001a70:	000027b7          	lui	a5,0x2
    80001a74:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001a78:	0097ee63          	bltu	a5,s1,80001a94 <_Z11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++)
    80001a7c:	00000713          	li	a4,0
    80001a80:	000077b7          	lui	a5,0x7
    80001a84:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001a88:	fce7eee3          	bltu	a5,a4,80001a64 <_Z11workerBodyAPv+0x20>
    80001a8c:	00170713          	addi	a4,a4,1
    80001a90:	ff1ff06f          	j	80001a80 <_Z11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++)
    80001a94:	00190913          	addi	s2,s2,1
    80001a98:	00900793          	li	a5,9
    80001a9c:	0527e063          	bltu	a5,s2,80001adc <_Z11workerBodyAPv+0x98>
        printString("A: i=");
    80001aa0:	00007517          	auipc	a0,0x7
    80001aa4:	66850513          	addi	a0,a0,1640 # 80009108 <CONSOLE_STATUS+0xf8>
    80001aa8:	00002097          	auipc	ra,0x2
    80001aac:	df4080e7          	jalr	-524(ra) # 8000389c <_Z11printStringPKc>
        printInt(i);
    80001ab0:	00000613          	li	a2,0
    80001ab4:	00a00593          	li	a1,10
    80001ab8:	0009051b          	sext.w	a0,s2
    80001abc:	00002097          	auipc	ra,0x2
    80001ac0:	f90080e7          	jalr	-112(ra) # 80003a4c <_Z8printIntiii>
        printString("\n");
    80001ac4:	00008517          	auipc	a0,0x8
    80001ac8:	8e450513          	addi	a0,a0,-1820 # 800093a8 <CONSOLE_STATUS+0x398>
    80001acc:	00002097          	auipc	ra,0x2
    80001ad0:	dd0080e7          	jalr	-560(ra) # 8000389c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++)
    80001ad4:	00000493          	li	s1,0
    80001ad8:	f99ff06f          	j	80001a70 <_Z11workerBodyAPv+0x2c>
}
    80001adc:	01813083          	ld	ra,24(sp)
    80001ae0:	01013403          	ld	s0,16(sp)
    80001ae4:	00813483          	ld	s1,8(sp)
    80001ae8:	00013903          	ld	s2,0(sp)
    80001aec:	02010113          	addi	sp,sp,32
    80001af0:	00008067          	ret

0000000080001af4 <_Z11workerBodyBPv>:
{
    80001af4:	fe010113          	addi	sp,sp,-32
    80001af8:	00113c23          	sd	ra,24(sp)
    80001afc:	00813823          	sd	s0,16(sp)
    80001b00:	00913423          	sd	s1,8(sp)
    80001b04:	01213023          	sd	s2,0(sp)
    80001b08:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++)
    80001b0c:	00000913          	li	s2,0
    80001b10:	0380006f          	j	80001b48 <_Z11workerBodyBPv+0x54>
            thread_dispatch();
    80001b14:	fffff097          	auipc	ra,0xfffff
    80001b18:	780080e7          	jalr	1920(ra) # 80001294 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++)
    80001b1c:	00148493          	addi	s1,s1,1
    80001b20:	000027b7          	lui	a5,0x2
    80001b24:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001b28:	0097ee63          	bltu	a5,s1,80001b44 <_Z11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++)
    80001b2c:	00000713          	li	a4,0
    80001b30:	000077b7          	lui	a5,0x7
    80001b34:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001b38:	fce7eee3          	bltu	a5,a4,80001b14 <_Z11workerBodyBPv+0x20>
    80001b3c:	00170713          	addi	a4,a4,1
    80001b40:	ff1ff06f          	j	80001b30 <_Z11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++)
    80001b44:	00190913          	addi	s2,s2,1
    80001b48:	00f00793          	li	a5,15
    80001b4c:	0527e063          	bltu	a5,s2,80001b8c <_Z11workerBodyBPv+0x98>
        printString("B: i=");
    80001b50:	00007517          	auipc	a0,0x7
    80001b54:	5c050513          	addi	a0,a0,1472 # 80009110 <CONSOLE_STATUS+0x100>
    80001b58:	00002097          	auipc	ra,0x2
    80001b5c:	d44080e7          	jalr	-700(ra) # 8000389c <_Z11printStringPKc>
        printInt(i);
    80001b60:	00000613          	li	a2,0
    80001b64:	00a00593          	li	a1,10
    80001b68:	0009051b          	sext.w	a0,s2
    80001b6c:	00002097          	auipc	ra,0x2
    80001b70:	ee0080e7          	jalr	-288(ra) # 80003a4c <_Z8printIntiii>
        printString("\n");
    80001b74:	00008517          	auipc	a0,0x8
    80001b78:	83450513          	addi	a0,a0,-1996 # 800093a8 <CONSOLE_STATUS+0x398>
    80001b7c:	00002097          	auipc	ra,0x2
    80001b80:	d20080e7          	jalr	-736(ra) # 8000389c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++)
    80001b84:	00000493          	li	s1,0
    80001b88:	f99ff06f          	j	80001b20 <_Z11workerBodyBPv+0x2c>
}
    80001b8c:	01813083          	ld	ra,24(sp)
    80001b90:	01013403          	ld	s0,16(sp)
    80001b94:	00813483          	ld	s1,8(sp)
    80001b98:	00013903          	ld	s2,0(sp)
    80001b9c:	02010113          	addi	sp,sp,32
    80001ba0:	00008067          	ret

0000000080001ba4 <_Z11workerBodyCPv>:

void workerBodyC(void*)
{
    80001ba4:	fe010113          	addi	sp,sp,-32
    80001ba8:	00113c23          	sd	ra,24(sp)
    80001bac:	00813823          	sd	s0,16(sp)
    80001bb0:	00913423          	sd	s1,8(sp)
    80001bb4:	01213023          	sd	s2,0(sp)
    80001bb8:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80001bbc:	00000493          	li	s1,0
    80001bc0:	0400006f          	j	80001c00 <_Z11workerBodyCPv+0x5c>
    for (; i < 3; i++)
    {
        printString("C: i=");
    80001bc4:	00007517          	auipc	a0,0x7
    80001bc8:	55450513          	addi	a0,a0,1364 # 80009118 <CONSOLE_STATUS+0x108>
    80001bcc:	00002097          	auipc	ra,0x2
    80001bd0:	cd0080e7          	jalr	-816(ra) # 8000389c <_Z11printStringPKc>
        printInt(i);
    80001bd4:	00000613          	li	a2,0
    80001bd8:	00a00593          	li	a1,10
    80001bdc:	00048513          	mv	a0,s1
    80001be0:	00002097          	auipc	ra,0x2
    80001be4:	e6c080e7          	jalr	-404(ra) # 80003a4c <_Z8printIntiii>
        printString("\n");
    80001be8:	00007517          	auipc	a0,0x7
    80001bec:	7c050513          	addi	a0,a0,1984 # 800093a8 <CONSOLE_STATUS+0x398>
    80001bf0:	00002097          	auipc	ra,0x2
    80001bf4:	cac080e7          	jalr	-852(ra) # 8000389c <_Z11printStringPKc>
    for (; i < 3; i++)
    80001bf8:	0014849b          	addiw	s1,s1,1
    80001bfc:	0ff4f493          	andi	s1,s1,255
    80001c00:	00200793          	li	a5,2
    80001c04:	fc97f0e3          	bgeu	a5,s1,80001bc4 <_Z11workerBodyCPv+0x20>
    }

    printString("C: yield\n");
    80001c08:	00007517          	auipc	a0,0x7
    80001c0c:	51850513          	addi	a0,a0,1304 # 80009120 <CONSOLE_STATUS+0x110>
    80001c10:	00002097          	auipc	ra,0x2
    80001c14:	c8c080e7          	jalr	-884(ra) # 8000389c <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80001c18:	00700313          	li	t1,7
    thread_dispatch();
    80001c1c:	fffff097          	auipc	ra,0xfffff
    80001c20:	678080e7          	jalr	1656(ra) # 80001294 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80001c24:	00030913          	mv	s2,t1

    printString("C: t1=");
    80001c28:	00007517          	auipc	a0,0x7
    80001c2c:	50850513          	addi	a0,a0,1288 # 80009130 <CONSOLE_STATUS+0x120>
    80001c30:	00002097          	auipc	ra,0x2
    80001c34:	c6c080e7          	jalr	-916(ra) # 8000389c <_Z11printStringPKc>
    printInt(t1);
    80001c38:	00000613          	li	a2,0
    80001c3c:	00a00593          	li	a1,10
    80001c40:	0009051b          	sext.w	a0,s2
    80001c44:	00002097          	auipc	ra,0x2
    80001c48:	e08080e7          	jalr	-504(ra) # 80003a4c <_Z8printIntiii>
    printString("\n");
    80001c4c:	00007517          	auipc	a0,0x7
    80001c50:	75c50513          	addi	a0,a0,1884 # 800093a8 <CONSOLE_STATUS+0x398>
    80001c54:	00002097          	auipc	ra,0x2
    80001c58:	c48080e7          	jalr	-952(ra) # 8000389c <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80001c5c:	00c00513          	li	a0,12
    80001c60:	00000097          	auipc	ra,0x0
    80001c64:	d70080e7          	jalr	-656(ra) # 800019d0 <_ZL9fibonaccim>
    80001c68:	00050913          	mv	s2,a0
    printString("C: fibonaci=");
    80001c6c:	00007517          	auipc	a0,0x7
    80001c70:	4cc50513          	addi	a0,a0,1228 # 80009138 <CONSOLE_STATUS+0x128>
    80001c74:	00002097          	auipc	ra,0x2
    80001c78:	c28080e7          	jalr	-984(ra) # 8000389c <_Z11printStringPKc>
    printInt(result);
    80001c7c:	00000613          	li	a2,0
    80001c80:	00a00593          	li	a1,10
    80001c84:	0009051b          	sext.w	a0,s2
    80001c88:	00002097          	auipc	ra,0x2
    80001c8c:	dc4080e7          	jalr	-572(ra) # 80003a4c <_Z8printIntiii>
    printString("\n");
    80001c90:	00007517          	auipc	a0,0x7
    80001c94:	71850513          	addi	a0,a0,1816 # 800093a8 <CONSOLE_STATUS+0x398>
    80001c98:	00002097          	auipc	ra,0x2
    80001c9c:	c04080e7          	jalr	-1020(ra) # 8000389c <_Z11printStringPKc>
    80001ca0:	0400006f          	j	80001ce0 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++)
    {
        printString("C: i=");
    80001ca4:	00007517          	auipc	a0,0x7
    80001ca8:	47450513          	addi	a0,a0,1140 # 80009118 <CONSOLE_STATUS+0x108>
    80001cac:	00002097          	auipc	ra,0x2
    80001cb0:	bf0080e7          	jalr	-1040(ra) # 8000389c <_Z11printStringPKc>
        printInt(i);
    80001cb4:	00000613          	li	a2,0
    80001cb8:	00a00593          	li	a1,10
    80001cbc:	00048513          	mv	a0,s1
    80001cc0:	00002097          	auipc	ra,0x2
    80001cc4:	d8c080e7          	jalr	-628(ra) # 80003a4c <_Z8printIntiii>
        printString("\n");
    80001cc8:	00007517          	auipc	a0,0x7
    80001ccc:	6e050513          	addi	a0,a0,1760 # 800093a8 <CONSOLE_STATUS+0x398>
    80001cd0:	00002097          	auipc	ra,0x2
    80001cd4:	bcc080e7          	jalr	-1076(ra) # 8000389c <_Z11printStringPKc>
    for (; i < 6; i++)
    80001cd8:	0014849b          	addiw	s1,s1,1
    80001cdc:	0ff4f493          	andi	s1,s1,255
    80001ce0:	00500793          	li	a5,5
    80001ce4:	fc97f0e3          	bgeu	a5,s1,80001ca4 <_Z11workerBodyCPv+0x100>
    }


}
    80001ce8:	01813083          	ld	ra,24(sp)
    80001cec:	01013403          	ld	s0,16(sp)
    80001cf0:	00813483          	ld	s1,8(sp)
    80001cf4:	00013903          	ld	s2,0(sp)
    80001cf8:	02010113          	addi	sp,sp,32
    80001cfc:	00008067          	ret

0000000080001d00 <_Z11workerBodyDPv>:

void workerBodyD(void*)
{
    80001d00:	fe010113          	addi	sp,sp,-32
    80001d04:	00113c23          	sd	ra,24(sp)
    80001d08:	00813823          	sd	s0,16(sp)
    80001d0c:	00913423          	sd	s1,8(sp)
    80001d10:	01213023          	sd	s2,0(sp)
    80001d14:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80001d18:	00a00493          	li	s1,10
    80001d1c:	0400006f          	j	80001d5c <_Z11workerBodyDPv+0x5c>
    for (; i < 13; i++)
    {
        printString("D: i=");
    80001d20:	00007517          	auipc	a0,0x7
    80001d24:	42850513          	addi	a0,a0,1064 # 80009148 <CONSOLE_STATUS+0x138>
    80001d28:	00002097          	auipc	ra,0x2
    80001d2c:	b74080e7          	jalr	-1164(ra) # 8000389c <_Z11printStringPKc>
        printInt(i);
    80001d30:	00000613          	li	a2,0
    80001d34:	00a00593          	li	a1,10
    80001d38:	00048513          	mv	a0,s1
    80001d3c:	00002097          	auipc	ra,0x2
    80001d40:	d10080e7          	jalr	-752(ra) # 80003a4c <_Z8printIntiii>
        printString("\n");
    80001d44:	00007517          	auipc	a0,0x7
    80001d48:	66450513          	addi	a0,a0,1636 # 800093a8 <CONSOLE_STATUS+0x398>
    80001d4c:	00002097          	auipc	ra,0x2
    80001d50:	b50080e7          	jalr	-1200(ra) # 8000389c <_Z11printStringPKc>
    for (; i < 13; i++)
    80001d54:	0014849b          	addiw	s1,s1,1
    80001d58:	0ff4f493          	andi	s1,s1,255
    80001d5c:	00c00793          	li	a5,12
    80001d60:	fc97f0e3          	bgeu	a5,s1,80001d20 <_Z11workerBodyDPv+0x20>
    }

    printString("D: yield\n");
    80001d64:	00007517          	auipc	a0,0x7
    80001d68:	3ec50513          	addi	a0,a0,1004 # 80009150 <CONSOLE_STATUS+0x140>
    80001d6c:	00002097          	auipc	ra,0x2
    80001d70:	b30080e7          	jalr	-1232(ra) # 8000389c <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80001d74:	00500313          	li	t1,5
    thread_dispatch();
    80001d78:	fffff097          	auipc	ra,0xfffff
    80001d7c:	51c080e7          	jalr	1308(ra) # 80001294 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80001d80:	01000513          	li	a0,16
    80001d84:	00000097          	auipc	ra,0x0
    80001d88:	c4c080e7          	jalr	-948(ra) # 800019d0 <_ZL9fibonaccim>
    80001d8c:	00050913          	mv	s2,a0
    printString("D: fibonaci=");
    80001d90:	00007517          	auipc	a0,0x7
    80001d94:	3d050513          	addi	a0,a0,976 # 80009160 <CONSOLE_STATUS+0x150>
    80001d98:	00002097          	auipc	ra,0x2
    80001d9c:	b04080e7          	jalr	-1276(ra) # 8000389c <_Z11printStringPKc>
    printInt(result);
    80001da0:	00000613          	li	a2,0
    80001da4:	00a00593          	li	a1,10
    80001da8:	0009051b          	sext.w	a0,s2
    80001dac:	00002097          	auipc	ra,0x2
    80001db0:	ca0080e7          	jalr	-864(ra) # 80003a4c <_Z8printIntiii>
    printString("\n");
    80001db4:	00007517          	auipc	a0,0x7
    80001db8:	5f450513          	addi	a0,a0,1524 # 800093a8 <CONSOLE_STATUS+0x398>
    80001dbc:	00002097          	auipc	ra,0x2
    80001dc0:	ae0080e7          	jalr	-1312(ra) # 8000389c <_Z11printStringPKc>
    80001dc4:	0400006f          	j	80001e04 <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++)
    {
        printString("D: i=");
    80001dc8:	00007517          	auipc	a0,0x7
    80001dcc:	38050513          	addi	a0,a0,896 # 80009148 <CONSOLE_STATUS+0x138>
    80001dd0:	00002097          	auipc	ra,0x2
    80001dd4:	acc080e7          	jalr	-1332(ra) # 8000389c <_Z11printStringPKc>
        printInt(i);
    80001dd8:	00000613          	li	a2,0
    80001ddc:	00a00593          	li	a1,10
    80001de0:	00048513          	mv	a0,s1
    80001de4:	00002097          	auipc	ra,0x2
    80001de8:	c68080e7          	jalr	-920(ra) # 80003a4c <_Z8printIntiii>
        printString("\n");
    80001dec:	00007517          	auipc	a0,0x7
    80001df0:	5bc50513          	addi	a0,a0,1468 # 800093a8 <CONSOLE_STATUS+0x398>
    80001df4:	00002097          	auipc	ra,0x2
    80001df8:	aa8080e7          	jalr	-1368(ra) # 8000389c <_Z11printStringPKc>
    for (; i < 16; i++)
    80001dfc:	0014849b          	addiw	s1,s1,1
    80001e00:	0ff4f493          	andi	s1,s1,255
    80001e04:	00f00793          	li	a5,15
    80001e08:	fc97f0e3          	bgeu	a5,s1,80001dc8 <_Z11workerBodyDPv+0xc8>
    }

    80001e0c:	01813083          	ld	ra,24(sp)
    80001e10:	01013403          	ld	s0,16(sp)
    80001e14:	00813483          	ld	s1,8(sp)
    80001e18:	00013903          	ld	s2,0(sp)
    80001e1c:	02010113          	addi	sp,sp,32
    80001e20:	00008067          	ret

0000000080001e24 <_ZN11MySemaphore8sem_waitEPS_>:
    return 0;
}

int MySemaphore::sem_wait(sem_t id)
{
    if(id == nullptr)
    80001e24:	0e050663          	beqz	a0,80001f10 <_ZN11MySemaphore8sem_waitEPS_+0xec>
{
    80001e28:	fe010113          	addi	sp,sp,-32
    80001e2c:	00113c23          	sd	ra,24(sp)
    80001e30:	00813823          	sd	s0,16(sp)
    80001e34:	00913423          	sd	s1,8(sp)
    80001e38:	01213023          	sd	s2,0(sp)
    80001e3c:	02010413          	addi	s0,sp,32
    80001e40:	00050493          	mv	s1,a0
    {
        return -2;
    }

    id->value = id->value - 1;
    80001e44:	01852783          	lw	a5,24(a0)
    80001e48:	fff7879b          	addiw	a5,a5,-1
    80001e4c:	00f52c23          	sw	a5,24(a0)

    if(id->value < 0)
    80001e50:	02079713          	slli	a4,a5,0x20
    80001e54:	02074a63          	bltz	a4,80001e88 <_ZN11MySemaphore8sem_waitEPS_+0x64>
        thread_t newRunning = Scheduler::getInstance().get();
        TCB::running = newRunning;
        TCB::contextSwitch(&oldRunning->context, &newRunning->context);
    }

    if(TCB::running->semClosed)
    80001e58:	00009797          	auipc	a5,0x9
    80001e5c:	7307b783          	ld	a5,1840(a5) # 8000b588 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001e60:	0007b783          	ld	a5,0(a5)
    80001e64:	0297c783          	lbu	a5,41(a5)
    80001e68:	0a079863          	bnez	a5,80001f18 <_ZN11MySemaphore8sem_waitEPS_+0xf4>
    {
        return -1;
    }

    return 0;
    80001e6c:	00000513          	li	a0,0
}
    80001e70:	01813083          	ld	ra,24(sp)
    80001e74:	01013403          	ld	s0,16(sp)
    80001e78:	00813483          	ld	s1,8(sp)
    80001e7c:	00013903          	ld	s2,0(sp)
    80001e80:	02010113          	addi	sp,sp,32
    80001e84:	00008067          	ret
        thread_t oldRunning = TCB::running;
    80001e88:	00009797          	auipc	a5,0x9
    80001e8c:	7007b783          	ld	a5,1792(a5) # 8000b588 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001e90:	0007b903          	ld	s2,0(a5)
    }

    void addLast(T *data)
    {

        Elem* elem = (Elem*) MemoryAllocator::mem_alloc((sizeof(Elem) + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE);
    80001e94:	00100513          	li	a0,1
    80001e98:	00003097          	auipc	ra,0x3
    80001e9c:	6f8080e7          	jalr	1784(ra) # 80005590 <_ZN15MemoryAllocator9mem_allocEm>
        elem->data = data;
    80001ea0:	01253023          	sd	s2,0(a0)
        elem->next = nullptr;
    80001ea4:	00053423          	sd	zero,8(a0)

        if (tail)
    80001ea8:	0084b783          	ld	a5,8(s1)
    80001eac:	04078c63          	beqz	a5,80001f04 <_ZN11MySemaphore8sem_waitEPS_+0xe0>
        {
            tail->next = elem;
    80001eb0:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80001eb4:	00a4b423          	sd	a0,8(s1)
        else
        {
            head = tail = elem;
        }

        n++;
    80001eb8:	0104a783          	lw	a5,16(s1)
    80001ebc:	0017879b          	addiw	a5,a5,1
    80001ec0:	00f4a823          	sw	a5,16(s1)

    static void put(TCB *tcb);

    static Scheduler& getInstance()
    {
        static Scheduler instance;
    80001ec4:	00009797          	auipc	a5,0x9
    80001ec8:	72c7c783          	lbu	a5,1836(a5) # 8000b5f0 <_ZGVZN9Scheduler11getInstanceEvE8instance>
    80001ecc:	00079863          	bnez	a5,80001edc <_ZN11MySemaphore8sem_waitEPS_+0xb8>
    80001ed0:	00100793          	li	a5,1
    80001ed4:	00009717          	auipc	a4,0x9
    80001ed8:	70f70e23          	sb	a5,1820(a4) # 8000b5f0 <_ZGVZN9Scheduler11getInstanceEvE8instance>
        thread_t newRunning = Scheduler::getInstance().get();
    80001edc:	00003097          	auipc	ra,0x3
    80001ee0:	f44080e7          	jalr	-188(ra) # 80004e20 <_ZN9Scheduler3getEv>
        TCB::running = newRunning;
    80001ee4:	00009797          	auipc	a5,0x9
    80001ee8:	6a47b783          	ld	a5,1700(a5) # 8000b588 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001eec:	00a7b023          	sd	a0,0(a5)
        TCB::contextSwitch(&oldRunning->context, &newRunning->context);
    80001ef0:	01850593          	addi	a1,a0,24
    80001ef4:	01890513          	addi	a0,s2,24
    80001ef8:	fffff097          	auipc	ra,0xfffff
    80001efc:	238080e7          	jalr	568(ra) # 80001130 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
    80001f00:	f59ff06f          	j	80001e58 <_ZN11MySemaphore8sem_waitEPS_+0x34>
            head = tail = elem;
    80001f04:	00a4b423          	sd	a0,8(s1)
    80001f08:	00a4b023          	sd	a0,0(s1)
    80001f0c:	fadff06f          	j	80001eb8 <_ZN11MySemaphore8sem_waitEPS_+0x94>
        return -2;
    80001f10:	ffe00513          	li	a0,-2
}
    80001f14:	00008067          	ret
        return -1;
    80001f18:	fff00513          	li	a0,-1
    80001f1c:	f55ff06f          	j	80001e70 <_ZN11MySemaphore8sem_waitEPS_+0x4c>

0000000080001f20 <_ZN11MySemaphore10sem_signalEPS_>:

int MySemaphore::sem_signal(sem_t id)
{
    if(id == nullptr)
    80001f20:	0a050c63          	beqz	a0,80001fd8 <_ZN11MySemaphore10sem_signalEPS_+0xb8>
{
    80001f24:	fe010113          	addi	sp,sp,-32
    80001f28:	00113c23          	sd	ra,24(sp)
    80001f2c:	00813823          	sd	s0,16(sp)
    80001f30:	00913423          	sd	s1,8(sp)
    80001f34:	01213023          	sd	s2,0(sp)
    80001f38:	02010413          	addi	s0,sp,32
    80001f3c:	00050493          	mv	s1,a0
    {
        return -2;
    }

    id->value = id->value + 1;
    80001f40:	01852783          	lw	a5,24(a0)
    80001f44:	0017879b          	addiw	a5,a5,1
    80001f48:	0007871b          	sext.w	a4,a5
    80001f4c:	00f52c23          	sw	a5,24(a0)

    if(id->value <= 0)
    80001f50:	02e05063          	blez	a4,80001f70 <_ZN11MySemaphore10sem_signalEPS_+0x50>
    {
        thread_t unblocked = id->semaphoreQueue.removeFirst();
        Scheduler::getInstance().put(unblocked);
    }

    return 0;
    80001f54:	00000513          	li	a0,0
}
    80001f58:	01813083          	ld	ra,24(sp)
    80001f5c:	01013403          	ld	s0,16(sp)
    80001f60:	00813483          	ld	s1,8(sp)
    80001f64:	00013903          	ld	s2,0(sp)
    80001f68:	02010113          	addi	sp,sp,32
    80001f6c:	00008067          	ret
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80001f70:	00053503          	ld	a0,0(a0)
    80001f74:	04050e63          	beqz	a0,80001fd0 <_ZN11MySemaphore10sem_signalEPS_+0xb0>

        Elem *elem = head;
        head = head->next;
    80001f78:	00853783          	ld	a5,8(a0)
    80001f7c:	00f4b023          	sd	a5,0(s1)
        if (!head) { tail = 0; }
    80001f80:	04078463          	beqz	a5,80001fc8 <_ZN11MySemaphore10sem_signalEPS_+0xa8>

        T *ret = elem->data;
    80001f84:	00053903          	ld	s2,0(a0)

        MemoryAllocator::mem_free(elem);
    80001f88:	00003097          	auipc	ra,0x3
    80001f8c:	78c080e7          	jalr	1932(ra) # 80005714 <_ZN15MemoryAllocator8mem_freeEPv>

        n--;
    80001f90:	0104a783          	lw	a5,16(s1)
    80001f94:	fff7879b          	addiw	a5,a5,-1
    80001f98:	00f4a823          	sw	a5,16(s1)
    80001f9c:	00009797          	auipc	a5,0x9
    80001fa0:	6547c783          	lbu	a5,1620(a5) # 8000b5f0 <_ZGVZN9Scheduler11getInstanceEvE8instance>
    80001fa4:	00079863          	bnez	a5,80001fb4 <_ZN11MySemaphore10sem_signalEPS_+0x94>
    80001fa8:	00100793          	li	a5,1
    80001fac:	00009717          	auipc	a4,0x9
    80001fb0:	64f70223          	sb	a5,1604(a4) # 8000b5f0 <_ZGVZN9Scheduler11getInstanceEvE8instance>
        Scheduler::getInstance().put(unblocked);
    80001fb4:	00090513          	mv	a0,s2
    80001fb8:	00003097          	auipc	ra,0x3
    80001fbc:	ee4080e7          	jalr	-284(ra) # 80004e9c <_ZN9Scheduler3putEP3TCB>
    return 0;
    80001fc0:	00000513          	li	a0,0
    80001fc4:	f95ff06f          	j	80001f58 <_ZN11MySemaphore10sem_signalEPS_+0x38>
        if (!head) { tail = 0; }
    80001fc8:	0004b423          	sd	zero,8(s1)
    80001fcc:	fb9ff06f          	j	80001f84 <_ZN11MySemaphore10sem_signalEPS_+0x64>
        if (!head) { return 0; }
    80001fd0:	00050913          	mv	s2,a0
    80001fd4:	fc9ff06f          	j	80001f9c <_ZN11MySemaphore10sem_signalEPS_+0x7c>
        return -2;
    80001fd8:	ffe00513          	li	a0,-2
}
    80001fdc:	00008067          	ret

0000000080001fe0 <_ZN11MySemaphore11sem_trywaitEPS_>:

int MySemaphore::sem_trywait(sem_t id)
{
    80001fe0:	ff010113          	addi	sp,sp,-16
    80001fe4:	00813423          	sd	s0,8(sp)
    80001fe8:	01010413          	addi	s0,sp,16
    if(id == nullptr)
    80001fec:	02050463          	beqz	a0,80002014 <_ZN11MySemaphore11sem_trywaitEPS_+0x34>
    {
        return -2;
    }

    id->value = id->value - 1;
    80001ff0:	01852783          	lw	a5,24(a0)
    80001ff4:	fff7879b          	addiw	a5,a5,-1
    80001ff8:	00f52c23          	sw	a5,24(a0)

    if(id->value < 0)
    80001ffc:	02079713          	slli	a4,a5,0x20
    80002000:	00074e63          	bltz	a4,8000201c <_ZN11MySemaphore11sem_trywaitEPS_+0x3c>
    {
        return 0;
    }

    return 1;
    80002004:	00100513          	li	a0,1
}
    80002008:	00813403          	ld	s0,8(sp)
    8000200c:	01010113          	addi	sp,sp,16
    80002010:	00008067          	ret
        return -2;
    80002014:	ffe00513          	li	a0,-2
    80002018:	ff1ff06f          	j	80002008 <_ZN11MySemaphore11sem_trywaitEPS_+0x28>
        return 0;
    8000201c:	00000513          	li	a0,0
    80002020:	fe9ff06f          	j	80002008 <_ZN11MySemaphore11sem_trywaitEPS_+0x28>

0000000080002024 <_ZN11MySemaphorenwEm>:


void *MySemaphore::operator new(size_t size)
{
    80002024:	ff010113          	addi	sp,sp,-16
    80002028:	00113423          	sd	ra,8(sp)
    8000202c:	00813023          	sd	s0,0(sp)
    80002030:	01010413          	addi	s0,sp,16
    return (sem_t) MemoryAllocator::mem_alloc((sizeof(MySemaphore) + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE);
    80002034:	00100513          	li	a0,1
    80002038:	00003097          	auipc	ra,0x3
    8000203c:	558080e7          	jalr	1368(ra) # 80005590 <_ZN15MemoryAllocator9mem_allocEm>
}
    80002040:	00813083          	ld	ra,8(sp)
    80002044:	00013403          	ld	s0,0(sp)
    80002048:	01010113          	addi	sp,sp,16
    8000204c:	00008067          	ret

0000000080002050 <_ZN11MySemaphore8sem_openEPPS_j>:
{
    80002050:	fe010113          	addi	sp,sp,-32
    80002054:	00113c23          	sd	ra,24(sp)
    80002058:	00813823          	sd	s0,16(sp)
    8000205c:	00913423          	sd	s1,8(sp)
    80002060:	01213023          	sd	s2,0(sp)
    80002064:	02010413          	addi	s0,sp,32
    80002068:	00050493          	mv	s1,a0
    8000206c:	00058913          	mv	s2,a1
    *handle = new MySemaphore(init);
    80002070:	02000513          	li	a0,32
    80002074:	00000097          	auipc	ra,0x0
    80002078:	fb0080e7          	jalr	-80(ra) # 80002024 <_ZN11MySemaphorenwEm>
    List() : head(0), tail(0), n(0) {}
    8000207c:	00053023          	sd	zero,0(a0)
    80002080:	00053423          	sd	zero,8(a0)
    80002084:	00052823          	sw	zero,16(a0)

class MySemaphore{

public:

    MySemaphore(unsigned value): value(value){}
    80002088:	01252c23          	sw	s2,24(a0)
    8000208c:	00a4b023          	sd	a0,0(s1)
    if(*handle == nullptr)
    80002090:	02050063          	beqz	a0,800020b0 <_ZN11MySemaphore8sem_openEPPS_j+0x60>
    return 0;
    80002094:	00000513          	li	a0,0
}
    80002098:	01813083          	ld	ra,24(sp)
    8000209c:	01013403          	ld	s0,16(sp)
    800020a0:	00813483          	ld	s1,8(sp)
    800020a4:	00013903          	ld	s2,0(sp)
    800020a8:	02010113          	addi	sp,sp,32
    800020ac:	00008067          	ret
        return -1;
    800020b0:	fff00513          	li	a0,-1
    800020b4:	fe5ff06f          	j	80002098 <_ZN11MySemaphore8sem_openEPPS_j+0x48>

00000000800020b8 <_ZN11MySemaphoredlEPv>:

void MySemaphore::operator delete(void *address)
{
    800020b8:	ff010113          	addi	sp,sp,-16
    800020bc:	00113423          	sd	ra,8(sp)
    800020c0:	00813023          	sd	s0,0(sp)
    800020c4:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(address);
    800020c8:	00003097          	auipc	ra,0x3
    800020cc:	64c080e7          	jalr	1612(ra) # 80005714 <_ZN15MemoryAllocator8mem_freeEPv>
}
    800020d0:	00813083          	ld	ra,8(sp)
    800020d4:	00013403          	ld	s0,0(sp)
    800020d8:	01010113          	addi	sp,sp,16
    800020dc:	00008067          	ret

00000000800020e0 <_ZN11MySemaphore9sem_closeEPS_>:
    if(handle == nullptr)
    800020e0:	0c050863          	beqz	a0,800021b0 <_ZN11MySemaphore9sem_closeEPS_+0xd0>
{
    800020e4:	fd010113          	addi	sp,sp,-48
    800020e8:	02113423          	sd	ra,40(sp)
    800020ec:	02813023          	sd	s0,32(sp)
    800020f0:	00913c23          	sd	s1,24(sp)
    800020f4:	01213823          	sd	s2,16(sp)
    800020f8:	01313423          	sd	s3,8(sp)
    800020fc:	03010413          	addi	s0,sp,48
    80002100:	00050493          	mv	s1,a0
    for(unsigned int i = 0; i < handle->semaphoreQueue.numberOfElements(); i++)
    80002104:	00000913          	li	s2,0
    80002108:	02c0006f          	j	80002134 <_ZN11MySemaphore9sem_closeEPS_+0x54>
        if (!head) { tail = 0; }
    8000210c:	0004b423          	sd	zero,8(s1)
    80002110:	0400006f          	j	80002150 <_ZN11MySemaphore9sem_closeEPS_+0x70>
        if (!head) { return 0; }
    80002114:	00050993          	mv	s3,a0
    80002118:	0500006f          	j	80002168 <_ZN11MySemaphore9sem_closeEPS_+0x88>
        Scheduler::getInstance().put(tcb);
    8000211c:	00098513          	mv	a0,s3
    80002120:	00003097          	auipc	ra,0x3
    80002124:	d7c080e7          	jalr	-644(ra) # 80004e9c <_ZN9Scheduler3putEP3TCB>
        tcb->semClosed = true;
    80002128:	00100793          	li	a5,1
    8000212c:	02f984a3          	sb	a5,41(s3)
    for(unsigned int i = 0; i < handle->semaphoreQueue.numberOfElements(); i++)
    80002130:	0019091b          	addiw	s2,s2,1
        return n;
    80002134:	0104a783          	lw	a5,16(s1)
    80002138:	04f97663          	bgeu	s2,a5,80002184 <_ZN11MySemaphore9sem_closeEPS_+0xa4>
        if (!head) { return 0; }
    8000213c:	0004b503          	ld	a0,0(s1)
    80002140:	fc050ae3          	beqz	a0,80002114 <_ZN11MySemaphore9sem_closeEPS_+0x34>
        head = head->next;
    80002144:	00853783          	ld	a5,8(a0)
    80002148:	00f4b023          	sd	a5,0(s1)
        if (!head) { tail = 0; }
    8000214c:	fc0780e3          	beqz	a5,8000210c <_ZN11MySemaphore9sem_closeEPS_+0x2c>
        T *ret = elem->data;
    80002150:	00053983          	ld	s3,0(a0)
        MemoryAllocator::mem_free(elem);
    80002154:	00003097          	auipc	ra,0x3
    80002158:	5c0080e7          	jalr	1472(ra) # 80005714 <_ZN15MemoryAllocator8mem_freeEPv>
        n--;
    8000215c:	0104a783          	lw	a5,16(s1)
    80002160:	fff7879b          	addiw	a5,a5,-1
    80002164:	00f4a823          	sw	a5,16(s1)
    80002168:	00009797          	auipc	a5,0x9
    8000216c:	4887c783          	lbu	a5,1160(a5) # 8000b5f0 <_ZGVZN9Scheduler11getInstanceEvE8instance>
    80002170:	fa0796e3          	bnez	a5,8000211c <_ZN11MySemaphore9sem_closeEPS_+0x3c>
    80002174:	00100793          	li	a5,1
    80002178:	00009717          	auipc	a4,0x9
    8000217c:	46f70c23          	sb	a5,1144(a4) # 8000b5f0 <_ZGVZN9Scheduler11getInstanceEvE8instance>
    80002180:	f9dff06f          	j	8000211c <_ZN11MySemaphore9sem_closeEPS_+0x3c>
    delete handle;
    80002184:	00048513          	mv	a0,s1
    80002188:	00000097          	auipc	ra,0x0
    8000218c:	f30080e7          	jalr	-208(ra) # 800020b8 <_ZN11MySemaphoredlEPv>
    return 0;
    80002190:	00000513          	li	a0,0
}
    80002194:	02813083          	ld	ra,40(sp)
    80002198:	02013403          	ld	s0,32(sp)
    8000219c:	01813483          	ld	s1,24(sp)
    800021a0:	01013903          	ld	s2,16(sp)
    800021a4:	00813983          	ld	s3,8(sp)
    800021a8:	03010113          	addi	sp,sp,48
    800021ac:	00008067          	ret
        return -2;
    800021b0:	ffe00513          	li	a0,-2
}
    800021b4:	00008067          	ret

00000000800021b8 <_ZN11MySemaphore12sem_setValueEPS_i>:

void MySemaphore::sem_setValue(sem_t id, int value)
{
    800021b8:	ff010113          	addi	sp,sp,-16
    800021bc:	00813423          	sd	s0,8(sp)
    800021c0:	01010413          	addi	s0,sp,16
    id->value = value;
    800021c4:	00b52c23          	sw	a1,24(a0)
}
    800021c8:	00813403          	ld	s0,8(sp)
    800021cc:	01010113          	addi	sp,sp,16
    800021d0:	00008067          	ret

00000000800021d4 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    800021d4:	fe010113          	addi	sp,sp,-32
    800021d8:	00113c23          	sd	ra,24(sp)
    800021dc:	00813823          	sd	s0,16(sp)
    800021e0:	00913423          	sd	s1,8(sp)
    800021e4:	01213023          	sd	s2,0(sp)
    800021e8:	02010413          	addi	s0,sp,32
    800021ec:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800021f0:	00100793          	li	a5,1
    800021f4:	02a7f863          	bgeu	a5,a0,80002224 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800021f8:	00a00793          	li	a5,10
    800021fc:	02f577b3          	remu	a5,a0,a5
    80002200:	02078e63          	beqz	a5,8000223c <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002204:	fff48513          	addi	a0,s1,-1
    80002208:	00000097          	auipc	ra,0x0
    8000220c:	fcc080e7          	jalr	-52(ra) # 800021d4 <_ZL9fibonaccim>
    80002210:	00050913          	mv	s2,a0
    80002214:	ffe48513          	addi	a0,s1,-2
    80002218:	00000097          	auipc	ra,0x0
    8000221c:	fbc080e7          	jalr	-68(ra) # 800021d4 <_ZL9fibonaccim>
    80002220:	00a90533          	add	a0,s2,a0
}
    80002224:	01813083          	ld	ra,24(sp)
    80002228:	01013403          	ld	s0,16(sp)
    8000222c:	00813483          	ld	s1,8(sp)
    80002230:	00013903          	ld	s2,0(sp)
    80002234:	02010113          	addi	sp,sp,32
    80002238:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    8000223c:	fffff097          	auipc	ra,0xfffff
    80002240:	058080e7          	jalr	88(ra) # 80001294 <_Z15thread_dispatchv>
    80002244:	fc1ff06f          	j	80002204 <_ZL9fibonaccim+0x30>

0000000080002248 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80002248:	fe010113          	addi	sp,sp,-32
    8000224c:	00113c23          	sd	ra,24(sp)
    80002250:	00813823          	sd	s0,16(sp)
    80002254:	00913423          	sd	s1,8(sp)
    80002258:	01213023          	sd	s2,0(sp)
    8000225c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 12; i++) {
    80002260:	00000913          	li	s2,0
    80002264:	0380006f          	j	8000229c <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80002268:	fffff097          	auipc	ra,0xfffff
    8000226c:	02c080e7          	jalr	44(ra) # 80001294 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80002270:	00148493          	addi	s1,s1,1
    80002274:	000027b7          	lui	a5,0x2
    80002278:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000227c:	0097ee63          	bltu	a5,s1,80002298 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80002280:	00000713          	li	a4,0
    80002284:	000077b7          	lui	a5,0x7
    80002288:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000228c:	fce7eee3          	bltu	a5,a4,80002268 <_ZN7WorkerA11workerBodyAEPv+0x20>
    80002290:	00170713          	addi	a4,a4,1
    80002294:	ff1ff06f          	j	80002284 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 12; i++) {
    80002298:	00190913          	addi	s2,s2,1
    8000229c:	00b00793          	li	a5,11
    800022a0:	0527e063          	bltu	a5,s2,800022e0 <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800022a4:	00007517          	auipc	a0,0x7
    800022a8:	e6450513          	addi	a0,a0,-412 # 80009108 <CONSOLE_STATUS+0xf8>
    800022ac:	00001097          	auipc	ra,0x1
    800022b0:	5f0080e7          	jalr	1520(ra) # 8000389c <_Z11printStringPKc>
    800022b4:	00000613          	li	a2,0
    800022b8:	00a00593          	li	a1,10
    800022bc:	0009051b          	sext.w	a0,s2
    800022c0:	00001097          	auipc	ra,0x1
    800022c4:	78c080e7          	jalr	1932(ra) # 80003a4c <_Z8printIntiii>
    800022c8:	00007517          	auipc	a0,0x7
    800022cc:	0e050513          	addi	a0,a0,224 # 800093a8 <CONSOLE_STATUS+0x398>
    800022d0:	00001097          	auipc	ra,0x1
    800022d4:	5cc080e7          	jalr	1484(ra) # 8000389c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800022d8:	00000493          	li	s1,0
    800022dc:	f99ff06f          	j	80002274 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    800022e0:	00007517          	auipc	a0,0x7
    800022e4:	e9050513          	addi	a0,a0,-368 # 80009170 <CONSOLE_STATUS+0x160>
    800022e8:	00001097          	auipc	ra,0x1
    800022ec:	5b4080e7          	jalr	1460(ra) # 8000389c <_Z11printStringPKc>
    finishedA = true;
    800022f0:	00100793          	li	a5,1
    800022f4:	00009717          	auipc	a4,0x9
    800022f8:	30f70223          	sb	a5,772(a4) # 8000b5f8 <_ZL9finishedA>
}
    800022fc:	01813083          	ld	ra,24(sp)
    80002300:	01013403          	ld	s0,16(sp)
    80002304:	00813483          	ld	s1,8(sp)
    80002308:	00013903          	ld	s2,0(sp)
    8000230c:	02010113          	addi	sp,sp,32
    80002310:	00008067          	ret

0000000080002314 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80002314:	fe010113          	addi	sp,sp,-32
    80002318:	00113c23          	sd	ra,24(sp)
    8000231c:	00813823          	sd	s0,16(sp)
    80002320:	00913423          	sd	s1,8(sp)
    80002324:	01213023          	sd	s2,0(sp)
    80002328:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    8000232c:	00000913          	li	s2,0
    80002330:	0380006f          	j	80002368 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80002334:	fffff097          	auipc	ra,0xfffff
    80002338:	f60080e7          	jalr	-160(ra) # 80001294 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000233c:	00148493          	addi	s1,s1,1
    80002340:	000027b7          	lui	a5,0x2
    80002344:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002348:	0097ee63          	bltu	a5,s1,80002364 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000234c:	00000713          	li	a4,0
    80002350:	000077b7          	lui	a5,0x7
    80002354:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002358:	fce7eee3          	bltu	a5,a4,80002334 <_ZN7WorkerB11workerBodyBEPv+0x20>
    8000235c:	00170713          	addi	a4,a4,1
    80002360:	ff1ff06f          	j	80002350 <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80002364:	00190913          	addi	s2,s2,1
    80002368:	00f00793          	li	a5,15
    8000236c:	0527e063          	bltu	a5,s2,800023ac <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80002370:	00007517          	auipc	a0,0x7
    80002374:	da050513          	addi	a0,a0,-608 # 80009110 <CONSOLE_STATUS+0x100>
    80002378:	00001097          	auipc	ra,0x1
    8000237c:	524080e7          	jalr	1316(ra) # 8000389c <_Z11printStringPKc>
    80002380:	00000613          	li	a2,0
    80002384:	00a00593          	li	a1,10
    80002388:	0009051b          	sext.w	a0,s2
    8000238c:	00001097          	auipc	ra,0x1
    80002390:	6c0080e7          	jalr	1728(ra) # 80003a4c <_Z8printIntiii>
    80002394:	00007517          	auipc	a0,0x7
    80002398:	01450513          	addi	a0,a0,20 # 800093a8 <CONSOLE_STATUS+0x398>
    8000239c:	00001097          	auipc	ra,0x1
    800023a0:	500080e7          	jalr	1280(ra) # 8000389c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800023a4:	00000493          	li	s1,0
    800023a8:	f99ff06f          	j	80002340 <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    800023ac:	00007517          	auipc	a0,0x7
    800023b0:	dd450513          	addi	a0,a0,-556 # 80009180 <CONSOLE_STATUS+0x170>
    800023b4:	00001097          	auipc	ra,0x1
    800023b8:	4e8080e7          	jalr	1256(ra) # 8000389c <_Z11printStringPKc>
    finishedB = true;
    800023bc:	00100793          	li	a5,1
    800023c0:	00009717          	auipc	a4,0x9
    800023c4:	22f70ca3          	sb	a5,569(a4) # 8000b5f9 <_ZL9finishedB>
    thread_dispatch();
    800023c8:	fffff097          	auipc	ra,0xfffff
    800023cc:	ecc080e7          	jalr	-308(ra) # 80001294 <_Z15thread_dispatchv>
}
    800023d0:	01813083          	ld	ra,24(sp)
    800023d4:	01013403          	ld	s0,16(sp)
    800023d8:	00813483          	ld	s1,8(sp)
    800023dc:	00013903          	ld	s2,0(sp)
    800023e0:	02010113          	addi	sp,sp,32
    800023e4:	00008067          	ret

00000000800023e8 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    800023e8:	fe010113          	addi	sp,sp,-32
    800023ec:	00113c23          	sd	ra,24(sp)
    800023f0:	00813823          	sd	s0,16(sp)
    800023f4:	00913423          	sd	s1,8(sp)
    800023f8:	01213023          	sd	s2,0(sp)
    800023fc:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80002400:	00000493          	li	s1,0
    80002404:	0400006f          	j	80002444 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80002408:	00007517          	auipc	a0,0x7
    8000240c:	d1050513          	addi	a0,a0,-752 # 80009118 <CONSOLE_STATUS+0x108>
    80002410:	00001097          	auipc	ra,0x1
    80002414:	48c080e7          	jalr	1164(ra) # 8000389c <_Z11printStringPKc>
    80002418:	00000613          	li	a2,0
    8000241c:	00a00593          	li	a1,10
    80002420:	00048513          	mv	a0,s1
    80002424:	00001097          	auipc	ra,0x1
    80002428:	628080e7          	jalr	1576(ra) # 80003a4c <_Z8printIntiii>
    8000242c:	00007517          	auipc	a0,0x7
    80002430:	f7c50513          	addi	a0,a0,-132 # 800093a8 <CONSOLE_STATUS+0x398>
    80002434:	00001097          	auipc	ra,0x1
    80002438:	468080e7          	jalr	1128(ra) # 8000389c <_Z11printStringPKc>
    for (; i < 3; i++) {
    8000243c:	0014849b          	addiw	s1,s1,1
    80002440:	0ff4f493          	andi	s1,s1,255
    80002444:	00200793          	li	a5,2
    80002448:	fc97f0e3          	bgeu	a5,s1,80002408 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    8000244c:	00007517          	auipc	a0,0x7
    80002450:	d4450513          	addi	a0,a0,-700 # 80009190 <CONSOLE_STATUS+0x180>
    80002454:	00001097          	auipc	ra,0x1
    80002458:	448080e7          	jalr	1096(ra) # 8000389c <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    8000245c:	00700313          	li	t1,7
    thread_dispatch();
    80002460:	fffff097          	auipc	ra,0xfffff
    80002464:	e34080e7          	jalr	-460(ra) # 80001294 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80002468:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    8000246c:	00007517          	auipc	a0,0x7
    80002470:	cc450513          	addi	a0,a0,-828 # 80009130 <CONSOLE_STATUS+0x120>
    80002474:	00001097          	auipc	ra,0x1
    80002478:	428080e7          	jalr	1064(ra) # 8000389c <_Z11printStringPKc>
    8000247c:	00000613          	li	a2,0
    80002480:	00a00593          	li	a1,10
    80002484:	0009051b          	sext.w	a0,s2
    80002488:	00001097          	auipc	ra,0x1
    8000248c:	5c4080e7          	jalr	1476(ra) # 80003a4c <_Z8printIntiii>
    80002490:	00007517          	auipc	a0,0x7
    80002494:	f1850513          	addi	a0,a0,-232 # 800093a8 <CONSOLE_STATUS+0x398>
    80002498:	00001097          	auipc	ra,0x1
    8000249c:	404080e7          	jalr	1028(ra) # 8000389c <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    800024a0:	00c00513          	li	a0,12
    800024a4:	00000097          	auipc	ra,0x0
    800024a8:	d30080e7          	jalr	-720(ra) # 800021d4 <_ZL9fibonaccim>
    800024ac:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800024b0:	00007517          	auipc	a0,0x7
    800024b4:	c8850513          	addi	a0,a0,-888 # 80009138 <CONSOLE_STATUS+0x128>
    800024b8:	00001097          	auipc	ra,0x1
    800024bc:	3e4080e7          	jalr	996(ra) # 8000389c <_Z11printStringPKc>
    800024c0:	00000613          	li	a2,0
    800024c4:	00a00593          	li	a1,10
    800024c8:	0009051b          	sext.w	a0,s2
    800024cc:	00001097          	auipc	ra,0x1
    800024d0:	580080e7          	jalr	1408(ra) # 80003a4c <_Z8printIntiii>
    800024d4:	00007517          	auipc	a0,0x7
    800024d8:	ed450513          	addi	a0,a0,-300 # 800093a8 <CONSOLE_STATUS+0x398>
    800024dc:	00001097          	auipc	ra,0x1
    800024e0:	3c0080e7          	jalr	960(ra) # 8000389c <_Z11printStringPKc>
    800024e4:	0400006f          	j	80002524 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    800024e8:	00007517          	auipc	a0,0x7
    800024ec:	c3050513          	addi	a0,a0,-976 # 80009118 <CONSOLE_STATUS+0x108>
    800024f0:	00001097          	auipc	ra,0x1
    800024f4:	3ac080e7          	jalr	940(ra) # 8000389c <_Z11printStringPKc>
    800024f8:	00000613          	li	a2,0
    800024fc:	00a00593          	li	a1,10
    80002500:	00048513          	mv	a0,s1
    80002504:	00001097          	auipc	ra,0x1
    80002508:	548080e7          	jalr	1352(ra) # 80003a4c <_Z8printIntiii>
    8000250c:	00007517          	auipc	a0,0x7
    80002510:	e9c50513          	addi	a0,a0,-356 # 800093a8 <CONSOLE_STATUS+0x398>
    80002514:	00001097          	auipc	ra,0x1
    80002518:	388080e7          	jalr	904(ra) # 8000389c <_Z11printStringPKc>
    for (; i < 6; i++) {
    8000251c:	0014849b          	addiw	s1,s1,1
    80002520:	0ff4f493          	andi	s1,s1,255
    80002524:	00500793          	li	a5,5
    80002528:	fc97f0e3          	bgeu	a5,s1,800024e8 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    8000252c:	00007517          	auipc	a0,0x7
    80002530:	c4450513          	addi	a0,a0,-956 # 80009170 <CONSOLE_STATUS+0x160>
    80002534:	00001097          	auipc	ra,0x1
    80002538:	368080e7          	jalr	872(ra) # 8000389c <_Z11printStringPKc>
    finishedC = true;
    8000253c:	00100793          	li	a5,1
    80002540:	00009717          	auipc	a4,0x9
    80002544:	0af70d23          	sb	a5,186(a4) # 8000b5fa <_ZL9finishedC>
    thread_dispatch();
    80002548:	fffff097          	auipc	ra,0xfffff
    8000254c:	d4c080e7          	jalr	-692(ra) # 80001294 <_Z15thread_dispatchv>
}
    80002550:	01813083          	ld	ra,24(sp)
    80002554:	01013403          	ld	s0,16(sp)
    80002558:	00813483          	ld	s1,8(sp)
    8000255c:	00013903          	ld	s2,0(sp)
    80002560:	02010113          	addi	sp,sp,32
    80002564:	00008067          	ret

0000000080002568 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80002568:	fe010113          	addi	sp,sp,-32
    8000256c:	00113c23          	sd	ra,24(sp)
    80002570:	00813823          	sd	s0,16(sp)
    80002574:	00913423          	sd	s1,8(sp)
    80002578:	01213023          	sd	s2,0(sp)
    8000257c:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80002580:	00a00493          	li	s1,10
    80002584:	0400006f          	j	800025c4 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002588:	00007517          	auipc	a0,0x7
    8000258c:	bc050513          	addi	a0,a0,-1088 # 80009148 <CONSOLE_STATUS+0x138>
    80002590:	00001097          	auipc	ra,0x1
    80002594:	30c080e7          	jalr	780(ra) # 8000389c <_Z11printStringPKc>
    80002598:	00000613          	li	a2,0
    8000259c:	00a00593          	li	a1,10
    800025a0:	00048513          	mv	a0,s1
    800025a4:	00001097          	auipc	ra,0x1
    800025a8:	4a8080e7          	jalr	1192(ra) # 80003a4c <_Z8printIntiii>
    800025ac:	00007517          	auipc	a0,0x7
    800025b0:	dfc50513          	addi	a0,a0,-516 # 800093a8 <CONSOLE_STATUS+0x398>
    800025b4:	00001097          	auipc	ra,0x1
    800025b8:	2e8080e7          	jalr	744(ra) # 8000389c <_Z11printStringPKc>
    for (; i < 13; i++) {
    800025bc:	0014849b          	addiw	s1,s1,1
    800025c0:	0ff4f493          	andi	s1,s1,255
    800025c4:	00c00793          	li	a5,12
    800025c8:	fc97f0e3          	bgeu	a5,s1,80002588 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    800025cc:	00007517          	auipc	a0,0x7
    800025d0:	bd450513          	addi	a0,a0,-1068 # 800091a0 <CONSOLE_STATUS+0x190>
    800025d4:	00001097          	auipc	ra,0x1
    800025d8:	2c8080e7          	jalr	712(ra) # 8000389c <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800025dc:	00500313          	li	t1,5
    thread_dispatch();
    800025e0:	fffff097          	auipc	ra,0xfffff
    800025e4:	cb4080e7          	jalr	-844(ra) # 80001294 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800025e8:	01000513          	li	a0,16
    800025ec:	00000097          	auipc	ra,0x0
    800025f0:	be8080e7          	jalr	-1048(ra) # 800021d4 <_ZL9fibonaccim>
    800025f4:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800025f8:	00007517          	auipc	a0,0x7
    800025fc:	b6850513          	addi	a0,a0,-1176 # 80009160 <CONSOLE_STATUS+0x150>
    80002600:	00001097          	auipc	ra,0x1
    80002604:	29c080e7          	jalr	668(ra) # 8000389c <_Z11printStringPKc>
    80002608:	00000613          	li	a2,0
    8000260c:	00a00593          	li	a1,10
    80002610:	0009051b          	sext.w	a0,s2
    80002614:	00001097          	auipc	ra,0x1
    80002618:	438080e7          	jalr	1080(ra) # 80003a4c <_Z8printIntiii>
    8000261c:	00007517          	auipc	a0,0x7
    80002620:	d8c50513          	addi	a0,a0,-628 # 800093a8 <CONSOLE_STATUS+0x398>
    80002624:	00001097          	auipc	ra,0x1
    80002628:	278080e7          	jalr	632(ra) # 8000389c <_Z11printStringPKc>
    8000262c:	0400006f          	j	8000266c <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002630:	00007517          	auipc	a0,0x7
    80002634:	b1850513          	addi	a0,a0,-1256 # 80009148 <CONSOLE_STATUS+0x138>
    80002638:	00001097          	auipc	ra,0x1
    8000263c:	264080e7          	jalr	612(ra) # 8000389c <_Z11printStringPKc>
    80002640:	00000613          	li	a2,0
    80002644:	00a00593          	li	a1,10
    80002648:	00048513          	mv	a0,s1
    8000264c:	00001097          	auipc	ra,0x1
    80002650:	400080e7          	jalr	1024(ra) # 80003a4c <_Z8printIntiii>
    80002654:	00007517          	auipc	a0,0x7
    80002658:	d5450513          	addi	a0,a0,-684 # 800093a8 <CONSOLE_STATUS+0x398>
    8000265c:	00001097          	auipc	ra,0x1
    80002660:	240080e7          	jalr	576(ra) # 8000389c <_Z11printStringPKc>
    for (; i < 16; i++) {
    80002664:	0014849b          	addiw	s1,s1,1
    80002668:	0ff4f493          	andi	s1,s1,255
    8000266c:	00f00793          	li	a5,15
    80002670:	fc97f0e3          	bgeu	a5,s1,80002630 <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80002674:	00007517          	auipc	a0,0x7
    80002678:	b3c50513          	addi	a0,a0,-1220 # 800091b0 <CONSOLE_STATUS+0x1a0>
    8000267c:	00001097          	auipc	ra,0x1
    80002680:	220080e7          	jalr	544(ra) # 8000389c <_Z11printStringPKc>
    finishedD = true;
    80002684:	00100793          	li	a5,1
    80002688:	00009717          	auipc	a4,0x9
    8000268c:	f6f709a3          	sb	a5,-141(a4) # 8000b5fb <_ZL9finishedD>
    thread_dispatch();
    80002690:	fffff097          	auipc	ra,0xfffff
    80002694:	c04080e7          	jalr	-1020(ra) # 80001294 <_Z15thread_dispatchv>
}
    80002698:	01813083          	ld	ra,24(sp)
    8000269c:	01013403          	ld	s0,16(sp)
    800026a0:	00813483          	ld	s1,8(sp)
    800026a4:	00013903          	ld	s2,0(sp)
    800026a8:	02010113          	addi	sp,sp,32
    800026ac:	00008067          	ret

00000000800026b0 <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    800026b0:	fc010113          	addi	sp,sp,-64
    800026b4:	02113c23          	sd	ra,56(sp)
    800026b8:	02813823          	sd	s0,48(sp)
    800026bc:	02913423          	sd	s1,40(sp)
    800026c0:	03213023          	sd	s2,32(sp)
    800026c4:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    800026c8:	02000513          	li	a0,32
    800026cc:	00002097          	auipc	ra,0x2
    800026d0:	f94080e7          	jalr	-108(ra) # 80004660 <_Znwm>
    800026d4:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    800026d8:	00002097          	auipc	ra,0x2
    800026dc:	148080e7          	jalr	328(ra) # 80004820 <_ZN6ThreadC1Ev>
    800026e0:	00009797          	auipc	a5,0x9
    800026e4:	ca878793          	addi	a5,a5,-856 # 8000b388 <_ZTV7WorkerA+0x10>
    800026e8:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    800026ec:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    800026f0:	00007517          	auipc	a0,0x7
    800026f4:	ad050513          	addi	a0,a0,-1328 # 800091c0 <CONSOLE_STATUS+0x1b0>
    800026f8:	00001097          	auipc	ra,0x1
    800026fc:	1a4080e7          	jalr	420(ra) # 8000389c <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80002700:	02000513          	li	a0,32
    80002704:	00002097          	auipc	ra,0x2
    80002708:	f5c080e7          	jalr	-164(ra) # 80004660 <_Znwm>
    8000270c:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    80002710:	00002097          	auipc	ra,0x2
    80002714:	110080e7          	jalr	272(ra) # 80004820 <_ZN6ThreadC1Ev>
    80002718:	00009797          	auipc	a5,0x9
    8000271c:	c9878793          	addi	a5,a5,-872 # 8000b3b0 <_ZTV7WorkerB+0x10>
    80002720:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    80002724:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    80002728:	00007517          	auipc	a0,0x7
    8000272c:	ab050513          	addi	a0,a0,-1360 # 800091d8 <CONSOLE_STATUS+0x1c8>
    80002730:	00001097          	auipc	ra,0x1
    80002734:	16c080e7          	jalr	364(ra) # 8000389c <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80002738:	02000513          	li	a0,32
    8000273c:	00002097          	auipc	ra,0x2
    80002740:	f24080e7          	jalr	-220(ra) # 80004660 <_Znwm>
    80002744:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    80002748:	00002097          	auipc	ra,0x2
    8000274c:	0d8080e7          	jalr	216(ra) # 80004820 <_ZN6ThreadC1Ev>
    80002750:	00009797          	auipc	a5,0x9
    80002754:	c8878793          	addi	a5,a5,-888 # 8000b3d8 <_ZTV7WorkerC+0x10>
    80002758:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    8000275c:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    80002760:	00007517          	auipc	a0,0x7
    80002764:	a9050513          	addi	a0,a0,-1392 # 800091f0 <CONSOLE_STATUS+0x1e0>
    80002768:	00001097          	auipc	ra,0x1
    8000276c:	134080e7          	jalr	308(ra) # 8000389c <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80002770:	02000513          	li	a0,32
    80002774:	00002097          	auipc	ra,0x2
    80002778:	eec080e7          	jalr	-276(ra) # 80004660 <_Znwm>
    8000277c:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    80002780:	00002097          	auipc	ra,0x2
    80002784:	0a0080e7          	jalr	160(ra) # 80004820 <_ZN6ThreadC1Ev>
    80002788:	00009797          	auipc	a5,0x9
    8000278c:	c7878793          	addi	a5,a5,-904 # 8000b400 <_ZTV7WorkerD+0x10>
    80002790:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    80002794:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80002798:	00007517          	auipc	a0,0x7
    8000279c:	a7050513          	addi	a0,a0,-1424 # 80009208 <CONSOLE_STATUS+0x1f8>
    800027a0:	00001097          	auipc	ra,0x1
    800027a4:	0fc080e7          	jalr	252(ra) # 8000389c <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    800027a8:	00000493          	li	s1,0
    800027ac:	00300793          	li	a5,3
    800027b0:	0297c663          	blt	a5,s1,800027dc <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    800027b4:	00349793          	slli	a5,s1,0x3
    800027b8:	fe040713          	addi	a4,s0,-32
    800027bc:	00f707b3          	add	a5,a4,a5
    800027c0:	fe07b503          	ld	a0,-32(a5)
    800027c4:	00002097          	auipc	ra,0x2
    800027c8:	fec080e7          	jalr	-20(ra) # 800047b0 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    800027cc:	0014849b          	addiw	s1,s1,1
    800027d0:	fddff06f          	j	800027ac <_Z20Threads_CPP_API_testv+0xfc>
    }


    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    800027d4:	00002097          	auipc	ra,0x2
    800027d8:	024080e7          	jalr	36(ra) # 800047f8 <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800027dc:	00009797          	auipc	a5,0x9
    800027e0:	e1c7c783          	lbu	a5,-484(a5) # 8000b5f8 <_ZL9finishedA>
    800027e4:	fe0788e3          	beqz	a5,800027d4 <_Z20Threads_CPP_API_testv+0x124>
    800027e8:	00009797          	auipc	a5,0x9
    800027ec:	e117c783          	lbu	a5,-495(a5) # 8000b5f9 <_ZL9finishedB>
    800027f0:	fe0782e3          	beqz	a5,800027d4 <_Z20Threads_CPP_API_testv+0x124>
    800027f4:	00009797          	auipc	a5,0x9
    800027f8:	e067c783          	lbu	a5,-506(a5) # 8000b5fa <_ZL9finishedC>
    800027fc:	fc078ce3          	beqz	a5,800027d4 <_Z20Threads_CPP_API_testv+0x124>
    80002800:	00009797          	auipc	a5,0x9
    80002804:	dfb7c783          	lbu	a5,-517(a5) # 8000b5fb <_ZL9finishedD>
    80002808:	fc0786e3          	beqz	a5,800027d4 <_Z20Threads_CPP_API_testv+0x124>
    8000280c:	fc040493          	addi	s1,s0,-64
    80002810:	0080006f          	j	80002818 <_Z20Threads_CPP_API_testv+0x168>
    }

    for (auto thread: threads) { delete thread; }
    80002814:	00848493          	addi	s1,s1,8
    80002818:	fe040793          	addi	a5,s0,-32
    8000281c:	08f48663          	beq	s1,a5,800028a8 <_Z20Threads_CPP_API_testv+0x1f8>
    80002820:	0004b503          	ld	a0,0(s1)
    80002824:	fe0508e3          	beqz	a0,80002814 <_Z20Threads_CPP_API_testv+0x164>
    80002828:	00053783          	ld	a5,0(a0)
    8000282c:	0087b783          	ld	a5,8(a5)
    80002830:	000780e7          	jalr	a5
    80002834:	fe1ff06f          	j	80002814 <_Z20Threads_CPP_API_testv+0x164>
    80002838:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    8000283c:	00048513          	mv	a0,s1
    80002840:	00002097          	auipc	ra,0x2
    80002844:	e70080e7          	jalr	-400(ra) # 800046b0 <_ZdlPv>
    80002848:	00090513          	mv	a0,s2
    8000284c:	0000a097          	auipc	ra,0xa
    80002850:	efc080e7          	jalr	-260(ra) # 8000c748 <_Unwind_Resume>
    80002854:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    80002858:	00048513          	mv	a0,s1
    8000285c:	00002097          	auipc	ra,0x2
    80002860:	e54080e7          	jalr	-428(ra) # 800046b0 <_ZdlPv>
    80002864:	00090513          	mv	a0,s2
    80002868:	0000a097          	auipc	ra,0xa
    8000286c:	ee0080e7          	jalr	-288(ra) # 8000c748 <_Unwind_Resume>
    80002870:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    80002874:	00048513          	mv	a0,s1
    80002878:	00002097          	auipc	ra,0x2
    8000287c:	e38080e7          	jalr	-456(ra) # 800046b0 <_ZdlPv>
    80002880:	00090513          	mv	a0,s2
    80002884:	0000a097          	auipc	ra,0xa
    80002888:	ec4080e7          	jalr	-316(ra) # 8000c748 <_Unwind_Resume>
    8000288c:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    80002890:	00048513          	mv	a0,s1
    80002894:	00002097          	auipc	ra,0x2
    80002898:	e1c080e7          	jalr	-484(ra) # 800046b0 <_ZdlPv>
    8000289c:	00090513          	mv	a0,s2
    800028a0:	0000a097          	auipc	ra,0xa
    800028a4:	ea8080e7          	jalr	-344(ra) # 8000c748 <_Unwind_Resume>
}
    800028a8:	03813083          	ld	ra,56(sp)
    800028ac:	03013403          	ld	s0,48(sp)
    800028b0:	02813483          	ld	s1,40(sp)
    800028b4:	02013903          	ld	s2,32(sp)
    800028b8:	04010113          	addi	sp,sp,64
    800028bc:	00008067          	ret

00000000800028c0 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    800028c0:	ff010113          	addi	sp,sp,-16
    800028c4:	00113423          	sd	ra,8(sp)
    800028c8:	00813023          	sd	s0,0(sp)
    800028cc:	01010413          	addi	s0,sp,16
    800028d0:	00009797          	auipc	a5,0x9
    800028d4:	ab878793          	addi	a5,a5,-1352 # 8000b388 <_ZTV7WorkerA+0x10>
    800028d8:	00f53023          	sd	a5,0(a0)
    800028dc:	00002097          	auipc	ra,0x2
    800028e0:	cf0080e7          	jalr	-784(ra) # 800045cc <_ZN6ThreadD1Ev>
    800028e4:	00813083          	ld	ra,8(sp)
    800028e8:	00013403          	ld	s0,0(sp)
    800028ec:	01010113          	addi	sp,sp,16
    800028f0:	00008067          	ret

00000000800028f4 <_ZN7WorkerAD0Ev>:
    800028f4:	fe010113          	addi	sp,sp,-32
    800028f8:	00113c23          	sd	ra,24(sp)
    800028fc:	00813823          	sd	s0,16(sp)
    80002900:	00913423          	sd	s1,8(sp)
    80002904:	02010413          	addi	s0,sp,32
    80002908:	00050493          	mv	s1,a0
    8000290c:	00009797          	auipc	a5,0x9
    80002910:	a7c78793          	addi	a5,a5,-1412 # 8000b388 <_ZTV7WorkerA+0x10>
    80002914:	00f53023          	sd	a5,0(a0)
    80002918:	00002097          	auipc	ra,0x2
    8000291c:	cb4080e7          	jalr	-844(ra) # 800045cc <_ZN6ThreadD1Ev>
    80002920:	00048513          	mv	a0,s1
    80002924:	00002097          	auipc	ra,0x2
    80002928:	d8c080e7          	jalr	-628(ra) # 800046b0 <_ZdlPv>
    8000292c:	01813083          	ld	ra,24(sp)
    80002930:	01013403          	ld	s0,16(sp)
    80002934:	00813483          	ld	s1,8(sp)
    80002938:	02010113          	addi	sp,sp,32
    8000293c:	00008067          	ret

0000000080002940 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80002940:	ff010113          	addi	sp,sp,-16
    80002944:	00113423          	sd	ra,8(sp)
    80002948:	00813023          	sd	s0,0(sp)
    8000294c:	01010413          	addi	s0,sp,16
    80002950:	00009797          	auipc	a5,0x9
    80002954:	a6078793          	addi	a5,a5,-1440 # 8000b3b0 <_ZTV7WorkerB+0x10>
    80002958:	00f53023          	sd	a5,0(a0)
    8000295c:	00002097          	auipc	ra,0x2
    80002960:	c70080e7          	jalr	-912(ra) # 800045cc <_ZN6ThreadD1Ev>
    80002964:	00813083          	ld	ra,8(sp)
    80002968:	00013403          	ld	s0,0(sp)
    8000296c:	01010113          	addi	sp,sp,16
    80002970:	00008067          	ret

0000000080002974 <_ZN7WorkerBD0Ev>:
    80002974:	fe010113          	addi	sp,sp,-32
    80002978:	00113c23          	sd	ra,24(sp)
    8000297c:	00813823          	sd	s0,16(sp)
    80002980:	00913423          	sd	s1,8(sp)
    80002984:	02010413          	addi	s0,sp,32
    80002988:	00050493          	mv	s1,a0
    8000298c:	00009797          	auipc	a5,0x9
    80002990:	a2478793          	addi	a5,a5,-1500 # 8000b3b0 <_ZTV7WorkerB+0x10>
    80002994:	00f53023          	sd	a5,0(a0)
    80002998:	00002097          	auipc	ra,0x2
    8000299c:	c34080e7          	jalr	-972(ra) # 800045cc <_ZN6ThreadD1Ev>
    800029a0:	00048513          	mv	a0,s1
    800029a4:	00002097          	auipc	ra,0x2
    800029a8:	d0c080e7          	jalr	-756(ra) # 800046b0 <_ZdlPv>
    800029ac:	01813083          	ld	ra,24(sp)
    800029b0:	01013403          	ld	s0,16(sp)
    800029b4:	00813483          	ld	s1,8(sp)
    800029b8:	02010113          	addi	sp,sp,32
    800029bc:	00008067          	ret

00000000800029c0 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    800029c0:	ff010113          	addi	sp,sp,-16
    800029c4:	00113423          	sd	ra,8(sp)
    800029c8:	00813023          	sd	s0,0(sp)
    800029cc:	01010413          	addi	s0,sp,16
    800029d0:	00009797          	auipc	a5,0x9
    800029d4:	a0878793          	addi	a5,a5,-1528 # 8000b3d8 <_ZTV7WorkerC+0x10>
    800029d8:	00f53023          	sd	a5,0(a0)
    800029dc:	00002097          	auipc	ra,0x2
    800029e0:	bf0080e7          	jalr	-1040(ra) # 800045cc <_ZN6ThreadD1Ev>
    800029e4:	00813083          	ld	ra,8(sp)
    800029e8:	00013403          	ld	s0,0(sp)
    800029ec:	01010113          	addi	sp,sp,16
    800029f0:	00008067          	ret

00000000800029f4 <_ZN7WorkerCD0Ev>:
    800029f4:	fe010113          	addi	sp,sp,-32
    800029f8:	00113c23          	sd	ra,24(sp)
    800029fc:	00813823          	sd	s0,16(sp)
    80002a00:	00913423          	sd	s1,8(sp)
    80002a04:	02010413          	addi	s0,sp,32
    80002a08:	00050493          	mv	s1,a0
    80002a0c:	00009797          	auipc	a5,0x9
    80002a10:	9cc78793          	addi	a5,a5,-1588 # 8000b3d8 <_ZTV7WorkerC+0x10>
    80002a14:	00f53023          	sd	a5,0(a0)
    80002a18:	00002097          	auipc	ra,0x2
    80002a1c:	bb4080e7          	jalr	-1100(ra) # 800045cc <_ZN6ThreadD1Ev>
    80002a20:	00048513          	mv	a0,s1
    80002a24:	00002097          	auipc	ra,0x2
    80002a28:	c8c080e7          	jalr	-884(ra) # 800046b0 <_ZdlPv>
    80002a2c:	01813083          	ld	ra,24(sp)
    80002a30:	01013403          	ld	s0,16(sp)
    80002a34:	00813483          	ld	s1,8(sp)
    80002a38:	02010113          	addi	sp,sp,32
    80002a3c:	00008067          	ret

0000000080002a40 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80002a40:	ff010113          	addi	sp,sp,-16
    80002a44:	00113423          	sd	ra,8(sp)
    80002a48:	00813023          	sd	s0,0(sp)
    80002a4c:	01010413          	addi	s0,sp,16
    80002a50:	00009797          	auipc	a5,0x9
    80002a54:	9b078793          	addi	a5,a5,-1616 # 8000b400 <_ZTV7WorkerD+0x10>
    80002a58:	00f53023          	sd	a5,0(a0)
    80002a5c:	00002097          	auipc	ra,0x2
    80002a60:	b70080e7          	jalr	-1168(ra) # 800045cc <_ZN6ThreadD1Ev>
    80002a64:	00813083          	ld	ra,8(sp)
    80002a68:	00013403          	ld	s0,0(sp)
    80002a6c:	01010113          	addi	sp,sp,16
    80002a70:	00008067          	ret

0000000080002a74 <_ZN7WorkerDD0Ev>:
    80002a74:	fe010113          	addi	sp,sp,-32
    80002a78:	00113c23          	sd	ra,24(sp)
    80002a7c:	00813823          	sd	s0,16(sp)
    80002a80:	00913423          	sd	s1,8(sp)
    80002a84:	02010413          	addi	s0,sp,32
    80002a88:	00050493          	mv	s1,a0
    80002a8c:	00009797          	auipc	a5,0x9
    80002a90:	97478793          	addi	a5,a5,-1676 # 8000b400 <_ZTV7WorkerD+0x10>
    80002a94:	00f53023          	sd	a5,0(a0)
    80002a98:	00002097          	auipc	ra,0x2
    80002a9c:	b34080e7          	jalr	-1228(ra) # 800045cc <_ZN6ThreadD1Ev>
    80002aa0:	00048513          	mv	a0,s1
    80002aa4:	00002097          	auipc	ra,0x2
    80002aa8:	c0c080e7          	jalr	-1012(ra) # 800046b0 <_ZdlPv>
    80002aac:	01813083          	ld	ra,24(sp)
    80002ab0:	01013403          	ld	s0,16(sp)
    80002ab4:	00813483          	ld	s1,8(sp)
    80002ab8:	02010113          	addi	sp,sp,32
    80002abc:	00008067          	ret

0000000080002ac0 <_ZN7WorkerA3runEv>:
    void run() override {
    80002ac0:	ff010113          	addi	sp,sp,-16
    80002ac4:	00113423          	sd	ra,8(sp)
    80002ac8:	00813023          	sd	s0,0(sp)
    80002acc:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80002ad0:	00000593          	li	a1,0
    80002ad4:	fffff097          	auipc	ra,0xfffff
    80002ad8:	774080e7          	jalr	1908(ra) # 80002248 <_ZN7WorkerA11workerBodyAEPv>
    }
    80002adc:	00813083          	ld	ra,8(sp)
    80002ae0:	00013403          	ld	s0,0(sp)
    80002ae4:	01010113          	addi	sp,sp,16
    80002ae8:	00008067          	ret

0000000080002aec <_ZN7WorkerB3runEv>:
    void run() override {
    80002aec:	ff010113          	addi	sp,sp,-16
    80002af0:	00113423          	sd	ra,8(sp)
    80002af4:	00813023          	sd	s0,0(sp)
    80002af8:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80002afc:	00000593          	li	a1,0
    80002b00:	00000097          	auipc	ra,0x0
    80002b04:	814080e7          	jalr	-2028(ra) # 80002314 <_ZN7WorkerB11workerBodyBEPv>
    }
    80002b08:	00813083          	ld	ra,8(sp)
    80002b0c:	00013403          	ld	s0,0(sp)
    80002b10:	01010113          	addi	sp,sp,16
    80002b14:	00008067          	ret

0000000080002b18 <_ZN7WorkerC3runEv>:
    void run() override {
    80002b18:	ff010113          	addi	sp,sp,-16
    80002b1c:	00113423          	sd	ra,8(sp)
    80002b20:	00813023          	sd	s0,0(sp)
    80002b24:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80002b28:	00000593          	li	a1,0
    80002b2c:	00000097          	auipc	ra,0x0
    80002b30:	8bc080e7          	jalr	-1860(ra) # 800023e8 <_ZN7WorkerC11workerBodyCEPv>
    }
    80002b34:	00813083          	ld	ra,8(sp)
    80002b38:	00013403          	ld	s0,0(sp)
    80002b3c:	01010113          	addi	sp,sp,16
    80002b40:	00008067          	ret

0000000080002b44 <_ZN7WorkerD3runEv>:
    void run() override {
    80002b44:	ff010113          	addi	sp,sp,-16
    80002b48:	00113423          	sd	ra,8(sp)
    80002b4c:	00813023          	sd	s0,0(sp)
    80002b50:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80002b54:	00000593          	li	a1,0
    80002b58:	00000097          	auipc	ra,0x0
    80002b5c:	a10080e7          	jalr	-1520(ra) # 80002568 <_ZN7WorkerD11workerBodyDEPv>
    }
    80002b60:	00813083          	ld	ra,8(sp)
    80002b64:	00013403          	ld	s0,0(sp)
    80002b68:	01010113          	addi	sp,sp,16
    80002b6c:	00008067          	ret

0000000080002b70 <_Z20testConsumerProducerv>:

        td->sem->signal();
    }
};

void testConsumerProducer() {
    80002b70:	f8010113          	addi	sp,sp,-128
    80002b74:	06113c23          	sd	ra,120(sp)
    80002b78:	06813823          	sd	s0,112(sp)
    80002b7c:	06913423          	sd	s1,104(sp)
    80002b80:	07213023          	sd	s2,96(sp)
    80002b84:	05313c23          	sd	s3,88(sp)
    80002b88:	05413823          	sd	s4,80(sp)
    80002b8c:	05513423          	sd	s5,72(sp)
    80002b90:	05613023          	sd	s6,64(sp)
    80002b94:	03713c23          	sd	s7,56(sp)
    80002b98:	03813823          	sd	s8,48(sp)
    80002b9c:	03913423          	sd	s9,40(sp)
    80002ba0:	08010413          	addi	s0,sp,128
    delete waitForAll;
    for (int i = 0; i < threadNum; i++) {
        delete producers[i];
    }
    delete consumer;
    delete buffer;
    80002ba4:	00010c13          	mv	s8,sp
    printString("Unesite broj proizvodjaca?\n");
    80002ba8:	00006517          	auipc	a0,0x6
    80002bac:	47850513          	addi	a0,a0,1144 # 80009020 <CONSOLE_STATUS+0x10>
    80002bb0:	00001097          	auipc	ra,0x1
    80002bb4:	cec080e7          	jalr	-788(ra) # 8000389c <_Z11printStringPKc>
    getString(input, 30);
    80002bb8:	01e00593          	li	a1,30
    80002bbc:	f8040493          	addi	s1,s0,-128
    80002bc0:	00048513          	mv	a0,s1
    80002bc4:	00001097          	auipc	ra,0x1
    80002bc8:	d60080e7          	jalr	-672(ra) # 80003924 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80002bcc:	00048513          	mv	a0,s1
    80002bd0:	00001097          	auipc	ra,0x1
    80002bd4:	e2c080e7          	jalr	-468(ra) # 800039fc <_Z11stringToIntPKc>
    80002bd8:	00050993          	mv	s3,a0
    printString("Unesite velicinu bafera?\n");
    80002bdc:	00006517          	auipc	a0,0x6
    80002be0:	46450513          	addi	a0,a0,1124 # 80009040 <CONSOLE_STATUS+0x30>
    80002be4:	00001097          	auipc	ra,0x1
    80002be8:	cb8080e7          	jalr	-840(ra) # 8000389c <_Z11printStringPKc>
    getString(input, 30);
    80002bec:	01e00593          	li	a1,30
    80002bf0:	00048513          	mv	a0,s1
    80002bf4:	00001097          	auipc	ra,0x1
    80002bf8:	d30080e7          	jalr	-720(ra) # 80003924 <_Z9getStringPci>
    n = stringToInt(input);
    80002bfc:	00048513          	mv	a0,s1
    80002c00:	00001097          	auipc	ra,0x1
    80002c04:	dfc080e7          	jalr	-516(ra) # 800039fc <_Z11stringToIntPKc>
    80002c08:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca ");
    80002c0c:	00006517          	auipc	a0,0x6
    80002c10:	45450513          	addi	a0,a0,1108 # 80009060 <CONSOLE_STATUS+0x50>
    80002c14:	00001097          	auipc	ra,0x1
    80002c18:	c88080e7          	jalr	-888(ra) # 8000389c <_Z11printStringPKc>
    printInt(threadNum);
    80002c1c:	00000613          	li	a2,0
    80002c20:	00a00593          	li	a1,10
    80002c24:	00098513          	mv	a0,s3
    80002c28:	00001097          	auipc	ra,0x1
    80002c2c:	e24080e7          	jalr	-476(ra) # 80003a4c <_Z8printIntiii>
    printString(" i velicina bafera ");
    80002c30:	00006517          	auipc	a0,0x6
    80002c34:	44850513          	addi	a0,a0,1096 # 80009078 <CONSOLE_STATUS+0x68>
    80002c38:	00001097          	auipc	ra,0x1
    80002c3c:	c64080e7          	jalr	-924(ra) # 8000389c <_Z11printStringPKc>
    printInt(n);
    80002c40:	00000613          	li	a2,0
    80002c44:	00a00593          	li	a1,10
    80002c48:	00048513          	mv	a0,s1
    80002c4c:	00001097          	auipc	ra,0x1
    80002c50:	e00080e7          	jalr	-512(ra) # 80003a4c <_Z8printIntiii>
    printString(".\n");
    80002c54:	00006517          	auipc	a0,0x6
    80002c58:	43c50513          	addi	a0,a0,1084 # 80009090 <CONSOLE_STATUS+0x80>
    80002c5c:	00001097          	auipc	ra,0x1
    80002c60:	c40080e7          	jalr	-960(ra) # 8000389c <_Z11printStringPKc>
    if (threadNum > n) {
    80002c64:	0334c463          	blt	s1,s3,80002c8c <_Z20testConsumerProducerv+0x11c>
    } else if (threadNum < 1) {
    80002c68:	03305c63          	blez	s3,80002ca0 <_Z20testConsumerProducerv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80002c6c:	03800513          	li	a0,56
    80002c70:	00002097          	auipc	ra,0x2
    80002c74:	9f0080e7          	jalr	-1552(ra) # 80004660 <_Znwm>
    80002c78:	00050a93          	mv	s5,a0
    80002c7c:	00048593          	mv	a1,s1
    80002c80:	00001097          	auipc	ra,0x1
    80002c84:	eec080e7          	jalr	-276(ra) # 80003b6c <_ZN9BufferCPPC1Ei>
    80002c88:	0300006f          	j	80002cb8 <_Z20testConsumerProducerv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80002c8c:	00006517          	auipc	a0,0x6
    80002c90:	40c50513          	addi	a0,a0,1036 # 80009098 <CONSOLE_STATUS+0x88>
    80002c94:	00001097          	auipc	ra,0x1
    80002c98:	c08080e7          	jalr	-1016(ra) # 8000389c <_Z11printStringPKc>
        return;
    80002c9c:	0140006f          	j	80002cb0 <_Z20testConsumerProducerv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80002ca0:	00006517          	auipc	a0,0x6
    80002ca4:	43850513          	addi	a0,a0,1080 # 800090d8 <CONSOLE_STATUS+0xc8>
    80002ca8:	00001097          	auipc	ra,0x1
    80002cac:	bf4080e7          	jalr	-1036(ra) # 8000389c <_Z11printStringPKc>
        return;
    80002cb0:	000c0113          	mv	sp,s8
    80002cb4:	2140006f          	j	80002ec8 <_Z20testConsumerProducerv+0x358>
    waitForAll = new Semaphore(0);
    80002cb8:	01000513          	li	a0,16
    80002cbc:	00002097          	auipc	ra,0x2
    80002cc0:	9a4080e7          	jalr	-1628(ra) # 80004660 <_Znwm>
    80002cc4:	00050913          	mv	s2,a0
    80002cc8:	00000593          	li	a1,0
    80002ccc:	00002097          	auipc	ra,0x2
    80002cd0:	be0080e7          	jalr	-1056(ra) # 800048ac <_ZN9SemaphoreC1Ej>
    80002cd4:	00009797          	auipc	a5,0x9
    80002cd8:	9327ba23          	sd	s2,-1740(a5) # 8000b608 <_ZL10waitForAll>
    Thread *producers[threadNum];
    80002cdc:	00399793          	slli	a5,s3,0x3
    80002ce0:	00f78793          	addi	a5,a5,15
    80002ce4:	ff07f793          	andi	a5,a5,-16
    80002ce8:	40f10133          	sub	sp,sp,a5
    80002cec:	00010a13          	mv	s4,sp
    thread_data threadData[threadNum + 1];
    80002cf0:	0019871b          	addiw	a4,s3,1
    80002cf4:	00171793          	slli	a5,a4,0x1
    80002cf8:	00e787b3          	add	a5,a5,a4
    80002cfc:	00379793          	slli	a5,a5,0x3
    80002d00:	00f78793          	addi	a5,a5,15
    80002d04:	ff07f793          	andi	a5,a5,-16
    80002d08:	40f10133          	sub	sp,sp,a5
    80002d0c:	00010b13          	mv	s6,sp
    threadData[threadNum].id = threadNum;
    80002d10:	00199493          	slli	s1,s3,0x1
    80002d14:	013484b3          	add	s1,s1,s3
    80002d18:	00349493          	slli	s1,s1,0x3
    80002d1c:	009b04b3          	add	s1,s6,s1
    80002d20:	0134a023          	sw	s3,0(s1)
    threadData[threadNum].buffer = buffer;
    80002d24:	0154b423          	sd	s5,8(s1)
    threadData[threadNum].sem = waitForAll;
    80002d28:	0124b823          	sd	s2,16(s1)
    Thread *consumer = new Consumer(&threadData[threadNum]);
    80002d2c:	02800513          	li	a0,40
    80002d30:	00002097          	auipc	ra,0x2
    80002d34:	930080e7          	jalr	-1744(ra) # 80004660 <_Znwm>
    80002d38:	00050b93          	mv	s7,a0
    Consumer(thread_data *_td) : Thread(), td(_td) {}
    80002d3c:	00002097          	auipc	ra,0x2
    80002d40:	ae4080e7          	jalr	-1308(ra) # 80004820 <_ZN6ThreadC1Ev>
    80002d44:	00008797          	auipc	a5,0x8
    80002d48:	73478793          	addi	a5,a5,1844 # 8000b478 <_ZTV8Consumer+0x10>
    80002d4c:	00fbb023          	sd	a5,0(s7)
    80002d50:	029bb023          	sd	s1,32(s7)
    consumer->start();
    80002d54:	000b8513          	mv	a0,s7
    80002d58:	00002097          	auipc	ra,0x2
    80002d5c:	a58080e7          	jalr	-1448(ra) # 800047b0 <_ZN6Thread5startEv>
    threadData[0].id = 0;
    80002d60:	000b2023          	sw	zero,0(s6)
    threadData[0].buffer = buffer;
    80002d64:	015b3423          	sd	s5,8(s6)
    threadData[0].sem = waitForAll;
    80002d68:	00009797          	auipc	a5,0x9
    80002d6c:	8a07b783          	ld	a5,-1888(a5) # 8000b608 <_ZL10waitForAll>
    80002d70:	00fb3823          	sd	a5,16(s6)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80002d74:	02800513          	li	a0,40
    80002d78:	00002097          	auipc	ra,0x2
    80002d7c:	8e8080e7          	jalr	-1816(ra) # 80004660 <_Znwm>
    80002d80:	00050493          	mv	s1,a0
    ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80002d84:	00002097          	auipc	ra,0x2
    80002d88:	a9c080e7          	jalr	-1380(ra) # 80004820 <_ZN6ThreadC1Ev>
    80002d8c:	00008797          	auipc	a5,0x8
    80002d90:	69c78793          	addi	a5,a5,1692 # 8000b428 <_ZTV16ProducerKeyborad+0x10>
    80002d94:	00f4b023          	sd	a5,0(s1)
    80002d98:	0364b023          	sd	s6,32(s1)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80002d9c:	009a3023          	sd	s1,0(s4)
    producers[0]->start();
    80002da0:	00048513          	mv	a0,s1
    80002da4:	00002097          	auipc	ra,0x2
    80002da8:	a0c080e7          	jalr	-1524(ra) # 800047b0 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    80002dac:	00100913          	li	s2,1
    80002db0:	0300006f          	j	80002de0 <_Z20testConsumerProducerv+0x270>
    Producer(thread_data *_td) : Thread(), td(_td) {}
    80002db4:	00008797          	auipc	a5,0x8
    80002db8:	69c78793          	addi	a5,a5,1692 # 8000b450 <_ZTV8Producer+0x10>
    80002dbc:	00fcb023          	sd	a5,0(s9)
    80002dc0:	029cb023          	sd	s1,32(s9)
        producers[i] = new Producer(&threadData[i]);
    80002dc4:	00391793          	slli	a5,s2,0x3
    80002dc8:	00fa07b3          	add	a5,s4,a5
    80002dcc:	0197b023          	sd	s9,0(a5)
        producers[i]->start();
    80002dd0:	000c8513          	mv	a0,s9
    80002dd4:	00002097          	auipc	ra,0x2
    80002dd8:	9dc080e7          	jalr	-1572(ra) # 800047b0 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    80002ddc:	0019091b          	addiw	s2,s2,1
    80002de0:	05395263          	bge	s2,s3,80002e24 <_Z20testConsumerProducerv+0x2b4>
        threadData[i].id = i;
    80002de4:	00191493          	slli	s1,s2,0x1
    80002de8:	012484b3          	add	s1,s1,s2
    80002dec:	00349493          	slli	s1,s1,0x3
    80002df0:	009b04b3          	add	s1,s6,s1
    80002df4:	0124a023          	sw	s2,0(s1)
        threadData[i].buffer = buffer;
    80002df8:	0154b423          	sd	s5,8(s1)
        threadData[i].sem = waitForAll;
    80002dfc:	00009797          	auipc	a5,0x9
    80002e00:	80c7b783          	ld	a5,-2036(a5) # 8000b608 <_ZL10waitForAll>
    80002e04:	00f4b823          	sd	a5,16(s1)
        producers[i] = new Producer(&threadData[i]);
    80002e08:	02800513          	li	a0,40
    80002e0c:	00002097          	auipc	ra,0x2
    80002e10:	854080e7          	jalr	-1964(ra) # 80004660 <_Znwm>
    80002e14:	00050c93          	mv	s9,a0
    Producer(thread_data *_td) : Thread(), td(_td) {}
    80002e18:	00002097          	auipc	ra,0x2
    80002e1c:	a08080e7          	jalr	-1528(ra) # 80004820 <_ZN6ThreadC1Ev>
    80002e20:	f95ff06f          	j	80002db4 <_Z20testConsumerProducerv+0x244>
    Thread::dispatch();
    80002e24:	00002097          	auipc	ra,0x2
    80002e28:	9d4080e7          	jalr	-1580(ra) # 800047f8 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80002e2c:	00000493          	li	s1,0
    80002e30:	0099ce63          	blt	s3,s1,80002e4c <_Z20testConsumerProducerv+0x2dc>
        waitForAll->wait();
    80002e34:	00008517          	auipc	a0,0x8
    80002e38:	7d453503          	ld	a0,2004(a0) # 8000b608 <_ZL10waitForAll>
    80002e3c:	00002097          	auipc	ra,0x2
    80002e40:	aa8080e7          	jalr	-1368(ra) # 800048e4 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80002e44:	0014849b          	addiw	s1,s1,1
    80002e48:	fe9ff06f          	j	80002e30 <_Z20testConsumerProducerv+0x2c0>
    delete waitForAll;
    80002e4c:	00008517          	auipc	a0,0x8
    80002e50:	7bc53503          	ld	a0,1980(a0) # 8000b608 <_ZL10waitForAll>
    80002e54:	00050863          	beqz	a0,80002e64 <_Z20testConsumerProducerv+0x2f4>
    80002e58:	00053783          	ld	a5,0(a0)
    80002e5c:	0087b783          	ld	a5,8(a5)
    80002e60:	000780e7          	jalr	a5
    for (int i = 0; i <= threadNum; i++) {
    80002e64:	00000493          	li	s1,0
    80002e68:	0080006f          	j	80002e70 <_Z20testConsumerProducerv+0x300>
    for (int i = 0; i < threadNum; i++) {
    80002e6c:	0014849b          	addiw	s1,s1,1
    80002e70:	0334d263          	bge	s1,s3,80002e94 <_Z20testConsumerProducerv+0x324>
        delete producers[i];
    80002e74:	00349793          	slli	a5,s1,0x3
    80002e78:	00fa07b3          	add	a5,s4,a5
    80002e7c:	0007b503          	ld	a0,0(a5)
    80002e80:	fe0506e3          	beqz	a0,80002e6c <_Z20testConsumerProducerv+0x2fc>
    80002e84:	00053783          	ld	a5,0(a0)
    80002e88:	0087b783          	ld	a5,8(a5)
    80002e8c:	000780e7          	jalr	a5
    80002e90:	fddff06f          	j	80002e6c <_Z20testConsumerProducerv+0x2fc>
    delete consumer;
    80002e94:	000b8a63          	beqz	s7,80002ea8 <_Z20testConsumerProducerv+0x338>
    80002e98:	000bb783          	ld	a5,0(s7)
    80002e9c:	0087b783          	ld	a5,8(a5)
    80002ea0:	000b8513          	mv	a0,s7
    80002ea4:	000780e7          	jalr	a5
    delete buffer;
    80002ea8:	000a8e63          	beqz	s5,80002ec4 <_Z20testConsumerProducerv+0x354>
    80002eac:	000a8513          	mv	a0,s5
    80002eb0:	00001097          	auipc	ra,0x1
    80002eb4:	fb4080e7          	jalr	-76(ra) # 80003e64 <_ZN9BufferCPPD1Ev>
    80002eb8:	000a8513          	mv	a0,s5
    80002ebc:	00001097          	auipc	ra,0x1
    80002ec0:	7f4080e7          	jalr	2036(ra) # 800046b0 <_ZdlPv>
    80002ec4:	000c0113          	mv	sp,s8
}
    80002ec8:	f8040113          	addi	sp,s0,-128
    80002ecc:	07813083          	ld	ra,120(sp)
    80002ed0:	07013403          	ld	s0,112(sp)
    80002ed4:	06813483          	ld	s1,104(sp)
    80002ed8:	06013903          	ld	s2,96(sp)
    80002edc:	05813983          	ld	s3,88(sp)
    80002ee0:	05013a03          	ld	s4,80(sp)
    80002ee4:	04813a83          	ld	s5,72(sp)
    80002ee8:	04013b03          	ld	s6,64(sp)
    80002eec:	03813b83          	ld	s7,56(sp)
    80002ef0:	03013c03          	ld	s8,48(sp)
    80002ef4:	02813c83          	ld	s9,40(sp)
    80002ef8:	08010113          	addi	sp,sp,128
    80002efc:	00008067          	ret
    80002f00:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80002f04:	000a8513          	mv	a0,s5
    80002f08:	00001097          	auipc	ra,0x1
    80002f0c:	7a8080e7          	jalr	1960(ra) # 800046b0 <_ZdlPv>
    80002f10:	00048513          	mv	a0,s1
    80002f14:	0000a097          	auipc	ra,0xa
    80002f18:	834080e7          	jalr	-1996(ra) # 8000c748 <_Unwind_Resume>
    80002f1c:	00050493          	mv	s1,a0
    waitForAll = new Semaphore(0);
    80002f20:	00090513          	mv	a0,s2
    80002f24:	00001097          	auipc	ra,0x1
    80002f28:	78c080e7          	jalr	1932(ra) # 800046b0 <_ZdlPv>
    80002f2c:	00048513          	mv	a0,s1
    80002f30:	0000a097          	auipc	ra,0xa
    80002f34:	818080e7          	jalr	-2024(ra) # 8000c748 <_Unwind_Resume>
    80002f38:	00050493          	mv	s1,a0
    Thread *consumer = new Consumer(&threadData[threadNum]);
    80002f3c:	000b8513          	mv	a0,s7
    80002f40:	00001097          	auipc	ra,0x1
    80002f44:	770080e7          	jalr	1904(ra) # 800046b0 <_ZdlPv>
    80002f48:	00048513          	mv	a0,s1
    80002f4c:	00009097          	auipc	ra,0x9
    80002f50:	7fc080e7          	jalr	2044(ra) # 8000c748 <_Unwind_Resume>
    80002f54:	00050913          	mv	s2,a0
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80002f58:	00048513          	mv	a0,s1
    80002f5c:	00001097          	auipc	ra,0x1
    80002f60:	754080e7          	jalr	1876(ra) # 800046b0 <_ZdlPv>
    80002f64:	00090513          	mv	a0,s2
    80002f68:	00009097          	auipc	ra,0x9
    80002f6c:	7e0080e7          	jalr	2016(ra) # 8000c748 <_Unwind_Resume>
    80002f70:	00050493          	mv	s1,a0
        producers[i] = new Producer(&threadData[i]);
    80002f74:	000c8513          	mv	a0,s9
    80002f78:	00001097          	auipc	ra,0x1
    80002f7c:	738080e7          	jalr	1848(ra) # 800046b0 <_ZdlPv>
    80002f80:	00048513          	mv	a0,s1
    80002f84:	00009097          	auipc	ra,0x9
    80002f88:	7c4080e7          	jalr	1988(ra) # 8000c748 <_Unwind_Resume>

0000000080002f8c <_ZN8Consumer3runEv>:
    void run() override {
    80002f8c:	fd010113          	addi	sp,sp,-48
    80002f90:	02113423          	sd	ra,40(sp)
    80002f94:	02813023          	sd	s0,32(sp)
    80002f98:	00913c23          	sd	s1,24(sp)
    80002f9c:	01213823          	sd	s2,16(sp)
    80002fa0:	01313423          	sd	s3,8(sp)
    80002fa4:	03010413          	addi	s0,sp,48
    80002fa8:	00050913          	mv	s2,a0
        int i = 0;
    80002fac:	00000993          	li	s3,0
    80002fb0:	0100006f          	j	80002fc0 <_ZN8Consumer3runEv+0x34>
                Console::putc('\n');
    80002fb4:	00a00513          	li	a0,10
    80002fb8:	00002097          	auipc	ra,0x2
    80002fbc:	a08080e7          	jalr	-1528(ra) # 800049c0 <_ZN7Console4putcEc>
        while (!threadEnd) {
    80002fc0:	00008797          	auipc	a5,0x8
    80002fc4:	6407a783          	lw	a5,1600(a5) # 8000b600 <_ZL9threadEnd>
    80002fc8:	04079a63          	bnez	a5,8000301c <_ZN8Consumer3runEv+0x90>
            int key = td->buffer->get();
    80002fcc:	02093783          	ld	a5,32(s2)
    80002fd0:	0087b503          	ld	a0,8(a5)
    80002fd4:	00001097          	auipc	ra,0x1
    80002fd8:	d7c080e7          	jalr	-644(ra) # 80003d50 <_ZN9BufferCPP3getEv>
            i++;
    80002fdc:	0019849b          	addiw	s1,s3,1
    80002fe0:	0004899b          	sext.w	s3,s1
            Console::putc(key);
    80002fe4:	0ff57513          	andi	a0,a0,255
    80002fe8:	00002097          	auipc	ra,0x2
    80002fec:	9d8080e7          	jalr	-1576(ra) # 800049c0 <_ZN7Console4putcEc>
            if (i % 80 == 0) {
    80002ff0:	05000793          	li	a5,80
    80002ff4:	02f4e4bb          	remw	s1,s1,a5
    80002ff8:	fc0494e3          	bnez	s1,80002fc0 <_ZN8Consumer3runEv+0x34>
    80002ffc:	fb9ff06f          	j	80002fb4 <_ZN8Consumer3runEv+0x28>
            int key = td->buffer->get();
    80003000:	02093783          	ld	a5,32(s2)
    80003004:	0087b503          	ld	a0,8(a5)
    80003008:	00001097          	auipc	ra,0x1
    8000300c:	d48080e7          	jalr	-696(ra) # 80003d50 <_ZN9BufferCPP3getEv>
            Console::putc(key);
    80003010:	0ff57513          	andi	a0,a0,255
    80003014:	00002097          	auipc	ra,0x2
    80003018:	9ac080e7          	jalr	-1620(ra) # 800049c0 <_ZN7Console4putcEc>
        while (td->buffer->getCnt() > 0) {
    8000301c:	02093783          	ld	a5,32(s2)
    80003020:	0087b503          	ld	a0,8(a5)
    80003024:	00001097          	auipc	ra,0x1
    80003028:	db8080e7          	jalr	-584(ra) # 80003ddc <_ZN9BufferCPP6getCntEv>
    8000302c:	fca04ae3          	bgtz	a0,80003000 <_ZN8Consumer3runEv+0x74>
        td->sem->signal();
    80003030:	02093783          	ld	a5,32(s2)
    80003034:	0107b503          	ld	a0,16(a5)
    80003038:	00002097          	auipc	ra,0x2
    8000303c:	8e8080e7          	jalr	-1816(ra) # 80004920 <_ZN9Semaphore6signalEv>
    }
    80003040:	02813083          	ld	ra,40(sp)
    80003044:	02013403          	ld	s0,32(sp)
    80003048:	01813483          	ld	s1,24(sp)
    8000304c:	01013903          	ld	s2,16(sp)
    80003050:	00813983          	ld	s3,8(sp)
    80003054:	03010113          	addi	sp,sp,48
    80003058:	00008067          	ret

000000008000305c <_ZN8ConsumerD1Ev>:
class Consumer : public Thread {
    8000305c:	ff010113          	addi	sp,sp,-16
    80003060:	00113423          	sd	ra,8(sp)
    80003064:	00813023          	sd	s0,0(sp)
    80003068:	01010413          	addi	s0,sp,16
    8000306c:	00008797          	auipc	a5,0x8
    80003070:	40c78793          	addi	a5,a5,1036 # 8000b478 <_ZTV8Consumer+0x10>
    80003074:	00f53023          	sd	a5,0(a0)
    80003078:	00001097          	auipc	ra,0x1
    8000307c:	554080e7          	jalr	1364(ra) # 800045cc <_ZN6ThreadD1Ev>
    80003080:	00813083          	ld	ra,8(sp)
    80003084:	00013403          	ld	s0,0(sp)
    80003088:	01010113          	addi	sp,sp,16
    8000308c:	00008067          	ret

0000000080003090 <_ZN8ConsumerD0Ev>:
    80003090:	fe010113          	addi	sp,sp,-32
    80003094:	00113c23          	sd	ra,24(sp)
    80003098:	00813823          	sd	s0,16(sp)
    8000309c:	00913423          	sd	s1,8(sp)
    800030a0:	02010413          	addi	s0,sp,32
    800030a4:	00050493          	mv	s1,a0
    800030a8:	00008797          	auipc	a5,0x8
    800030ac:	3d078793          	addi	a5,a5,976 # 8000b478 <_ZTV8Consumer+0x10>
    800030b0:	00f53023          	sd	a5,0(a0)
    800030b4:	00001097          	auipc	ra,0x1
    800030b8:	518080e7          	jalr	1304(ra) # 800045cc <_ZN6ThreadD1Ev>
    800030bc:	00048513          	mv	a0,s1
    800030c0:	00001097          	auipc	ra,0x1
    800030c4:	5f0080e7          	jalr	1520(ra) # 800046b0 <_ZdlPv>
    800030c8:	01813083          	ld	ra,24(sp)
    800030cc:	01013403          	ld	s0,16(sp)
    800030d0:	00813483          	ld	s1,8(sp)
    800030d4:	02010113          	addi	sp,sp,32
    800030d8:	00008067          	ret

00000000800030dc <_ZN16ProducerKeyboradD1Ev>:
class ProducerKeyborad : public Thread {
    800030dc:	ff010113          	addi	sp,sp,-16
    800030e0:	00113423          	sd	ra,8(sp)
    800030e4:	00813023          	sd	s0,0(sp)
    800030e8:	01010413          	addi	s0,sp,16
    800030ec:	00008797          	auipc	a5,0x8
    800030f0:	33c78793          	addi	a5,a5,828 # 8000b428 <_ZTV16ProducerKeyborad+0x10>
    800030f4:	00f53023          	sd	a5,0(a0)
    800030f8:	00001097          	auipc	ra,0x1
    800030fc:	4d4080e7          	jalr	1236(ra) # 800045cc <_ZN6ThreadD1Ev>
    80003100:	00813083          	ld	ra,8(sp)
    80003104:	00013403          	ld	s0,0(sp)
    80003108:	01010113          	addi	sp,sp,16
    8000310c:	00008067          	ret

0000000080003110 <_ZN16ProducerKeyboradD0Ev>:
    80003110:	fe010113          	addi	sp,sp,-32
    80003114:	00113c23          	sd	ra,24(sp)
    80003118:	00813823          	sd	s0,16(sp)
    8000311c:	00913423          	sd	s1,8(sp)
    80003120:	02010413          	addi	s0,sp,32
    80003124:	00050493          	mv	s1,a0
    80003128:	00008797          	auipc	a5,0x8
    8000312c:	30078793          	addi	a5,a5,768 # 8000b428 <_ZTV16ProducerKeyborad+0x10>
    80003130:	00f53023          	sd	a5,0(a0)
    80003134:	00001097          	auipc	ra,0x1
    80003138:	498080e7          	jalr	1176(ra) # 800045cc <_ZN6ThreadD1Ev>
    8000313c:	00048513          	mv	a0,s1
    80003140:	00001097          	auipc	ra,0x1
    80003144:	570080e7          	jalr	1392(ra) # 800046b0 <_ZdlPv>
    80003148:	01813083          	ld	ra,24(sp)
    8000314c:	01013403          	ld	s0,16(sp)
    80003150:	00813483          	ld	s1,8(sp)
    80003154:	02010113          	addi	sp,sp,32
    80003158:	00008067          	ret

000000008000315c <_ZN8ProducerD1Ev>:
class Producer : public Thread {
    8000315c:	ff010113          	addi	sp,sp,-16
    80003160:	00113423          	sd	ra,8(sp)
    80003164:	00813023          	sd	s0,0(sp)
    80003168:	01010413          	addi	s0,sp,16
    8000316c:	00008797          	auipc	a5,0x8
    80003170:	2e478793          	addi	a5,a5,740 # 8000b450 <_ZTV8Producer+0x10>
    80003174:	00f53023          	sd	a5,0(a0)
    80003178:	00001097          	auipc	ra,0x1
    8000317c:	454080e7          	jalr	1108(ra) # 800045cc <_ZN6ThreadD1Ev>
    80003180:	00813083          	ld	ra,8(sp)
    80003184:	00013403          	ld	s0,0(sp)
    80003188:	01010113          	addi	sp,sp,16
    8000318c:	00008067          	ret

0000000080003190 <_ZN8ProducerD0Ev>:
    80003190:	fe010113          	addi	sp,sp,-32
    80003194:	00113c23          	sd	ra,24(sp)
    80003198:	00813823          	sd	s0,16(sp)
    8000319c:	00913423          	sd	s1,8(sp)
    800031a0:	02010413          	addi	s0,sp,32
    800031a4:	00050493          	mv	s1,a0
    800031a8:	00008797          	auipc	a5,0x8
    800031ac:	2a878793          	addi	a5,a5,680 # 8000b450 <_ZTV8Producer+0x10>
    800031b0:	00f53023          	sd	a5,0(a0)
    800031b4:	00001097          	auipc	ra,0x1
    800031b8:	418080e7          	jalr	1048(ra) # 800045cc <_ZN6ThreadD1Ev>
    800031bc:	00048513          	mv	a0,s1
    800031c0:	00001097          	auipc	ra,0x1
    800031c4:	4f0080e7          	jalr	1264(ra) # 800046b0 <_ZdlPv>
    800031c8:	01813083          	ld	ra,24(sp)
    800031cc:	01013403          	ld	s0,16(sp)
    800031d0:	00813483          	ld	s1,8(sp)
    800031d4:	02010113          	addi	sp,sp,32
    800031d8:	00008067          	ret

00000000800031dc <_ZN16ProducerKeyborad3runEv>:
    void run() override {
    800031dc:	fe010113          	addi	sp,sp,-32
    800031e0:	00113c23          	sd	ra,24(sp)
    800031e4:	00813823          	sd	s0,16(sp)
    800031e8:	00913423          	sd	s1,8(sp)
    800031ec:	02010413          	addi	s0,sp,32
    800031f0:	00050493          	mv	s1,a0
        while ((key = getc()) != 0x1b) {
    800031f4:	ffffe097          	auipc	ra,0xffffe
    800031f8:	27c080e7          	jalr	636(ra) # 80001470 <_Z4getcv>
    800031fc:	0005059b          	sext.w	a1,a0
    80003200:	01b00793          	li	a5,27
    80003204:	00f58c63          	beq	a1,a5,8000321c <_ZN16ProducerKeyborad3runEv+0x40>
            td->buffer->put(key);
    80003208:	0204b783          	ld	a5,32(s1)
    8000320c:	0087b503          	ld	a0,8(a5)
    80003210:	00001097          	auipc	ra,0x1
    80003214:	ab0080e7          	jalr	-1360(ra) # 80003cc0 <_ZN9BufferCPP3putEi>
        while ((key = getc()) != 0x1b) {
    80003218:	fddff06f          	j	800031f4 <_ZN16ProducerKeyborad3runEv+0x18>
        threadEnd = 1;
    8000321c:	00100793          	li	a5,1
    80003220:	00008717          	auipc	a4,0x8
    80003224:	3ef72023          	sw	a5,992(a4) # 8000b600 <_ZL9threadEnd>
        td->buffer->put('!');
    80003228:	0204b783          	ld	a5,32(s1)
    8000322c:	02100593          	li	a1,33
    80003230:	0087b503          	ld	a0,8(a5)
    80003234:	00001097          	auipc	ra,0x1
    80003238:	a8c080e7          	jalr	-1396(ra) # 80003cc0 <_ZN9BufferCPP3putEi>
        td->sem->signal();
    8000323c:	0204b783          	ld	a5,32(s1)
    80003240:	0107b503          	ld	a0,16(a5)
    80003244:	00001097          	auipc	ra,0x1
    80003248:	6dc080e7          	jalr	1756(ra) # 80004920 <_ZN9Semaphore6signalEv>
    }
    8000324c:	01813083          	ld	ra,24(sp)
    80003250:	01013403          	ld	s0,16(sp)
    80003254:	00813483          	ld	s1,8(sp)
    80003258:	02010113          	addi	sp,sp,32
    8000325c:	00008067          	ret

0000000080003260 <_ZN8Producer3runEv>:
    void run() override {
    80003260:	fe010113          	addi	sp,sp,-32
    80003264:	00113c23          	sd	ra,24(sp)
    80003268:	00813823          	sd	s0,16(sp)
    8000326c:	00913423          	sd	s1,8(sp)
    80003270:	02010413          	addi	s0,sp,32
    80003274:	00050493          	mv	s1,a0
        while (!threadEnd) {
    80003278:	00008797          	auipc	a5,0x8
    8000327c:	3887a783          	lw	a5,904(a5) # 8000b600 <_ZL9threadEnd>
    80003280:	02079063          	bnez	a5,800032a0 <_ZN8Producer3runEv+0x40>
            td->buffer->put(td->id + '0');
    80003284:	0204b783          	ld	a5,32(s1)
    80003288:	0007a583          	lw	a1,0(a5)
    8000328c:	0305859b          	addiw	a1,a1,48
    80003290:	0087b503          	ld	a0,8(a5)
    80003294:	00001097          	auipc	ra,0x1
    80003298:	a2c080e7          	jalr	-1492(ra) # 80003cc0 <_ZN9BufferCPP3putEi>
        while (!threadEnd) {
    8000329c:	fddff06f          	j	80003278 <_ZN8Producer3runEv+0x18>
        td->sem->signal();
    800032a0:	0204b783          	ld	a5,32(s1)
    800032a4:	0107b503          	ld	a0,16(a5)
    800032a8:	00001097          	auipc	ra,0x1
    800032ac:	678080e7          	jalr	1656(ra) # 80004920 <_ZN9Semaphore6signalEv>
    }
    800032b0:	01813083          	ld	ra,24(sp)
    800032b4:	01013403          	ld	s0,16(sp)
    800032b8:	00813483          	ld	s1,8(sp)
    800032bc:	02010113          	addi	sp,sp,32
    800032c0:	00008067          	ret

00000000800032c4 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    800032c4:	fe010113          	addi	sp,sp,-32
    800032c8:	00113c23          	sd	ra,24(sp)
    800032cc:	00813823          	sd	s0,16(sp)
    800032d0:	00913423          	sd	s1,8(sp)
    800032d4:	01213023          	sd	s2,0(sp)
    800032d8:	02010413          	addi	s0,sp,32
    800032dc:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800032e0:	00100793          	li	a5,1
    800032e4:	02a7f863          	bgeu	a5,a0,80003314 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800032e8:	00a00793          	li	a5,10
    800032ec:	02f577b3          	remu	a5,a0,a5
    800032f0:	02078e63          	beqz	a5,8000332c <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    800032f4:	fff48513          	addi	a0,s1,-1
    800032f8:	00000097          	auipc	ra,0x0
    800032fc:	fcc080e7          	jalr	-52(ra) # 800032c4 <_ZL9fibonaccim>
    80003300:	00050913          	mv	s2,a0
    80003304:	ffe48513          	addi	a0,s1,-2
    80003308:	00000097          	auipc	ra,0x0
    8000330c:	fbc080e7          	jalr	-68(ra) # 800032c4 <_ZL9fibonaccim>
    80003310:	00a90533          	add	a0,s2,a0
}
    80003314:	01813083          	ld	ra,24(sp)
    80003318:	01013403          	ld	s0,16(sp)
    8000331c:	00813483          	ld	s1,8(sp)
    80003320:	00013903          	ld	s2,0(sp)
    80003324:	02010113          	addi	sp,sp,32
    80003328:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    8000332c:	ffffe097          	auipc	ra,0xffffe
    80003330:	f68080e7          	jalr	-152(ra) # 80001294 <_Z15thread_dispatchv>
    80003334:	fc1ff06f          	j	800032f4 <_ZL9fibonaccim+0x30>

0000000080003338 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80003338:	fe010113          	addi	sp,sp,-32
    8000333c:	00113c23          	sd	ra,24(sp)
    80003340:	00813823          	sd	s0,16(sp)
    80003344:	00913423          	sd	s1,8(sp)
    80003348:	01213023          	sd	s2,0(sp)
    8000334c:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80003350:	00a00493          	li	s1,10
    80003354:	0400006f          	j	80003394 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80003358:	00006517          	auipc	a0,0x6
    8000335c:	df050513          	addi	a0,a0,-528 # 80009148 <CONSOLE_STATUS+0x138>
    80003360:	00000097          	auipc	ra,0x0
    80003364:	53c080e7          	jalr	1340(ra) # 8000389c <_Z11printStringPKc>
    80003368:	00000613          	li	a2,0
    8000336c:	00a00593          	li	a1,10
    80003370:	00048513          	mv	a0,s1
    80003374:	00000097          	auipc	ra,0x0
    80003378:	6d8080e7          	jalr	1752(ra) # 80003a4c <_Z8printIntiii>
    8000337c:	00006517          	auipc	a0,0x6
    80003380:	02c50513          	addi	a0,a0,44 # 800093a8 <CONSOLE_STATUS+0x398>
    80003384:	00000097          	auipc	ra,0x0
    80003388:	518080e7          	jalr	1304(ra) # 8000389c <_Z11printStringPKc>
    for (; i < 13; i++) {
    8000338c:	0014849b          	addiw	s1,s1,1
    80003390:	0ff4f493          	andi	s1,s1,255
    80003394:	00c00793          	li	a5,12
    80003398:	fc97f0e3          	bgeu	a5,s1,80003358 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    8000339c:	00006517          	auipc	a0,0x6
    800033a0:	e0450513          	addi	a0,a0,-508 # 800091a0 <CONSOLE_STATUS+0x190>
    800033a4:	00000097          	auipc	ra,0x0
    800033a8:	4f8080e7          	jalr	1272(ra) # 8000389c <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800033ac:	00500313          	li	t1,5
    thread_dispatch();
    800033b0:	ffffe097          	auipc	ra,0xffffe
    800033b4:	ee4080e7          	jalr	-284(ra) # 80001294 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800033b8:	01000513          	li	a0,16
    800033bc:	00000097          	auipc	ra,0x0
    800033c0:	f08080e7          	jalr	-248(ra) # 800032c4 <_ZL9fibonaccim>
    800033c4:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800033c8:	00006517          	auipc	a0,0x6
    800033cc:	d9850513          	addi	a0,a0,-616 # 80009160 <CONSOLE_STATUS+0x150>
    800033d0:	00000097          	auipc	ra,0x0
    800033d4:	4cc080e7          	jalr	1228(ra) # 8000389c <_Z11printStringPKc>
    800033d8:	00000613          	li	a2,0
    800033dc:	00a00593          	li	a1,10
    800033e0:	0009051b          	sext.w	a0,s2
    800033e4:	00000097          	auipc	ra,0x0
    800033e8:	668080e7          	jalr	1640(ra) # 80003a4c <_Z8printIntiii>
    800033ec:	00006517          	auipc	a0,0x6
    800033f0:	fbc50513          	addi	a0,a0,-68 # 800093a8 <CONSOLE_STATUS+0x398>
    800033f4:	00000097          	auipc	ra,0x0
    800033f8:	4a8080e7          	jalr	1192(ra) # 8000389c <_Z11printStringPKc>
    800033fc:	0400006f          	j	8000343c <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80003400:	00006517          	auipc	a0,0x6
    80003404:	d4850513          	addi	a0,a0,-696 # 80009148 <CONSOLE_STATUS+0x138>
    80003408:	00000097          	auipc	ra,0x0
    8000340c:	494080e7          	jalr	1172(ra) # 8000389c <_Z11printStringPKc>
    80003410:	00000613          	li	a2,0
    80003414:	00a00593          	li	a1,10
    80003418:	00048513          	mv	a0,s1
    8000341c:	00000097          	auipc	ra,0x0
    80003420:	630080e7          	jalr	1584(ra) # 80003a4c <_Z8printIntiii>
    80003424:	00006517          	auipc	a0,0x6
    80003428:	f8450513          	addi	a0,a0,-124 # 800093a8 <CONSOLE_STATUS+0x398>
    8000342c:	00000097          	auipc	ra,0x0
    80003430:	470080e7          	jalr	1136(ra) # 8000389c <_Z11printStringPKc>
    for (; i < 16; i++) {
    80003434:	0014849b          	addiw	s1,s1,1
    80003438:	0ff4f493          	andi	s1,s1,255
    8000343c:	00f00793          	li	a5,15
    80003440:	fc97f0e3          	bgeu	a5,s1,80003400 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80003444:	00006517          	auipc	a0,0x6
    80003448:	d6c50513          	addi	a0,a0,-660 # 800091b0 <CONSOLE_STATUS+0x1a0>
    8000344c:	00000097          	auipc	ra,0x0
    80003450:	450080e7          	jalr	1104(ra) # 8000389c <_Z11printStringPKc>
    finishedD = true;
    80003454:	00100793          	li	a5,1
    80003458:	00008717          	auipc	a4,0x8
    8000345c:	1af70c23          	sb	a5,440(a4) # 8000b610 <_ZL9finishedD>
    thread_dispatch();
    80003460:	ffffe097          	auipc	ra,0xffffe
    80003464:	e34080e7          	jalr	-460(ra) # 80001294 <_Z15thread_dispatchv>
}
    80003468:	01813083          	ld	ra,24(sp)
    8000346c:	01013403          	ld	s0,16(sp)
    80003470:	00813483          	ld	s1,8(sp)
    80003474:	00013903          	ld	s2,0(sp)
    80003478:	02010113          	addi	sp,sp,32
    8000347c:	00008067          	ret

0000000080003480 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80003480:	fe010113          	addi	sp,sp,-32
    80003484:	00113c23          	sd	ra,24(sp)
    80003488:	00813823          	sd	s0,16(sp)
    8000348c:	00913423          	sd	s1,8(sp)
    80003490:	01213023          	sd	s2,0(sp)
    80003494:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80003498:	00000493          	li	s1,0
    8000349c:	0400006f          	j	800034dc <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    800034a0:	00006517          	auipc	a0,0x6
    800034a4:	c7850513          	addi	a0,a0,-904 # 80009118 <CONSOLE_STATUS+0x108>
    800034a8:	00000097          	auipc	ra,0x0
    800034ac:	3f4080e7          	jalr	1012(ra) # 8000389c <_Z11printStringPKc>
    800034b0:	00000613          	li	a2,0
    800034b4:	00a00593          	li	a1,10
    800034b8:	00048513          	mv	a0,s1
    800034bc:	00000097          	auipc	ra,0x0
    800034c0:	590080e7          	jalr	1424(ra) # 80003a4c <_Z8printIntiii>
    800034c4:	00006517          	auipc	a0,0x6
    800034c8:	ee450513          	addi	a0,a0,-284 # 800093a8 <CONSOLE_STATUS+0x398>
    800034cc:	00000097          	auipc	ra,0x0
    800034d0:	3d0080e7          	jalr	976(ra) # 8000389c <_Z11printStringPKc>
    for (; i < 3; i++) {
    800034d4:	0014849b          	addiw	s1,s1,1
    800034d8:	0ff4f493          	andi	s1,s1,255
    800034dc:	00200793          	li	a5,2
    800034e0:	fc97f0e3          	bgeu	a5,s1,800034a0 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    800034e4:	00006517          	auipc	a0,0x6
    800034e8:	cac50513          	addi	a0,a0,-852 # 80009190 <CONSOLE_STATUS+0x180>
    800034ec:	00000097          	auipc	ra,0x0
    800034f0:	3b0080e7          	jalr	944(ra) # 8000389c <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800034f4:	00700313          	li	t1,7
    thread_dispatch();
    800034f8:	ffffe097          	auipc	ra,0xffffe
    800034fc:	d9c080e7          	jalr	-612(ra) # 80001294 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80003500:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80003504:	00006517          	auipc	a0,0x6
    80003508:	c2c50513          	addi	a0,a0,-980 # 80009130 <CONSOLE_STATUS+0x120>
    8000350c:	00000097          	auipc	ra,0x0
    80003510:	390080e7          	jalr	912(ra) # 8000389c <_Z11printStringPKc>
    80003514:	00000613          	li	a2,0
    80003518:	00a00593          	li	a1,10
    8000351c:	0009051b          	sext.w	a0,s2
    80003520:	00000097          	auipc	ra,0x0
    80003524:	52c080e7          	jalr	1324(ra) # 80003a4c <_Z8printIntiii>
    80003528:	00006517          	auipc	a0,0x6
    8000352c:	e8050513          	addi	a0,a0,-384 # 800093a8 <CONSOLE_STATUS+0x398>
    80003530:	00000097          	auipc	ra,0x0
    80003534:	36c080e7          	jalr	876(ra) # 8000389c <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80003538:	00c00513          	li	a0,12
    8000353c:	00000097          	auipc	ra,0x0
    80003540:	d88080e7          	jalr	-632(ra) # 800032c4 <_ZL9fibonaccim>
    80003544:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80003548:	00006517          	auipc	a0,0x6
    8000354c:	bf050513          	addi	a0,a0,-1040 # 80009138 <CONSOLE_STATUS+0x128>
    80003550:	00000097          	auipc	ra,0x0
    80003554:	34c080e7          	jalr	844(ra) # 8000389c <_Z11printStringPKc>
    80003558:	00000613          	li	a2,0
    8000355c:	00a00593          	li	a1,10
    80003560:	0009051b          	sext.w	a0,s2
    80003564:	00000097          	auipc	ra,0x0
    80003568:	4e8080e7          	jalr	1256(ra) # 80003a4c <_Z8printIntiii>
    8000356c:	00006517          	auipc	a0,0x6
    80003570:	e3c50513          	addi	a0,a0,-452 # 800093a8 <CONSOLE_STATUS+0x398>
    80003574:	00000097          	auipc	ra,0x0
    80003578:	328080e7          	jalr	808(ra) # 8000389c <_Z11printStringPKc>
    8000357c:	0400006f          	j	800035bc <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80003580:	00006517          	auipc	a0,0x6
    80003584:	b9850513          	addi	a0,a0,-1128 # 80009118 <CONSOLE_STATUS+0x108>
    80003588:	00000097          	auipc	ra,0x0
    8000358c:	314080e7          	jalr	788(ra) # 8000389c <_Z11printStringPKc>
    80003590:	00000613          	li	a2,0
    80003594:	00a00593          	li	a1,10
    80003598:	00048513          	mv	a0,s1
    8000359c:	00000097          	auipc	ra,0x0
    800035a0:	4b0080e7          	jalr	1200(ra) # 80003a4c <_Z8printIntiii>
    800035a4:	00006517          	auipc	a0,0x6
    800035a8:	e0450513          	addi	a0,a0,-508 # 800093a8 <CONSOLE_STATUS+0x398>
    800035ac:	00000097          	auipc	ra,0x0
    800035b0:	2f0080e7          	jalr	752(ra) # 8000389c <_Z11printStringPKc>
    for (; i < 6; i++) {
    800035b4:	0014849b          	addiw	s1,s1,1
    800035b8:	0ff4f493          	andi	s1,s1,255
    800035bc:	00500793          	li	a5,5
    800035c0:	fc97f0e3          	bgeu	a5,s1,80003580 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    800035c4:	00006517          	auipc	a0,0x6
    800035c8:	bac50513          	addi	a0,a0,-1108 # 80009170 <CONSOLE_STATUS+0x160>
    800035cc:	00000097          	auipc	ra,0x0
    800035d0:	2d0080e7          	jalr	720(ra) # 8000389c <_Z11printStringPKc>
    finishedC = true;
    800035d4:	00100793          	li	a5,1
    800035d8:	00008717          	auipc	a4,0x8
    800035dc:	02f70ca3          	sb	a5,57(a4) # 8000b611 <_ZL9finishedC>
    thread_dispatch();
    800035e0:	ffffe097          	auipc	ra,0xffffe
    800035e4:	cb4080e7          	jalr	-844(ra) # 80001294 <_Z15thread_dispatchv>
}
    800035e8:	01813083          	ld	ra,24(sp)
    800035ec:	01013403          	ld	s0,16(sp)
    800035f0:	00813483          	ld	s1,8(sp)
    800035f4:	00013903          	ld	s2,0(sp)
    800035f8:	02010113          	addi	sp,sp,32
    800035fc:	00008067          	ret

0000000080003600 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80003600:	fe010113          	addi	sp,sp,-32
    80003604:	00113c23          	sd	ra,24(sp)
    80003608:	00813823          	sd	s0,16(sp)
    8000360c:	00913423          	sd	s1,8(sp)
    80003610:	01213023          	sd	s2,0(sp)
    80003614:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80003618:	00000913          	li	s2,0
    8000361c:	0380006f          	j	80003654 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80003620:	ffffe097          	auipc	ra,0xffffe
    80003624:	c74080e7          	jalr	-908(ra) # 80001294 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003628:	00148493          	addi	s1,s1,1
    8000362c:	000027b7          	lui	a5,0x2
    80003630:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003634:	0097ee63          	bltu	a5,s1,80003650 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003638:	00000713          	li	a4,0
    8000363c:	000077b7          	lui	a5,0x7
    80003640:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003644:	fce7eee3          	bltu	a5,a4,80003620 <_ZL11workerBodyBPv+0x20>
    80003648:	00170713          	addi	a4,a4,1
    8000364c:	ff1ff06f          	j	8000363c <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80003650:	00190913          	addi	s2,s2,1
    80003654:	00f00793          	li	a5,15
    80003658:	0527e063          	bltu	a5,s2,80003698 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    8000365c:	00006517          	auipc	a0,0x6
    80003660:	ab450513          	addi	a0,a0,-1356 # 80009110 <CONSOLE_STATUS+0x100>
    80003664:	00000097          	auipc	ra,0x0
    80003668:	238080e7          	jalr	568(ra) # 8000389c <_Z11printStringPKc>
    8000366c:	00000613          	li	a2,0
    80003670:	00a00593          	li	a1,10
    80003674:	0009051b          	sext.w	a0,s2
    80003678:	00000097          	auipc	ra,0x0
    8000367c:	3d4080e7          	jalr	980(ra) # 80003a4c <_Z8printIntiii>
    80003680:	00006517          	auipc	a0,0x6
    80003684:	d2850513          	addi	a0,a0,-728 # 800093a8 <CONSOLE_STATUS+0x398>
    80003688:	00000097          	auipc	ra,0x0
    8000368c:	214080e7          	jalr	532(ra) # 8000389c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80003690:	00000493          	li	s1,0
    80003694:	f99ff06f          	j	8000362c <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80003698:	00006517          	auipc	a0,0x6
    8000369c:	ae850513          	addi	a0,a0,-1304 # 80009180 <CONSOLE_STATUS+0x170>
    800036a0:	00000097          	auipc	ra,0x0
    800036a4:	1fc080e7          	jalr	508(ra) # 8000389c <_Z11printStringPKc>
    finishedB = true;
    800036a8:	00100793          	li	a5,1
    800036ac:	00008717          	auipc	a4,0x8
    800036b0:	f6f70323          	sb	a5,-154(a4) # 8000b612 <_ZL9finishedB>
    thread_dispatch();
    800036b4:	ffffe097          	auipc	ra,0xffffe
    800036b8:	be0080e7          	jalr	-1056(ra) # 80001294 <_Z15thread_dispatchv>
}
    800036bc:	01813083          	ld	ra,24(sp)
    800036c0:	01013403          	ld	s0,16(sp)
    800036c4:	00813483          	ld	s1,8(sp)
    800036c8:	00013903          	ld	s2,0(sp)
    800036cc:	02010113          	addi	sp,sp,32
    800036d0:	00008067          	ret

00000000800036d4 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    800036d4:	fe010113          	addi	sp,sp,-32
    800036d8:	00113c23          	sd	ra,24(sp)
    800036dc:	00813823          	sd	s0,16(sp)
    800036e0:	00913423          	sd	s1,8(sp)
    800036e4:	01213023          	sd	s2,0(sp)
    800036e8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800036ec:	00000913          	li	s2,0
    800036f0:	0380006f          	j	80003728 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    800036f4:	ffffe097          	auipc	ra,0xffffe
    800036f8:	ba0080e7          	jalr	-1120(ra) # 80001294 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800036fc:	00148493          	addi	s1,s1,1
    80003700:	000027b7          	lui	a5,0x2
    80003704:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003708:	0097ee63          	bltu	a5,s1,80003724 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000370c:	00000713          	li	a4,0
    80003710:	000077b7          	lui	a5,0x7
    80003714:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003718:	fce7eee3          	bltu	a5,a4,800036f4 <_ZL11workerBodyAPv+0x20>
    8000371c:	00170713          	addi	a4,a4,1
    80003720:	ff1ff06f          	j	80003710 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80003724:	00190913          	addi	s2,s2,1
    80003728:	00900793          	li	a5,9
    8000372c:	0527e063          	bltu	a5,s2,8000376c <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80003730:	00006517          	auipc	a0,0x6
    80003734:	9d850513          	addi	a0,a0,-1576 # 80009108 <CONSOLE_STATUS+0xf8>
    80003738:	00000097          	auipc	ra,0x0
    8000373c:	164080e7          	jalr	356(ra) # 8000389c <_Z11printStringPKc>
    80003740:	00000613          	li	a2,0
    80003744:	00a00593          	li	a1,10
    80003748:	0009051b          	sext.w	a0,s2
    8000374c:	00000097          	auipc	ra,0x0
    80003750:	300080e7          	jalr	768(ra) # 80003a4c <_Z8printIntiii>
    80003754:	00006517          	auipc	a0,0x6
    80003758:	c5450513          	addi	a0,a0,-940 # 800093a8 <CONSOLE_STATUS+0x398>
    8000375c:	00000097          	auipc	ra,0x0
    80003760:	140080e7          	jalr	320(ra) # 8000389c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80003764:	00000493          	li	s1,0
    80003768:	f99ff06f          	j	80003700 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    8000376c:	00006517          	auipc	a0,0x6
    80003770:	a0450513          	addi	a0,a0,-1532 # 80009170 <CONSOLE_STATUS+0x160>
    80003774:	00000097          	auipc	ra,0x0
    80003778:	128080e7          	jalr	296(ra) # 8000389c <_Z11printStringPKc>
    finishedA = true;
    8000377c:	00100793          	li	a5,1
    80003780:	00008717          	auipc	a4,0x8
    80003784:	e8f709a3          	sb	a5,-365(a4) # 8000b613 <_ZL9finishedA>
}
    80003788:	01813083          	ld	ra,24(sp)
    8000378c:	01013403          	ld	s0,16(sp)
    80003790:	00813483          	ld	s1,8(sp)
    80003794:	00013903          	ld	s2,0(sp)
    80003798:	02010113          	addi	sp,sp,32
    8000379c:	00008067          	ret

00000000800037a0 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    800037a0:	fd010113          	addi	sp,sp,-48
    800037a4:	02113423          	sd	ra,40(sp)
    800037a8:	02813023          	sd	s0,32(sp)
    800037ac:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    800037b0:	00000613          	li	a2,0
    800037b4:	00000597          	auipc	a1,0x0
    800037b8:	f2058593          	addi	a1,a1,-224 # 800036d4 <_ZL11workerBodyAPv>
    800037bc:	fd040513          	addi	a0,s0,-48
    800037c0:	ffffe097          	auipc	ra,0xffffe
    800037c4:	a14080e7          	jalr	-1516(ra) # 800011d4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadA created\n");
    800037c8:	00006517          	auipc	a0,0x6
    800037cc:	9f850513          	addi	a0,a0,-1544 # 800091c0 <CONSOLE_STATUS+0x1b0>
    800037d0:	00000097          	auipc	ra,0x0
    800037d4:	0cc080e7          	jalr	204(ra) # 8000389c <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    800037d8:	00000613          	li	a2,0
    800037dc:	00000597          	auipc	a1,0x0
    800037e0:	e2458593          	addi	a1,a1,-476 # 80003600 <_ZL11workerBodyBPv>
    800037e4:	fd840513          	addi	a0,s0,-40
    800037e8:	ffffe097          	auipc	ra,0xffffe
    800037ec:	9ec080e7          	jalr	-1556(ra) # 800011d4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadB created\n");
    800037f0:	00006517          	auipc	a0,0x6
    800037f4:	9e850513          	addi	a0,a0,-1560 # 800091d8 <CONSOLE_STATUS+0x1c8>
    800037f8:	00000097          	auipc	ra,0x0
    800037fc:	0a4080e7          	jalr	164(ra) # 8000389c <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80003800:	00000613          	li	a2,0
    80003804:	00000597          	auipc	a1,0x0
    80003808:	c7c58593          	addi	a1,a1,-900 # 80003480 <_ZL11workerBodyCPv>
    8000380c:	fe040513          	addi	a0,s0,-32
    80003810:	ffffe097          	auipc	ra,0xffffe
    80003814:	9c4080e7          	jalr	-1596(ra) # 800011d4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadC created\n");
    80003818:	00006517          	auipc	a0,0x6
    8000381c:	9d850513          	addi	a0,a0,-1576 # 800091f0 <CONSOLE_STATUS+0x1e0>
    80003820:	00000097          	auipc	ra,0x0
    80003824:	07c080e7          	jalr	124(ra) # 8000389c <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80003828:	00000613          	li	a2,0
    8000382c:	00000597          	auipc	a1,0x0
    80003830:	b0c58593          	addi	a1,a1,-1268 # 80003338 <_ZL11workerBodyDPv>
    80003834:	fe840513          	addi	a0,s0,-24
    80003838:	ffffe097          	auipc	ra,0xffffe
    8000383c:	99c080e7          	jalr	-1636(ra) # 800011d4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadD created\n");
    80003840:	00006517          	auipc	a0,0x6
    80003844:	9c850513          	addi	a0,a0,-1592 # 80009208 <CONSOLE_STATUS+0x1f8>
    80003848:	00000097          	auipc	ra,0x0
    8000384c:	054080e7          	jalr	84(ra) # 8000389c <_Z11printStringPKc>
    80003850:	00c0006f          	j	8000385c <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80003854:	ffffe097          	auipc	ra,0xffffe
    80003858:	a40080e7          	jalr	-1472(ra) # 80001294 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    8000385c:	00008797          	auipc	a5,0x8
    80003860:	db77c783          	lbu	a5,-585(a5) # 8000b613 <_ZL9finishedA>
    80003864:	fe0788e3          	beqz	a5,80003854 <_Z18Threads_C_API_testv+0xb4>
    80003868:	00008797          	auipc	a5,0x8
    8000386c:	daa7c783          	lbu	a5,-598(a5) # 8000b612 <_ZL9finishedB>
    80003870:	fe0782e3          	beqz	a5,80003854 <_Z18Threads_C_API_testv+0xb4>
    80003874:	00008797          	auipc	a5,0x8
    80003878:	d9d7c783          	lbu	a5,-611(a5) # 8000b611 <_ZL9finishedC>
    8000387c:	fc078ce3          	beqz	a5,80003854 <_Z18Threads_C_API_testv+0xb4>
    80003880:	00008797          	auipc	a5,0x8
    80003884:	d907c783          	lbu	a5,-624(a5) # 8000b610 <_ZL9finishedD>
    80003888:	fc0786e3          	beqz	a5,80003854 <_Z18Threads_C_API_testv+0xb4>
    }

    8000388c:	02813083          	ld	ra,40(sp)
    80003890:	02013403          	ld	s0,32(sp)
    80003894:	03010113          	addi	sp,sp,48
    80003898:	00008067          	ret

000000008000389c <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    8000389c:	fe010113          	addi	sp,sp,-32
    800038a0:	00113c23          	sd	ra,24(sp)
    800038a4:	00813823          	sd	s0,16(sp)
    800038a8:	00913423          	sd	s1,8(sp)
    800038ac:	02010413          	addi	s0,sp,32
    800038b0:	00050493          	mv	s1,a0
    LOCK();
    800038b4:	00100613          	li	a2,1
    800038b8:	00000593          	li	a1,0
    800038bc:	00008517          	auipc	a0,0x8
    800038c0:	d5c50513          	addi	a0,a0,-676 # 8000b618 <lockPrint>
    800038c4:	ffffd097          	auipc	ra,0xffffd
    800038c8:	73c080e7          	jalr	1852(ra) # 80001000 <copy_and_swap>
    800038cc:	00050863          	beqz	a0,800038dc <_Z11printStringPKc+0x40>
    800038d0:	ffffe097          	auipc	ra,0xffffe
    800038d4:	9c4080e7          	jalr	-1596(ra) # 80001294 <_Z15thread_dispatchv>
    800038d8:	fddff06f          	j	800038b4 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    800038dc:	0004c503          	lbu	a0,0(s1)
    800038e0:	00050a63          	beqz	a0,800038f4 <_Z11printStringPKc+0x58>
    {
        putc(*string);
    800038e4:	ffffe097          	auipc	ra,0xffffe
    800038e8:	bc8080e7          	jalr	-1080(ra) # 800014ac <_Z4putcc>
        string++;
    800038ec:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800038f0:	fedff06f          	j	800038dc <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    800038f4:	00000613          	li	a2,0
    800038f8:	00100593          	li	a1,1
    800038fc:	00008517          	auipc	a0,0x8
    80003900:	d1c50513          	addi	a0,a0,-740 # 8000b618 <lockPrint>
    80003904:	ffffd097          	auipc	ra,0xffffd
    80003908:	6fc080e7          	jalr	1788(ra) # 80001000 <copy_and_swap>
    8000390c:	fe0514e3          	bnez	a0,800038f4 <_Z11printStringPKc+0x58>
}
    80003910:	01813083          	ld	ra,24(sp)
    80003914:	01013403          	ld	s0,16(sp)
    80003918:	00813483          	ld	s1,8(sp)
    8000391c:	02010113          	addi	sp,sp,32
    80003920:	00008067          	ret

0000000080003924 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80003924:	fd010113          	addi	sp,sp,-48
    80003928:	02113423          	sd	ra,40(sp)
    8000392c:	02813023          	sd	s0,32(sp)
    80003930:	00913c23          	sd	s1,24(sp)
    80003934:	01213823          	sd	s2,16(sp)
    80003938:	01313423          	sd	s3,8(sp)
    8000393c:	01413023          	sd	s4,0(sp)
    80003940:	03010413          	addi	s0,sp,48
    80003944:	00050993          	mv	s3,a0
    80003948:	00058a13          	mv	s4,a1
    LOCK();
    8000394c:	00100613          	li	a2,1
    80003950:	00000593          	li	a1,0
    80003954:	00008517          	auipc	a0,0x8
    80003958:	cc450513          	addi	a0,a0,-828 # 8000b618 <lockPrint>
    8000395c:	ffffd097          	auipc	ra,0xffffd
    80003960:	6a4080e7          	jalr	1700(ra) # 80001000 <copy_and_swap>
    80003964:	00050863          	beqz	a0,80003974 <_Z9getStringPci+0x50>
    80003968:	ffffe097          	auipc	ra,0xffffe
    8000396c:	92c080e7          	jalr	-1748(ra) # 80001294 <_Z15thread_dispatchv>
    80003970:	fddff06f          	j	8000394c <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80003974:	00000913          	li	s2,0
    80003978:	00090493          	mv	s1,s2
    8000397c:	0019091b          	addiw	s2,s2,1
    80003980:	03495a63          	bge	s2,s4,800039b4 <_Z9getStringPci+0x90>
        cc = getc();
    80003984:	ffffe097          	auipc	ra,0xffffe
    80003988:	aec080e7          	jalr	-1300(ra) # 80001470 <_Z4getcv>
        if(cc < 1)
    8000398c:	02050463          	beqz	a0,800039b4 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80003990:	009984b3          	add	s1,s3,s1
    80003994:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80003998:	00a00793          	li	a5,10
    8000399c:	00f50a63          	beq	a0,a5,800039b0 <_Z9getStringPci+0x8c>
    800039a0:	00d00793          	li	a5,13
    800039a4:	fcf51ae3          	bne	a0,a5,80003978 <_Z9getStringPci+0x54>
        buf[i++] = c;
    800039a8:	00090493          	mv	s1,s2
    800039ac:	0080006f          	j	800039b4 <_Z9getStringPci+0x90>
    800039b0:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    800039b4:	009984b3          	add	s1,s3,s1
    800039b8:	00048023          	sb	zero,0(s1)

    UNLOCK();
    800039bc:	00000613          	li	a2,0
    800039c0:	00100593          	li	a1,1
    800039c4:	00008517          	auipc	a0,0x8
    800039c8:	c5450513          	addi	a0,a0,-940 # 8000b618 <lockPrint>
    800039cc:	ffffd097          	auipc	ra,0xffffd
    800039d0:	634080e7          	jalr	1588(ra) # 80001000 <copy_and_swap>
    800039d4:	fe0514e3          	bnez	a0,800039bc <_Z9getStringPci+0x98>
    return buf;
}
    800039d8:	00098513          	mv	a0,s3
    800039dc:	02813083          	ld	ra,40(sp)
    800039e0:	02013403          	ld	s0,32(sp)
    800039e4:	01813483          	ld	s1,24(sp)
    800039e8:	01013903          	ld	s2,16(sp)
    800039ec:	00813983          	ld	s3,8(sp)
    800039f0:	00013a03          	ld	s4,0(sp)
    800039f4:	03010113          	addi	sp,sp,48
    800039f8:	00008067          	ret

00000000800039fc <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    800039fc:	ff010113          	addi	sp,sp,-16
    80003a00:	00813423          	sd	s0,8(sp)
    80003a04:	01010413          	addi	s0,sp,16
    80003a08:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80003a0c:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80003a10:	0006c603          	lbu	a2,0(a3)
    80003a14:	fd06071b          	addiw	a4,a2,-48
    80003a18:	0ff77713          	andi	a4,a4,255
    80003a1c:	00900793          	li	a5,9
    80003a20:	02e7e063          	bltu	a5,a4,80003a40 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80003a24:	0025179b          	slliw	a5,a0,0x2
    80003a28:	00a787bb          	addw	a5,a5,a0
    80003a2c:	0017979b          	slliw	a5,a5,0x1
    80003a30:	00168693          	addi	a3,a3,1
    80003a34:	00c787bb          	addw	a5,a5,a2
    80003a38:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80003a3c:	fd5ff06f          	j	80003a10 <_Z11stringToIntPKc+0x14>
    return n;
}
    80003a40:	00813403          	ld	s0,8(sp)
    80003a44:	01010113          	addi	sp,sp,16
    80003a48:	00008067          	ret

0000000080003a4c <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80003a4c:	fc010113          	addi	sp,sp,-64
    80003a50:	02113c23          	sd	ra,56(sp)
    80003a54:	02813823          	sd	s0,48(sp)
    80003a58:	02913423          	sd	s1,40(sp)
    80003a5c:	03213023          	sd	s2,32(sp)
    80003a60:	01313c23          	sd	s3,24(sp)
    80003a64:	04010413          	addi	s0,sp,64
    80003a68:	00050493          	mv	s1,a0
    80003a6c:	00058913          	mv	s2,a1
    80003a70:	00060993          	mv	s3,a2
    LOCK();
    80003a74:	00100613          	li	a2,1
    80003a78:	00000593          	li	a1,0
    80003a7c:	00008517          	auipc	a0,0x8
    80003a80:	b9c50513          	addi	a0,a0,-1124 # 8000b618 <lockPrint>
    80003a84:	ffffd097          	auipc	ra,0xffffd
    80003a88:	57c080e7          	jalr	1404(ra) # 80001000 <copy_and_swap>
    80003a8c:	00050863          	beqz	a0,80003a9c <_Z8printIntiii+0x50>
    80003a90:	ffffe097          	auipc	ra,0xffffe
    80003a94:	804080e7          	jalr	-2044(ra) # 80001294 <_Z15thread_dispatchv>
    80003a98:	fddff06f          	j	80003a74 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80003a9c:	00098463          	beqz	s3,80003aa4 <_Z8printIntiii+0x58>
    80003aa0:	0804c463          	bltz	s1,80003b28 <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80003aa4:	0004851b          	sext.w	a0,s1
    neg = 0;
    80003aa8:	00000593          	li	a1,0
    }

    i = 0;
    80003aac:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80003ab0:	0009079b          	sext.w	a5,s2
    80003ab4:	0325773b          	remuw	a4,a0,s2
    80003ab8:	00048613          	mv	a2,s1
    80003abc:	0014849b          	addiw	s1,s1,1
    80003ac0:	02071693          	slli	a3,a4,0x20
    80003ac4:	0206d693          	srli	a3,a3,0x20
    80003ac8:	00008717          	auipc	a4,0x8
    80003acc:	9c870713          	addi	a4,a4,-1592 # 8000b490 <digits>
    80003ad0:	00d70733          	add	a4,a4,a3
    80003ad4:	00074683          	lbu	a3,0(a4)
    80003ad8:	fd040713          	addi	a4,s0,-48
    80003adc:	00c70733          	add	a4,a4,a2
    80003ae0:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80003ae4:	0005071b          	sext.w	a4,a0
    80003ae8:	0325553b          	divuw	a0,a0,s2
    80003aec:	fcf772e3          	bgeu	a4,a5,80003ab0 <_Z8printIntiii+0x64>
    if(neg)
    80003af0:	00058c63          	beqz	a1,80003b08 <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80003af4:	fd040793          	addi	a5,s0,-48
    80003af8:	009784b3          	add	s1,a5,s1
    80003afc:	02d00793          	li	a5,45
    80003b00:	fef48823          	sb	a5,-16(s1)
    80003b04:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80003b08:	fff4849b          	addiw	s1,s1,-1
    80003b0c:	0204c463          	bltz	s1,80003b34 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80003b10:	fd040793          	addi	a5,s0,-48
    80003b14:	009787b3          	add	a5,a5,s1
    80003b18:	ff07c503          	lbu	a0,-16(a5)
    80003b1c:	ffffe097          	auipc	ra,0xffffe
    80003b20:	990080e7          	jalr	-1648(ra) # 800014ac <_Z4putcc>
    80003b24:	fe5ff06f          	j	80003b08 <_Z8printIntiii+0xbc>
        x = -xx;
    80003b28:	4090053b          	negw	a0,s1
        neg = 1;
    80003b2c:	00100593          	li	a1,1
        x = -xx;
    80003b30:	f7dff06f          	j	80003aac <_Z8printIntiii+0x60>

    UNLOCK();
    80003b34:	00000613          	li	a2,0
    80003b38:	00100593          	li	a1,1
    80003b3c:	00008517          	auipc	a0,0x8
    80003b40:	adc50513          	addi	a0,a0,-1316 # 8000b618 <lockPrint>
    80003b44:	ffffd097          	auipc	ra,0xffffd
    80003b48:	4bc080e7          	jalr	1212(ra) # 80001000 <copy_and_swap>
    80003b4c:	fe0514e3          	bnez	a0,80003b34 <_Z8printIntiii+0xe8>
    80003b50:	03813083          	ld	ra,56(sp)
    80003b54:	03013403          	ld	s0,48(sp)
    80003b58:	02813483          	ld	s1,40(sp)
    80003b5c:	02013903          	ld	s2,32(sp)
    80003b60:	01813983          	ld	s3,24(sp)
    80003b64:	04010113          	addi	sp,sp,64
    80003b68:	00008067          	ret

0000000080003b6c <_ZN9BufferCPPC1Ei>:
#include "../h/buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80003b6c:	fd010113          	addi	sp,sp,-48
    80003b70:	02113423          	sd	ra,40(sp)
    80003b74:	02813023          	sd	s0,32(sp)
    80003b78:	00913c23          	sd	s1,24(sp)
    80003b7c:	01213823          	sd	s2,16(sp)
    80003b80:	01313423          	sd	s3,8(sp)
    80003b84:	03010413          	addi	s0,sp,48
    80003b88:	00050493          	mv	s1,a0
    80003b8c:	00058913          	mv	s2,a1
    80003b90:	0015879b          	addiw	a5,a1,1
    80003b94:	0007851b          	sext.w	a0,a5
    80003b98:	00f4a023          	sw	a5,0(s1)
    80003b9c:	0004a823          	sw	zero,16(s1)
    80003ba0:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80003ba4:	00251513          	slli	a0,a0,0x2
    80003ba8:	ffffd097          	auipc	ra,0xffffd
    80003bac:	59c080e7          	jalr	1436(ra) # 80001144 <_Z9mem_allocm>
    80003bb0:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80003bb4:	01000513          	li	a0,16
    80003bb8:	00001097          	auipc	ra,0x1
    80003bbc:	aa8080e7          	jalr	-1368(ra) # 80004660 <_Znwm>
    80003bc0:	00050993          	mv	s3,a0
    80003bc4:	00000593          	li	a1,0
    80003bc8:	00001097          	auipc	ra,0x1
    80003bcc:	ce4080e7          	jalr	-796(ra) # 800048ac <_ZN9SemaphoreC1Ej>
    80003bd0:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80003bd4:	01000513          	li	a0,16
    80003bd8:	00001097          	auipc	ra,0x1
    80003bdc:	a88080e7          	jalr	-1400(ra) # 80004660 <_Znwm>
    80003be0:	00050993          	mv	s3,a0
    80003be4:	00090593          	mv	a1,s2
    80003be8:	00001097          	auipc	ra,0x1
    80003bec:	cc4080e7          	jalr	-828(ra) # 800048ac <_ZN9SemaphoreC1Ej>
    80003bf0:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80003bf4:	01000513          	li	a0,16
    80003bf8:	00001097          	auipc	ra,0x1
    80003bfc:	a68080e7          	jalr	-1432(ra) # 80004660 <_Znwm>
    80003c00:	00050913          	mv	s2,a0
    80003c04:	00100593          	li	a1,1
    80003c08:	00001097          	auipc	ra,0x1
    80003c0c:	ca4080e7          	jalr	-860(ra) # 800048ac <_ZN9SemaphoreC1Ej>
    80003c10:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80003c14:	01000513          	li	a0,16
    80003c18:	00001097          	auipc	ra,0x1
    80003c1c:	a48080e7          	jalr	-1464(ra) # 80004660 <_Znwm>
    80003c20:	00050913          	mv	s2,a0
    80003c24:	00100593          	li	a1,1
    80003c28:	00001097          	auipc	ra,0x1
    80003c2c:	c84080e7          	jalr	-892(ra) # 800048ac <_ZN9SemaphoreC1Ej>
    80003c30:	0324b823          	sd	s2,48(s1)
}
    80003c34:	02813083          	ld	ra,40(sp)
    80003c38:	02013403          	ld	s0,32(sp)
    80003c3c:	01813483          	ld	s1,24(sp)
    80003c40:	01013903          	ld	s2,16(sp)
    80003c44:	00813983          	ld	s3,8(sp)
    80003c48:	03010113          	addi	sp,sp,48
    80003c4c:	00008067          	ret
    80003c50:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80003c54:	00098513          	mv	a0,s3
    80003c58:	00001097          	auipc	ra,0x1
    80003c5c:	a58080e7          	jalr	-1448(ra) # 800046b0 <_ZdlPv>
    80003c60:	00048513          	mv	a0,s1
    80003c64:	00009097          	auipc	ra,0x9
    80003c68:	ae4080e7          	jalr	-1308(ra) # 8000c748 <_Unwind_Resume>
    80003c6c:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80003c70:	00098513          	mv	a0,s3
    80003c74:	00001097          	auipc	ra,0x1
    80003c78:	a3c080e7          	jalr	-1476(ra) # 800046b0 <_ZdlPv>
    80003c7c:	00048513          	mv	a0,s1
    80003c80:	00009097          	auipc	ra,0x9
    80003c84:	ac8080e7          	jalr	-1336(ra) # 8000c748 <_Unwind_Resume>
    80003c88:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80003c8c:	00090513          	mv	a0,s2
    80003c90:	00001097          	auipc	ra,0x1
    80003c94:	a20080e7          	jalr	-1504(ra) # 800046b0 <_ZdlPv>
    80003c98:	00048513          	mv	a0,s1
    80003c9c:	00009097          	auipc	ra,0x9
    80003ca0:	aac080e7          	jalr	-1364(ra) # 8000c748 <_Unwind_Resume>
    80003ca4:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80003ca8:	00090513          	mv	a0,s2
    80003cac:	00001097          	auipc	ra,0x1
    80003cb0:	a04080e7          	jalr	-1532(ra) # 800046b0 <_ZdlPv>
    80003cb4:	00048513          	mv	a0,s1
    80003cb8:	00009097          	auipc	ra,0x9
    80003cbc:	a90080e7          	jalr	-1392(ra) # 8000c748 <_Unwind_Resume>

0000000080003cc0 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80003cc0:	fe010113          	addi	sp,sp,-32
    80003cc4:	00113c23          	sd	ra,24(sp)
    80003cc8:	00813823          	sd	s0,16(sp)
    80003ccc:	00913423          	sd	s1,8(sp)
    80003cd0:	01213023          	sd	s2,0(sp)
    80003cd4:	02010413          	addi	s0,sp,32
    80003cd8:	00050493          	mv	s1,a0
    80003cdc:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80003ce0:	01853503          	ld	a0,24(a0)
    80003ce4:	00001097          	auipc	ra,0x1
    80003ce8:	c00080e7          	jalr	-1024(ra) # 800048e4 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80003cec:	0304b503          	ld	a0,48(s1)
    80003cf0:	00001097          	auipc	ra,0x1
    80003cf4:	bf4080e7          	jalr	-1036(ra) # 800048e4 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80003cf8:	0084b783          	ld	a5,8(s1)
    80003cfc:	0144a703          	lw	a4,20(s1)
    80003d00:	00271713          	slli	a4,a4,0x2
    80003d04:	00e787b3          	add	a5,a5,a4
    80003d08:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80003d0c:	0144a783          	lw	a5,20(s1)
    80003d10:	0017879b          	addiw	a5,a5,1
    80003d14:	0004a703          	lw	a4,0(s1)
    80003d18:	02e7e7bb          	remw	a5,a5,a4
    80003d1c:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80003d20:	0304b503          	ld	a0,48(s1)
    80003d24:	00001097          	auipc	ra,0x1
    80003d28:	bfc080e7          	jalr	-1028(ra) # 80004920 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80003d2c:	0204b503          	ld	a0,32(s1)
    80003d30:	00001097          	auipc	ra,0x1
    80003d34:	bf0080e7          	jalr	-1040(ra) # 80004920 <_ZN9Semaphore6signalEv>

}
    80003d38:	01813083          	ld	ra,24(sp)
    80003d3c:	01013403          	ld	s0,16(sp)
    80003d40:	00813483          	ld	s1,8(sp)
    80003d44:	00013903          	ld	s2,0(sp)
    80003d48:	02010113          	addi	sp,sp,32
    80003d4c:	00008067          	ret

0000000080003d50 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80003d50:	fe010113          	addi	sp,sp,-32
    80003d54:	00113c23          	sd	ra,24(sp)
    80003d58:	00813823          	sd	s0,16(sp)
    80003d5c:	00913423          	sd	s1,8(sp)
    80003d60:	01213023          	sd	s2,0(sp)
    80003d64:	02010413          	addi	s0,sp,32
    80003d68:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80003d6c:	02053503          	ld	a0,32(a0)
    80003d70:	00001097          	auipc	ra,0x1
    80003d74:	b74080e7          	jalr	-1164(ra) # 800048e4 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80003d78:	0284b503          	ld	a0,40(s1)
    80003d7c:	00001097          	auipc	ra,0x1
    80003d80:	b68080e7          	jalr	-1176(ra) # 800048e4 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80003d84:	0084b703          	ld	a4,8(s1)
    80003d88:	0104a783          	lw	a5,16(s1)
    80003d8c:	00279693          	slli	a3,a5,0x2
    80003d90:	00d70733          	add	a4,a4,a3
    80003d94:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80003d98:	0017879b          	addiw	a5,a5,1
    80003d9c:	0004a703          	lw	a4,0(s1)
    80003da0:	02e7e7bb          	remw	a5,a5,a4
    80003da4:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80003da8:	0284b503          	ld	a0,40(s1)
    80003dac:	00001097          	auipc	ra,0x1
    80003db0:	b74080e7          	jalr	-1164(ra) # 80004920 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80003db4:	0184b503          	ld	a0,24(s1)
    80003db8:	00001097          	auipc	ra,0x1
    80003dbc:	b68080e7          	jalr	-1176(ra) # 80004920 <_ZN9Semaphore6signalEv>

    return ret;
}
    80003dc0:	00090513          	mv	a0,s2
    80003dc4:	01813083          	ld	ra,24(sp)
    80003dc8:	01013403          	ld	s0,16(sp)
    80003dcc:	00813483          	ld	s1,8(sp)
    80003dd0:	00013903          	ld	s2,0(sp)
    80003dd4:	02010113          	addi	sp,sp,32
    80003dd8:	00008067          	ret

0000000080003ddc <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80003ddc:	fe010113          	addi	sp,sp,-32
    80003de0:	00113c23          	sd	ra,24(sp)
    80003de4:	00813823          	sd	s0,16(sp)
    80003de8:	00913423          	sd	s1,8(sp)
    80003dec:	01213023          	sd	s2,0(sp)
    80003df0:	02010413          	addi	s0,sp,32
    80003df4:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80003df8:	02853503          	ld	a0,40(a0)
    80003dfc:	00001097          	auipc	ra,0x1
    80003e00:	ae8080e7          	jalr	-1304(ra) # 800048e4 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80003e04:	0304b503          	ld	a0,48(s1)
    80003e08:	00001097          	auipc	ra,0x1
    80003e0c:	adc080e7          	jalr	-1316(ra) # 800048e4 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80003e10:	0144a783          	lw	a5,20(s1)
    80003e14:	0104a903          	lw	s2,16(s1)
    80003e18:	0327ce63          	blt	a5,s2,80003e54 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80003e1c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80003e20:	0304b503          	ld	a0,48(s1)
    80003e24:	00001097          	auipc	ra,0x1
    80003e28:	afc080e7          	jalr	-1284(ra) # 80004920 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80003e2c:	0284b503          	ld	a0,40(s1)
    80003e30:	00001097          	auipc	ra,0x1
    80003e34:	af0080e7          	jalr	-1296(ra) # 80004920 <_ZN9Semaphore6signalEv>

    return ret;
}
    80003e38:	00090513          	mv	a0,s2
    80003e3c:	01813083          	ld	ra,24(sp)
    80003e40:	01013403          	ld	s0,16(sp)
    80003e44:	00813483          	ld	s1,8(sp)
    80003e48:	00013903          	ld	s2,0(sp)
    80003e4c:	02010113          	addi	sp,sp,32
    80003e50:	00008067          	ret
        ret = cap - head + tail;
    80003e54:	0004a703          	lw	a4,0(s1)
    80003e58:	4127093b          	subw	s2,a4,s2
    80003e5c:	00f9093b          	addw	s2,s2,a5
    80003e60:	fc1ff06f          	j	80003e20 <_ZN9BufferCPP6getCntEv+0x44>

0000000080003e64 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80003e64:	fe010113          	addi	sp,sp,-32
    80003e68:	00113c23          	sd	ra,24(sp)
    80003e6c:	00813823          	sd	s0,16(sp)
    80003e70:	00913423          	sd	s1,8(sp)
    80003e74:	02010413          	addi	s0,sp,32
    80003e78:	00050493          	mv	s1,a0
    Console::putc('\n');
    80003e7c:	00a00513          	li	a0,10
    80003e80:	00001097          	auipc	ra,0x1
    80003e84:	b40080e7          	jalr	-1216(ra) # 800049c0 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80003e88:	00005517          	auipc	a0,0x5
    80003e8c:	39850513          	addi	a0,a0,920 # 80009220 <CONSOLE_STATUS+0x210>
    80003e90:	00000097          	auipc	ra,0x0
    80003e94:	a0c080e7          	jalr	-1524(ra) # 8000389c <_Z11printStringPKc>
    while (getCnt()) {
    80003e98:	00048513          	mv	a0,s1
    80003e9c:	00000097          	auipc	ra,0x0
    80003ea0:	f40080e7          	jalr	-192(ra) # 80003ddc <_ZN9BufferCPP6getCntEv>
    80003ea4:	02050c63          	beqz	a0,80003edc <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80003ea8:	0084b783          	ld	a5,8(s1)
    80003eac:	0104a703          	lw	a4,16(s1)
    80003eb0:	00271713          	slli	a4,a4,0x2
    80003eb4:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80003eb8:	0007c503          	lbu	a0,0(a5)
    80003ebc:	00001097          	auipc	ra,0x1
    80003ec0:	b04080e7          	jalr	-1276(ra) # 800049c0 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80003ec4:	0104a783          	lw	a5,16(s1)
    80003ec8:	0017879b          	addiw	a5,a5,1
    80003ecc:	0004a703          	lw	a4,0(s1)
    80003ed0:	02e7e7bb          	remw	a5,a5,a4
    80003ed4:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80003ed8:	fc1ff06f          	j	80003e98 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80003edc:	02100513          	li	a0,33
    80003ee0:	00001097          	auipc	ra,0x1
    80003ee4:	ae0080e7          	jalr	-1312(ra) # 800049c0 <_ZN7Console4putcEc>
    Console::putc('\n');
    80003ee8:	00a00513          	li	a0,10
    80003eec:	00001097          	auipc	ra,0x1
    80003ef0:	ad4080e7          	jalr	-1324(ra) # 800049c0 <_ZN7Console4putcEc>
    mem_free(buffer);
    80003ef4:	0084b503          	ld	a0,8(s1)
    80003ef8:	ffffd097          	auipc	ra,0xffffd
    80003efc:	29c080e7          	jalr	668(ra) # 80001194 <_Z8mem_freePv>
    delete itemAvailable;
    80003f00:	0204b503          	ld	a0,32(s1)
    80003f04:	00050863          	beqz	a0,80003f14 <_ZN9BufferCPPD1Ev+0xb0>
    80003f08:	00053783          	ld	a5,0(a0)
    80003f0c:	0087b783          	ld	a5,8(a5)
    80003f10:	000780e7          	jalr	a5
    delete spaceAvailable;
    80003f14:	0184b503          	ld	a0,24(s1)
    80003f18:	00050863          	beqz	a0,80003f28 <_ZN9BufferCPPD1Ev+0xc4>
    80003f1c:	00053783          	ld	a5,0(a0)
    80003f20:	0087b783          	ld	a5,8(a5)
    80003f24:	000780e7          	jalr	a5
    delete mutexTail;
    80003f28:	0304b503          	ld	a0,48(s1)
    80003f2c:	00050863          	beqz	a0,80003f3c <_ZN9BufferCPPD1Ev+0xd8>
    80003f30:	00053783          	ld	a5,0(a0)
    80003f34:	0087b783          	ld	a5,8(a5)
    80003f38:	000780e7          	jalr	a5
    delete mutexHead;
    80003f3c:	0284b503          	ld	a0,40(s1)
    80003f40:	00050863          	beqz	a0,80003f50 <_ZN9BufferCPPD1Ev+0xec>
    80003f44:	00053783          	ld	a5,0(a0)
    80003f48:	0087b783          	ld	a5,8(a5)
    80003f4c:	000780e7          	jalr	a5
}
    80003f50:	01813083          	ld	ra,24(sp)
    80003f54:	01013403          	ld	s0,16(sp)
    80003f58:	00813483          	ld	s1,8(sp)
    80003f5c:	02010113          	addi	sp,sp,32
    80003f60:	00008067          	ret

0000000080003f64 <_Z8userMainv>:
//#include "../h/System_Mode_test.hpp"

#endif

void userMain()
{
    80003f64:	fe010113          	addi	sp,sp,-32
    80003f68:	00113c23          	sd	ra,24(sp)
    80003f6c:	00813823          	sd	s0,16(sp)
    80003f70:	00913423          	sd	s1,8(sp)
    80003f74:	01213023          	sd	s2,0(sp)
    80003f78:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    80003f7c:	00005517          	auipc	a0,0x5
    80003f80:	2bc50513          	addi	a0,a0,700 # 80009238 <CONSOLE_STATUS+0x228>
    80003f84:	00000097          	auipc	ra,0x0
    80003f88:	918080e7          	jalr	-1768(ra) # 8000389c <_Z11printStringPKc>
    int test = getc() - '0';
    80003f8c:	ffffd097          	auipc	ra,0xffffd
    80003f90:	4e4080e7          	jalr	1252(ra) # 80001470 <_Z4getcv>
    80003f94:	00050913          	mv	s2,a0
    80003f98:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    80003f9c:	ffffd097          	auipc	ra,0xffffd
    80003fa0:	4d4080e7          	jalr	1236(ra) # 80001470 <_Z4getcv>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
            return;
        }
    }

    if (test >= 5 && test <= 6) {
    80003fa4:	fcb9091b          	addiw	s2,s2,-53
    80003fa8:	00100793          	li	a5,1
    80003fac:	0327f463          	bgeu	a5,s2,80003fd4 <_Z8userMainv+0x70>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80003fb0:	00800793          	li	a5,8
    80003fb4:	1097e063          	bltu	a5,s1,800040b4 <_Z8userMainv+0x150>
    80003fb8:	00249493          	slli	s1,s1,0x2
    80003fbc:	00005717          	auipc	a4,0x5
    80003fc0:	4b470713          	addi	a4,a4,1204 # 80009470 <CONSOLE_STATUS+0x460>
    80003fc4:	00e484b3          	add	s1,s1,a4
    80003fc8:	0004a783          	lw	a5,0(s1)
    80003fcc:	00e787b3          	add	a5,a5,a4
    80003fd0:	00078067          	jr	a5
            printString("Nije navedeno da je zadatak 4 implementiran\n");
    80003fd4:	00005517          	auipc	a0,0x5
    80003fd8:	28450513          	addi	a0,a0,644 # 80009258 <CONSOLE_STATUS+0x248>
    80003fdc:	00000097          	auipc	ra,0x0
    80003fe0:	8c0080e7          	jalr	-1856(ra) # 8000389c <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    80003fe4:	01813083          	ld	ra,24(sp)
    80003fe8:	01013403          	ld	s0,16(sp)
    80003fec:	00813483          	ld	s1,8(sp)
    80003ff0:	00013903          	ld	s2,0(sp)
    80003ff4:	02010113          	addi	sp,sp,32
    80003ff8:	00008067          	ret
            Threads_C_API_test();
    80003ffc:	fffff097          	auipc	ra,0xfffff
    80004000:	7a4080e7          	jalr	1956(ra) # 800037a0 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80004004:	00005517          	auipc	a0,0x5
    80004008:	28450513          	addi	a0,a0,644 # 80009288 <CONSOLE_STATUS+0x278>
    8000400c:	00000097          	auipc	ra,0x0
    80004010:	890080e7          	jalr	-1904(ra) # 8000389c <_Z11printStringPKc>
            break;
    80004014:	fd1ff06f          	j	80003fe4 <_Z8userMainv+0x80>
            Threads_CPP_API_test();
    80004018:	ffffe097          	auipc	ra,0xffffe
    8000401c:	698080e7          	jalr	1688(ra) # 800026b0 <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80004020:	00005517          	auipc	a0,0x5
    80004024:	2a850513          	addi	a0,a0,680 # 800092c8 <CONSOLE_STATUS+0x2b8>
    80004028:	00000097          	auipc	ra,0x0
    8000402c:	874080e7          	jalr	-1932(ra) # 8000389c <_Z11printStringPKc>
            break;
    80004030:	fb5ff06f          	j	80003fe4 <_Z8userMainv+0x80>
            producerConsumer_C_API();
    80004034:	ffffd097          	auipc	ra,0xffffd
    80004038:	6cc080e7          	jalr	1740(ra) # 80001700 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    8000403c:	00005517          	auipc	a0,0x5
    80004040:	2cc50513          	addi	a0,a0,716 # 80009308 <CONSOLE_STATUS+0x2f8>
    80004044:	00000097          	auipc	ra,0x0
    80004048:	858080e7          	jalr	-1960(ra) # 8000389c <_Z11printStringPKc>
            break;
    8000404c:	f99ff06f          	j	80003fe4 <_Z8userMainv+0x80>
            testConsumerProducer();
    80004050:	fffff097          	auipc	ra,0xfffff
    80004054:	b20080e7          	jalr	-1248(ra) # 80002b70 <_Z20testConsumerProducerv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80004058:	00005517          	auipc	a0,0x5
    8000405c:	30050513          	addi	a0,a0,768 # 80009358 <CONSOLE_STATUS+0x348>
    80004060:	00000097          	auipc	ra,0x0
    80004064:	83c080e7          	jalr	-1988(ra) # 8000389c <_Z11printStringPKc>
            break;
    80004068:	f7dff06f          	j	80003fe4 <_Z8userMainv+0x80>
            System_Mode_test();
    8000406c:	00001097          	auipc	ra,0x1
    80004070:	3d0080e7          	jalr	976(ra) # 8000543c <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    80004074:	00005517          	auipc	a0,0x5
    80004078:	33c50513          	addi	a0,a0,828 # 800093b0 <CONSOLE_STATUS+0x3a0>
    8000407c:	00000097          	auipc	ra,0x0
    80004080:	820080e7          	jalr	-2016(ra) # 8000389c <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80004084:	00005517          	auipc	a0,0x5
    80004088:	34c50513          	addi	a0,a0,844 # 800093d0 <CONSOLE_STATUS+0x3c0>
    8000408c:	00000097          	auipc	ra,0x0
    80004090:	810080e7          	jalr	-2032(ra) # 8000389c <_Z11printStringPKc>
            break;
    80004094:	f51ff06f          	j	80003fe4 <_Z8userMainv+0x80>
            Test();
    80004098:	00002097          	auipc	ra,0x2
    8000409c:	c5c080e7          	jalr	-932(ra) # 80005cf4 <_Z4Testv>
            printString("TEST 8 (zadatak 2., Moj Test)\n");
    800040a0:	00005517          	auipc	a0,0x5
    800040a4:	38850513          	addi	a0,a0,904 # 80009428 <CONSOLE_STATUS+0x418>
    800040a8:	fffff097          	auipc	ra,0xfffff
    800040ac:	7f4080e7          	jalr	2036(ra) # 8000389c <_Z11printStringPKc>
            break;
    800040b0:	f35ff06f          	j	80003fe4 <_Z8userMainv+0x80>
            printString("Niste uneli odgovarajuci broj za test\n");
    800040b4:	00005517          	auipc	a0,0x5
    800040b8:	39450513          	addi	a0,a0,916 # 80009448 <CONSOLE_STATUS+0x438>
    800040bc:	fffff097          	auipc	ra,0xfffff
    800040c0:	7e0080e7          	jalr	2016(ra) # 8000389c <_Z11printStringPKc>
    800040c4:	f21ff06f          	j	80003fe4 <_Z8userMainv+0x80>

00000000800040c8 <_Z15userMainWrapperPv>:
//#include "../src/userMain.cpp"

extern void userMain();

void userMainWrapper(void*)
{
    800040c8:	ff010113          	addi	sp,sp,-16
    800040cc:	00113423          	sd	ra,8(sp)
    800040d0:	00813023          	sd	s0,0(sp)
    800040d4:	01010413          	addi	s0,sp,16
    userMain();
    800040d8:	00000097          	auipc	ra,0x0
    800040dc:	e8c080e7          	jalr	-372(ra) # 80003f64 <_Z8userMainv>
}
    800040e0:	00813083          	ld	ra,8(sp)
    800040e4:	00013403          	ld	s0,0(sp)
    800040e8:	01010113          	addi	sp,sp,16
    800040ec:	00008067          	ret

00000000800040f0 <main>:

int main()
{
    800040f0:	fe010113          	addi	sp,sp,-32
    800040f4:	00113c23          	sd	ra,24(sp)
    800040f8:	00813823          	sd	s0,16(sp)
    800040fc:	02010413          	addi	s0,sp,32
    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    80004100:	00007797          	auipc	a5,0x7
    80004104:	4787b783          	ld	a5,1144(a5) # 8000b578 <_GLOBAL_OFFSET_TABLE_+0x10>
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80004108:	10579073          	csrw	stvec,a5

    thread_t systemThread;
    thread_create(&systemThread , nullptr, nullptr);
    8000410c:	00000613          	li	a2,0
    80004110:	00000593          	li	a1,0
    80004114:	fe840513          	addi	a0,s0,-24
    80004118:	ffffd097          	auipc	ra,0xffffd
    8000411c:	0bc080e7          	jalr	188(ra) # 800011d4 <_Z13thread_createPP3TCBPFvPvES2_>
    TCB::running = systemThread;
    80004120:	00007797          	auipc	a5,0x7
    80004124:	4687b783          	ld	a5,1128(a5) # 8000b588 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004128:	fe843703          	ld	a4,-24(s0)
    8000412c:	00e7b023          	sd	a4,0(a5)


    thread_t userMainThread;
    thread_create(&userMainThread , &userMainWrapper, nullptr);
    80004130:	00000613          	li	a2,0
    80004134:	00000597          	auipc	a1,0x0
    80004138:	f9458593          	addi	a1,a1,-108 # 800040c8 <_Z15userMainWrapperPv>
    8000413c:	fe040513          	addi	a0,s0,-32
    80004140:	ffffd097          	auipc	ra,0xffffd
    80004144:	094080e7          	jalr	148(ra) # 800011d4 <_Z13thread_createPP3TCBPFvPvES2_>
    __asm__ volatile ("csrw sip, %[sip]" : : [sip] "r"(sip));
}

inline void Riscv::ms_sstatus(uint64 mask)
{
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80004148:	00200793          	li	a5,2
    8000414c:	1007a073          	csrs	sstatus,a5

    Riscv::ms_sstatus(Riscv::BitMaskSstatus::SSTATUS_SIE);

    while(!userMainThread->isFinished())
    80004150:	fe043783          	ld	a5,-32(s0)
{

public:

    ~TCB() { MemoryAllocator::mem_free(stack); }
    bool isFinished() const { return finished; }
    80004154:	0287c783          	lbu	a5,40(a5)
    80004158:	00079863          	bnez	a5,80004168 <main+0x78>
    {
        thread_dispatch();
    8000415c:	ffffd097          	auipc	ra,0xffffd
    80004160:	138080e7          	jalr	312(ra) # 80001294 <_Z15thread_dispatchv>
    80004164:	fedff06f          	j	80004150 <main+0x60>
    }

    return 0;
    80004168:	00000513          	li	a0,0
    8000416c:	01813083          	ld	ra,24(sp)
    80004170:	01013403          	ld	s0,16(sp)
    80004174:	02010113          	addi	sp,sp,32
    80004178:	00008067          	ret

000000008000417c <_ZN3TCB13threadWrapperEv>:

    TCB::contextSwitch(&old->context, &running->context);
}

void TCB::threadWrapper()
{
    8000417c:	fe010113          	addi	sp,sp,-32
    80004180:	00113c23          	sd	ra,24(sp)
    80004184:	00813823          	sd	s0,16(sp)
    80004188:	00913423          	sd	s1,8(sp)
    8000418c:	02010413          	addi	s0,sp,32
    Riscv::popSppSpie();
    80004190:	00001097          	auipc	ra,0x1
    80004194:	870080e7          	jalr	-1936(ra) # 80004a00 <_ZN5Riscv10popSppSpieEv>
    running->body(running->arg);
    80004198:	00007497          	auipc	s1,0x7
    8000419c:	48848493          	addi	s1,s1,1160 # 8000b620 <_ZN3TCB7runningE>
    800041a0:	0004b783          	ld	a5,0(s1)
    800041a4:	0007b703          	ld	a4,0(a5)
    800041a8:	0087b503          	ld	a0,8(a5)
    800041ac:	000700e7          	jalr	a4
    running->setFinished(true);
    800041b0:	0004b783          	ld	a5,0(s1)
    void setFinished(bool value) { finished = value; }
    800041b4:	00100713          	li	a4,1
    800041b8:	02e78423          	sb	a4,40(a5)
    ::thread_dispatch();
    800041bc:	ffffd097          	auipc	ra,0xffffd
    800041c0:	0d8080e7          	jalr	216(ra) # 80001294 <_Z15thread_dispatchv>
    //TCB::thread_dispatch();
}
    800041c4:	01813083          	ld	ra,24(sp)
    800041c8:	01013403          	ld	s0,16(sp)
    800041cc:	00813483          	ld	s1,8(sp)
    800041d0:	02010113          	addi	sp,sp,32
    800041d4:	00008067          	ret

00000000800041d8 <_ZN3TCB15thread_dispatchEv>:
{
    800041d8:	fe010113          	addi	sp,sp,-32
    800041dc:	00113c23          	sd	ra,24(sp)
    800041e0:	00813823          	sd	s0,16(sp)
    800041e4:	00913423          	sd	s1,8(sp)
    800041e8:	02010413          	addi	s0,sp,32
    TCB *old = running;
    800041ec:	00007497          	auipc	s1,0x7
    800041f0:	4344b483          	ld	s1,1076(s1) # 8000b620 <_ZN3TCB7runningE>
    bool isFinished() const { return finished; }
    800041f4:	0284c783          	lbu	a5,40(s1)
    if (!old->isFinished()) { Scheduler::put(old); }
    800041f8:	02078c63          	beqz	a5,80004230 <_ZN3TCB15thread_dispatchEv+0x58>
    running = Scheduler::get();
    800041fc:	00001097          	auipc	ra,0x1
    80004200:	c24080e7          	jalr	-988(ra) # 80004e20 <_ZN9Scheduler3getEv>
    80004204:	00007797          	auipc	a5,0x7
    80004208:	40a7be23          	sd	a0,1052(a5) # 8000b620 <_ZN3TCB7runningE>
    TCB::contextSwitch(&old->context, &running->context);
    8000420c:	01850593          	addi	a1,a0,24
    80004210:	01848513          	addi	a0,s1,24
    80004214:	ffffd097          	auipc	ra,0xffffd
    80004218:	f1c080e7          	jalr	-228(ra) # 80001130 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    8000421c:	01813083          	ld	ra,24(sp)
    80004220:	01013403          	ld	s0,16(sp)
    80004224:	00813483          	ld	s1,8(sp)
    80004228:	02010113          	addi	sp,sp,32
    8000422c:	00008067          	ret
    if (!old->isFinished()) { Scheduler::put(old); }
    80004230:	00048513          	mv	a0,s1
    80004234:	00001097          	auipc	ra,0x1
    80004238:	c68080e7          	jalr	-920(ra) # 80004e9c <_ZN9Scheduler3putEP3TCB>
    8000423c:	fc1ff06f          	j	800041fc <_ZN3TCB15thread_dispatchEv+0x24>

0000000080004240 <_ZN3TCB11thread_exitEv>:

int TCB::thread_exit()
{
    80004240:	ff010113          	addi	sp,sp,-16
    80004244:	00113423          	sd	ra,8(sp)
    80004248:	00813023          	sd	s0,0(sp)
    8000424c:	01010413          	addi	s0,sp,16
    void setFinished(bool value) { finished = value; }
    80004250:	00007797          	auipc	a5,0x7
    80004254:	3d07b783          	ld	a5,976(a5) # 8000b620 <_ZN3TCB7runningE>
    80004258:	00100713          	li	a4,1
    8000425c:	02e78423          	sb	a4,40(a5)
    running->setFinished(true);
    ::thread_dispatch();
    80004260:	ffffd097          	auipc	ra,0xffffd
    80004264:	034080e7          	jalr	52(ra) # 80001294 <_Z15thread_dispatchv>
    //TCB::thread_dispatch();
    return 0;
}
    80004268:	00000513          	li	a0,0
    8000426c:	00813083          	ld	ra,8(sp)
    80004270:	00013403          	ld	s0,0(sp)
    80004274:	01010113          	addi	sp,sp,16
    80004278:	00008067          	ret

000000008000427c <_ZN3TCBnwEm>:

void *TCB::operator new(size_t size)
{
    8000427c:	ff010113          	addi	sp,sp,-16
    80004280:	00113423          	sd	ra,8(sp)
    80004284:	00813023          	sd	s0,0(sp)
    80004288:	01010413          	addi	s0,sp,16
    return (thread_t) MemoryAllocator::mem_alloc((sizeof(TCB) + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE);
    8000428c:	00200513          	li	a0,2
    80004290:	00001097          	auipc	ra,0x1
    80004294:	300080e7          	jalr	768(ra) # 80005590 <_ZN15MemoryAllocator9mem_allocEm>
}
    80004298:	00813083          	ld	ra,8(sp)
    8000429c:	00013403          	ld	s0,0(sp)
    800042a0:	01010113          	addi	sp,sp,16
    800042a4:	00008067          	ret

00000000800042a8 <_ZN3TCBdlEPv>:

void TCB::operator delete(void* address)
{
    800042a8:	ff010113          	addi	sp,sp,-16
    800042ac:	00113423          	sd	ra,8(sp)
    800042b0:	00813023          	sd	s0,0(sp)
    800042b4:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(address);
    800042b8:	00001097          	auipc	ra,0x1
    800042bc:	45c080e7          	jalr	1116(ra) # 80005714 <_ZN15MemoryAllocator8mem_freeEPv>
}
    800042c0:	00813083          	ld	ra,8(sp)
    800042c4:	00013403          	ld	s0,0(sp)
    800042c8:	01010113          	addi	sp,sp,16
    800042cc:	00008067          	ret

00000000800042d0 <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_>:
{
    800042d0:	fc010113          	addi	sp,sp,-64
    800042d4:	02113c23          	sd	ra,56(sp)
    800042d8:	02813823          	sd	s0,48(sp)
    800042dc:	02913423          	sd	s1,40(sp)
    800042e0:	03213023          	sd	s2,32(sp)
    800042e4:	01313c23          	sd	s3,24(sp)
    800042e8:	01413823          	sd	s4,16(sp)
    800042ec:	01513423          	sd	s5,8(sp)
    800042f0:	04010413          	addi	s0,sp,64
    800042f4:	00050a13          	mv	s4,a0
    800042f8:	00058993          	mv	s3,a1
    800042fc:	00060a93          	mv	s5,a2
    80004300:	00068913          	mv	s2,a3
    *handle = new TCB(start_routine, arg, stack_space);
    80004304:	06000513          	li	a0,96
    80004308:	00000097          	auipc	ra,0x0
    8000430c:	f74080e7          	jalr	-140(ra) # 8000427c <_ZN3TCBnwEm>
    80004310:	00050493          	mv	s1,a0
            finished(false),
            semClosed(false),
            msg(nullptr),
            full(false),
            block(false),
            waiting()
    80004314:	01353023          	sd	s3,0(a0)
    80004318:	01553423          	sd	s5,8(a0)
    8000431c:	01253823          	sd	s2,16(a0)
    80004320:	00000797          	auipc	a5,0x0
    80004324:	e5c78793          	addi	a5,a5,-420 # 8000417c <_ZN3TCB13threadWrapperEv>
    80004328:	00f53c23          	sd	a5,24(a0)
                     stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    8000432c:	04090063          	beqz	s2,8000436c <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_+0x9c>
    80004330:	000086b7          	lui	a3,0x8
    80004334:	00d90933          	add	s2,s2,a3
            waiting()
    80004338:	0324b023          	sd	s2,32(s1)
    8000433c:	02048423          	sb	zero,40(s1)
    80004340:	020484a3          	sb	zero,41(s1)
    80004344:	0204b823          	sd	zero,48(s1)
    80004348:	02048c23          	sb	zero,56(s1)
    8000434c:	02048ca3          	sb	zero,57(s1)
    List() : head(0), tail(0), n(0) {}
    80004350:	0404b423          	sd	zero,72(s1)
    80004354:	0404b823          	sd	zero,80(s1)
    80004358:	0404ac23          	sw	zero,88(s1)
    {
        blocked = new MySemaphore(0);
    8000435c:	02000513          	li	a0,32
    80004360:	ffffe097          	auipc	ra,0xffffe
    80004364:	cc4080e7          	jalr	-828(ra) # 80002024 <_ZN11MySemaphorenwEm>
    80004368:	00c0006f          	j	80004374 <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_+0xa4>
                     stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    8000436c:	00000913          	li	s2,0
    80004370:	fc9ff06f          	j	80004338 <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_+0x68>
    80004374:	00053023          	sd	zero,0(a0)
    80004378:	00053423          	sd	zero,8(a0)
    8000437c:	00052823          	sw	zero,16(a0)

class MySemaphore{

public:

    MySemaphore(unsigned value): value(value){}
    80004380:	00052c23          	sw	zero,24(a0)
        blocked = new MySemaphore(0);
    80004384:	04a4b023          	sd	a0,64(s1)
        if (body != nullptr) { Scheduler::getInstance().put(this); }
    80004388:	02098463          	beqz	s3,800043b0 <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_+0xe0>
    8000438c:	00007797          	auipc	a5,0x7
    80004390:	2647c783          	lbu	a5,612(a5) # 8000b5f0 <_ZGVZN9Scheduler11getInstanceEvE8instance>
    80004394:	00079863          	bnez	a5,800043a4 <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_+0xd4>
    80004398:	00100793          	li	a5,1
    8000439c:	00007717          	auipc	a4,0x7
    800043a0:	24f70a23          	sb	a5,596(a4) # 8000b5f0 <_ZGVZN9Scheduler11getInstanceEvE8instance>
    800043a4:	00048513          	mv	a0,s1
    800043a8:	00001097          	auipc	ra,0x1
    800043ac:	af4080e7          	jalr	-1292(ra) # 80004e9c <_ZN9Scheduler3putEP3TCB>
    800043b0:	009a3023          	sd	s1,0(s4)
    if(*handle == nullptr)
    800043b4:	02048663          	beqz	s1,800043e0 <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_+0x110>
    return 0;
    800043b8:	00000513          	li	a0,0
}
    800043bc:	03813083          	ld	ra,56(sp)
    800043c0:	03013403          	ld	s0,48(sp)
    800043c4:	02813483          	ld	s1,40(sp)
    800043c8:	02013903          	ld	s2,32(sp)
    800043cc:	01813983          	ld	s3,24(sp)
    800043d0:	01013a03          	ld	s4,16(sp)
    800043d4:	00813a83          	ld	s5,8(sp)
    800043d8:	04010113          	addi	sp,sp,64
    800043dc:	00008067          	ret
        return -1;
    800043e0:	fff00513          	li	a0,-1
    800043e4:	fd9ff06f          	j	800043bc <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_+0xec>
    800043e8:	00050913          	mv	s2,a0
    *handle = new TCB(start_routine, arg, stack_space);
    800043ec:	00048513          	mv	a0,s1
    800043f0:	00000097          	auipc	ra,0x0
    800043f4:	eb8080e7          	jalr	-328(ra) # 800042a8 <_ZN3TCBdlEPv>
    800043f8:	00090513          	mv	a0,s2
    800043fc:	00008097          	auipc	ra,0x8
    80004400:	34c080e7          	jalr	844(ra) # 8000c748 <_Unwind_Resume>

0000000080004404 <_ZN3TCB4sendEPS_Pc>:

void TCB::send(thread_t handle, char *message)
{
    80004404:	fd010113          	addi	sp,sp,-48
    80004408:	02113423          	sd	ra,40(sp)
    8000440c:	02813023          	sd	s0,32(sp)
    80004410:	00913c23          	sd	s1,24(sp)
    80004414:	01213823          	sd	s2,16(sp)
    80004418:	01313423          	sd	s3,8(sp)
    8000441c:	01413023          	sd	s4,0(sp)
    80004420:	03010413          	addi	s0,sp,48
    80004424:	00050493          	mv	s1,a0
    80004428:	00058913          	mv	s2,a1
    if(handle->full)
    8000442c:	03854783          	lbu	a5,56(a0)
    80004430:	02079c63          	bnez	a5,80004468 <_ZN3TCB4sendEPS_Pc+0x64>
    {
        handle->waiting.addLast(&running->blocked);
        sem_wait(running->blocked);
    }

    handle->msg = message;
    80004434:	0324b823          	sd	s2,48(s1)
    handle->full = true;
    80004438:	00100793          	li	a5,1
    8000443c:	02f48c23          	sb	a5,56(s1)

    if(handle->block)
    80004440:	0394c783          	lbu	a5,57(s1)
    80004444:	08079463          	bnez	a5,800044cc <_ZN3TCB4sendEPS_Pc+0xc8>
    {
        handle->block = false;
        sem_signal(handle->blocked);
    }
}
    80004448:	02813083          	ld	ra,40(sp)
    8000444c:	02013403          	ld	s0,32(sp)
    80004450:	01813483          	ld	s1,24(sp)
    80004454:	01013903          	ld	s2,16(sp)
    80004458:	00813983          	ld	s3,8(sp)
    8000445c:	00013a03          	ld	s4,0(sp)
    80004460:	03010113          	addi	sp,sp,48
    80004464:	00008067          	ret
        handle->waiting.addLast(&running->blocked);
    80004468:	04850993          	addi	s3,a0,72
    8000446c:	00007a17          	auipc	s4,0x7
    80004470:	1b4a3a03          	ld	s4,436(s4) # 8000b620 <_ZN3TCB7runningE>
    80004474:	040a0a13          	addi	s4,s4,64
        Elem* elem = (Elem*) MemoryAllocator::mem_alloc((sizeof(Elem) + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE);
    80004478:	00100513          	li	a0,1
    8000447c:	00001097          	auipc	ra,0x1
    80004480:	114080e7          	jalr	276(ra) # 80005590 <_ZN15MemoryAllocator9mem_allocEm>
        elem->data = data;
    80004484:	01453023          	sd	s4,0(a0)
        elem->next = nullptr;
    80004488:	00053423          	sd	zero,8(a0)
        if (tail)
    8000448c:	0089b783          	ld	a5,8(s3)
    80004490:	02078863          	beqz	a5,800044c0 <_ZN3TCB4sendEPS_Pc+0xbc>
            tail->next = elem;
    80004494:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80004498:	00a9b423          	sd	a0,8(s3)
        n++;
    8000449c:	0109a783          	lw	a5,16(s3)
    800044a0:	0017879b          	addiw	a5,a5,1
    800044a4:	00f9a823          	sw	a5,16(s3)
        sem_wait(running->blocked);
    800044a8:	00007797          	auipc	a5,0x7
    800044ac:	1787b783          	ld	a5,376(a5) # 8000b620 <_ZN3TCB7runningE>
    800044b0:	0407b503          	ld	a0,64(a5)
    800044b4:	ffffd097          	auipc	ra,0xffffd
    800044b8:	efc080e7          	jalr	-260(ra) # 800013b0 <_Z8sem_waitP11MySemaphore>
    800044bc:	f79ff06f          	j	80004434 <_ZN3TCB4sendEPS_Pc+0x30>
            head = tail = elem;
    800044c0:	00a9b423          	sd	a0,8(s3)
    800044c4:	04a4b423          	sd	a0,72(s1)
    800044c8:	fd5ff06f          	j	8000449c <_ZN3TCB4sendEPS_Pc+0x98>
        handle->block = false;
    800044cc:	02048ca3          	sb	zero,57(s1)
        sem_signal(handle->blocked);
    800044d0:	0404b503          	ld	a0,64(s1)
    800044d4:	ffffd097          	auipc	ra,0xffffd
    800044d8:	f1c080e7          	jalr	-228(ra) # 800013f0 <_Z10sem_signalP11MySemaphore>
}
    800044dc:	f6dff06f          	j	80004448 <_ZN3TCB4sendEPS_Pc+0x44>

00000000800044e0 <_ZN3TCB7receiveEv>:

char *TCB::receive()
{
    800044e0:	fe010113          	addi	sp,sp,-32
    800044e4:	00113c23          	sd	ra,24(sp)
    800044e8:	00813823          	sd	s0,16(sp)
    800044ec:	00913423          	sd	s1,8(sp)
    800044f0:	01213023          	sd	s2,0(sp)
    800044f4:	02010413          	addi	s0,sp,32
    if(!running->full)
    800044f8:	00007797          	auipc	a5,0x7
    800044fc:	1287b783          	ld	a5,296(a5) # 8000b620 <_ZN3TCB7runningE>
    80004500:	0387c703          	lbu	a4,56(a5)
    80004504:	06070a63          	beqz	a4,80004578 <_ZN3TCB7receiveEv+0x98>
    {
        running->block = true;
        sem_wait(running->blocked);
    }

    running->full = false;
    80004508:	00007797          	auipc	a5,0x7
    8000450c:	1187b783          	ld	a5,280(a5) # 8000b620 <_ZN3TCB7runningE>
    80004510:	02078c23          	sb	zero,56(a5)

    sem_t *sem = running->waiting.removeFirst();
    80004514:	04878493          	addi	s1,a5,72
        if (!head) { return 0; }
    80004518:	0487b503          	ld	a0,72(a5)
    8000451c:	06050e63          	beqz	a0,80004598 <_ZN3TCB7receiveEv+0xb8>
        head = head->next;
    80004520:	00853703          	ld	a4,8(a0)
    80004524:	04e7b423          	sd	a4,72(a5)
        if (!head) { tail = 0; }
    80004528:	06070463          	beqz	a4,80004590 <_ZN3TCB7receiveEv+0xb0>
        T *ret = elem->data;
    8000452c:	00053903          	ld	s2,0(a0)
        MemoryAllocator::mem_free(elem);
    80004530:	00001097          	auipc	ra,0x1
    80004534:	1e4080e7          	jalr	484(ra) # 80005714 <_ZN15MemoryAllocator8mem_freeEPv>
        n--;
    80004538:	0104a783          	lw	a5,16(s1)
    8000453c:	fff7879b          	addiw	a5,a5,-1
    80004540:	00f4a823          	sw	a5,16(s1)
    
    if(sem)
    80004544:	00090863          	beqz	s2,80004554 <_ZN3TCB7receiveEv+0x74>
    {
        sem_signal(*sem);
    80004548:	00093503          	ld	a0,0(s2)
    8000454c:	ffffd097          	auipc	ra,0xffffd
    80004550:	ea4080e7          	jalr	-348(ra) # 800013f0 <_Z10sem_signalP11MySemaphore>
    }


    return running->msg;
}
    80004554:	00007797          	auipc	a5,0x7
    80004558:	0cc7b783          	ld	a5,204(a5) # 8000b620 <_ZN3TCB7runningE>
    8000455c:	0307b503          	ld	a0,48(a5)
    80004560:	01813083          	ld	ra,24(sp)
    80004564:	01013403          	ld	s0,16(sp)
    80004568:	00813483          	ld	s1,8(sp)
    8000456c:	00013903          	ld	s2,0(sp)
    80004570:	02010113          	addi	sp,sp,32
    80004574:	00008067          	ret
        running->block = true;
    80004578:	00100713          	li	a4,1
    8000457c:	02e78ca3          	sb	a4,57(a5)
        sem_wait(running->blocked);
    80004580:	0407b503          	ld	a0,64(a5)
    80004584:	ffffd097          	auipc	ra,0xffffd
    80004588:	e2c080e7          	jalr	-468(ra) # 800013b0 <_Z8sem_waitP11MySemaphore>
    8000458c:	f7dff06f          	j	80004508 <_ZN3TCB7receiveEv+0x28>
        if (!head) { tail = 0; }
    80004590:	0004b423          	sd	zero,8(s1)
    80004594:	f99ff06f          	j	8000452c <_ZN3TCB7receiveEv+0x4c>
        if (!head) { return 0; }
    80004598:	00050913          	mv	s2,a0
    8000459c:	fa9ff06f          	j	80004544 <_ZN3TCB7receiveEv+0x64>

00000000800045a0 <_ZN6Thread7WrapperEPv>:
    this->body = &Wrapper;
    this->arg = this;
}

void Thread::Wrapper(void *thread)
{
    800045a0:	ff010113          	addi	sp,sp,-16
    800045a4:	00113423          	sd	ra,8(sp)
    800045a8:	00813023          	sd	s0,0(sp)
    800045ac:	01010413          	addi	s0,sp,16
    ((Thread*) thread) -> run();
    800045b0:	00053783          	ld	a5,0(a0)
    800045b4:	0107b783          	ld	a5,16(a5)
    800045b8:	000780e7          	jalr	a5
}
    800045bc:	00813083          	ld	ra,8(sp)
    800045c0:	00013403          	ld	s0,0(sp)
    800045c4:	01010113          	addi	sp,sp,16
    800045c8:	00008067          	ret

00000000800045cc <_ZN6ThreadD1Ev>:
Thread::~Thread()
    800045cc:	fe010113          	addi	sp,sp,-32
    800045d0:	00113c23          	sd	ra,24(sp)
    800045d4:	00813823          	sd	s0,16(sp)
    800045d8:	00913423          	sd	s1,8(sp)
    800045dc:	02010413          	addi	s0,sp,32
    800045e0:	00007797          	auipc	a5,0x7
    800045e4:	ed878793          	addi	a5,a5,-296 # 8000b4b8 <_ZTV6Thread+0x10>
    800045e8:	00f53023          	sd	a5,0(a0)
    if(myHandle != nullptr)
    800045ec:	00853483          	ld	s1,8(a0)
    800045f0:	00048e63          	beqz	s1,8000460c <_ZN6ThreadD1Ev+0x40>
    ~TCB() { MemoryAllocator::mem_free(stack); }
    800045f4:	0104b503          	ld	a0,16(s1)
    800045f8:	00001097          	auipc	ra,0x1
    800045fc:	11c080e7          	jalr	284(ra) # 80005714 <_ZN15MemoryAllocator8mem_freeEPv>
        delete this->myHandle;
    80004600:	00048513          	mv	a0,s1
    80004604:	00000097          	auipc	ra,0x0
    80004608:	ca4080e7          	jalr	-860(ra) # 800042a8 <_ZN3TCBdlEPv>
}
    8000460c:	01813083          	ld	ra,24(sp)
    80004610:	01013403          	ld	s0,16(sp)
    80004614:	00813483          	ld	s1,8(sp)
    80004618:	02010113          	addi	sp,sp,32
    8000461c:	00008067          	ret

0000000080004620 <_ZN9SemaphoreD1Ev>:
Semaphore::Semaphore(unsigned int init)
{
    sem_open(&this->myHandle, init);
}

Semaphore::~Semaphore()
    80004620:	00007797          	auipc	a5,0x7
    80004624:	ec078793          	addi	a5,a5,-320 # 8000b4e0 <_ZTV9Semaphore+0x10>
    80004628:	00f53023          	sd	a5,0(a0)
{
    if(this->myHandle != nullptr)
    8000462c:	00853503          	ld	a0,8(a0)
    80004630:	02050663          	beqz	a0,8000465c <_ZN9SemaphoreD1Ev+0x3c>
Semaphore::~Semaphore()
    80004634:	ff010113          	addi	sp,sp,-16
    80004638:	00113423          	sd	ra,8(sp)
    8000463c:	00813023          	sd	s0,0(sp)
    80004640:	01010413          	addi	s0,sp,16
    {
        sem_close(this->myHandle);
    80004644:	ffffd097          	auipc	ra,0xffffd
    80004648:	d2c080e7          	jalr	-724(ra) # 80001370 <_Z9sem_closeP11MySemaphore>
    }
}
    8000464c:	00813083          	ld	ra,8(sp)
    80004650:	00013403          	ld	s0,0(sp)
    80004654:	01010113          	addi	sp,sp,16
    80004658:	00008067          	ret
    8000465c:	00008067          	ret

0000000080004660 <_Znwm>:
{
    80004660:	ff010113          	addi	sp,sp,-16
    80004664:	00113423          	sd	ra,8(sp)
    80004668:	00813023          	sd	s0,0(sp)
    8000466c:	01010413          	addi	s0,sp,16
    void* address = mem_alloc(size);
    80004670:	ffffd097          	auipc	ra,0xffffd
    80004674:	ad4080e7          	jalr	-1324(ra) # 80001144 <_Z9mem_allocm>
}
    80004678:	00813083          	ld	ra,8(sp)
    8000467c:	00013403          	ld	s0,0(sp)
    80004680:	01010113          	addi	sp,sp,16
    80004684:	00008067          	ret

0000000080004688 <_Znam>:
{
    80004688:	ff010113          	addi	sp,sp,-16
    8000468c:	00113423          	sd	ra,8(sp)
    80004690:	00813023          	sd	s0,0(sp)
    80004694:	01010413          	addi	s0,sp,16
    void* address = mem_alloc(size);
    80004698:	ffffd097          	auipc	ra,0xffffd
    8000469c:	aac080e7          	jalr	-1364(ra) # 80001144 <_Z9mem_allocm>
}
    800046a0:	00813083          	ld	ra,8(sp)
    800046a4:	00013403          	ld	s0,0(sp)
    800046a8:	01010113          	addi	sp,sp,16
    800046ac:	00008067          	ret

00000000800046b0 <_ZdlPv>:
{
    800046b0:	ff010113          	addi	sp,sp,-16
    800046b4:	00113423          	sd	ra,8(sp)
    800046b8:	00813023          	sd	s0,0(sp)
    800046bc:	01010413          	addi	s0,sp,16
    mem_free(address);
    800046c0:	ffffd097          	auipc	ra,0xffffd
    800046c4:	ad4080e7          	jalr	-1324(ra) # 80001194 <_Z8mem_freePv>
}
    800046c8:	00813083          	ld	ra,8(sp)
    800046cc:	00013403          	ld	s0,0(sp)
    800046d0:	01010113          	addi	sp,sp,16
    800046d4:	00008067          	ret

00000000800046d8 <_ZN6ThreadD0Ev>:
Thread::~Thread()
    800046d8:	fe010113          	addi	sp,sp,-32
    800046dc:	00113c23          	sd	ra,24(sp)
    800046e0:	00813823          	sd	s0,16(sp)
    800046e4:	00913423          	sd	s1,8(sp)
    800046e8:	02010413          	addi	s0,sp,32
    800046ec:	00050493          	mv	s1,a0
}
    800046f0:	00000097          	auipc	ra,0x0
    800046f4:	edc080e7          	jalr	-292(ra) # 800045cc <_ZN6ThreadD1Ev>
    800046f8:	00048513          	mv	a0,s1
    800046fc:	00000097          	auipc	ra,0x0
    80004700:	fb4080e7          	jalr	-76(ra) # 800046b0 <_ZdlPv>
    80004704:	01813083          	ld	ra,24(sp)
    80004708:	01013403          	ld	s0,16(sp)
    8000470c:	00813483          	ld	s1,8(sp)
    80004710:	02010113          	addi	sp,sp,32
    80004714:	00008067          	ret

0000000080004718 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore()
    80004718:	fe010113          	addi	sp,sp,-32
    8000471c:	00113c23          	sd	ra,24(sp)
    80004720:	00813823          	sd	s0,16(sp)
    80004724:	00913423          	sd	s1,8(sp)
    80004728:	02010413          	addi	s0,sp,32
    8000472c:	00050493          	mv	s1,a0
}
    80004730:	00000097          	auipc	ra,0x0
    80004734:	ef0080e7          	jalr	-272(ra) # 80004620 <_ZN9SemaphoreD1Ev>
    80004738:	00048513          	mv	a0,s1
    8000473c:	00000097          	auipc	ra,0x0
    80004740:	f74080e7          	jalr	-140(ra) # 800046b0 <_ZdlPv>
    80004744:	01813083          	ld	ra,24(sp)
    80004748:	01013403          	ld	s0,16(sp)
    8000474c:	00813483          	ld	s1,8(sp)
    80004750:	02010113          	addi	sp,sp,32
    80004754:	00008067          	ret

0000000080004758 <_ZdaPv>:
{
    80004758:	ff010113          	addi	sp,sp,-16
    8000475c:	00113423          	sd	ra,8(sp)
    80004760:	00813023          	sd	s0,0(sp)
    80004764:	01010413          	addi	s0,sp,16
    mem_free(address);
    80004768:	ffffd097          	auipc	ra,0xffffd
    8000476c:	a2c080e7          	jalr	-1492(ra) # 80001194 <_Z8mem_freePv>
}
    80004770:	00813083          	ld	ra,8(sp)
    80004774:	00013403          	ld	s0,0(sp)
    80004778:	01010113          	addi	sp,sp,16
    8000477c:	00008067          	ret

0000000080004780 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg)
    80004780:	ff010113          	addi	sp,sp,-16
    80004784:	00813423          	sd	s0,8(sp)
    80004788:	01010413          	addi	s0,sp,16
    8000478c:	00007797          	auipc	a5,0x7
    80004790:	d2c78793          	addi	a5,a5,-724 # 8000b4b8 <_ZTV6Thread+0x10>
    80004794:	00f53023          	sd	a5,0(a0)
    this->myHandle = nullptr;
    80004798:	00053423          	sd	zero,8(a0)
    this->body = body;
    8000479c:	00b53823          	sd	a1,16(a0)
    this->arg = arg;
    800047a0:	00c53c23          	sd	a2,24(a0)
}
    800047a4:	00813403          	ld	s0,8(sp)
    800047a8:	01010113          	addi	sp,sp,16
    800047ac:	00008067          	ret

00000000800047b0 <_ZN6Thread5startEv>:
    if(this->myHandle == nullptr)
    800047b0:	00853783          	ld	a5,8(a0)
    800047b4:	02079e63          	bnez	a5,800047f0 <_ZN6Thread5startEv+0x40>
{
    800047b8:	ff010113          	addi	sp,sp,-16
    800047bc:	00113423          	sd	ra,8(sp)
    800047c0:	00813023          	sd	s0,0(sp)
    800047c4:	01010413          	addi	s0,sp,16
        thread_create(&this->myHandle, this->body, this->arg);
    800047c8:	01853603          	ld	a2,24(a0)
    800047cc:	01053583          	ld	a1,16(a0)
    800047d0:	00850513          	addi	a0,a0,8
    800047d4:	ffffd097          	auipc	ra,0xffffd
    800047d8:	a00080e7          	jalr	-1536(ra) # 800011d4 <_Z13thread_createPP3TCBPFvPvES2_>
        return 0;
    800047dc:	00000513          	li	a0,0
}
    800047e0:	00813083          	ld	ra,8(sp)
    800047e4:	00013403          	ld	s0,0(sp)
    800047e8:	01010113          	addi	sp,sp,16
    800047ec:	00008067          	ret
    return -1;
    800047f0:	fff00513          	li	a0,-1
}
    800047f4:	00008067          	ret

00000000800047f8 <_ZN6Thread8dispatchEv>:
{
    800047f8:	ff010113          	addi	sp,sp,-16
    800047fc:	00113423          	sd	ra,8(sp)
    80004800:	00813023          	sd	s0,0(sp)
    80004804:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80004808:	ffffd097          	auipc	ra,0xffffd
    8000480c:	a8c080e7          	jalr	-1396(ra) # 80001294 <_Z15thread_dispatchv>
}
    80004810:	00813083          	ld	ra,8(sp)
    80004814:	00013403          	ld	s0,0(sp)
    80004818:	01010113          	addi	sp,sp,16
    8000481c:	00008067          	ret

0000000080004820 <_ZN6ThreadC1Ev>:
Thread::Thread()
    80004820:	ff010113          	addi	sp,sp,-16
    80004824:	00813423          	sd	s0,8(sp)
    80004828:	01010413          	addi	s0,sp,16
    8000482c:	00007797          	auipc	a5,0x7
    80004830:	c8c78793          	addi	a5,a5,-884 # 8000b4b8 <_ZTV6Thread+0x10>
    80004834:	00f53023          	sd	a5,0(a0)
    this->myHandle = nullptr;
    80004838:	00053423          	sd	zero,8(a0)
    this->body = &Wrapper;
    8000483c:	00000797          	auipc	a5,0x0
    80004840:	d6478793          	addi	a5,a5,-668 # 800045a0 <_ZN6Thread7WrapperEPv>
    80004844:	00f53823          	sd	a5,16(a0)
    this->arg = this;
    80004848:	00a53c23          	sd	a0,24(a0)
}
    8000484c:	00813403          	ld	s0,8(sp)
    80004850:	01010113          	addi	sp,sp,16
    80004854:	00008067          	ret

0000000080004858 <_ZN6Thread4sendEPc>:
{
    80004858:	ff010113          	addi	sp,sp,-16
    8000485c:	00113423          	sd	ra,8(sp)
    80004860:	00813023          	sd	s0,0(sp)
    80004864:	01010413          	addi	s0,sp,16
    ::send(this->myHandle, message);
    80004868:	00853503          	ld	a0,8(a0)
    8000486c:	ffffd097          	auipc	ra,0xffffd
    80004870:	a54080e7          	jalr	-1452(ra) # 800012c0 <_Z4sendP3TCBPc>
}
    80004874:	00813083          	ld	ra,8(sp)
    80004878:	00013403          	ld	s0,0(sp)
    8000487c:	01010113          	addi	sp,sp,16
    80004880:	00008067          	ret

0000000080004884 <_ZN6Thread7receiveEv>:
{
    80004884:	ff010113          	addi	sp,sp,-16
    80004888:	00113423          	sd	ra,8(sp)
    8000488c:	00813023          	sd	s0,0(sp)
    80004890:	01010413          	addi	s0,sp,16
    return ::receive();
    80004894:	ffffd097          	auipc	ra,0xffffd
    80004898:	a60080e7          	jalr	-1440(ra) # 800012f4 <_Z7receivev>
}
    8000489c:	00813083          	ld	ra,8(sp)
    800048a0:	00013403          	ld	s0,0(sp)
    800048a4:	01010113          	addi	sp,sp,16
    800048a8:	00008067          	ret

00000000800048ac <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init)
    800048ac:	ff010113          	addi	sp,sp,-16
    800048b0:	00113423          	sd	ra,8(sp)
    800048b4:	00813023          	sd	s0,0(sp)
    800048b8:	01010413          	addi	s0,sp,16
    800048bc:	00007797          	auipc	a5,0x7
    800048c0:	c2478793          	addi	a5,a5,-988 # 8000b4e0 <_ZTV9Semaphore+0x10>
    800048c4:	00f53023          	sd	a5,0(a0)
    sem_open(&this->myHandle, init);
    800048c8:	00850513          	addi	a0,a0,8
    800048cc:	ffffd097          	auipc	ra,0xffffd
    800048d0:	a60080e7          	jalr	-1440(ra) # 8000132c <_Z8sem_openPP11MySemaphorej>
}
    800048d4:	00813083          	ld	ra,8(sp)
    800048d8:	00013403          	ld	s0,0(sp)
    800048dc:	01010113          	addi	sp,sp,16
    800048e0:	00008067          	ret

00000000800048e4 <_ZN9Semaphore4waitEv>:

int Semaphore::wait()
{
    if(this->myHandle != nullptr)
    800048e4:	00853503          	ld	a0,8(a0)
    800048e8:	02050863          	beqz	a0,80004918 <_ZN9Semaphore4waitEv+0x34>
{
    800048ec:	ff010113          	addi	sp,sp,-16
    800048f0:	00113423          	sd	ra,8(sp)
    800048f4:	00813023          	sd	s0,0(sp)
    800048f8:	01010413          	addi	s0,sp,16
    {
        sem_wait(this->myHandle);
    800048fc:	ffffd097          	auipc	ra,0xffffd
    80004900:	ab4080e7          	jalr	-1356(ra) # 800013b0 <_Z8sem_waitP11MySemaphore>
        return 0;
    80004904:	00000513          	li	a0,0
    }

    return -1;
}
    80004908:	00813083          	ld	ra,8(sp)
    8000490c:	00013403          	ld	s0,0(sp)
    80004910:	01010113          	addi	sp,sp,16
    80004914:	00008067          	ret
    return -1;
    80004918:	fff00513          	li	a0,-1
}
    8000491c:	00008067          	ret

0000000080004920 <_ZN9Semaphore6signalEv>:

int Semaphore::signal()
{
    if(this->myHandle != nullptr)
    80004920:	00853503          	ld	a0,8(a0)
    80004924:	02050863          	beqz	a0,80004954 <_ZN9Semaphore6signalEv+0x34>
{
    80004928:	ff010113          	addi	sp,sp,-16
    8000492c:	00113423          	sd	ra,8(sp)
    80004930:	00813023          	sd	s0,0(sp)
    80004934:	01010413          	addi	s0,sp,16
    {
        sem_signal(this->myHandle);
    80004938:	ffffd097          	auipc	ra,0xffffd
    8000493c:	ab8080e7          	jalr	-1352(ra) # 800013f0 <_Z10sem_signalP11MySemaphore>
        return 0;
    80004940:	00000513          	li	a0,0
    }

    return -1;
}
    80004944:	00813083          	ld	ra,8(sp)
    80004948:	00013403          	ld	s0,0(sp)
    8000494c:	01010113          	addi	sp,sp,16
    80004950:	00008067          	ret
    return -1;
    80004954:	fff00513          	li	a0,-1
}
    80004958:	00008067          	ret

000000008000495c <_ZN9Semaphore7tryWaitEv>:

int Semaphore::tryWait()
{
    if(this->myHandle != nullptr)
    8000495c:	00853503          	ld	a0,8(a0)
    80004960:	02050863          	beqz	a0,80004990 <_ZN9Semaphore7tryWaitEv+0x34>
{
    80004964:	ff010113          	addi	sp,sp,-16
    80004968:	00113423          	sd	ra,8(sp)
    8000496c:	00813023          	sd	s0,0(sp)
    80004970:	01010413          	addi	s0,sp,16
    {
        sem_trywait(this->myHandle);
    80004974:	ffffd097          	auipc	ra,0xffffd
    80004978:	abc080e7          	jalr	-1348(ra) # 80001430 <_Z11sem_trywaitP11MySemaphore>
        return 0;
    8000497c:	00000513          	li	a0,0
    }

    return -1;
}
    80004980:	00813083          	ld	ra,8(sp)
    80004984:	00013403          	ld	s0,0(sp)
    80004988:	01010113          	addi	sp,sp,16
    8000498c:	00008067          	ret
    return -1;
    80004990:	fff00513          	li	a0,-1
}
    80004994:	00008067          	ret

0000000080004998 <_ZN7Console4getcEv>:


char Console::getc()
{
    80004998:	ff010113          	addi	sp,sp,-16
    8000499c:	00113423          	sd	ra,8(sp)
    800049a0:	00813023          	sd	s0,0(sp)
    800049a4:	01010413          	addi	s0,sp,16
    return ::getc();
    800049a8:	ffffd097          	auipc	ra,0xffffd
    800049ac:	ac8080e7          	jalr	-1336(ra) # 80001470 <_Z4getcv>
}
    800049b0:	00813083          	ld	ra,8(sp)
    800049b4:	00013403          	ld	s0,0(sp)
    800049b8:	01010113          	addi	sp,sp,16
    800049bc:	00008067          	ret

00000000800049c0 <_ZN7Console4putcEc>:

void Console::putc(char character)
{
    800049c0:	ff010113          	addi	sp,sp,-16
    800049c4:	00113423          	sd	ra,8(sp)
    800049c8:	00813023          	sd	s0,0(sp)
    800049cc:	01010413          	addi	s0,sp,16
    ::putc(character);
    800049d0:	ffffd097          	auipc	ra,0xffffd
    800049d4:	adc080e7          	jalr	-1316(ra) # 800014ac <_Z4putcc>
    800049d8:	00813083          	ld	ra,8(sp)
    800049dc:	00013403          	ld	s0,0(sp)
    800049e0:	01010113          	addi	sp,sp,16
    800049e4:	00008067          	ret

00000000800049e8 <_ZN6Thread3runEv>:


protected:

    Thread();
    virtual void run(){}
    800049e8:	ff010113          	addi	sp,sp,-16
    800049ec:	00813423          	sd	s0,8(sp)
    800049f0:	01010413          	addi	s0,sp,16
    800049f4:	00813403          	ld	s0,8(sp)
    800049f8:	01010113          	addi	sp,sp,16
    800049fc:	00008067          	ret

0000000080004a00 <_ZN5Riscv10popSppSpieEv>:
#include "../lib/console.h"
#include "../h/MySemaphore.hpp"
#include "../h/printing.hpp"

void Riscv::popSppSpie()
{
    80004a00:	ff010113          	addi	sp,sp,-16
    80004a04:	00813423          	sd	s0,8(sp)
    80004a08:	01010413          	addi	s0,sp,16
}

inline void Riscv::mc_sstatus(uint64 mask)
{
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80004a0c:	10000793          	li	a5,256
    80004a10:	1007b073          	csrc	sstatus,a5
    mc_sstatus(BitMaskSstatus::SSTATUS_SPP);
    __asm__ volatile("csrw sepc, ra");
    80004a14:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    80004a18:	10200073          	sret
}
    80004a1c:	00813403          	ld	s0,8(sp)
    80004a20:	01010113          	addi	sp,sp,16
    80004a24:	00008067          	ret

0000000080004a28 <_ZN5Riscv20handleSupervisorTrapEv>:

void Riscv::handleSupervisorTrap()
{
    80004a28:	f0010113          	addi	sp,sp,-256
    80004a2c:	0e113c23          	sd	ra,248(sp)
    80004a30:	0e813823          	sd	s0,240(sp)
    80004a34:	10010413          	addi	s0,sp,256
    uint64 volatile  a1, a2, a3, a4;
    __asm__ volatile("mv %0, a1" : "=r" (a1));
    80004a38:	00058793          	mv	a5,a1
    80004a3c:	fef43423          	sd	a5,-24(s0)
    __asm__ volatile("mv %0, a2" : "=r" (a2));
    80004a40:	00060793          	mv	a5,a2
    80004a44:	fef43023          	sd	a5,-32(s0)
    __asm__ volatile("mv %0, a3" : "=r" (a3));
    80004a48:	00068793          	mv	a5,a3
    80004a4c:	fcf43c23          	sd	a5,-40(s0)
    __asm__ volatile("mv %0, a4" : "=r" (a4));
    80004a50:	00070793          	mv	a5,a4
    80004a54:	fcf43823          	sd	a5,-48(s0)
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80004a58:	142027f3          	csrr	a5,scause
    80004a5c:	faf43c23          	sd	a5,-72(s0)
    return scause;
    80004a60:	fb843703          	ld	a4,-72(s0)

    uint64 scause = r_scause();

    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)
    80004a64:	ff870693          	addi	a3,a4,-8
    80004a68:	00100793          	li	a5,1
    80004a6c:	02d7fc63          	bgeu	a5,a3,80004aa4 <_ZN5Riscv20handleSupervisorTrapEv+0x7c>

        w_sstatus(sstatus);
        w_sepc(sepc);

    }
    else if (scause == 0x8000000000000001UL)
    80004a70:	fff00793          	li	a5,-1
    80004a74:	03f79793          	slli	a5,a5,0x3f
    80004a78:	00178793          	addi	a5,a5,1
    80004a7c:	34f70463          	beq	a4,a5,80004dc4 <_ZN5Riscv20handleSupervisorTrapEv+0x39c>
        //    TCB::dispatch();
        //    w_sstatus(sstatus);
        //    w_sepc(sepc);
        //}
    }
    else if (scause == 0x8000000000000009UL)
    80004a80:	fff00793          	li	a5,-1
    80004a84:	03f79793          	slli	a5,a5,0x3f
    80004a88:	00978793          	addi	a5,a5,9
    80004a8c:	34f70263          	beq	a4,a5,80004dd0 <_ZN5Riscv20handleSupervisorTrapEv+0x3a8>
        console_handler();
    }
    else
    {
        // unexpected trap cause
        printString("Error");
    80004a90:	00005517          	auipc	a0,0x5
    80004a94:	a0850513          	addi	a0,a0,-1528 # 80009498 <CONSOLE_STATUS+0x488>
    80004a98:	fffff097          	auipc	ra,0xfffff
    80004a9c:	e04080e7          	jalr	-508(ra) # 8000389c <_Z11printStringPKc>
        while(1);
    80004aa0:	0000006f          	j	80004aa0 <_ZN5Riscv20handleSupervisorTrapEv+0x78>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80004aa4:	141027f3          	csrr	a5,sepc
    80004aa8:	fcf43423          	sd	a5,-56(s0)
    return sepc;
    80004aac:	fc843783          	ld	a5,-56(s0)
        uint64 volatile sepc = r_sepc() + 4;
    80004ab0:	00478793          	addi	a5,a5,4
    80004ab4:	f2f43423          	sd	a5,-216(s0)
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80004ab8:	100027f3          	csrr	a5,sstatus
    80004abc:	fcf43023          	sd	a5,-64(s0)
    return sstatus;
    80004ac0:	fc043783          	ld	a5,-64(s0)
        uint64 volatile sstatus = r_sstatus();
    80004ac4:	f2f43823          	sd	a5,-208(s0)
        __asm__ volatile("mv %0, a0" : "=r" (number));
    80004ac8:	00050793          	mv	a5,a0
    80004acc:	f2f43c23          	sd	a5,-200(s0)
        if(number == 0x01)
    80004ad0:	f3843703          	ld	a4,-200(s0)
    80004ad4:	00100793          	li	a5,1
    80004ad8:	0cf70063          	beq	a4,a5,80004b98 <_ZN5Riscv20handleSupervisorTrapEv+0x170>
        else if(number == 0x02)
    80004adc:	f3843703          	ld	a4,-200(s0)
    80004ae0:	00200793          	li	a5,2
    80004ae4:	10f70263          	beq	a4,a5,80004be8 <_ZN5Riscv20handleSupervisorTrapEv+0x1c0>
        else if(number == 0x11)
    80004ae8:	f3843703          	ld	a4,-200(s0)
    80004aec:	01100793          	li	a5,17
    80004af0:	12f70463          	beq	a4,a5,80004c18 <_ZN5Riscv20handleSupervisorTrapEv+0x1f0>
        else if(number == 0x12)
    80004af4:	f3843703          	ld	a4,-200(s0)
    80004af8:	01200793          	li	a5,18
    80004afc:	16f70463          	beq	a4,a5,80004c64 <_ZN5Riscv20handleSupervisorTrapEv+0x23c>
        else if(number == 0x13)
    80004b00:	f3843703          	ld	a4,-200(s0)
    80004b04:	01300793          	li	a5,19
    80004b08:	16f70c63          	beq	a4,a5,80004c80 <_ZN5Riscv20handleSupervisorTrapEv+0x258>
        else if(number == 0x14)
    80004b0c:	f3843703          	ld	a4,-200(s0)
    80004b10:	01400793          	li	a5,20
    80004b14:	16f70c63          	beq	a4,a5,80004c8c <_ZN5Riscv20handleSupervisorTrapEv+0x264>
        else if(number == 0x15)
    80004b18:	f3843703          	ld	a4,-200(s0)
    80004b1c:	01500793          	li	a5,21
    80004b20:	18f70863          	beq	a4,a5,80004cb0 <_ZN5Riscv20handleSupervisorTrapEv+0x288>
        else if(number == 0x21)
    80004b24:	f3843703          	ld	a4,-200(s0)
    80004b28:	02100793          	li	a5,33
    80004b2c:	1af70063          	beq	a4,a5,80004ccc <_ZN5Riscv20handleSupervisorTrapEv+0x2a4>
        else if(number == 0x22)
    80004b30:	f3843703          	ld	a4,-200(s0)
    80004b34:	02200793          	li	a5,34
    80004b38:	1cf70863          	beq	a4,a5,80004d08 <_ZN5Riscv20handleSupervisorTrapEv+0x2e0>
        else if(number == 0x23)
    80004b3c:	f3843703          	ld	a4,-200(s0)
    80004b40:	02300793          	li	a5,35
    80004b44:	1ef70663          	beq	a4,a5,80004d30 <_ZN5Riscv20handleSupervisorTrapEv+0x308>
        else if(number == 0x24)
    80004b48:	f3843703          	ld	a4,-200(s0)
    80004b4c:	02400793          	li	a5,36
    80004b50:	20f70463          	beq	a4,a5,80004d58 <_ZN5Riscv20handleSupervisorTrapEv+0x330>
        else if(number == 0x26)
    80004b54:	f3843703          	ld	a4,-200(s0)
    80004b58:	02600793          	li	a5,38
    80004b5c:	22f70263          	beq	a4,a5,80004d80 <_ZN5Riscv20handleSupervisorTrapEv+0x358>
        else if(number == 0x41)
    80004b60:	f3843703          	ld	a4,-200(s0)
    80004b64:	04100793          	li	a5,65
    80004b68:	24f70063          	beq	a4,a5,80004da8 <_ZN5Riscv20handleSupervisorTrapEv+0x380>
        else if(number == 0x42)
    80004b6c:	f3843703          	ld	a4,-200(s0)
    80004b70:	04200793          	li	a5,66
    80004b74:	04f71a63          	bne	a4,a5,80004bc8 <_ZN5Riscv20handleSupervisorTrapEv+0x1a0>
            char volatile character = (char volatile) a1;
    80004b78:	fe843783          	ld	a5,-24(s0)
    80004b7c:	0ff7f793          	andi	a5,a5,255
    80004b80:	f0f401a3          	sb	a5,-253(s0)
            __putc(character);
    80004b84:	f0344503          	lbu	a0,-253(s0)
    80004b88:	0ff57513          	andi	a0,a0,255
    80004b8c:	00003097          	auipc	ra,0x3
    80004b90:	5f0080e7          	jalr	1520(ra) # 8000817c <__putc>
    80004b94:	0340006f          	j	80004bc8 <_ZN5Riscv20handleSupervisorTrapEv+0x1a0>
            uint64 volatile numberOfBlocks = (uint64 volatile) a1;
    80004b98:	fe843783          	ld	a5,-24(s0)
    80004b9c:	f4f43023          	sd	a5,-192(s0)
            void* volatile ptr = nullptr;
    80004ba0:	f4043423          	sd	zero,-184(s0)
            ptr = MemoryAllocator::getInstance()->mem_alloc(numberOfBlocks);
    80004ba4:	00001097          	auipc	ra,0x1
    80004ba8:	ac4080e7          	jalr	-1340(ra) # 80005668 <_ZN15MemoryAllocator11getInstanceEv>
    80004bac:	f4043503          	ld	a0,-192(s0)
    80004bb0:	00001097          	auipc	ra,0x1
    80004bb4:	9e0080e7          	jalr	-1568(ra) # 80005590 <_ZN15MemoryAllocator9mem_allocEm>
    80004bb8:	f4a43423          	sd	a0,-184(s0)
            __asm__ volatile("mv a0, %0" : : "r" (ptr));
    80004bbc:	f4843783          	ld	a5,-184(s0)
    80004bc0:	00078513          	mv	a0,a5
            __asm__ volatile("sd a0, 80(fp)");
    80004bc4:	04a43823          	sd	a0,80(s0)
        w_sstatus(sstatus);
    80004bc8:	f3043783          	ld	a5,-208(s0)
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80004bcc:	10079073          	csrw	sstatus,a5
        w_sepc(sepc);
    80004bd0:	f2843783          	ld	a5,-216(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80004bd4:	14179073          	csrw	sepc,a5
    }
    80004bd8:	0f813083          	ld	ra,248(sp)
    80004bdc:	0f013403          	ld	s0,240(sp)
    80004be0:	10010113          	addi	sp,sp,256
    80004be4:	00008067          	ret
            void* volatile address = (void* volatile) a1;
    80004be8:	fe843783          	ld	a5,-24(s0)
    80004bec:	f4f43823          	sd	a5,-176(s0)
            returnValue = MemoryAllocator::getInstance()->mem_free(address);
    80004bf0:	00001097          	auipc	ra,0x1
    80004bf4:	a78080e7          	jalr	-1416(ra) # 80005668 <_ZN15MemoryAllocator11getInstanceEv>
    80004bf8:	f5043503          	ld	a0,-176(s0)
    80004bfc:	00001097          	auipc	ra,0x1
    80004c00:	b18080e7          	jalr	-1256(ra) # 80005714 <_ZN15MemoryAllocator8mem_freeEPv>
    80004c04:	f0a42223          	sw	a0,-252(s0)
            __asm__ volatile("mv a0, %0" : : "r" (returnValue));
    80004c08:	f0442783          	lw	a5,-252(s0)
    80004c0c:	00078513          	mv	a0,a5
            __asm__ volatile("sd a0, 80(fp)");
    80004c10:	04a43823          	sd	a0,80(s0)
    80004c14:	fb5ff06f          	j	80004bc8 <_ZN5Riscv20handleSupervisorTrapEv+0x1a0>
            thread_t* volatile handle = (thread_t* volatile) a1;
    80004c18:	fe843783          	ld	a5,-24(s0)
    80004c1c:	f4f43c23          	sd	a5,-168(s0)
            TCB::Body volatile start_routine = (TCB::Body volatile) a2;
    80004c20:	fe043783          	ld	a5,-32(s0)
    80004c24:	f6f43023          	sd	a5,-160(s0)
            void* volatile arg = (void* volatile)a3;
    80004c28:	fd843783          	ld	a5,-40(s0)
    80004c2c:	f6f43423          	sd	a5,-152(s0)
            void* volatile stack = (void* volatile)a4;
    80004c30:	fd043783          	ld	a5,-48(s0)
    80004c34:	f6f43823          	sd	a5,-144(s0)
            returnValue = TCB::thread_create(handle, start_routine, arg, stack);
    80004c38:	f5843503          	ld	a0,-168(s0)
    80004c3c:	f6043583          	ld	a1,-160(s0)
    80004c40:	f6843603          	ld	a2,-152(s0)
    80004c44:	f7043683          	ld	a3,-144(s0)
    80004c48:	fffff097          	auipc	ra,0xfffff
    80004c4c:	688080e7          	jalr	1672(ra) # 800042d0 <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_>
    80004c50:	f0a42423          	sw	a0,-248(s0)
            __asm__ volatile("mv a0, %0" : : "r" (returnValue));
    80004c54:	f0842783          	lw	a5,-248(s0)
    80004c58:	00078513          	mv	a0,a5
            __asm__ volatile("sd a0, 80(fp)");
    80004c5c:	04a43823          	sd	a0,80(s0)
    80004c60:	f69ff06f          	j	80004bc8 <_ZN5Riscv20handleSupervisorTrapEv+0x1a0>
            returnValue = TCB::thread_exit();
    80004c64:	fffff097          	auipc	ra,0xfffff
    80004c68:	5dc080e7          	jalr	1500(ra) # 80004240 <_ZN3TCB11thread_exitEv>
    80004c6c:	f0a42623          	sw	a0,-244(s0)
            __asm__ volatile("mv a0, %0" : : "r" (returnValue));
    80004c70:	f0c42783          	lw	a5,-244(s0)
    80004c74:	00078513          	mv	a0,a5
            __asm__ volatile("sd a0, 80(fp)");
    80004c78:	04a43823          	sd	a0,80(s0)
    80004c7c:	f4dff06f          	j	80004bc8 <_ZN5Riscv20handleSupervisorTrapEv+0x1a0>
            TCB::thread_dispatch();
    80004c80:	fffff097          	auipc	ra,0xfffff
    80004c84:	558080e7          	jalr	1368(ra) # 800041d8 <_ZN3TCB15thread_dispatchEv>
    80004c88:	f41ff06f          	j	80004bc8 <_ZN5Riscv20handleSupervisorTrapEv+0x1a0>
            thread_t volatile handle = (thread_t volatile) a1;
    80004c8c:	fe843783          	ld	a5,-24(s0)
    80004c90:	f6f43c23          	sd	a5,-136(s0)
            char* volatile msg = (char* volatile) a2;
    80004c94:	fe043783          	ld	a5,-32(s0)
    80004c98:	f8f43023          	sd	a5,-128(s0)
            TCB::send(handle, msg);
    80004c9c:	f7843503          	ld	a0,-136(s0)
    80004ca0:	f8043583          	ld	a1,-128(s0)
    80004ca4:	fffff097          	auipc	ra,0xfffff
    80004ca8:	760080e7          	jalr	1888(ra) # 80004404 <_ZN3TCB4sendEPS_Pc>
    80004cac:	f1dff06f          	j	80004bc8 <_ZN5Riscv20handleSupervisorTrapEv+0x1a0>
            returnValue = TCB::receive();
    80004cb0:	00000097          	auipc	ra,0x0
    80004cb4:	830080e7          	jalr	-2000(ra) # 800044e0 <_ZN3TCB7receiveEv>
    80004cb8:	f8a43423          	sd	a0,-120(s0)
            __asm__ volatile("mv a0, %0" : : "r" (returnValue));
    80004cbc:	f8843783          	ld	a5,-120(s0)
    80004cc0:	00078513          	mv	a0,a5
            __asm__ volatile("sd a0, 80(fp)");
    80004cc4:	04a43823          	sd	a0,80(s0)
    80004cc8:	f01ff06f          	j	80004bc8 <_ZN5Riscv20handleSupervisorTrapEv+0x1a0>
            sem_t* volatile handle = (sem_t * volatile) a1;
    80004ccc:	fe843783          	ld	a5,-24(s0)
    80004cd0:	f8f43823          	sd	a5,-112(s0)
            unsigned volatile init = (unsigned volatile) a2;
    80004cd4:	fe043783          	ld	a5,-32(s0)
    80004cd8:	0007879b          	sext.w	a5,a5
    80004cdc:	f0f42a23          	sw	a5,-236(s0)
            returnValue = MySemaphore::sem_open(handle, init);
    80004ce0:	f9043503          	ld	a0,-112(s0)
    80004ce4:	f1442583          	lw	a1,-236(s0)
    80004ce8:	0005859b          	sext.w	a1,a1
    80004cec:	ffffd097          	auipc	ra,0xffffd
    80004cf0:	364080e7          	jalr	868(ra) # 80002050 <_ZN11MySemaphore8sem_openEPPS_j>
    80004cf4:	f0a42823          	sw	a0,-240(s0)
            __asm__ volatile("mv a0, %0" : : "r" (returnValue));
    80004cf8:	f1042783          	lw	a5,-240(s0)
    80004cfc:	00078513          	mv	a0,a5
            __asm__ volatile("sd a0, 80(fp)");
    80004d00:	04a43823          	sd	a0,80(s0)
    80004d04:	ec5ff06f          	j	80004bc8 <_ZN5Riscv20handleSupervisorTrapEv+0x1a0>
            sem_t volatile handle = (sem_t volatile) a1;
    80004d08:	fe843783          	ld	a5,-24(s0)
    80004d0c:	f8f43c23          	sd	a5,-104(s0)
            returnValue = MySemaphore::sem_close(handle);
    80004d10:	f9843503          	ld	a0,-104(s0)
    80004d14:	ffffd097          	auipc	ra,0xffffd
    80004d18:	3cc080e7          	jalr	972(ra) # 800020e0 <_ZN11MySemaphore9sem_closeEPS_>
    80004d1c:	f0a42c23          	sw	a0,-232(s0)
            __asm__ volatile("mv a0, %0" : : "r" (returnValue));
    80004d20:	f1842783          	lw	a5,-232(s0)
    80004d24:	00078513          	mv	a0,a5
            __asm__ volatile("sd a0, 80(fp)");
    80004d28:	04a43823          	sd	a0,80(s0)
    80004d2c:	e9dff06f          	j	80004bc8 <_ZN5Riscv20handleSupervisorTrapEv+0x1a0>
            sem_t volatile id = (sem_t volatile) a1;
    80004d30:	fe843783          	ld	a5,-24(s0)
    80004d34:	faf43023          	sd	a5,-96(s0)
            returnValue = MySemaphore::sem_wait(id);
    80004d38:	fa043503          	ld	a0,-96(s0)
    80004d3c:	ffffd097          	auipc	ra,0xffffd
    80004d40:	0e8080e7          	jalr	232(ra) # 80001e24 <_ZN11MySemaphore8sem_waitEPS_>
    80004d44:	f0a42e23          	sw	a0,-228(s0)
            __asm__ volatile("mv a0, %0" : : "r" (returnValue));
    80004d48:	f1c42783          	lw	a5,-228(s0)
    80004d4c:	00078513          	mv	a0,a5
            __asm__ volatile("sd a0, 80(fp)");
    80004d50:	04a43823          	sd	a0,80(s0)
    80004d54:	e75ff06f          	j	80004bc8 <_ZN5Riscv20handleSupervisorTrapEv+0x1a0>
            sem_t volatile id = (sem_t volatile) a1;
    80004d58:	fe843783          	ld	a5,-24(s0)
    80004d5c:	faf43423          	sd	a5,-88(s0)
            returnValue = MySemaphore::sem_signal(id);
    80004d60:	fa843503          	ld	a0,-88(s0)
    80004d64:	ffffd097          	auipc	ra,0xffffd
    80004d68:	1bc080e7          	jalr	444(ra) # 80001f20 <_ZN11MySemaphore10sem_signalEPS_>
    80004d6c:	f2a42023          	sw	a0,-224(s0)
            __asm__ volatile("mv a0, %0" : : "r" (returnValue));
    80004d70:	f2042783          	lw	a5,-224(s0)
    80004d74:	00078513          	mv	a0,a5
            __asm__ volatile("sd a0, 80(fp)");
    80004d78:	04a43823          	sd	a0,80(s0)
    80004d7c:	e4dff06f          	j	80004bc8 <_ZN5Riscv20handleSupervisorTrapEv+0x1a0>
            sem_t volatile id = (sem_t volatile) a1;
    80004d80:	fe843783          	ld	a5,-24(s0)
    80004d84:	faf43823          	sd	a5,-80(s0)
            returnValue = MySemaphore::sem_trywait(id);
    80004d88:	fb043503          	ld	a0,-80(s0)
    80004d8c:	ffffd097          	auipc	ra,0xffffd
    80004d90:	254080e7          	jalr	596(ra) # 80001fe0 <_ZN11MySemaphore11sem_trywaitEPS_>
    80004d94:	f2a42223          	sw	a0,-220(s0)
            __asm__ volatile("mv a0, %0" : : "r" (returnValue));
    80004d98:	f2442783          	lw	a5,-220(s0)
    80004d9c:	00078513          	mv	a0,a5
            __asm__ volatile("sd a0, 80(fp)");
    80004da0:	04a43823          	sd	a0,80(s0)
    80004da4:	e25ff06f          	j	80004bc8 <_ZN5Riscv20handleSupervisorTrapEv+0x1a0>
            returnValue = __getc();
    80004da8:	00003097          	auipc	ra,0x3
    80004dac:	410080e7          	jalr	1040(ra) # 800081b8 <__getc>
    80004db0:	f0a40123          	sb	a0,-254(s0)
            __asm__ volatile("mv a0, %0" : : "r" (returnValue));
    80004db4:	f0244783          	lbu	a5,-254(s0)
    80004db8:	00078513          	mv	a0,a5
            __asm__ volatile("sd a0, 80(fp)");
    80004dbc:	04a43823          	sd	a0,80(s0)
    80004dc0:	e09ff06f          	j	80004bc8 <_ZN5Riscv20handleSupervisorTrapEv+0x1a0>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80004dc4:	00200793          	li	a5,2
    80004dc8:	1447b073          	csrc	sip,a5
}
    80004dcc:	e0dff06f          	j	80004bd8 <_ZN5Riscv20handleSupervisorTrapEv+0x1b0>
        console_handler();
    80004dd0:	00003097          	auipc	ra,0x3
    80004dd4:	420080e7          	jalr	1056(ra) # 800081f0 <console_handler>
    80004dd8:	e01ff06f          	j	80004bd8 <_ZN5Riscv20handleSupervisorTrapEv+0x1b0>

0000000080004ddc <_Z41__static_initialization_and_destruction_0ii>:
}

void Scheduler::put(TCB *tcb)
{
    readyThreadQueue.addLast(tcb);
}
    80004ddc:	ff010113          	addi	sp,sp,-16
    80004de0:	00813423          	sd	s0,8(sp)
    80004de4:	01010413          	addi	s0,sp,16
    80004de8:	00100793          	li	a5,1
    80004dec:	00f50863          	beq	a0,a5,80004dfc <_Z41__static_initialization_and_destruction_0ii+0x20>
    80004df0:	00813403          	ld	s0,8(sp)
    80004df4:	01010113          	addi	sp,sp,16
    80004df8:	00008067          	ret
    80004dfc:	000107b7          	lui	a5,0x10
    80004e00:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004e04:	fef596e3          	bne	a1,a5,80004df0 <_Z41__static_initialization_and_destruction_0ii+0x14>
    List() : head(0), tail(0), n(0) {}
    80004e08:	00007797          	auipc	a5,0x7
    80004e0c:	82078793          	addi	a5,a5,-2016 # 8000b628 <_ZN9Scheduler16readyThreadQueueE>
    80004e10:	0007b023          	sd	zero,0(a5)
    80004e14:	0007b423          	sd	zero,8(a5)
    80004e18:	0007a823          	sw	zero,16(a5)
    80004e1c:	fd5ff06f          	j	80004df0 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080004e20 <_ZN9Scheduler3getEv>:
{
    80004e20:	fe010113          	addi	sp,sp,-32
    80004e24:	00113c23          	sd	ra,24(sp)
    80004e28:	00813823          	sd	s0,16(sp)
    80004e2c:	00913423          	sd	s1,8(sp)
    80004e30:	02010413          	addi	s0,sp,32
        if (!head) { return 0; }
    80004e34:	00006517          	auipc	a0,0x6
    80004e38:	7f453503          	ld	a0,2036(a0) # 8000b628 <_ZN9Scheduler16readyThreadQueueE>
    80004e3c:	04050c63          	beqz	a0,80004e94 <_ZN9Scheduler3getEv+0x74>
        head = head->next;
    80004e40:	00853783          	ld	a5,8(a0)
    80004e44:	00006717          	auipc	a4,0x6
    80004e48:	7ef73223          	sd	a5,2020(a4) # 8000b628 <_ZN9Scheduler16readyThreadQueueE>
        if (!head) { tail = 0; }
    80004e4c:	02078e63          	beqz	a5,80004e88 <_ZN9Scheduler3getEv+0x68>
        T *ret = elem->data;
    80004e50:	00053483          	ld	s1,0(a0)
        MemoryAllocator::mem_free(elem);
    80004e54:	00001097          	auipc	ra,0x1
    80004e58:	8c0080e7          	jalr	-1856(ra) # 80005714 <_ZN15MemoryAllocator8mem_freeEPv>
        n--;
    80004e5c:	00006717          	auipc	a4,0x6
    80004e60:	7cc70713          	addi	a4,a4,1996 # 8000b628 <_ZN9Scheduler16readyThreadQueueE>
    80004e64:	01072783          	lw	a5,16(a4)
    80004e68:	fff7879b          	addiw	a5,a5,-1
    80004e6c:	00f72823          	sw	a5,16(a4)
}
    80004e70:	00048513          	mv	a0,s1
    80004e74:	01813083          	ld	ra,24(sp)
    80004e78:	01013403          	ld	s0,16(sp)
    80004e7c:	00813483          	ld	s1,8(sp)
    80004e80:	02010113          	addi	sp,sp,32
    80004e84:	00008067          	ret
        if (!head) { tail = 0; }
    80004e88:	00006797          	auipc	a5,0x6
    80004e8c:	7a07b423          	sd	zero,1960(a5) # 8000b630 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80004e90:	fc1ff06f          	j	80004e50 <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    80004e94:	00050493          	mv	s1,a0
    return readyThreadQueue.removeFirst();
    80004e98:	fd9ff06f          	j	80004e70 <_ZN9Scheduler3getEv+0x50>

0000000080004e9c <_ZN9Scheduler3putEP3TCB>:
{
    80004e9c:	fe010113          	addi	sp,sp,-32
    80004ea0:	00113c23          	sd	ra,24(sp)
    80004ea4:	00813823          	sd	s0,16(sp)
    80004ea8:	00913423          	sd	s1,8(sp)
    80004eac:	02010413          	addi	s0,sp,32
    80004eb0:	00050493          	mv	s1,a0
        Elem* elem = (Elem*) MemoryAllocator::mem_alloc((sizeof(Elem) + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE);
    80004eb4:	00100513          	li	a0,1
    80004eb8:	00000097          	auipc	ra,0x0
    80004ebc:	6d8080e7          	jalr	1752(ra) # 80005590 <_ZN15MemoryAllocator9mem_allocEm>
        elem->data = data;
    80004ec0:	00953023          	sd	s1,0(a0)
        elem->next = nullptr;
    80004ec4:	00053423          	sd	zero,8(a0)
        if (tail)
    80004ec8:	00006797          	auipc	a5,0x6
    80004ecc:	7687b783          	ld	a5,1896(a5) # 8000b630 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80004ed0:	02078c63          	beqz	a5,80004f08 <_ZN9Scheduler3putEP3TCB+0x6c>
            tail->next = elem;
    80004ed4:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80004ed8:	00006797          	auipc	a5,0x6
    80004edc:	74a7bc23          	sd	a0,1880(a5) # 8000b630 <_ZN9Scheduler16readyThreadQueueE+0x8>
        n++;
    80004ee0:	00006717          	auipc	a4,0x6
    80004ee4:	74870713          	addi	a4,a4,1864 # 8000b628 <_ZN9Scheduler16readyThreadQueueE>
    80004ee8:	01072783          	lw	a5,16(a4)
    80004eec:	0017879b          	addiw	a5,a5,1
    80004ef0:	00f72823          	sw	a5,16(a4)
}
    80004ef4:	01813083          	ld	ra,24(sp)
    80004ef8:	01013403          	ld	s0,16(sp)
    80004efc:	00813483          	ld	s1,8(sp)
    80004f00:	02010113          	addi	sp,sp,32
    80004f04:	00008067          	ret
            head = tail = elem;
    80004f08:	00006797          	auipc	a5,0x6
    80004f0c:	72078793          	addi	a5,a5,1824 # 8000b628 <_ZN9Scheduler16readyThreadQueueE>
    80004f10:	00a7b423          	sd	a0,8(a5)
    80004f14:	00a7b023          	sd	a0,0(a5)
    80004f18:	fc9ff06f          	j	80004ee0 <_ZN9Scheduler3putEP3TCB+0x44>

0000000080004f1c <_GLOBAL__sub_I__ZN9Scheduler16readyThreadQueueE>:
    80004f1c:	ff010113          	addi	sp,sp,-16
    80004f20:	00113423          	sd	ra,8(sp)
    80004f24:	00813023          	sd	s0,0(sp)
    80004f28:	01010413          	addi	s0,sp,16
    80004f2c:	000105b7          	lui	a1,0x10
    80004f30:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80004f34:	00100513          	li	a0,1
    80004f38:	00000097          	auipc	ra,0x0
    80004f3c:	ea4080e7          	jalr	-348(ra) # 80004ddc <_Z41__static_initialization_and_destruction_0ii>
    80004f40:	00813083          	ld	ra,8(sp)
    80004f44:	00013403          	ld	s0,0(sp)
    80004f48:	01010113          	addi	sp,sp,16
    80004f4c:	00008067          	ret

0000000080004f50 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80004f50:	fe010113          	addi	sp,sp,-32
    80004f54:	00113c23          	sd	ra,24(sp)
    80004f58:	00813823          	sd	s0,16(sp)
    80004f5c:	00913423          	sd	s1,8(sp)
    80004f60:	01213023          	sd	s2,0(sp)
    80004f64:	02010413          	addi	s0,sp,32
    80004f68:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004f6c:	00100793          	li	a5,1
    80004f70:	02a7f863          	bgeu	a5,a0,80004fa0 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80004f74:	00a00793          	li	a5,10
    80004f78:	02f577b3          	remu	a5,a0,a5
    80004f7c:	02078e63          	beqz	a5,80004fb8 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004f80:	fff48513          	addi	a0,s1,-1
    80004f84:	00000097          	auipc	ra,0x0
    80004f88:	fcc080e7          	jalr	-52(ra) # 80004f50 <_ZL9fibonaccim>
    80004f8c:	00050913          	mv	s2,a0
    80004f90:	ffe48513          	addi	a0,s1,-2
    80004f94:	00000097          	auipc	ra,0x0
    80004f98:	fbc080e7          	jalr	-68(ra) # 80004f50 <_ZL9fibonaccim>
    80004f9c:	00a90533          	add	a0,s2,a0
}
    80004fa0:	01813083          	ld	ra,24(sp)
    80004fa4:	01013403          	ld	s0,16(sp)
    80004fa8:	00813483          	ld	s1,8(sp)
    80004fac:	00013903          	ld	s2,0(sp)
    80004fb0:	02010113          	addi	sp,sp,32
    80004fb4:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80004fb8:	ffffc097          	auipc	ra,0xffffc
    80004fbc:	2dc080e7          	jalr	732(ra) # 80001294 <_Z15thread_dispatchv>
    80004fc0:	fc1ff06f          	j	80004f80 <_ZL9fibonaccim+0x30>

0000000080004fc4 <_ZL11workerBodyDPv>:
    printString("C finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80004fc4:	fe010113          	addi	sp,sp,-32
    80004fc8:	00113c23          	sd	ra,24(sp)
    80004fcc:	00813823          	sd	s0,16(sp)
    80004fd0:	00913423          	sd	s1,8(sp)
    80004fd4:	01213023          	sd	s2,0(sp)
    80004fd8:	02010413          	addi	s0,sp,32

    uint8 i = 10;
    80004fdc:	00a00493          	li	s1,10
    80004fe0:	0400006f          	j	80005020 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004fe4:	00004517          	auipc	a0,0x4
    80004fe8:	16450513          	addi	a0,a0,356 # 80009148 <CONSOLE_STATUS+0x138>
    80004fec:	fffff097          	auipc	ra,0xfffff
    80004ff0:	8b0080e7          	jalr	-1872(ra) # 8000389c <_Z11printStringPKc>
    80004ff4:	00000613          	li	a2,0
    80004ff8:	00a00593          	li	a1,10
    80004ffc:	00048513          	mv	a0,s1
    80005000:	fffff097          	auipc	ra,0xfffff
    80005004:	a4c080e7          	jalr	-1460(ra) # 80003a4c <_Z8printIntiii>
    80005008:	00004517          	auipc	a0,0x4
    8000500c:	3a050513          	addi	a0,a0,928 # 800093a8 <CONSOLE_STATUS+0x398>
    80005010:	fffff097          	auipc	ra,0xfffff
    80005014:	88c080e7          	jalr	-1908(ra) # 8000389c <_Z11printStringPKc>
    for (; i < 13; i++) {
    80005018:	0014849b          	addiw	s1,s1,1
    8000501c:	0ff4f493          	andi	s1,s1,255
    80005020:	00c00793          	li	a5,12
    80005024:	fc97f0e3          	bgeu	a5,s1,80004fe4 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80005028:	00004517          	auipc	a0,0x4
    8000502c:	17850513          	addi	a0,a0,376 # 800091a0 <CONSOLE_STATUS+0x190>
    80005030:	fffff097          	auipc	ra,0xfffff
    80005034:	86c080e7          	jalr	-1940(ra) # 8000389c <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80005038:	00500313          	li	t1,5
    thread_dispatch();
    8000503c:	ffffc097          	auipc	ra,0xffffc
    80005040:	258080e7          	jalr	600(ra) # 80001294 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80005044:	01000513          	li	a0,16
    80005048:	00000097          	auipc	ra,0x0
    8000504c:	f08080e7          	jalr	-248(ra) # 80004f50 <_ZL9fibonaccim>
    80005050:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80005054:	00004517          	auipc	a0,0x4
    80005058:	10c50513          	addi	a0,a0,268 # 80009160 <CONSOLE_STATUS+0x150>
    8000505c:	fffff097          	auipc	ra,0xfffff
    80005060:	840080e7          	jalr	-1984(ra) # 8000389c <_Z11printStringPKc>
    80005064:	00000613          	li	a2,0
    80005068:	00a00593          	li	a1,10
    8000506c:	0009051b          	sext.w	a0,s2
    80005070:	fffff097          	auipc	ra,0xfffff
    80005074:	9dc080e7          	jalr	-1572(ra) # 80003a4c <_Z8printIntiii>
    80005078:	00004517          	auipc	a0,0x4
    8000507c:	33050513          	addi	a0,a0,816 # 800093a8 <CONSOLE_STATUS+0x398>
    80005080:	fffff097          	auipc	ra,0xfffff
    80005084:	81c080e7          	jalr	-2020(ra) # 8000389c <_Z11printStringPKc>
    80005088:	0400006f          	j	800050c8 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000508c:	00004517          	auipc	a0,0x4
    80005090:	0bc50513          	addi	a0,a0,188 # 80009148 <CONSOLE_STATUS+0x138>
    80005094:	fffff097          	auipc	ra,0xfffff
    80005098:	808080e7          	jalr	-2040(ra) # 8000389c <_Z11printStringPKc>
    8000509c:	00000613          	li	a2,0
    800050a0:	00a00593          	li	a1,10
    800050a4:	00048513          	mv	a0,s1
    800050a8:	fffff097          	auipc	ra,0xfffff
    800050ac:	9a4080e7          	jalr	-1628(ra) # 80003a4c <_Z8printIntiii>
    800050b0:	00004517          	auipc	a0,0x4
    800050b4:	2f850513          	addi	a0,a0,760 # 800093a8 <CONSOLE_STATUS+0x398>
    800050b8:	ffffe097          	auipc	ra,0xffffe
    800050bc:	7e4080e7          	jalr	2020(ra) # 8000389c <_Z11printStringPKc>
    for (; i < 16; i++) {
    800050c0:	0014849b          	addiw	s1,s1,1
    800050c4:	0ff4f493          	andi	s1,s1,255
    800050c8:	00f00793          	li	a5,15
    800050cc:	fc97f0e3          	bgeu	a5,s1,8000508c <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    800050d0:	00004517          	auipc	a0,0x4
    800050d4:	0e050513          	addi	a0,a0,224 # 800091b0 <CONSOLE_STATUS+0x1a0>
    800050d8:	ffffe097          	auipc	ra,0xffffe
    800050dc:	7c4080e7          	jalr	1988(ra) # 8000389c <_Z11printStringPKc>
    finishedD = true;
    800050e0:	00100793          	li	a5,1
    800050e4:	00006717          	auipc	a4,0x6
    800050e8:	54f70e23          	sb	a5,1372(a4) # 8000b640 <_ZL9finishedD>
    thread_dispatch();
    800050ec:	ffffc097          	auipc	ra,0xffffc
    800050f0:	1a8080e7          	jalr	424(ra) # 80001294 <_Z15thread_dispatchv>
}
    800050f4:	01813083          	ld	ra,24(sp)
    800050f8:	01013403          	ld	s0,16(sp)
    800050fc:	00813483          	ld	s1,8(sp)
    80005100:	00013903          	ld	s2,0(sp)
    80005104:	02010113          	addi	sp,sp,32
    80005108:	00008067          	ret

000000008000510c <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    8000510c:	fe010113          	addi	sp,sp,-32
    80005110:	00113c23          	sd	ra,24(sp)
    80005114:	00813823          	sd	s0,16(sp)
    80005118:	00913423          	sd	s1,8(sp)
    8000511c:	01213023          	sd	s2,0(sp)
    80005120:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80005124:	00000493          	li	s1,0
    80005128:	0400006f          	j	80005168 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    8000512c:	00004517          	auipc	a0,0x4
    80005130:	fec50513          	addi	a0,a0,-20 # 80009118 <CONSOLE_STATUS+0x108>
    80005134:	ffffe097          	auipc	ra,0xffffe
    80005138:	768080e7          	jalr	1896(ra) # 8000389c <_Z11printStringPKc>
    8000513c:	00000613          	li	a2,0
    80005140:	00a00593          	li	a1,10
    80005144:	00048513          	mv	a0,s1
    80005148:	fffff097          	auipc	ra,0xfffff
    8000514c:	904080e7          	jalr	-1788(ra) # 80003a4c <_Z8printIntiii>
    80005150:	00004517          	auipc	a0,0x4
    80005154:	25850513          	addi	a0,a0,600 # 800093a8 <CONSOLE_STATUS+0x398>
    80005158:	ffffe097          	auipc	ra,0xffffe
    8000515c:	744080e7          	jalr	1860(ra) # 8000389c <_Z11printStringPKc>
    for (; i < 3; i++) {
    80005160:	0014849b          	addiw	s1,s1,1
    80005164:	0ff4f493          	andi	s1,s1,255
    80005168:	00200793          	li	a5,2
    8000516c:	fc97f0e3          	bgeu	a5,s1,8000512c <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80005170:	00004517          	auipc	a0,0x4
    80005174:	02050513          	addi	a0,a0,32 # 80009190 <CONSOLE_STATUS+0x180>
    80005178:	ffffe097          	auipc	ra,0xffffe
    8000517c:	724080e7          	jalr	1828(ra) # 8000389c <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80005180:	00700313          	li	t1,7
    thread_dispatch();
    80005184:	ffffc097          	auipc	ra,0xffffc
    80005188:	110080e7          	jalr	272(ra) # 80001294 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    8000518c:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80005190:	00004517          	auipc	a0,0x4
    80005194:	fa050513          	addi	a0,a0,-96 # 80009130 <CONSOLE_STATUS+0x120>
    80005198:	ffffe097          	auipc	ra,0xffffe
    8000519c:	704080e7          	jalr	1796(ra) # 8000389c <_Z11printStringPKc>
    800051a0:	00000613          	li	a2,0
    800051a4:	00a00593          	li	a1,10
    800051a8:	0009051b          	sext.w	a0,s2
    800051ac:	fffff097          	auipc	ra,0xfffff
    800051b0:	8a0080e7          	jalr	-1888(ra) # 80003a4c <_Z8printIntiii>
    800051b4:	00004517          	auipc	a0,0x4
    800051b8:	1f450513          	addi	a0,a0,500 # 800093a8 <CONSOLE_STATUS+0x398>
    800051bc:	ffffe097          	auipc	ra,0xffffe
    800051c0:	6e0080e7          	jalr	1760(ra) # 8000389c <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    800051c4:	00c00513          	li	a0,12
    800051c8:	00000097          	auipc	ra,0x0
    800051cc:	d88080e7          	jalr	-632(ra) # 80004f50 <_ZL9fibonaccim>
    800051d0:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800051d4:	00004517          	auipc	a0,0x4
    800051d8:	f6450513          	addi	a0,a0,-156 # 80009138 <CONSOLE_STATUS+0x128>
    800051dc:	ffffe097          	auipc	ra,0xffffe
    800051e0:	6c0080e7          	jalr	1728(ra) # 8000389c <_Z11printStringPKc>
    800051e4:	00000613          	li	a2,0
    800051e8:	00a00593          	li	a1,10
    800051ec:	0009051b          	sext.w	a0,s2
    800051f0:	fffff097          	auipc	ra,0xfffff
    800051f4:	85c080e7          	jalr	-1956(ra) # 80003a4c <_Z8printIntiii>
    800051f8:	00004517          	auipc	a0,0x4
    800051fc:	1b050513          	addi	a0,a0,432 # 800093a8 <CONSOLE_STATUS+0x398>
    80005200:	ffffe097          	auipc	ra,0xffffe
    80005204:	69c080e7          	jalr	1692(ra) # 8000389c <_Z11printStringPKc>
    80005208:	0400006f          	j	80005248 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    8000520c:	00004517          	auipc	a0,0x4
    80005210:	f0c50513          	addi	a0,a0,-244 # 80009118 <CONSOLE_STATUS+0x108>
    80005214:	ffffe097          	auipc	ra,0xffffe
    80005218:	688080e7          	jalr	1672(ra) # 8000389c <_Z11printStringPKc>
    8000521c:	00000613          	li	a2,0
    80005220:	00a00593          	li	a1,10
    80005224:	00048513          	mv	a0,s1
    80005228:	fffff097          	auipc	ra,0xfffff
    8000522c:	824080e7          	jalr	-2012(ra) # 80003a4c <_Z8printIntiii>
    80005230:	00004517          	auipc	a0,0x4
    80005234:	17850513          	addi	a0,a0,376 # 800093a8 <CONSOLE_STATUS+0x398>
    80005238:	ffffe097          	auipc	ra,0xffffe
    8000523c:	664080e7          	jalr	1636(ra) # 8000389c <_Z11printStringPKc>
    for (; i < 6; i++) {
    80005240:	0014849b          	addiw	s1,s1,1
    80005244:	0ff4f493          	andi	s1,s1,255
    80005248:	00500793          	li	a5,5
    8000524c:	fc97f0e3          	bgeu	a5,s1,8000520c <_ZL11workerBodyCPv+0x100>
    printString("C finished!\n");
    80005250:	00004517          	auipc	a0,0x4
    80005254:	25050513          	addi	a0,a0,592 # 800094a0 <CONSOLE_STATUS+0x490>
    80005258:	ffffe097          	auipc	ra,0xffffe
    8000525c:	644080e7          	jalr	1604(ra) # 8000389c <_Z11printStringPKc>
    finishedC = true;
    80005260:	00100793          	li	a5,1
    80005264:	00006717          	auipc	a4,0x6
    80005268:	3cf70ea3          	sb	a5,989(a4) # 8000b641 <_ZL9finishedC>
    thread_dispatch();
    8000526c:	ffffc097          	auipc	ra,0xffffc
    80005270:	028080e7          	jalr	40(ra) # 80001294 <_Z15thread_dispatchv>
}
    80005274:	01813083          	ld	ra,24(sp)
    80005278:	01013403          	ld	s0,16(sp)
    8000527c:	00813483          	ld	s1,8(sp)
    80005280:	00013903          	ld	s2,0(sp)
    80005284:	02010113          	addi	sp,sp,32
    80005288:	00008067          	ret

000000008000528c <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    8000528c:	fe010113          	addi	sp,sp,-32
    80005290:	00113c23          	sd	ra,24(sp)
    80005294:	00813823          	sd	s0,16(sp)
    80005298:	00913423          	sd	s1,8(sp)
    8000529c:	01213023          	sd	s2,0(sp)
    800052a0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800052a4:	00000913          	li	s2,0
    800052a8:	0400006f          	j	800052e8 <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    800052ac:	ffffc097          	auipc	ra,0xffffc
    800052b0:	fe8080e7          	jalr	-24(ra) # 80001294 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800052b4:	00148493          	addi	s1,s1,1
    800052b8:	000027b7          	lui	a5,0x2
    800052bc:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800052c0:	0097ee63          	bltu	a5,s1,800052dc <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800052c4:	00000713          	li	a4,0
    800052c8:	000077b7          	lui	a5,0x7
    800052cc:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800052d0:	fce7eee3          	bltu	a5,a4,800052ac <_ZL11workerBodyBPv+0x20>
    800052d4:	00170713          	addi	a4,a4,1
    800052d8:	ff1ff06f          	j	800052c8 <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    800052dc:	00a00793          	li	a5,10
    800052e0:	04f90663          	beq	s2,a5,8000532c <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    800052e4:	00190913          	addi	s2,s2,1
    800052e8:	00f00793          	li	a5,15
    800052ec:	0527e463          	bltu	a5,s2,80005334 <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    800052f0:	00004517          	auipc	a0,0x4
    800052f4:	e2050513          	addi	a0,a0,-480 # 80009110 <CONSOLE_STATUS+0x100>
    800052f8:	ffffe097          	auipc	ra,0xffffe
    800052fc:	5a4080e7          	jalr	1444(ra) # 8000389c <_Z11printStringPKc>
    80005300:	00000613          	li	a2,0
    80005304:	00a00593          	li	a1,10
    80005308:	0009051b          	sext.w	a0,s2
    8000530c:	ffffe097          	auipc	ra,0xffffe
    80005310:	740080e7          	jalr	1856(ra) # 80003a4c <_Z8printIntiii>
    80005314:	00004517          	auipc	a0,0x4
    80005318:	09450513          	addi	a0,a0,148 # 800093a8 <CONSOLE_STATUS+0x398>
    8000531c:	ffffe097          	auipc	ra,0xffffe
    80005320:	580080e7          	jalr	1408(ra) # 8000389c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005324:	00000493          	li	s1,0
    80005328:	f91ff06f          	j	800052b8 <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    8000532c:	14102ff3          	csrr	t6,sepc
    80005330:	fb5ff06f          	j	800052e4 <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    80005334:	00004517          	auipc	a0,0x4
    80005338:	e4c50513          	addi	a0,a0,-436 # 80009180 <CONSOLE_STATUS+0x170>
    8000533c:	ffffe097          	auipc	ra,0xffffe
    80005340:	560080e7          	jalr	1376(ra) # 8000389c <_Z11printStringPKc>
    finishedB = true;
    80005344:	00100793          	li	a5,1
    80005348:	00006717          	auipc	a4,0x6
    8000534c:	2ef70d23          	sb	a5,762(a4) # 8000b642 <_ZL9finishedB>
    thread_dispatch();
    80005350:	ffffc097          	auipc	ra,0xffffc
    80005354:	f44080e7          	jalr	-188(ra) # 80001294 <_Z15thread_dispatchv>
}
    80005358:	01813083          	ld	ra,24(sp)
    8000535c:	01013403          	ld	s0,16(sp)
    80005360:	00813483          	ld	s1,8(sp)
    80005364:	00013903          	ld	s2,0(sp)
    80005368:	02010113          	addi	sp,sp,32
    8000536c:	00008067          	ret

0000000080005370 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80005370:	fe010113          	addi	sp,sp,-32
    80005374:	00113c23          	sd	ra,24(sp)
    80005378:	00813823          	sd	s0,16(sp)
    8000537c:	00913423          	sd	s1,8(sp)
    80005380:	01213023          	sd	s2,0(sp)
    80005384:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80005388:	00000913          	li	s2,0
    8000538c:	0380006f          	j	800053c4 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80005390:	ffffc097          	auipc	ra,0xffffc
    80005394:	f04080e7          	jalr	-252(ra) # 80001294 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005398:	00148493          	addi	s1,s1,1
    8000539c:	000027b7          	lui	a5,0x2
    800053a0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800053a4:	0097ee63          	bltu	a5,s1,800053c0 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800053a8:	00000713          	li	a4,0
    800053ac:	000077b7          	lui	a5,0x7
    800053b0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800053b4:	fce7eee3          	bltu	a5,a4,80005390 <_ZL11workerBodyAPv+0x20>
    800053b8:	00170713          	addi	a4,a4,1
    800053bc:	ff1ff06f          	j	800053ac <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800053c0:	00190913          	addi	s2,s2,1
    800053c4:	00900793          	li	a5,9
    800053c8:	0527e063          	bltu	a5,s2,80005408 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800053cc:	00004517          	auipc	a0,0x4
    800053d0:	d3c50513          	addi	a0,a0,-708 # 80009108 <CONSOLE_STATUS+0xf8>
    800053d4:	ffffe097          	auipc	ra,0xffffe
    800053d8:	4c8080e7          	jalr	1224(ra) # 8000389c <_Z11printStringPKc>
    800053dc:	00000613          	li	a2,0
    800053e0:	00a00593          	li	a1,10
    800053e4:	0009051b          	sext.w	a0,s2
    800053e8:	ffffe097          	auipc	ra,0xffffe
    800053ec:	664080e7          	jalr	1636(ra) # 80003a4c <_Z8printIntiii>
    800053f0:	00004517          	auipc	a0,0x4
    800053f4:	fb850513          	addi	a0,a0,-72 # 800093a8 <CONSOLE_STATUS+0x398>
    800053f8:	ffffe097          	auipc	ra,0xffffe
    800053fc:	4a4080e7          	jalr	1188(ra) # 8000389c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005400:	00000493          	li	s1,0
    80005404:	f99ff06f          	j	8000539c <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80005408:	00004517          	auipc	a0,0x4
    8000540c:	d6850513          	addi	a0,a0,-664 # 80009170 <CONSOLE_STATUS+0x160>
    80005410:	ffffe097          	auipc	ra,0xffffe
    80005414:	48c080e7          	jalr	1164(ra) # 8000389c <_Z11printStringPKc>
    finishedA = true;
    80005418:	00100793          	li	a5,1
    8000541c:	00006717          	auipc	a4,0x6
    80005420:	22f703a3          	sb	a5,551(a4) # 8000b643 <_ZL9finishedA>
}
    80005424:	01813083          	ld	ra,24(sp)
    80005428:	01013403          	ld	s0,16(sp)
    8000542c:	00813483          	ld	s1,8(sp)
    80005430:	00013903          	ld	s2,0(sp)
    80005434:	02010113          	addi	sp,sp,32
    80005438:	00008067          	ret

000000008000543c <_Z16System_Mode_testv>:


void System_Mode_test() {
    8000543c:	fd010113          	addi	sp,sp,-48
    80005440:	02113423          	sd	ra,40(sp)
    80005444:	02813023          	sd	s0,32(sp)
    80005448:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    8000544c:	00000613          	li	a2,0
    80005450:	00000597          	auipc	a1,0x0
    80005454:	f2058593          	addi	a1,a1,-224 # 80005370 <_ZL11workerBodyAPv>
    80005458:	fd040513          	addi	a0,s0,-48
    8000545c:	ffffc097          	auipc	ra,0xffffc
    80005460:	d78080e7          	jalr	-648(ra) # 800011d4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadA created\n");
    80005464:	00004517          	auipc	a0,0x4
    80005468:	d5c50513          	addi	a0,a0,-676 # 800091c0 <CONSOLE_STATUS+0x1b0>
    8000546c:	ffffe097          	auipc	ra,0xffffe
    80005470:	430080e7          	jalr	1072(ra) # 8000389c <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80005474:	00000613          	li	a2,0
    80005478:	00000597          	auipc	a1,0x0
    8000547c:	e1458593          	addi	a1,a1,-492 # 8000528c <_ZL11workerBodyBPv>
    80005480:	fd840513          	addi	a0,s0,-40
    80005484:	ffffc097          	auipc	ra,0xffffc
    80005488:	d50080e7          	jalr	-688(ra) # 800011d4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadB created\n");
    8000548c:	00004517          	auipc	a0,0x4
    80005490:	d4c50513          	addi	a0,a0,-692 # 800091d8 <CONSOLE_STATUS+0x1c8>
    80005494:	ffffe097          	auipc	ra,0xffffe
    80005498:	408080e7          	jalr	1032(ra) # 8000389c <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    8000549c:	00000613          	li	a2,0
    800054a0:	00000597          	auipc	a1,0x0
    800054a4:	c6c58593          	addi	a1,a1,-916 # 8000510c <_ZL11workerBodyCPv>
    800054a8:	fe040513          	addi	a0,s0,-32
    800054ac:	ffffc097          	auipc	ra,0xffffc
    800054b0:	d28080e7          	jalr	-728(ra) # 800011d4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadC created\n");
    800054b4:	00004517          	auipc	a0,0x4
    800054b8:	d3c50513          	addi	a0,a0,-708 # 800091f0 <CONSOLE_STATUS+0x1e0>
    800054bc:	ffffe097          	auipc	ra,0xffffe
    800054c0:	3e0080e7          	jalr	992(ra) # 8000389c <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    800054c4:	00000613          	li	a2,0
    800054c8:	00000597          	auipc	a1,0x0
    800054cc:	afc58593          	addi	a1,a1,-1284 # 80004fc4 <_ZL11workerBodyDPv>
    800054d0:	fe840513          	addi	a0,s0,-24
    800054d4:	ffffc097          	auipc	ra,0xffffc
    800054d8:	d00080e7          	jalr	-768(ra) # 800011d4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadD created\n");
    800054dc:	00004517          	auipc	a0,0x4
    800054e0:	d2c50513          	addi	a0,a0,-724 # 80009208 <CONSOLE_STATUS+0x1f8>
    800054e4:	ffffe097          	auipc	ra,0xffffe
    800054e8:	3b8080e7          	jalr	952(ra) # 8000389c <_Z11printStringPKc>
    800054ec:	00c0006f          	j	800054f8 <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800054f0:	ffffc097          	auipc	ra,0xffffc
    800054f4:	da4080e7          	jalr	-604(ra) # 80001294 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800054f8:	00006797          	auipc	a5,0x6
    800054fc:	14b7c783          	lbu	a5,331(a5) # 8000b643 <_ZL9finishedA>
    80005500:	fe0788e3          	beqz	a5,800054f0 <_Z16System_Mode_testv+0xb4>
    80005504:	00006797          	auipc	a5,0x6
    80005508:	13e7c783          	lbu	a5,318(a5) # 8000b642 <_ZL9finishedB>
    8000550c:	fe0782e3          	beqz	a5,800054f0 <_Z16System_Mode_testv+0xb4>
    80005510:	00006797          	auipc	a5,0x6
    80005514:	1317c783          	lbu	a5,305(a5) # 8000b641 <_ZL9finishedC>
    80005518:	fc078ce3          	beqz	a5,800054f0 <_Z16System_Mode_testv+0xb4>
    8000551c:	00006797          	auipc	a5,0x6
    80005520:	1247c783          	lbu	a5,292(a5) # 8000b640 <_ZL9finishedD>
    80005524:	fc0786e3          	beqz	a5,800054f0 <_Z16System_Mode_testv+0xb4>
    }

}
    80005528:	02813083          	ld	ra,40(sp)
    8000552c:	02013403          	ld	s0,32(sp)
    80005530:	03010113          	addi	sp,sp,48
    80005534:	00008067          	ret

0000000080005538 <_ZN15MemoryAllocator8mem_initEv>:

    return instance;
}

void MemoryAllocator::mem_init()
{
    80005538:	ff010113          	addi	sp,sp,-16
    8000553c:	00813423          	sd	s0,8(sp)
    80005540:	01010413          	addi	s0,sp,16

    FreeMemHead = (FreeMemBlockHeader*) HEAP_START_ADDR;
    80005544:	00006697          	auipc	a3,0x6
    80005548:	02c6b683          	ld	a3,44(a3) # 8000b570 <_GLOBAL_OFFSET_TABLE_+0x8>
    8000554c:	0006b703          	ld	a4,0(a3)
    80005550:	00006797          	auipc	a5,0x6
    80005554:	0f878793          	addi	a5,a5,248 # 8000b648 <_ZN15MemoryAllocator11FreeMemHeadE>
    80005558:	00e7b023          	sd	a4,0(a5)
    FreeMemHead->next = nullptr;
    8000555c:	00073023          	sd	zero,0(a4)
    FreeMemHead->prev = nullptr;
    80005560:	0007b703          	ld	a4,0(a5)
    80005564:	00073423          	sd	zero,8(a4)
    FreeMemHead->size = ((char*) HEAP_END_ADDR - 1 - (char*)HEAP_START_ADDR);
    80005568:	00006797          	auipc	a5,0x6
    8000556c:	0287b783          	ld	a5,40(a5) # 8000b590 <_GLOBAL_OFFSET_TABLE_+0x28>
    80005570:	0007b783          	ld	a5,0(a5)
    80005574:	fff78793          	addi	a5,a5,-1
    80005578:	0006b683          	ld	a3,0(a3)
    8000557c:	40d787b3          	sub	a5,a5,a3
    80005580:	00f73823          	sd	a5,16(a4)
}
    80005584:	00813403          	ld	s0,8(sp)
    80005588:	01010113          	addi	sp,sp,16
    8000558c:	00008067          	ret

0000000080005590 <_ZN15MemoryAllocator9mem_allocEm>:

void *MemoryAllocator::mem_alloc(size_t size)
{
    80005590:	ff010113          	addi	sp,sp,-16
    80005594:	00813423          	sd	s0,8(sp)
    80005598:	01010413          	addi	s0,sp,16
  //  printInteger((uint64) FreeMemHead);
  // if(size <= 0) return nullptr;


   size = size * MEM_BLOCK_SIZE + sizeof(FreeMemBlockHeader);
    8000559c:	00651713          	slli	a4,a0,0x6
    800055a0:	01870713          	addi	a4,a4,24
    //printInteger((uint64 ) FreeMemHead);
   FreeMemBlockHeader* current = FreeMemHead;
    800055a4:	00006517          	auipc	a0,0x6
    800055a8:	0a453503          	ld	a0,164(a0) # 8000b648 <_ZN15MemoryAllocator11FreeMemHeadE>
   bool found = false;

   for(; current != nullptr; current = current->next)
    800055ac:	00050a63          	beqz	a0,800055c0 <_ZN15MemoryAllocator9mem_allocEm+0x30>
   {
       if(current->size >= size)
    800055b0:	01053783          	ld	a5,16(a0)
    800055b4:	06e7f263          	bgeu	a5,a4,80005618 <_ZN15MemoryAllocator9mem_allocEm+0x88>
   for(; current != nullptr; current = current->next)
    800055b8:	00053503          	ld	a0,0(a0)
    800055bc:	ff1ff06f          	j	800055ac <_ZN15MemoryAllocator9mem_allocEm+0x1c>
   bool found = false;
    800055c0:	00000793          	li	a5,0
           found = true;
           break;
       }
   }

   if(!found) return nullptr;
    800055c4:	08078e63          	beqz	a5,80005660 <_ZN15MemoryAllocator9mem_allocEm+0xd0>

   size_t remaining = current->size - size;
    800055c8:	01053783          	ld	a5,16(a0)
    800055cc:	40e787b3          	sub	a5,a5,a4

   if(remaining >= MEM_BLOCK_SIZE + sizeof(FreeMemBlockHeader))
    800055d0:	05700693          	li	a3,87
    800055d4:	04f6fc63          	bgeu	a3,a5,8000562c <_ZN15MemoryAllocator9mem_allocEm+0x9c>
   {

        current->size = size;
    800055d8:	00e53823          	sd	a4,16(a0)
        size_t offset  = size;
        FreeMemBlockHeader* newFreeMemBlockHeader = (FreeMemBlockHeader*) ((char*) current + offset);
    800055dc:	00e50733          	add	a4,a0,a4
        if(current->prev)
    800055e0:	00853683          	ld	a3,8(a0)
    800055e4:	02068e63          	beqz	a3,80005620 <_ZN15MemoryAllocator9mem_allocEm+0x90>
        {
            current->prev->next = newFreeMemBlockHeader;
    800055e8:	00e6b023          	sd	a4,0(a3)
            FreeMemHead = newFreeMemBlockHeader;
        }

       // printInteger((uint64) current);
       // printInteger((uint64) newFreeMemBlockHeader);
        newFreeMemBlockHeader->next = current->next;
    800055ec:	00053683          	ld	a3,0(a0)
    800055f0:	00d73023          	sd	a3,0(a4)
        newFreeMemBlockHeader->prev = current->prev;
    800055f4:	00853683          	ld	a3,8(a0)
    800055f8:	00d73423          	sd	a3,8(a4)
        //printInteger((uint64) newFreeMemBlockHeader);

        newFreeMemBlockHeader->size = remaining;
    800055fc:	00f73823          	sd	a5,16(a4)
           current->next->prev = current->prev;
       }

   }

   current->next = nullptr;
    80005600:	00053023          	sd	zero,0(a0)
   current->prev = nullptr;
    80005604:	00053423          	sd	zero,8(a0)

   return (char*) current + sizeof(FreeMemBlockHeader);
    80005608:	01850513          	addi	a0,a0,24

}
    8000560c:	00813403          	ld	s0,8(sp)
    80005610:	01010113          	addi	sp,sp,16
    80005614:	00008067          	ret
           found = true;
    80005618:	00100793          	li	a5,1
    8000561c:	fa9ff06f          	j	800055c4 <_ZN15MemoryAllocator9mem_allocEm+0x34>
            FreeMemHead = newFreeMemBlockHeader;
    80005620:	00006697          	auipc	a3,0x6
    80005624:	02e6b423          	sd	a4,40(a3) # 8000b648 <_ZN15MemoryAllocator11FreeMemHeadE>
    80005628:	fc5ff06f          	j	800055ec <_ZN15MemoryAllocator9mem_allocEm+0x5c>
       if(current->prev)
    8000562c:	00853783          	ld	a5,8(a0)
    80005630:	02078063          	beqz	a5,80005650 <_ZN15MemoryAllocator9mem_allocEm+0xc0>
           current->prev->next = current->next;
    80005634:	00053703          	ld	a4,0(a0)
    80005638:	00e7b023          	sd	a4,0(a5)
       if(current->next)
    8000563c:	00053783          	ld	a5,0(a0)
    80005640:	fc0780e3          	beqz	a5,80005600 <_ZN15MemoryAllocator9mem_allocEm+0x70>
           current->next->prev = current->prev;
    80005644:	00853703          	ld	a4,8(a0)
    80005648:	00e7b423          	sd	a4,8(a5)
    8000564c:	fb5ff06f          	j	80005600 <_ZN15MemoryAllocator9mem_allocEm+0x70>
           FreeMemHead = current->next;
    80005650:	00053783          	ld	a5,0(a0)
    80005654:	00006717          	auipc	a4,0x6
    80005658:	fef73a23          	sd	a5,-12(a4) # 8000b648 <_ZN15MemoryAllocator11FreeMemHeadE>
    8000565c:	fe1ff06f          	j	8000563c <_ZN15MemoryAllocator9mem_allocEm+0xac>
   if(!found) return nullptr;
    80005660:	00000513          	li	a0,0
    80005664:	fa9ff06f          	j	8000560c <_ZN15MemoryAllocator9mem_allocEm+0x7c>

0000000080005668 <_ZN15MemoryAllocator11getInstanceEv>:
    if(instance == nullptr)
    80005668:	00006797          	auipc	a5,0x6
    8000566c:	fe87b783          	ld	a5,-24(a5) # 8000b650 <_ZN15MemoryAllocator8instanceE>
    80005670:	00078863          	beqz	a5,80005680 <_ZN15MemoryAllocator11getInstanceEv+0x18>
}
    80005674:	00006517          	auipc	a0,0x6
    80005678:	fdc53503          	ld	a0,-36(a0) # 8000b650 <_ZN15MemoryAllocator8instanceE>
    8000567c:	00008067          	ret
{
    80005680:	ff010113          	addi	sp,sp,-16
    80005684:	00113423          	sd	ra,8(sp)
    80005688:	00813023          	sd	s0,0(sp)
    8000568c:	01010413          	addi	s0,sp,16
        mem_init();
    80005690:	00000097          	auipc	ra,0x0
    80005694:	ea8080e7          	jalr	-344(ra) # 80005538 <_ZN15MemoryAllocator8mem_initEv>
        instance = (MemoryAllocator*) MemoryAllocator::mem_alloc((sizeof(instance) + MEM_BLOCK_SIZE - 1)/ MEM_BLOCK_SIZE);
    80005698:	00100513          	li	a0,1
    8000569c:	00000097          	auipc	ra,0x0
    800056a0:	ef4080e7          	jalr	-268(ra) # 80005590 <_ZN15MemoryAllocator9mem_allocEm>
    800056a4:	00006797          	auipc	a5,0x6
    800056a8:	faa7b623          	sd	a0,-84(a5) # 8000b650 <_ZN15MemoryAllocator8instanceE>
}
    800056ac:	00006517          	auipc	a0,0x6
    800056b0:	fa453503          	ld	a0,-92(a0) # 8000b650 <_ZN15MemoryAllocator8instanceE>
    800056b4:	00813083          	ld	ra,8(sp)
    800056b8:	00013403          	ld	s0,0(sp)
    800056bc:	01010113          	addi	sp,sp,16
    800056c0:	00008067          	ret

00000000800056c4 <_ZN15MemoryAllocator9tryToJoinEPNS_18FreeMemBlockHeaderE>:

    return 0;
}

void MemoryAllocator::tryToJoin(MemoryAllocator::FreeMemBlockHeader *block)
{
    800056c4:	ff010113          	addi	sp,sp,-16
    800056c8:	00813423          	sd	s0,8(sp)
    800056cc:	01010413          	addi	s0,sp,16
    if(!block) return;
    800056d0:	00050c63          	beqz	a0,800056e8 <_ZN15MemoryAllocator9tryToJoinEPNS_18FreeMemBlockHeaderE+0x24>
   // printString("\n BLSIZE next:");
   // printInteger((uint64) (block->size));
   // printString("\n");


    if(block->next && (((char*)((char*) block + block->size)) == (char*) (block->next)))
    800056d4:	00053783          	ld	a5,0(a0)
    800056d8:	00078863          	beqz	a5,800056e8 <_ZN15MemoryAllocator9tryToJoinEPNS_18FreeMemBlockHeaderE+0x24>
    800056dc:	01053703          	ld	a4,16(a0)
    800056e0:	00e506b3          	add	a3,a0,a4
    800056e4:	00d78863          	beq	a5,a3,800056f4 <_ZN15MemoryAllocator9tryToJoinEPNS_18FreeMemBlockHeaderE+0x30>
       //printInteger((uint64) block->size);
       //printString("\n");
        block->next = block->next->next;
        if(block->next) block->next->prev = block;
    }
}
    800056e8:	00813403          	ld	s0,8(sp)
    800056ec:	01010113          	addi	sp,sp,16
    800056f0:	00008067          	ret
        block->size = block->size + block->next->size;
    800056f4:	0107b683          	ld	a3,16(a5)
    800056f8:	00d70733          	add	a4,a4,a3
    800056fc:	00e53823          	sd	a4,16(a0)
        block->next = block->next->next;
    80005700:	0007b783          	ld	a5,0(a5)
    80005704:	00f53023          	sd	a5,0(a0)
        if(block->next) block->next->prev = block;
    80005708:	fe0780e3          	beqz	a5,800056e8 <_ZN15MemoryAllocator9tryToJoinEPNS_18FreeMemBlockHeaderE+0x24>
    8000570c:	00a7b423          	sd	a0,8(a5)
    80005710:	fd9ff06f          	j	800056e8 <_ZN15MemoryAllocator9tryToJoinEPNS_18FreeMemBlockHeaderE+0x24>

0000000080005714 <_ZN15MemoryAllocator8mem_freeEPv>:
    if(addr == nullptr)
    80005714:	0c050663          	beqz	a0,800057e0 <_ZN15MemoryAllocator8mem_freeEPv+0xcc>
    80005718:	00050713          	mv	a4,a0
    FreeMemBlockHeader* address = (FreeMemBlockHeader*) ((char*) addr - sizeof(FreeMemBlockHeader));
    8000571c:	fe850513          	addi	a0,a0,-24
    if(FreeMemHead == nullptr)
    80005720:	00006797          	auipc	a5,0x6
    80005724:	f287b783          	ld	a5,-216(a5) # 8000b648 <_ZN15MemoryAllocator11FreeMemHeadE>
    80005728:	04078063          	beqz	a5,80005768 <_ZN15MemoryAllocator8mem_freeEPv+0x54>
{
    8000572c:	fe010113          	addi	sp,sp,-32
    80005730:	00113c23          	sd	ra,24(sp)
    80005734:	00813823          	sd	s0,16(sp)
    80005738:	00913423          	sd	s1,8(sp)
    8000573c:	02010413          	addi	s0,sp,32
    if(address < FreeMemHead)
    80005740:	04f56063          	bltu	a0,a5,80005780 <_ZN15MemoryAllocator8mem_freeEPv+0x6c>
        for(; current->next != nullptr && address > current->next; current = current->next);
    80005744:	00078493          	mv	s1,a5
    80005748:	0007b783          	ld	a5,0(a5)
    8000574c:	00078463          	beqz	a5,80005754 <_ZN15MemoryAllocator8mem_freeEPv+0x40>
    80005750:	fea7eae3          	bltu	a5,a0,80005744 <_ZN15MemoryAllocator8mem_freeEPv+0x30>
    address->prev = current;
    80005754:	fe973823          	sd	s1,-16(a4)
    if(current)
    80005758:	02048863          	beqz	s1,80005788 <_ZN15MemoryAllocator8mem_freeEPv+0x74>
        address->next = current->next;
    8000575c:	0004b783          	ld	a5,0(s1)
    80005760:	fef73423          	sd	a5,-24(a4)
    80005764:	0300006f          	j	80005794 <_ZN15MemoryAllocator8mem_freeEPv+0x80>
        FreeMemHead = address;
    80005768:	00006797          	auipc	a5,0x6
    8000576c:	eea7b023          	sd	a0,-288(a5) # 8000b648 <_ZN15MemoryAllocator11FreeMemHeadE>
        FreeMemHead->prev = nullptr;
    80005770:	00053423          	sd	zero,8(a0)
        FreeMemHead->next = nullptr;
    80005774:	fe073423          	sd	zero,-24(a4)
        return 0;
    80005778:	00000513          	li	a0,0
    8000577c:	00008067          	ret
    address->prev = current;
    80005780:	fe073823          	sd	zero,-16(a4)
        current = nullptr;
    80005784:	00000493          	li	s1,0
        address->next = FreeMemHead;
    80005788:	00006797          	auipc	a5,0x6
    8000578c:	ec07b783          	ld	a5,-320(a5) # 8000b648 <_ZN15MemoryAllocator11FreeMemHeadE>
    80005790:	fef73423          	sd	a5,-24(a4)
    if(address->next)
    80005794:	fe873783          	ld	a5,-24(a4)
    80005798:	00078463          	beqz	a5,800057a0 <_ZN15MemoryAllocator8mem_freeEPv+0x8c>
        address->next->prev = address;
    8000579c:	00a7b423          	sd	a0,8(a5)
    if(current)
    800057a0:	02048a63          	beqz	s1,800057d4 <_ZN15MemoryAllocator8mem_freeEPv+0xc0>
        current->next = address;
    800057a4:	00a4b023          	sd	a0,0(s1)
    tryToJoin(address);
    800057a8:	00000097          	auipc	ra,0x0
    800057ac:	f1c080e7          	jalr	-228(ra) # 800056c4 <_ZN15MemoryAllocator9tryToJoinEPNS_18FreeMemBlockHeaderE>
    tryToJoin(current);
    800057b0:	00048513          	mv	a0,s1
    800057b4:	00000097          	auipc	ra,0x0
    800057b8:	f10080e7          	jalr	-240(ra) # 800056c4 <_ZN15MemoryAllocator9tryToJoinEPNS_18FreeMemBlockHeaderE>
    return 0;
    800057bc:	00000513          	li	a0,0
}
    800057c0:	01813083          	ld	ra,24(sp)
    800057c4:	01013403          	ld	s0,16(sp)
    800057c8:	00813483          	ld	s1,8(sp)
    800057cc:	02010113          	addi	sp,sp,32
    800057d0:	00008067          	ret
        FreeMemHead = address;
    800057d4:	00006797          	auipc	a5,0x6
    800057d8:	e6a7ba23          	sd	a0,-396(a5) # 8000b648 <_ZN15MemoryAllocator11FreeMemHeadE>
    800057dc:	fcdff06f          	j	800057a8 <_ZN15MemoryAllocator8mem_freeEPv+0x94>
        return 1;
    800057e0:	00100513          	li	a0,1
}
    800057e4:	00008067          	ret

00000000800057e8 <_ZN6BufferC1Ei>:
#include "../h/buffer.hpp"
#include "../lib/console.h"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800057e8:	fe010113          	addi	sp,sp,-32
    800057ec:	00113c23          	sd	ra,24(sp)
    800057f0:	00813823          	sd	s0,16(sp)
    800057f4:	00913423          	sd	s1,8(sp)
    800057f8:	01213023          	sd	s2,0(sp)
    800057fc:	02010413          	addi	s0,sp,32
    80005800:	00050493          	mv	s1,a0
    80005804:	00058913          	mv	s2,a1
    80005808:	0015879b          	addiw	a5,a1,1
    8000580c:	0007851b          	sext.w	a0,a5
    80005810:	00f4a023          	sw	a5,0(s1)
    80005814:	0004a823          	sw	zero,16(s1)
    80005818:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    8000581c:	00251513          	slli	a0,a0,0x2
    80005820:	ffffc097          	auipc	ra,0xffffc
    80005824:	924080e7          	jalr	-1756(ra) # 80001144 <_Z9mem_allocm>
    80005828:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    8000582c:	00000593          	li	a1,0
    80005830:	02048513          	addi	a0,s1,32
    80005834:	ffffc097          	auipc	ra,0xffffc
    80005838:	af8080e7          	jalr	-1288(ra) # 8000132c <_Z8sem_openPP11MySemaphorej>
    sem_open(&spaceAvailable, _cap);
    8000583c:	00090593          	mv	a1,s2
    80005840:	01848513          	addi	a0,s1,24
    80005844:	ffffc097          	auipc	ra,0xffffc
    80005848:	ae8080e7          	jalr	-1304(ra) # 8000132c <_Z8sem_openPP11MySemaphorej>
    sem_open(&mutexHead, 1);
    8000584c:	00100593          	li	a1,1
    80005850:	02848513          	addi	a0,s1,40
    80005854:	ffffc097          	auipc	ra,0xffffc
    80005858:	ad8080e7          	jalr	-1320(ra) # 8000132c <_Z8sem_openPP11MySemaphorej>
    sem_open(&mutexTail, 1);
    8000585c:	00100593          	li	a1,1
    80005860:	03048513          	addi	a0,s1,48
    80005864:	ffffc097          	auipc	ra,0xffffc
    80005868:	ac8080e7          	jalr	-1336(ra) # 8000132c <_Z8sem_openPP11MySemaphorej>
}
    8000586c:	01813083          	ld	ra,24(sp)
    80005870:	01013403          	ld	s0,16(sp)
    80005874:	00813483          	ld	s1,8(sp)
    80005878:	00013903          	ld	s2,0(sp)
    8000587c:	02010113          	addi	sp,sp,32
    80005880:	00008067          	ret

0000000080005884 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80005884:	fe010113          	addi	sp,sp,-32
    80005888:	00113c23          	sd	ra,24(sp)
    8000588c:	00813823          	sd	s0,16(sp)
    80005890:	00913423          	sd	s1,8(sp)
    80005894:	01213023          	sd	s2,0(sp)
    80005898:	02010413          	addi	s0,sp,32
    8000589c:	00050493          	mv	s1,a0
    800058a0:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    800058a4:	01853503          	ld	a0,24(a0)
    800058a8:	ffffc097          	auipc	ra,0xffffc
    800058ac:	b08080e7          	jalr	-1272(ra) # 800013b0 <_Z8sem_waitP11MySemaphore>

    sem_wait(mutexTail);
    800058b0:	0304b503          	ld	a0,48(s1)
    800058b4:	ffffc097          	auipc	ra,0xffffc
    800058b8:	afc080e7          	jalr	-1284(ra) # 800013b0 <_Z8sem_waitP11MySemaphore>
    buffer[tail] = val;
    800058bc:	0084b783          	ld	a5,8(s1)
    800058c0:	0144a703          	lw	a4,20(s1)
    800058c4:	00271713          	slli	a4,a4,0x2
    800058c8:	00e787b3          	add	a5,a5,a4
    800058cc:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800058d0:	0144a783          	lw	a5,20(s1)
    800058d4:	0017879b          	addiw	a5,a5,1
    800058d8:	0004a703          	lw	a4,0(s1)
    800058dc:	02e7e7bb          	remw	a5,a5,a4
    800058e0:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    800058e4:	0304b503          	ld	a0,48(s1)
    800058e8:	ffffc097          	auipc	ra,0xffffc
    800058ec:	b08080e7          	jalr	-1272(ra) # 800013f0 <_Z10sem_signalP11MySemaphore>

    sem_signal(itemAvailable);
    800058f0:	0204b503          	ld	a0,32(s1)
    800058f4:	ffffc097          	auipc	ra,0xffffc
    800058f8:	afc080e7          	jalr	-1284(ra) # 800013f0 <_Z10sem_signalP11MySemaphore>

}
    800058fc:	01813083          	ld	ra,24(sp)
    80005900:	01013403          	ld	s0,16(sp)
    80005904:	00813483          	ld	s1,8(sp)
    80005908:	00013903          	ld	s2,0(sp)
    8000590c:	02010113          	addi	sp,sp,32
    80005910:	00008067          	ret

0000000080005914 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80005914:	fe010113          	addi	sp,sp,-32
    80005918:	00113c23          	sd	ra,24(sp)
    8000591c:	00813823          	sd	s0,16(sp)
    80005920:	00913423          	sd	s1,8(sp)
    80005924:	01213023          	sd	s2,0(sp)
    80005928:	02010413          	addi	s0,sp,32
    8000592c:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80005930:	02053503          	ld	a0,32(a0)
    80005934:	ffffc097          	auipc	ra,0xffffc
    80005938:	a7c080e7          	jalr	-1412(ra) # 800013b0 <_Z8sem_waitP11MySemaphore>

    sem_wait(mutexHead);
    8000593c:	0284b503          	ld	a0,40(s1)
    80005940:	ffffc097          	auipc	ra,0xffffc
    80005944:	a70080e7          	jalr	-1424(ra) # 800013b0 <_Z8sem_waitP11MySemaphore>

    int ret = buffer[head];
    80005948:	0084b703          	ld	a4,8(s1)
    8000594c:	0104a783          	lw	a5,16(s1)
    80005950:	00279693          	slli	a3,a5,0x2
    80005954:	00d70733          	add	a4,a4,a3
    80005958:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000595c:	0017879b          	addiw	a5,a5,1
    80005960:	0004a703          	lw	a4,0(s1)
    80005964:	02e7e7bb          	remw	a5,a5,a4
    80005968:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    8000596c:	0284b503          	ld	a0,40(s1)
    80005970:	ffffc097          	auipc	ra,0xffffc
    80005974:	a80080e7          	jalr	-1408(ra) # 800013f0 <_Z10sem_signalP11MySemaphore>

    sem_signal(spaceAvailable);
    80005978:	0184b503          	ld	a0,24(s1)
    8000597c:	ffffc097          	auipc	ra,0xffffc
    80005980:	a74080e7          	jalr	-1420(ra) # 800013f0 <_Z10sem_signalP11MySemaphore>

    return ret;
}
    80005984:	00090513          	mv	a0,s2
    80005988:	01813083          	ld	ra,24(sp)
    8000598c:	01013403          	ld	s0,16(sp)
    80005990:	00813483          	ld	s1,8(sp)
    80005994:	00013903          	ld	s2,0(sp)
    80005998:	02010113          	addi	sp,sp,32
    8000599c:	00008067          	ret

00000000800059a0 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    800059a0:	fe010113          	addi	sp,sp,-32
    800059a4:	00113c23          	sd	ra,24(sp)
    800059a8:	00813823          	sd	s0,16(sp)
    800059ac:	00913423          	sd	s1,8(sp)
    800059b0:	01213023          	sd	s2,0(sp)
    800059b4:	02010413          	addi	s0,sp,32
    800059b8:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    800059bc:	02853503          	ld	a0,40(a0)
    800059c0:	ffffc097          	auipc	ra,0xffffc
    800059c4:	9f0080e7          	jalr	-1552(ra) # 800013b0 <_Z8sem_waitP11MySemaphore>
    sem_wait(mutexTail);
    800059c8:	0304b503          	ld	a0,48(s1)
    800059cc:	ffffc097          	auipc	ra,0xffffc
    800059d0:	9e4080e7          	jalr	-1564(ra) # 800013b0 <_Z8sem_waitP11MySemaphore>

    if (tail >= head) {
    800059d4:	0144a783          	lw	a5,20(s1)
    800059d8:	0104a903          	lw	s2,16(s1)
    800059dc:	0327ce63          	blt	a5,s2,80005a18 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    800059e0:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    800059e4:	0304b503          	ld	a0,48(s1)
    800059e8:	ffffc097          	auipc	ra,0xffffc
    800059ec:	a08080e7          	jalr	-1528(ra) # 800013f0 <_Z10sem_signalP11MySemaphore>
    sem_signal(mutexHead);
    800059f0:	0284b503          	ld	a0,40(s1)
    800059f4:	ffffc097          	auipc	ra,0xffffc
    800059f8:	9fc080e7          	jalr	-1540(ra) # 800013f0 <_Z10sem_signalP11MySemaphore>

    return ret;
}
    800059fc:	00090513          	mv	a0,s2
    80005a00:	01813083          	ld	ra,24(sp)
    80005a04:	01013403          	ld	s0,16(sp)
    80005a08:	00813483          	ld	s1,8(sp)
    80005a0c:	00013903          	ld	s2,0(sp)
    80005a10:	02010113          	addi	sp,sp,32
    80005a14:	00008067          	ret
        ret = cap - head + tail;
    80005a18:	0004a703          	lw	a4,0(s1)
    80005a1c:	4127093b          	subw	s2,a4,s2
    80005a20:	00f9093b          	addw	s2,s2,a5
    80005a24:	fc1ff06f          	j	800059e4 <_ZN6Buffer6getCntEv+0x44>

0000000080005a28 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80005a28:	fe010113          	addi	sp,sp,-32
    80005a2c:	00113c23          	sd	ra,24(sp)
    80005a30:	00813823          	sd	s0,16(sp)
    80005a34:	00913423          	sd	s1,8(sp)
    80005a38:	02010413          	addi	s0,sp,32
    80005a3c:	00050493          	mv	s1,a0
    putc('\n');
    80005a40:	00a00513          	li	a0,10
    80005a44:	ffffc097          	auipc	ra,0xffffc
    80005a48:	a68080e7          	jalr	-1432(ra) # 800014ac <_Z4putcc>
    printString("Buffer deleted!\n");
    80005a4c:	00003517          	auipc	a0,0x3
    80005a50:	7d450513          	addi	a0,a0,2004 # 80009220 <CONSOLE_STATUS+0x210>
    80005a54:	ffffe097          	auipc	ra,0xffffe
    80005a58:	e48080e7          	jalr	-440(ra) # 8000389c <_Z11printStringPKc>
    while (getCnt() > 0) {
    80005a5c:	00048513          	mv	a0,s1
    80005a60:	00000097          	auipc	ra,0x0
    80005a64:	f40080e7          	jalr	-192(ra) # 800059a0 <_ZN6Buffer6getCntEv>
    80005a68:	02a05c63          	blez	a0,80005aa0 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80005a6c:	0084b783          	ld	a5,8(s1)
    80005a70:	0104a703          	lw	a4,16(s1)
    80005a74:	00271713          	slli	a4,a4,0x2
    80005a78:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80005a7c:	0007c503          	lbu	a0,0(a5)
    80005a80:	ffffc097          	auipc	ra,0xffffc
    80005a84:	a2c080e7          	jalr	-1492(ra) # 800014ac <_Z4putcc>
        head = (head + 1) % cap;
    80005a88:	0104a783          	lw	a5,16(s1)
    80005a8c:	0017879b          	addiw	a5,a5,1
    80005a90:	0004a703          	lw	a4,0(s1)
    80005a94:	02e7e7bb          	remw	a5,a5,a4
    80005a98:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80005a9c:	fc1ff06f          	j	80005a5c <_ZN6BufferD1Ev+0x34>
    putc('!');
    80005aa0:	02100513          	li	a0,33
    80005aa4:	ffffc097          	auipc	ra,0xffffc
    80005aa8:	a08080e7          	jalr	-1528(ra) # 800014ac <_Z4putcc>
    putc('\n');
    80005aac:	00a00513          	li	a0,10
    80005ab0:	ffffc097          	auipc	ra,0xffffc
    80005ab4:	9fc080e7          	jalr	-1540(ra) # 800014ac <_Z4putcc>
    mem_free(buffer);
    80005ab8:	0084b503          	ld	a0,8(s1)
    80005abc:	ffffb097          	auipc	ra,0xffffb
    80005ac0:	6d8080e7          	jalr	1752(ra) # 80001194 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80005ac4:	0204b503          	ld	a0,32(s1)
    80005ac8:	ffffc097          	auipc	ra,0xffffc
    80005acc:	8a8080e7          	jalr	-1880(ra) # 80001370 <_Z9sem_closeP11MySemaphore>
    sem_close(spaceAvailable);
    80005ad0:	0184b503          	ld	a0,24(s1)
    80005ad4:	ffffc097          	auipc	ra,0xffffc
    80005ad8:	89c080e7          	jalr	-1892(ra) # 80001370 <_Z9sem_closeP11MySemaphore>
    sem_close(mutexTail);
    80005adc:	0304b503          	ld	a0,48(s1)
    80005ae0:	ffffc097          	auipc	ra,0xffffc
    80005ae4:	890080e7          	jalr	-1904(ra) # 80001370 <_Z9sem_closeP11MySemaphore>
    sem_close(mutexHead);
    80005ae8:	0284b503          	ld	a0,40(s1)
    80005aec:	ffffc097          	auipc	ra,0xffffc
    80005af0:	884080e7          	jalr	-1916(ra) # 80001370 <_Z9sem_closeP11MySemaphore>
}
    80005af4:	01813083          	ld	ra,24(sp)
    80005af8:	01013403          	ld	s0,16(sp)
    80005afc:	00813483          	ld	s1,8(sp)
    80005b00:	02010113          	addi	sp,sp,32
    80005b04:	00008067          	ret

0000000080005b08 <_ZN8WorkerA112workerBodyA1EPv>:
        workerBodyC1(nullptr);
    }
};

void WorkerA1::workerBodyA1(void *arg)
{
    80005b08:	fc010113          	addi	sp,sp,-64
    80005b0c:	02113c23          	sd	ra,56(sp)
    80005b10:	02813823          	sd	s0,48(sp)
    80005b14:	02913423          	sd	s1,40(sp)
    80005b18:	03213023          	sd	s2,32(sp)
    80005b1c:	01313c23          	sd	s3,24(sp)
    80005b20:	01413823          	sd	s4,16(sp)
    80005b24:	04010413          	addi	s0,sp,64
    80005b28:	00050a13          	mv	s4,a0
    char m1[] = "A -> B";
    80005b2c:	3e2d2937          	lui	s2,0x3e2d2
    80005b30:	0419091b          	addiw	s2,s2,65
    80005b34:	fd242423          	sw	s2,-56(s0)
    80005b38:	000044b7          	lui	s1,0x4
    80005b3c:	2204879b          	addiw	a5,s1,544
    80005b40:	fcf41623          	sh	a5,-52(s0)
    80005b44:	fc040723          	sb	zero,-50(s0)
    threads[1]->send(m1);
    80005b48:	00006997          	auipc	s3,0x6
    80005b4c:	b1098993          	addi	s3,s3,-1264 # 8000b658 <threads>
    80005b50:	fc840593          	addi	a1,s0,-56
    80005b54:	0089b503          	ld	a0,8(s3)
    80005b58:	fffff097          	auipc	ra,0xfffff
    80005b5c:	d00080e7          	jalr	-768(ra) # 80004858 <_ZN6Thread4sendEPc>

    char m2[] = "A -> C";
    80005b60:	fd242023          	sw	s2,-64(s0)
    80005b64:	3204849b          	addiw	s1,s1,800
    80005b68:	fc941223          	sh	s1,-60(s0)
    80005b6c:	fc040323          	sb	zero,-58(s0)
    threads[2]->send(m2);
    80005b70:	fc040593          	addi	a1,s0,-64
    80005b74:	0109b503          	ld	a0,16(s3)
    80005b78:	fffff097          	auipc	ra,0xfffff
    80005b7c:	ce0080e7          	jalr	-800(ra) # 80004858 <_ZN6Thread4sendEPc>

    char* msg = Thread::receive();
    80005b80:	000a0513          	mv	a0,s4
    80005b84:	fffff097          	auipc	ra,0xfffff
    80005b88:	d00080e7          	jalr	-768(ra) # 80004884 <_ZN6Thread7receiveEv>
    printString(msg);
    80005b8c:	ffffe097          	auipc	ra,0xffffe
    80005b90:	d10080e7          	jalr	-752(ra) # 8000389c <_Z11printStringPKc>

    printString("\nA finished!\n");
    80005b94:	00004517          	auipc	a0,0x4
    80005b98:	91c50513          	addi	a0,a0,-1764 # 800094b0 <CONSOLE_STATUS+0x4a0>
    80005b9c:	ffffe097          	auipc	ra,0xffffe
    80005ba0:	d00080e7          	jalr	-768(ra) # 8000389c <_Z11printStringPKc>
    finishedA1 = true;
    80005ba4:	00100793          	li	a5,1
    80005ba8:	00f98c23          	sb	a5,24(s3)
}
    80005bac:	03813083          	ld	ra,56(sp)
    80005bb0:	03013403          	ld	s0,48(sp)
    80005bb4:	02813483          	ld	s1,40(sp)
    80005bb8:	02013903          	ld	s2,32(sp)
    80005bbc:	01813983          	ld	s3,24(sp)
    80005bc0:	01013a03          	ld	s4,16(sp)
    80005bc4:	04010113          	addi	sp,sp,64
    80005bc8:	00008067          	ret

0000000080005bcc <_ZN8WorkerB112workerBodyB1EPv>:

void WorkerB1::workerBodyB1(void *arg)
{
    80005bcc:	fd010113          	addi	sp,sp,-48
    80005bd0:	02113423          	sd	ra,40(sp)
    80005bd4:	02813023          	sd	s0,32(sp)
    80005bd8:	00913c23          	sd	s1,24(sp)
    80005bdc:	01213823          	sd	s2,16(sp)
    80005be0:	03010413          	addi	s0,sp,48
    80005be4:	00050493          	mv	s1,a0
    char m3[] = "B -> C";
    80005be8:	3e2d27b7          	lui	a5,0x3e2d2
    80005bec:	0427879b          	addiw	a5,a5,66
    80005bf0:	fcf42c23          	sw	a5,-40(s0)
    80005bf4:	000047b7          	lui	a5,0x4
    80005bf8:	3207879b          	addiw	a5,a5,800
    80005bfc:	fcf41e23          	sh	a5,-36(s0)
    80005c00:	fc040f23          	sb	zero,-34(s0)
    threads[2]->send(m3);
    80005c04:	00006917          	auipc	s2,0x6
    80005c08:	a5490913          	addi	s2,s2,-1452 # 8000b658 <threads>
    80005c0c:	fd840593          	addi	a1,s0,-40
    80005c10:	01093503          	ld	a0,16(s2)
    80005c14:	fffff097          	auipc	ra,0xfffff
    80005c18:	c44080e7          	jalr	-956(ra) # 80004858 <_ZN6Thread4sendEPc>

    char* msg = Thread::receive();
    80005c1c:	00048513          	mv	a0,s1
    80005c20:	fffff097          	auipc	ra,0xfffff
    80005c24:	c64080e7          	jalr	-924(ra) # 80004884 <_ZN6Thread7receiveEv>
    printString(msg);
    80005c28:	ffffe097          	auipc	ra,0xffffe
    80005c2c:	c74080e7          	jalr	-908(ra) # 8000389c <_Z11printStringPKc>

    printString("\nB finished!\n");
    80005c30:	00004517          	auipc	a0,0x4
    80005c34:	89050513          	addi	a0,a0,-1904 # 800094c0 <CONSOLE_STATUS+0x4b0>
    80005c38:	ffffe097          	auipc	ra,0xffffe
    80005c3c:	c64080e7          	jalr	-924(ra) # 8000389c <_Z11printStringPKc>
    finishedB1 = true;
    80005c40:	00100793          	li	a5,1
    80005c44:	00f90ca3          	sb	a5,25(s2)
}
    80005c48:	02813083          	ld	ra,40(sp)
    80005c4c:	02013403          	ld	s0,32(sp)
    80005c50:	01813483          	ld	s1,24(sp)
    80005c54:	01013903          	ld	s2,16(sp)
    80005c58:	03010113          	addi	sp,sp,48
    80005c5c:	00008067          	ret

0000000080005c60 <_ZN8WorkerC112workerBodyC1EPv>:

void WorkerC1::workerBodyC1(void *arg)
{
    80005c60:	fd010113          	addi	sp,sp,-48
    80005c64:	02113423          	sd	ra,40(sp)
    80005c68:	02813023          	sd	s0,32(sp)
    80005c6c:	00913c23          	sd	s1,24(sp)
    80005c70:	01213823          	sd	s2,16(sp)
    80005c74:	03010413          	addi	s0,sp,48
    80005c78:	00050493          	mv	s1,a0

    char m4[] = "C -> A";
    80005c7c:	3e2d27b7          	lui	a5,0x3e2d2
    80005c80:	0437879b          	addiw	a5,a5,67
    80005c84:	fcf42c23          	sw	a5,-40(s0)
    80005c88:	000047b7          	lui	a5,0x4
    80005c8c:	1207879b          	addiw	a5,a5,288
    80005c90:	fcf41e23          	sh	a5,-36(s0)
    80005c94:	fc040f23          	sb	zero,-34(s0)
    threads[0]->send(m4);
    80005c98:	00006917          	auipc	s2,0x6
    80005c9c:	9c090913          	addi	s2,s2,-1600 # 8000b658 <threads>
    80005ca0:	fd840593          	addi	a1,s0,-40
    80005ca4:	00093503          	ld	a0,0(s2)
    80005ca8:	fffff097          	auipc	ra,0xfffff
    80005cac:	bb0080e7          	jalr	-1104(ra) # 80004858 <_ZN6Thread4sendEPc>

    char* msg = Thread::receive();
    80005cb0:	00048513          	mv	a0,s1
    80005cb4:	fffff097          	auipc	ra,0xfffff
    80005cb8:	bd0080e7          	jalr	-1072(ra) # 80004884 <_ZN6Thread7receiveEv>

    printString(msg);
    80005cbc:	ffffe097          	auipc	ra,0xffffe
    80005cc0:	be0080e7          	jalr	-1056(ra) # 8000389c <_Z11printStringPKc>

    printString("\nC finished!\n");
    80005cc4:	00004517          	auipc	a0,0x4
    80005cc8:	80c50513          	addi	a0,a0,-2036 # 800094d0 <CONSOLE_STATUS+0x4c0>
    80005ccc:	ffffe097          	auipc	ra,0xffffe
    80005cd0:	bd0080e7          	jalr	-1072(ra) # 8000389c <_Z11printStringPKc>
    finishedC1 = true;
    80005cd4:	00100793          	li	a5,1
    80005cd8:	00f90d23          	sb	a5,26(s2)
}
    80005cdc:	02813083          	ld	ra,40(sp)
    80005ce0:	02013403          	ld	s0,32(sp)
    80005ce4:	01813483          	ld	s1,24(sp)
    80005ce8:	01013903          	ld	s2,16(sp)
    80005cec:	03010113          	addi	sp,sp,48
    80005cf0:	00008067          	ret

0000000080005cf4 <_Z4Testv>:


void Test()
{
    80005cf4:	fe010113          	addi	sp,sp,-32
    80005cf8:	00113c23          	sd	ra,24(sp)
    80005cfc:	00813823          	sd	s0,16(sp)
    80005d00:	00913423          	sd	s1,8(sp)
    80005d04:	01213023          	sd	s2,0(sp)
    80005d08:	02010413          	addi	s0,sp,32

    threads[0] = new WorkerA1();
    80005d0c:	02000513          	li	a0,32
    80005d10:	fffff097          	auipc	ra,0xfffff
    80005d14:	950080e7          	jalr	-1712(ra) # 80004660 <_Znwm>
    80005d18:	00050493          	mv	s1,a0
    WorkerA1():Thread() {}
    80005d1c:	fffff097          	auipc	ra,0xfffff
    80005d20:	b04080e7          	jalr	-1276(ra) # 80004820 <_ZN6ThreadC1Ev>
    80005d24:	00005797          	auipc	a5,0x5
    80005d28:	7dc78793          	addi	a5,a5,2012 # 8000b500 <_ZTV8WorkerA1+0x10>
    80005d2c:	00f4b023          	sd	a5,0(s1) # 4000 <_entry-0x7fffc000>
    threads[0] = new WorkerA1();
    80005d30:	00006797          	auipc	a5,0x6
    80005d34:	9297b423          	sd	s1,-1752(a5) # 8000b658 <threads>
    printString("ThreadA created\n");
    80005d38:	00003517          	auipc	a0,0x3
    80005d3c:	48850513          	addi	a0,a0,1160 # 800091c0 <CONSOLE_STATUS+0x1b0>
    80005d40:	ffffe097          	auipc	ra,0xffffe
    80005d44:	b5c080e7          	jalr	-1188(ra) # 8000389c <_Z11printStringPKc>

    threads[1] = new WorkerB1();
    80005d48:	02000513          	li	a0,32
    80005d4c:	fffff097          	auipc	ra,0xfffff
    80005d50:	914080e7          	jalr	-1772(ra) # 80004660 <_Znwm>
    80005d54:	00050493          	mv	s1,a0
    WorkerB1():Thread() {}
    80005d58:	fffff097          	auipc	ra,0xfffff
    80005d5c:	ac8080e7          	jalr	-1336(ra) # 80004820 <_ZN6ThreadC1Ev>
    80005d60:	00005797          	auipc	a5,0x5
    80005d64:	7c878793          	addi	a5,a5,1992 # 8000b528 <_ZTV8WorkerB1+0x10>
    80005d68:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB1();
    80005d6c:	00006797          	auipc	a5,0x6
    80005d70:	8e97ba23          	sd	s1,-1804(a5) # 8000b660 <threads+0x8>
    printString("ThreadB created\n");
    80005d74:	00003517          	auipc	a0,0x3
    80005d78:	46450513          	addi	a0,a0,1124 # 800091d8 <CONSOLE_STATUS+0x1c8>
    80005d7c:	ffffe097          	auipc	ra,0xffffe
    80005d80:	b20080e7          	jalr	-1248(ra) # 8000389c <_Z11printStringPKc>

    threads[2] = new WorkerC1();
    80005d84:	02000513          	li	a0,32
    80005d88:	fffff097          	auipc	ra,0xfffff
    80005d8c:	8d8080e7          	jalr	-1832(ra) # 80004660 <_Znwm>
    80005d90:	00050493          	mv	s1,a0
    WorkerC1():Thread() {}
    80005d94:	fffff097          	auipc	ra,0xfffff
    80005d98:	a8c080e7          	jalr	-1396(ra) # 80004820 <_ZN6ThreadC1Ev>
    80005d9c:	00005797          	auipc	a5,0x5
    80005da0:	7b478793          	addi	a5,a5,1972 # 8000b550 <_ZTV8WorkerC1+0x10>
    80005da4:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC1();
    80005da8:	00006797          	auipc	a5,0x6
    80005dac:	8c97b023          	sd	s1,-1856(a5) # 8000b668 <threads+0x10>
    printString("ThreadC created\n");
    80005db0:	00003517          	auipc	a0,0x3
    80005db4:	44050513          	addi	a0,a0,1088 # 800091f0 <CONSOLE_STATUS+0x1e0>
    80005db8:	ffffe097          	auipc	ra,0xffffe
    80005dbc:	ae4080e7          	jalr	-1308(ra) # 8000389c <_Z11printStringPKc>

    for(int i=0; i<3; i++)
    80005dc0:	00000493          	li	s1,0
    80005dc4:	00200793          	li	a5,2
    80005dc8:	0297c863          	blt	a5,s1,80005df8 <_Z4Testv+0x104>
    {
        threads[i]->start();
    80005dcc:	00349713          	slli	a4,s1,0x3
    80005dd0:	00006797          	auipc	a5,0x6
    80005dd4:	88878793          	addi	a5,a5,-1912 # 8000b658 <threads>
    80005dd8:	00e787b3          	add	a5,a5,a4
    80005ddc:	0007b503          	ld	a0,0(a5)
    80005de0:	fffff097          	auipc	ra,0xfffff
    80005de4:	9d0080e7          	jalr	-1584(ra) # 800047b0 <_ZN6Thread5startEv>
    for(int i=0; i<3; i++)
    80005de8:	0014849b          	addiw	s1,s1,1
    80005dec:	fd9ff06f          	j	80005dc4 <_Z4Testv+0xd0>
    }

    while (!(finishedA1 && finishedB1 && finishedC1)) {
        Thread::dispatch();
    80005df0:	fffff097          	auipc	ra,0xfffff
    80005df4:	a08080e7          	jalr	-1528(ra) # 800047f8 <_ZN6Thread8dispatchEv>
    while (!(finishedA1 && finishedB1 && finishedC1)) {
    80005df8:	00006797          	auipc	a5,0x6
    80005dfc:	8787c783          	lbu	a5,-1928(a5) # 8000b670 <_ZL10finishedA1>
    80005e00:	fe0788e3          	beqz	a5,80005df0 <_Z4Testv+0xfc>
    80005e04:	00006797          	auipc	a5,0x6
    80005e08:	86d7c783          	lbu	a5,-1939(a5) # 8000b671 <_ZL10finishedB1>
    80005e0c:	fe0782e3          	beqz	a5,80005df0 <_Z4Testv+0xfc>
    80005e10:	00006797          	auipc	a5,0x6
    80005e14:	8627c783          	lbu	a5,-1950(a5) # 8000b672 <_ZL10finishedC1>
    80005e18:	fc078ce3          	beqz	a5,80005df0 <_Z4Testv+0xfc>
    80005e1c:	00006497          	auipc	s1,0x6
    80005e20:	83c48493          	addi	s1,s1,-1988 # 8000b658 <threads>
    80005e24:	0080006f          	j	80005e2c <_Z4Testv+0x138>
    }

    for (auto thread: threads) { delete thread; }
    80005e28:	00848493          	addi	s1,s1,8
    80005e2c:	00006797          	auipc	a5,0x6
    80005e30:	84478793          	addi	a5,a5,-1980 # 8000b670 <_ZL10finishedA1>
    80005e34:	06f48863          	beq	s1,a5,80005ea4 <_Z4Testv+0x1b0>
    80005e38:	0004b503          	ld	a0,0(s1)
    80005e3c:	fe0506e3          	beqz	a0,80005e28 <_Z4Testv+0x134>
    80005e40:	00053783          	ld	a5,0(a0)
    80005e44:	0087b783          	ld	a5,8(a5)
    80005e48:	000780e7          	jalr	a5
    80005e4c:	fddff06f          	j	80005e28 <_Z4Testv+0x134>
    80005e50:	00050913          	mv	s2,a0
    threads[0] = new WorkerA1();
    80005e54:	00048513          	mv	a0,s1
    80005e58:	fffff097          	auipc	ra,0xfffff
    80005e5c:	858080e7          	jalr	-1960(ra) # 800046b0 <_ZdlPv>
    80005e60:	00090513          	mv	a0,s2
    80005e64:	00007097          	auipc	ra,0x7
    80005e68:	8e4080e7          	jalr	-1820(ra) # 8000c748 <_Unwind_Resume>
    80005e6c:	00050913          	mv	s2,a0
    threads[1] = new WorkerB1();
    80005e70:	00048513          	mv	a0,s1
    80005e74:	fffff097          	auipc	ra,0xfffff
    80005e78:	83c080e7          	jalr	-1988(ra) # 800046b0 <_ZdlPv>
    80005e7c:	00090513          	mv	a0,s2
    80005e80:	00007097          	auipc	ra,0x7
    80005e84:	8c8080e7          	jalr	-1848(ra) # 8000c748 <_Unwind_Resume>
    80005e88:	00050913          	mv	s2,a0
    threads[2] = new WorkerC1();
    80005e8c:	00048513          	mv	a0,s1
    80005e90:	fffff097          	auipc	ra,0xfffff
    80005e94:	820080e7          	jalr	-2016(ra) # 800046b0 <_ZdlPv>
    80005e98:	00090513          	mv	a0,s2
    80005e9c:	00007097          	auipc	ra,0x7
    80005ea0:	8ac080e7          	jalr	-1876(ra) # 8000c748 <_Unwind_Resume>
}
    80005ea4:	01813083          	ld	ra,24(sp)
    80005ea8:	01013403          	ld	s0,16(sp)
    80005eac:	00813483          	ld	s1,8(sp)
    80005eb0:	00013903          	ld	s2,0(sp)
    80005eb4:	02010113          	addi	sp,sp,32
    80005eb8:	00008067          	ret

0000000080005ebc <_ZN8WorkerA1D1Ev>:
class WorkerA1: public Thread {
    80005ebc:	ff010113          	addi	sp,sp,-16
    80005ec0:	00113423          	sd	ra,8(sp)
    80005ec4:	00813023          	sd	s0,0(sp)
    80005ec8:	01010413          	addi	s0,sp,16
    80005ecc:	00005797          	auipc	a5,0x5
    80005ed0:	63478793          	addi	a5,a5,1588 # 8000b500 <_ZTV8WorkerA1+0x10>
    80005ed4:	00f53023          	sd	a5,0(a0)
    80005ed8:	ffffe097          	auipc	ra,0xffffe
    80005edc:	6f4080e7          	jalr	1780(ra) # 800045cc <_ZN6ThreadD1Ev>
    80005ee0:	00813083          	ld	ra,8(sp)
    80005ee4:	00013403          	ld	s0,0(sp)
    80005ee8:	01010113          	addi	sp,sp,16
    80005eec:	00008067          	ret

0000000080005ef0 <_ZN8WorkerA1D0Ev>:
    80005ef0:	fe010113          	addi	sp,sp,-32
    80005ef4:	00113c23          	sd	ra,24(sp)
    80005ef8:	00813823          	sd	s0,16(sp)
    80005efc:	00913423          	sd	s1,8(sp)
    80005f00:	02010413          	addi	s0,sp,32
    80005f04:	00050493          	mv	s1,a0
    80005f08:	00005797          	auipc	a5,0x5
    80005f0c:	5f878793          	addi	a5,a5,1528 # 8000b500 <_ZTV8WorkerA1+0x10>
    80005f10:	00f53023          	sd	a5,0(a0)
    80005f14:	ffffe097          	auipc	ra,0xffffe
    80005f18:	6b8080e7          	jalr	1720(ra) # 800045cc <_ZN6ThreadD1Ev>
    80005f1c:	00048513          	mv	a0,s1
    80005f20:	ffffe097          	auipc	ra,0xffffe
    80005f24:	790080e7          	jalr	1936(ra) # 800046b0 <_ZdlPv>
    80005f28:	01813083          	ld	ra,24(sp)
    80005f2c:	01013403          	ld	s0,16(sp)
    80005f30:	00813483          	ld	s1,8(sp)
    80005f34:	02010113          	addi	sp,sp,32
    80005f38:	00008067          	ret

0000000080005f3c <_ZN8WorkerB1D1Ev>:
class WorkerB1: public Thread {
    80005f3c:	ff010113          	addi	sp,sp,-16
    80005f40:	00113423          	sd	ra,8(sp)
    80005f44:	00813023          	sd	s0,0(sp)
    80005f48:	01010413          	addi	s0,sp,16
    80005f4c:	00005797          	auipc	a5,0x5
    80005f50:	5dc78793          	addi	a5,a5,1500 # 8000b528 <_ZTV8WorkerB1+0x10>
    80005f54:	00f53023          	sd	a5,0(a0)
    80005f58:	ffffe097          	auipc	ra,0xffffe
    80005f5c:	674080e7          	jalr	1652(ra) # 800045cc <_ZN6ThreadD1Ev>
    80005f60:	00813083          	ld	ra,8(sp)
    80005f64:	00013403          	ld	s0,0(sp)
    80005f68:	01010113          	addi	sp,sp,16
    80005f6c:	00008067          	ret

0000000080005f70 <_ZN8WorkerB1D0Ev>:
    80005f70:	fe010113          	addi	sp,sp,-32
    80005f74:	00113c23          	sd	ra,24(sp)
    80005f78:	00813823          	sd	s0,16(sp)
    80005f7c:	00913423          	sd	s1,8(sp)
    80005f80:	02010413          	addi	s0,sp,32
    80005f84:	00050493          	mv	s1,a0
    80005f88:	00005797          	auipc	a5,0x5
    80005f8c:	5a078793          	addi	a5,a5,1440 # 8000b528 <_ZTV8WorkerB1+0x10>
    80005f90:	00f53023          	sd	a5,0(a0)
    80005f94:	ffffe097          	auipc	ra,0xffffe
    80005f98:	638080e7          	jalr	1592(ra) # 800045cc <_ZN6ThreadD1Ev>
    80005f9c:	00048513          	mv	a0,s1
    80005fa0:	ffffe097          	auipc	ra,0xffffe
    80005fa4:	710080e7          	jalr	1808(ra) # 800046b0 <_ZdlPv>
    80005fa8:	01813083          	ld	ra,24(sp)
    80005fac:	01013403          	ld	s0,16(sp)
    80005fb0:	00813483          	ld	s1,8(sp)
    80005fb4:	02010113          	addi	sp,sp,32
    80005fb8:	00008067          	ret

0000000080005fbc <_ZN8WorkerC1D1Ev>:
class WorkerC1: public Thread {
    80005fbc:	ff010113          	addi	sp,sp,-16
    80005fc0:	00113423          	sd	ra,8(sp)
    80005fc4:	00813023          	sd	s0,0(sp)
    80005fc8:	01010413          	addi	s0,sp,16
    80005fcc:	00005797          	auipc	a5,0x5
    80005fd0:	58478793          	addi	a5,a5,1412 # 8000b550 <_ZTV8WorkerC1+0x10>
    80005fd4:	00f53023          	sd	a5,0(a0)
    80005fd8:	ffffe097          	auipc	ra,0xffffe
    80005fdc:	5f4080e7          	jalr	1524(ra) # 800045cc <_ZN6ThreadD1Ev>
    80005fe0:	00813083          	ld	ra,8(sp)
    80005fe4:	00013403          	ld	s0,0(sp)
    80005fe8:	01010113          	addi	sp,sp,16
    80005fec:	00008067          	ret

0000000080005ff0 <_ZN8WorkerC1D0Ev>:
    80005ff0:	fe010113          	addi	sp,sp,-32
    80005ff4:	00113c23          	sd	ra,24(sp)
    80005ff8:	00813823          	sd	s0,16(sp)
    80005ffc:	00913423          	sd	s1,8(sp)
    80006000:	02010413          	addi	s0,sp,32
    80006004:	00050493          	mv	s1,a0
    80006008:	00005797          	auipc	a5,0x5
    8000600c:	54878793          	addi	a5,a5,1352 # 8000b550 <_ZTV8WorkerC1+0x10>
    80006010:	00f53023          	sd	a5,0(a0)
    80006014:	ffffe097          	auipc	ra,0xffffe
    80006018:	5b8080e7          	jalr	1464(ra) # 800045cc <_ZN6ThreadD1Ev>
    8000601c:	00048513          	mv	a0,s1
    80006020:	ffffe097          	auipc	ra,0xffffe
    80006024:	690080e7          	jalr	1680(ra) # 800046b0 <_ZdlPv>
    80006028:	01813083          	ld	ra,24(sp)
    8000602c:	01013403          	ld	s0,16(sp)
    80006030:	00813483          	ld	s1,8(sp)
    80006034:	02010113          	addi	sp,sp,32
    80006038:	00008067          	ret

000000008000603c <_ZN8WorkerA13runEv>:
    void run() override {
    8000603c:	ff010113          	addi	sp,sp,-16
    80006040:	00113423          	sd	ra,8(sp)
    80006044:	00813023          	sd	s0,0(sp)
    80006048:	01010413          	addi	s0,sp,16
        workerBodyA1(nullptr);
    8000604c:	00000593          	li	a1,0
    80006050:	00000097          	auipc	ra,0x0
    80006054:	ab8080e7          	jalr	-1352(ra) # 80005b08 <_ZN8WorkerA112workerBodyA1EPv>
    }
    80006058:	00813083          	ld	ra,8(sp)
    8000605c:	00013403          	ld	s0,0(sp)
    80006060:	01010113          	addi	sp,sp,16
    80006064:	00008067          	ret

0000000080006068 <_ZN8WorkerB13runEv>:
    void run() override {
    80006068:	ff010113          	addi	sp,sp,-16
    8000606c:	00113423          	sd	ra,8(sp)
    80006070:	00813023          	sd	s0,0(sp)
    80006074:	01010413          	addi	s0,sp,16
        workerBodyB1(nullptr);
    80006078:	00000593          	li	a1,0
    8000607c:	00000097          	auipc	ra,0x0
    80006080:	b50080e7          	jalr	-1200(ra) # 80005bcc <_ZN8WorkerB112workerBodyB1EPv>
    }
    80006084:	00813083          	ld	ra,8(sp)
    80006088:	00013403          	ld	s0,0(sp)
    8000608c:	01010113          	addi	sp,sp,16
    80006090:	00008067          	ret

0000000080006094 <_ZN8WorkerC13runEv>:
    void run() override {
    80006094:	ff010113          	addi	sp,sp,-16
    80006098:	00113423          	sd	ra,8(sp)
    8000609c:	00813023          	sd	s0,0(sp)
    800060a0:	01010413          	addi	s0,sp,16
        workerBodyC1(nullptr);
    800060a4:	00000593          	li	a1,0
    800060a8:	00000097          	auipc	ra,0x0
    800060ac:	bb8080e7          	jalr	-1096(ra) # 80005c60 <_ZN8WorkerC112workerBodyC1EPv>
    }
    800060b0:	00813083          	ld	ra,8(sp)
    800060b4:	00013403          	ld	s0,0(sp)
    800060b8:	01010113          	addi	sp,sp,16
    800060bc:	00008067          	ret

00000000800060c0 <start>:
    800060c0:	ff010113          	addi	sp,sp,-16
    800060c4:	00813423          	sd	s0,8(sp)
    800060c8:	01010413          	addi	s0,sp,16
    800060cc:	300027f3          	csrr	a5,mstatus
    800060d0:	ffffe737          	lui	a4,0xffffe
    800060d4:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff1f1f>
    800060d8:	00e7f7b3          	and	a5,a5,a4
    800060dc:	00001737          	lui	a4,0x1
    800060e0:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800060e4:	00e7e7b3          	or	a5,a5,a4
    800060e8:	30079073          	csrw	mstatus,a5
    800060ec:	00000797          	auipc	a5,0x0
    800060f0:	16078793          	addi	a5,a5,352 # 8000624c <system_main>
    800060f4:	34179073          	csrw	mepc,a5
    800060f8:	00000793          	li	a5,0
    800060fc:	18079073          	csrw	satp,a5
    80006100:	000107b7          	lui	a5,0x10
    80006104:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80006108:	30279073          	csrw	medeleg,a5
    8000610c:	30379073          	csrw	mideleg,a5
    80006110:	104027f3          	csrr	a5,sie
    80006114:	2227e793          	ori	a5,a5,546
    80006118:	10479073          	csrw	sie,a5
    8000611c:	fff00793          	li	a5,-1
    80006120:	00a7d793          	srli	a5,a5,0xa
    80006124:	3b079073          	csrw	pmpaddr0,a5
    80006128:	00f00793          	li	a5,15
    8000612c:	3a079073          	csrw	pmpcfg0,a5
    80006130:	f14027f3          	csrr	a5,mhartid
    80006134:	0200c737          	lui	a4,0x200c
    80006138:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000613c:	0007869b          	sext.w	a3,a5
    80006140:	00269713          	slli	a4,a3,0x2
    80006144:	000f4637          	lui	a2,0xf4
    80006148:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000614c:	00d70733          	add	a4,a4,a3
    80006150:	0037979b          	slliw	a5,a5,0x3
    80006154:	020046b7          	lui	a3,0x2004
    80006158:	00d787b3          	add	a5,a5,a3
    8000615c:	00c585b3          	add	a1,a1,a2
    80006160:	00371693          	slli	a3,a4,0x3
    80006164:	00005717          	auipc	a4,0x5
    80006168:	51c70713          	addi	a4,a4,1308 # 8000b680 <timer_scratch>
    8000616c:	00b7b023          	sd	a1,0(a5)
    80006170:	00d70733          	add	a4,a4,a3
    80006174:	00f73c23          	sd	a5,24(a4)
    80006178:	02c73023          	sd	a2,32(a4)
    8000617c:	34071073          	csrw	mscratch,a4
    80006180:	00000797          	auipc	a5,0x0
    80006184:	6e078793          	addi	a5,a5,1760 # 80006860 <timervec>
    80006188:	30579073          	csrw	mtvec,a5
    8000618c:	300027f3          	csrr	a5,mstatus
    80006190:	0087e793          	ori	a5,a5,8
    80006194:	30079073          	csrw	mstatus,a5
    80006198:	304027f3          	csrr	a5,mie
    8000619c:	0807e793          	ori	a5,a5,128
    800061a0:	30479073          	csrw	mie,a5
    800061a4:	f14027f3          	csrr	a5,mhartid
    800061a8:	0007879b          	sext.w	a5,a5
    800061ac:	00078213          	mv	tp,a5
    800061b0:	30200073          	mret
    800061b4:	00813403          	ld	s0,8(sp)
    800061b8:	01010113          	addi	sp,sp,16
    800061bc:	00008067          	ret

00000000800061c0 <timerinit>:
    800061c0:	ff010113          	addi	sp,sp,-16
    800061c4:	00813423          	sd	s0,8(sp)
    800061c8:	01010413          	addi	s0,sp,16
    800061cc:	f14027f3          	csrr	a5,mhartid
    800061d0:	0200c737          	lui	a4,0x200c
    800061d4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800061d8:	0007869b          	sext.w	a3,a5
    800061dc:	00269713          	slli	a4,a3,0x2
    800061e0:	000f4637          	lui	a2,0xf4
    800061e4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800061e8:	00d70733          	add	a4,a4,a3
    800061ec:	0037979b          	slliw	a5,a5,0x3
    800061f0:	020046b7          	lui	a3,0x2004
    800061f4:	00d787b3          	add	a5,a5,a3
    800061f8:	00c585b3          	add	a1,a1,a2
    800061fc:	00371693          	slli	a3,a4,0x3
    80006200:	00005717          	auipc	a4,0x5
    80006204:	48070713          	addi	a4,a4,1152 # 8000b680 <timer_scratch>
    80006208:	00b7b023          	sd	a1,0(a5)
    8000620c:	00d70733          	add	a4,a4,a3
    80006210:	00f73c23          	sd	a5,24(a4)
    80006214:	02c73023          	sd	a2,32(a4)
    80006218:	34071073          	csrw	mscratch,a4
    8000621c:	00000797          	auipc	a5,0x0
    80006220:	64478793          	addi	a5,a5,1604 # 80006860 <timervec>
    80006224:	30579073          	csrw	mtvec,a5
    80006228:	300027f3          	csrr	a5,mstatus
    8000622c:	0087e793          	ori	a5,a5,8
    80006230:	30079073          	csrw	mstatus,a5
    80006234:	304027f3          	csrr	a5,mie
    80006238:	0807e793          	ori	a5,a5,128
    8000623c:	30479073          	csrw	mie,a5
    80006240:	00813403          	ld	s0,8(sp)
    80006244:	01010113          	addi	sp,sp,16
    80006248:	00008067          	ret

000000008000624c <system_main>:
    8000624c:	fe010113          	addi	sp,sp,-32
    80006250:	00813823          	sd	s0,16(sp)
    80006254:	00913423          	sd	s1,8(sp)
    80006258:	00113c23          	sd	ra,24(sp)
    8000625c:	02010413          	addi	s0,sp,32
    80006260:	00000097          	auipc	ra,0x0
    80006264:	0c4080e7          	jalr	196(ra) # 80006324 <cpuid>
    80006268:	00005497          	auipc	s1,0x5
    8000626c:	34848493          	addi	s1,s1,840 # 8000b5b0 <started>
    80006270:	02050263          	beqz	a0,80006294 <system_main+0x48>
    80006274:	0004a783          	lw	a5,0(s1)
    80006278:	0007879b          	sext.w	a5,a5
    8000627c:	fe078ce3          	beqz	a5,80006274 <system_main+0x28>
    80006280:	0ff0000f          	fence
    80006284:	00003517          	auipc	a0,0x3
    80006288:	28c50513          	addi	a0,a0,652 # 80009510 <CONSOLE_STATUS+0x500>
    8000628c:	00001097          	auipc	ra,0x1
    80006290:	a70080e7          	jalr	-1424(ra) # 80006cfc <panic>
    80006294:	00001097          	auipc	ra,0x1
    80006298:	9c4080e7          	jalr	-1596(ra) # 80006c58 <consoleinit>
    8000629c:	00001097          	auipc	ra,0x1
    800062a0:	150080e7          	jalr	336(ra) # 800073ec <printfinit>
    800062a4:	00003517          	auipc	a0,0x3
    800062a8:	10450513          	addi	a0,a0,260 # 800093a8 <CONSOLE_STATUS+0x398>
    800062ac:	00001097          	auipc	ra,0x1
    800062b0:	aac080e7          	jalr	-1364(ra) # 80006d58 <__printf>
    800062b4:	00003517          	auipc	a0,0x3
    800062b8:	22c50513          	addi	a0,a0,556 # 800094e0 <CONSOLE_STATUS+0x4d0>
    800062bc:	00001097          	auipc	ra,0x1
    800062c0:	a9c080e7          	jalr	-1380(ra) # 80006d58 <__printf>
    800062c4:	00003517          	auipc	a0,0x3
    800062c8:	0e450513          	addi	a0,a0,228 # 800093a8 <CONSOLE_STATUS+0x398>
    800062cc:	00001097          	auipc	ra,0x1
    800062d0:	a8c080e7          	jalr	-1396(ra) # 80006d58 <__printf>
    800062d4:	00001097          	auipc	ra,0x1
    800062d8:	4a4080e7          	jalr	1188(ra) # 80007778 <kinit>
    800062dc:	00000097          	auipc	ra,0x0
    800062e0:	148080e7          	jalr	328(ra) # 80006424 <trapinit>
    800062e4:	00000097          	auipc	ra,0x0
    800062e8:	16c080e7          	jalr	364(ra) # 80006450 <trapinithart>
    800062ec:	00000097          	auipc	ra,0x0
    800062f0:	5b4080e7          	jalr	1460(ra) # 800068a0 <plicinit>
    800062f4:	00000097          	auipc	ra,0x0
    800062f8:	5d4080e7          	jalr	1492(ra) # 800068c8 <plicinithart>
    800062fc:	00000097          	auipc	ra,0x0
    80006300:	078080e7          	jalr	120(ra) # 80006374 <userinit>
    80006304:	0ff0000f          	fence
    80006308:	00100793          	li	a5,1
    8000630c:	00003517          	auipc	a0,0x3
    80006310:	1ec50513          	addi	a0,a0,492 # 800094f8 <CONSOLE_STATUS+0x4e8>
    80006314:	00f4a023          	sw	a5,0(s1)
    80006318:	00001097          	auipc	ra,0x1
    8000631c:	a40080e7          	jalr	-1472(ra) # 80006d58 <__printf>
    80006320:	0000006f          	j	80006320 <system_main+0xd4>

0000000080006324 <cpuid>:
    80006324:	ff010113          	addi	sp,sp,-16
    80006328:	00813423          	sd	s0,8(sp)
    8000632c:	01010413          	addi	s0,sp,16
    80006330:	00020513          	mv	a0,tp
    80006334:	00813403          	ld	s0,8(sp)
    80006338:	0005051b          	sext.w	a0,a0
    8000633c:	01010113          	addi	sp,sp,16
    80006340:	00008067          	ret

0000000080006344 <mycpu>:
    80006344:	ff010113          	addi	sp,sp,-16
    80006348:	00813423          	sd	s0,8(sp)
    8000634c:	01010413          	addi	s0,sp,16
    80006350:	00020793          	mv	a5,tp
    80006354:	00813403          	ld	s0,8(sp)
    80006358:	0007879b          	sext.w	a5,a5
    8000635c:	00779793          	slli	a5,a5,0x7
    80006360:	00006517          	auipc	a0,0x6
    80006364:	35050513          	addi	a0,a0,848 # 8000c6b0 <cpus>
    80006368:	00f50533          	add	a0,a0,a5
    8000636c:	01010113          	addi	sp,sp,16
    80006370:	00008067          	ret

0000000080006374 <userinit>:
    80006374:	ff010113          	addi	sp,sp,-16
    80006378:	00813423          	sd	s0,8(sp)
    8000637c:	01010413          	addi	s0,sp,16
    80006380:	00813403          	ld	s0,8(sp)
    80006384:	01010113          	addi	sp,sp,16
    80006388:	ffffe317          	auipc	t1,0xffffe
    8000638c:	d6830067          	jr	-664(t1) # 800040f0 <main>

0000000080006390 <either_copyout>:
    80006390:	ff010113          	addi	sp,sp,-16
    80006394:	00813023          	sd	s0,0(sp)
    80006398:	00113423          	sd	ra,8(sp)
    8000639c:	01010413          	addi	s0,sp,16
    800063a0:	02051663          	bnez	a0,800063cc <either_copyout+0x3c>
    800063a4:	00058513          	mv	a0,a1
    800063a8:	00060593          	mv	a1,a2
    800063ac:	0006861b          	sext.w	a2,a3
    800063b0:	00002097          	auipc	ra,0x2
    800063b4:	c54080e7          	jalr	-940(ra) # 80008004 <__memmove>
    800063b8:	00813083          	ld	ra,8(sp)
    800063bc:	00013403          	ld	s0,0(sp)
    800063c0:	00000513          	li	a0,0
    800063c4:	01010113          	addi	sp,sp,16
    800063c8:	00008067          	ret
    800063cc:	00003517          	auipc	a0,0x3
    800063d0:	16c50513          	addi	a0,a0,364 # 80009538 <CONSOLE_STATUS+0x528>
    800063d4:	00001097          	auipc	ra,0x1
    800063d8:	928080e7          	jalr	-1752(ra) # 80006cfc <panic>

00000000800063dc <either_copyin>:
    800063dc:	ff010113          	addi	sp,sp,-16
    800063e0:	00813023          	sd	s0,0(sp)
    800063e4:	00113423          	sd	ra,8(sp)
    800063e8:	01010413          	addi	s0,sp,16
    800063ec:	02059463          	bnez	a1,80006414 <either_copyin+0x38>
    800063f0:	00060593          	mv	a1,a2
    800063f4:	0006861b          	sext.w	a2,a3
    800063f8:	00002097          	auipc	ra,0x2
    800063fc:	c0c080e7          	jalr	-1012(ra) # 80008004 <__memmove>
    80006400:	00813083          	ld	ra,8(sp)
    80006404:	00013403          	ld	s0,0(sp)
    80006408:	00000513          	li	a0,0
    8000640c:	01010113          	addi	sp,sp,16
    80006410:	00008067          	ret
    80006414:	00003517          	auipc	a0,0x3
    80006418:	14c50513          	addi	a0,a0,332 # 80009560 <CONSOLE_STATUS+0x550>
    8000641c:	00001097          	auipc	ra,0x1
    80006420:	8e0080e7          	jalr	-1824(ra) # 80006cfc <panic>

0000000080006424 <trapinit>:
    80006424:	ff010113          	addi	sp,sp,-16
    80006428:	00813423          	sd	s0,8(sp)
    8000642c:	01010413          	addi	s0,sp,16
    80006430:	00813403          	ld	s0,8(sp)
    80006434:	00003597          	auipc	a1,0x3
    80006438:	15458593          	addi	a1,a1,340 # 80009588 <CONSOLE_STATUS+0x578>
    8000643c:	00006517          	auipc	a0,0x6
    80006440:	2f450513          	addi	a0,a0,756 # 8000c730 <tickslock>
    80006444:	01010113          	addi	sp,sp,16
    80006448:	00001317          	auipc	t1,0x1
    8000644c:	5c030067          	jr	1472(t1) # 80007a08 <initlock>

0000000080006450 <trapinithart>:
    80006450:	ff010113          	addi	sp,sp,-16
    80006454:	00813423          	sd	s0,8(sp)
    80006458:	01010413          	addi	s0,sp,16
    8000645c:	00000797          	auipc	a5,0x0
    80006460:	2f478793          	addi	a5,a5,756 # 80006750 <kernelvec>
    80006464:	10579073          	csrw	stvec,a5
    80006468:	00813403          	ld	s0,8(sp)
    8000646c:	01010113          	addi	sp,sp,16
    80006470:	00008067          	ret

0000000080006474 <usertrap>:
    80006474:	ff010113          	addi	sp,sp,-16
    80006478:	00813423          	sd	s0,8(sp)
    8000647c:	01010413          	addi	s0,sp,16
    80006480:	00813403          	ld	s0,8(sp)
    80006484:	01010113          	addi	sp,sp,16
    80006488:	00008067          	ret

000000008000648c <usertrapret>:
    8000648c:	ff010113          	addi	sp,sp,-16
    80006490:	00813423          	sd	s0,8(sp)
    80006494:	01010413          	addi	s0,sp,16
    80006498:	00813403          	ld	s0,8(sp)
    8000649c:	01010113          	addi	sp,sp,16
    800064a0:	00008067          	ret

00000000800064a4 <kerneltrap>:
    800064a4:	fe010113          	addi	sp,sp,-32
    800064a8:	00813823          	sd	s0,16(sp)
    800064ac:	00113c23          	sd	ra,24(sp)
    800064b0:	00913423          	sd	s1,8(sp)
    800064b4:	02010413          	addi	s0,sp,32
    800064b8:	142025f3          	csrr	a1,scause
    800064bc:	100027f3          	csrr	a5,sstatus
    800064c0:	0027f793          	andi	a5,a5,2
    800064c4:	10079c63          	bnez	a5,800065dc <kerneltrap+0x138>
    800064c8:	142027f3          	csrr	a5,scause
    800064cc:	0207ce63          	bltz	a5,80006508 <kerneltrap+0x64>
    800064d0:	00003517          	auipc	a0,0x3
    800064d4:	10050513          	addi	a0,a0,256 # 800095d0 <CONSOLE_STATUS+0x5c0>
    800064d8:	00001097          	auipc	ra,0x1
    800064dc:	880080e7          	jalr	-1920(ra) # 80006d58 <__printf>
    800064e0:	141025f3          	csrr	a1,sepc
    800064e4:	14302673          	csrr	a2,stval
    800064e8:	00003517          	auipc	a0,0x3
    800064ec:	0f850513          	addi	a0,a0,248 # 800095e0 <CONSOLE_STATUS+0x5d0>
    800064f0:	00001097          	auipc	ra,0x1
    800064f4:	868080e7          	jalr	-1944(ra) # 80006d58 <__printf>
    800064f8:	00003517          	auipc	a0,0x3
    800064fc:	10050513          	addi	a0,a0,256 # 800095f8 <CONSOLE_STATUS+0x5e8>
    80006500:	00000097          	auipc	ra,0x0
    80006504:	7fc080e7          	jalr	2044(ra) # 80006cfc <panic>
    80006508:	0ff7f713          	andi	a4,a5,255
    8000650c:	00900693          	li	a3,9
    80006510:	04d70063          	beq	a4,a3,80006550 <kerneltrap+0xac>
    80006514:	fff00713          	li	a4,-1
    80006518:	03f71713          	slli	a4,a4,0x3f
    8000651c:	00170713          	addi	a4,a4,1
    80006520:	fae798e3          	bne	a5,a4,800064d0 <kerneltrap+0x2c>
    80006524:	00000097          	auipc	ra,0x0
    80006528:	e00080e7          	jalr	-512(ra) # 80006324 <cpuid>
    8000652c:	06050663          	beqz	a0,80006598 <kerneltrap+0xf4>
    80006530:	144027f3          	csrr	a5,sip
    80006534:	ffd7f793          	andi	a5,a5,-3
    80006538:	14479073          	csrw	sip,a5
    8000653c:	01813083          	ld	ra,24(sp)
    80006540:	01013403          	ld	s0,16(sp)
    80006544:	00813483          	ld	s1,8(sp)
    80006548:	02010113          	addi	sp,sp,32
    8000654c:	00008067          	ret
    80006550:	00000097          	auipc	ra,0x0
    80006554:	3c4080e7          	jalr	964(ra) # 80006914 <plic_claim>
    80006558:	00a00793          	li	a5,10
    8000655c:	00050493          	mv	s1,a0
    80006560:	06f50863          	beq	a0,a5,800065d0 <kerneltrap+0x12c>
    80006564:	fc050ce3          	beqz	a0,8000653c <kerneltrap+0x98>
    80006568:	00050593          	mv	a1,a0
    8000656c:	00003517          	auipc	a0,0x3
    80006570:	04450513          	addi	a0,a0,68 # 800095b0 <CONSOLE_STATUS+0x5a0>
    80006574:	00000097          	auipc	ra,0x0
    80006578:	7e4080e7          	jalr	2020(ra) # 80006d58 <__printf>
    8000657c:	01013403          	ld	s0,16(sp)
    80006580:	01813083          	ld	ra,24(sp)
    80006584:	00048513          	mv	a0,s1
    80006588:	00813483          	ld	s1,8(sp)
    8000658c:	02010113          	addi	sp,sp,32
    80006590:	00000317          	auipc	t1,0x0
    80006594:	3bc30067          	jr	956(t1) # 8000694c <plic_complete>
    80006598:	00006517          	auipc	a0,0x6
    8000659c:	19850513          	addi	a0,a0,408 # 8000c730 <tickslock>
    800065a0:	00001097          	auipc	ra,0x1
    800065a4:	48c080e7          	jalr	1164(ra) # 80007a2c <acquire>
    800065a8:	00005717          	auipc	a4,0x5
    800065ac:	00c70713          	addi	a4,a4,12 # 8000b5b4 <ticks>
    800065b0:	00072783          	lw	a5,0(a4)
    800065b4:	00006517          	auipc	a0,0x6
    800065b8:	17c50513          	addi	a0,a0,380 # 8000c730 <tickslock>
    800065bc:	0017879b          	addiw	a5,a5,1
    800065c0:	00f72023          	sw	a5,0(a4)
    800065c4:	00001097          	auipc	ra,0x1
    800065c8:	534080e7          	jalr	1332(ra) # 80007af8 <release>
    800065cc:	f65ff06f          	j	80006530 <kerneltrap+0x8c>
    800065d0:	00001097          	auipc	ra,0x1
    800065d4:	090080e7          	jalr	144(ra) # 80007660 <uartintr>
    800065d8:	fa5ff06f          	j	8000657c <kerneltrap+0xd8>
    800065dc:	00003517          	auipc	a0,0x3
    800065e0:	fb450513          	addi	a0,a0,-76 # 80009590 <CONSOLE_STATUS+0x580>
    800065e4:	00000097          	auipc	ra,0x0
    800065e8:	718080e7          	jalr	1816(ra) # 80006cfc <panic>

00000000800065ec <clockintr>:
    800065ec:	fe010113          	addi	sp,sp,-32
    800065f0:	00813823          	sd	s0,16(sp)
    800065f4:	00913423          	sd	s1,8(sp)
    800065f8:	00113c23          	sd	ra,24(sp)
    800065fc:	02010413          	addi	s0,sp,32
    80006600:	00006497          	auipc	s1,0x6
    80006604:	13048493          	addi	s1,s1,304 # 8000c730 <tickslock>
    80006608:	00048513          	mv	a0,s1
    8000660c:	00001097          	auipc	ra,0x1
    80006610:	420080e7          	jalr	1056(ra) # 80007a2c <acquire>
    80006614:	00005717          	auipc	a4,0x5
    80006618:	fa070713          	addi	a4,a4,-96 # 8000b5b4 <ticks>
    8000661c:	00072783          	lw	a5,0(a4)
    80006620:	01013403          	ld	s0,16(sp)
    80006624:	01813083          	ld	ra,24(sp)
    80006628:	00048513          	mv	a0,s1
    8000662c:	0017879b          	addiw	a5,a5,1
    80006630:	00813483          	ld	s1,8(sp)
    80006634:	00f72023          	sw	a5,0(a4)
    80006638:	02010113          	addi	sp,sp,32
    8000663c:	00001317          	auipc	t1,0x1
    80006640:	4bc30067          	jr	1212(t1) # 80007af8 <release>

0000000080006644 <devintr>:
    80006644:	142027f3          	csrr	a5,scause
    80006648:	00000513          	li	a0,0
    8000664c:	0007c463          	bltz	a5,80006654 <devintr+0x10>
    80006650:	00008067          	ret
    80006654:	fe010113          	addi	sp,sp,-32
    80006658:	00813823          	sd	s0,16(sp)
    8000665c:	00113c23          	sd	ra,24(sp)
    80006660:	00913423          	sd	s1,8(sp)
    80006664:	02010413          	addi	s0,sp,32
    80006668:	0ff7f713          	andi	a4,a5,255
    8000666c:	00900693          	li	a3,9
    80006670:	04d70c63          	beq	a4,a3,800066c8 <devintr+0x84>
    80006674:	fff00713          	li	a4,-1
    80006678:	03f71713          	slli	a4,a4,0x3f
    8000667c:	00170713          	addi	a4,a4,1
    80006680:	00e78c63          	beq	a5,a4,80006698 <devintr+0x54>
    80006684:	01813083          	ld	ra,24(sp)
    80006688:	01013403          	ld	s0,16(sp)
    8000668c:	00813483          	ld	s1,8(sp)
    80006690:	02010113          	addi	sp,sp,32
    80006694:	00008067          	ret
    80006698:	00000097          	auipc	ra,0x0
    8000669c:	c8c080e7          	jalr	-884(ra) # 80006324 <cpuid>
    800066a0:	06050663          	beqz	a0,8000670c <devintr+0xc8>
    800066a4:	144027f3          	csrr	a5,sip
    800066a8:	ffd7f793          	andi	a5,a5,-3
    800066ac:	14479073          	csrw	sip,a5
    800066b0:	01813083          	ld	ra,24(sp)
    800066b4:	01013403          	ld	s0,16(sp)
    800066b8:	00813483          	ld	s1,8(sp)
    800066bc:	00200513          	li	a0,2
    800066c0:	02010113          	addi	sp,sp,32
    800066c4:	00008067          	ret
    800066c8:	00000097          	auipc	ra,0x0
    800066cc:	24c080e7          	jalr	588(ra) # 80006914 <plic_claim>
    800066d0:	00a00793          	li	a5,10
    800066d4:	00050493          	mv	s1,a0
    800066d8:	06f50663          	beq	a0,a5,80006744 <devintr+0x100>
    800066dc:	00100513          	li	a0,1
    800066e0:	fa0482e3          	beqz	s1,80006684 <devintr+0x40>
    800066e4:	00048593          	mv	a1,s1
    800066e8:	00003517          	auipc	a0,0x3
    800066ec:	ec850513          	addi	a0,a0,-312 # 800095b0 <CONSOLE_STATUS+0x5a0>
    800066f0:	00000097          	auipc	ra,0x0
    800066f4:	668080e7          	jalr	1640(ra) # 80006d58 <__printf>
    800066f8:	00048513          	mv	a0,s1
    800066fc:	00000097          	auipc	ra,0x0
    80006700:	250080e7          	jalr	592(ra) # 8000694c <plic_complete>
    80006704:	00100513          	li	a0,1
    80006708:	f7dff06f          	j	80006684 <devintr+0x40>
    8000670c:	00006517          	auipc	a0,0x6
    80006710:	02450513          	addi	a0,a0,36 # 8000c730 <tickslock>
    80006714:	00001097          	auipc	ra,0x1
    80006718:	318080e7          	jalr	792(ra) # 80007a2c <acquire>
    8000671c:	00005717          	auipc	a4,0x5
    80006720:	e9870713          	addi	a4,a4,-360 # 8000b5b4 <ticks>
    80006724:	00072783          	lw	a5,0(a4)
    80006728:	00006517          	auipc	a0,0x6
    8000672c:	00850513          	addi	a0,a0,8 # 8000c730 <tickslock>
    80006730:	0017879b          	addiw	a5,a5,1
    80006734:	00f72023          	sw	a5,0(a4)
    80006738:	00001097          	auipc	ra,0x1
    8000673c:	3c0080e7          	jalr	960(ra) # 80007af8 <release>
    80006740:	f65ff06f          	j	800066a4 <devintr+0x60>
    80006744:	00001097          	auipc	ra,0x1
    80006748:	f1c080e7          	jalr	-228(ra) # 80007660 <uartintr>
    8000674c:	fadff06f          	j	800066f8 <devintr+0xb4>

0000000080006750 <kernelvec>:
    80006750:	f0010113          	addi	sp,sp,-256
    80006754:	00113023          	sd	ra,0(sp)
    80006758:	00213423          	sd	sp,8(sp)
    8000675c:	00313823          	sd	gp,16(sp)
    80006760:	00413c23          	sd	tp,24(sp)
    80006764:	02513023          	sd	t0,32(sp)
    80006768:	02613423          	sd	t1,40(sp)
    8000676c:	02713823          	sd	t2,48(sp)
    80006770:	02813c23          	sd	s0,56(sp)
    80006774:	04913023          	sd	s1,64(sp)
    80006778:	04a13423          	sd	a0,72(sp)
    8000677c:	04b13823          	sd	a1,80(sp)
    80006780:	04c13c23          	sd	a2,88(sp)
    80006784:	06d13023          	sd	a3,96(sp)
    80006788:	06e13423          	sd	a4,104(sp)
    8000678c:	06f13823          	sd	a5,112(sp)
    80006790:	07013c23          	sd	a6,120(sp)
    80006794:	09113023          	sd	a7,128(sp)
    80006798:	09213423          	sd	s2,136(sp)
    8000679c:	09313823          	sd	s3,144(sp)
    800067a0:	09413c23          	sd	s4,152(sp)
    800067a4:	0b513023          	sd	s5,160(sp)
    800067a8:	0b613423          	sd	s6,168(sp)
    800067ac:	0b713823          	sd	s7,176(sp)
    800067b0:	0b813c23          	sd	s8,184(sp)
    800067b4:	0d913023          	sd	s9,192(sp)
    800067b8:	0da13423          	sd	s10,200(sp)
    800067bc:	0db13823          	sd	s11,208(sp)
    800067c0:	0dc13c23          	sd	t3,216(sp)
    800067c4:	0fd13023          	sd	t4,224(sp)
    800067c8:	0fe13423          	sd	t5,232(sp)
    800067cc:	0ff13823          	sd	t6,240(sp)
    800067d0:	cd5ff0ef          	jal	ra,800064a4 <kerneltrap>
    800067d4:	00013083          	ld	ra,0(sp)
    800067d8:	00813103          	ld	sp,8(sp)
    800067dc:	01013183          	ld	gp,16(sp)
    800067e0:	02013283          	ld	t0,32(sp)
    800067e4:	02813303          	ld	t1,40(sp)
    800067e8:	03013383          	ld	t2,48(sp)
    800067ec:	03813403          	ld	s0,56(sp)
    800067f0:	04013483          	ld	s1,64(sp)
    800067f4:	04813503          	ld	a0,72(sp)
    800067f8:	05013583          	ld	a1,80(sp)
    800067fc:	05813603          	ld	a2,88(sp)
    80006800:	06013683          	ld	a3,96(sp)
    80006804:	06813703          	ld	a4,104(sp)
    80006808:	07013783          	ld	a5,112(sp)
    8000680c:	07813803          	ld	a6,120(sp)
    80006810:	08013883          	ld	a7,128(sp)
    80006814:	08813903          	ld	s2,136(sp)
    80006818:	09013983          	ld	s3,144(sp)
    8000681c:	09813a03          	ld	s4,152(sp)
    80006820:	0a013a83          	ld	s5,160(sp)
    80006824:	0a813b03          	ld	s6,168(sp)
    80006828:	0b013b83          	ld	s7,176(sp)
    8000682c:	0b813c03          	ld	s8,184(sp)
    80006830:	0c013c83          	ld	s9,192(sp)
    80006834:	0c813d03          	ld	s10,200(sp)
    80006838:	0d013d83          	ld	s11,208(sp)
    8000683c:	0d813e03          	ld	t3,216(sp)
    80006840:	0e013e83          	ld	t4,224(sp)
    80006844:	0e813f03          	ld	t5,232(sp)
    80006848:	0f013f83          	ld	t6,240(sp)
    8000684c:	10010113          	addi	sp,sp,256
    80006850:	10200073          	sret
    80006854:	00000013          	nop
    80006858:	00000013          	nop
    8000685c:	00000013          	nop

0000000080006860 <timervec>:
    80006860:	34051573          	csrrw	a0,mscratch,a0
    80006864:	00b53023          	sd	a1,0(a0)
    80006868:	00c53423          	sd	a2,8(a0)
    8000686c:	00d53823          	sd	a3,16(a0)
    80006870:	01853583          	ld	a1,24(a0)
    80006874:	02053603          	ld	a2,32(a0)
    80006878:	0005b683          	ld	a3,0(a1)
    8000687c:	00c686b3          	add	a3,a3,a2
    80006880:	00d5b023          	sd	a3,0(a1)
    80006884:	00200593          	li	a1,2
    80006888:	14459073          	csrw	sip,a1
    8000688c:	01053683          	ld	a3,16(a0)
    80006890:	00853603          	ld	a2,8(a0)
    80006894:	00053583          	ld	a1,0(a0)
    80006898:	34051573          	csrrw	a0,mscratch,a0
    8000689c:	30200073          	mret

00000000800068a0 <plicinit>:
    800068a0:	ff010113          	addi	sp,sp,-16
    800068a4:	00813423          	sd	s0,8(sp)
    800068a8:	01010413          	addi	s0,sp,16
    800068ac:	00813403          	ld	s0,8(sp)
    800068b0:	0c0007b7          	lui	a5,0xc000
    800068b4:	00100713          	li	a4,1
    800068b8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800068bc:	00e7a223          	sw	a4,4(a5)
    800068c0:	01010113          	addi	sp,sp,16
    800068c4:	00008067          	ret

00000000800068c8 <plicinithart>:
    800068c8:	ff010113          	addi	sp,sp,-16
    800068cc:	00813023          	sd	s0,0(sp)
    800068d0:	00113423          	sd	ra,8(sp)
    800068d4:	01010413          	addi	s0,sp,16
    800068d8:	00000097          	auipc	ra,0x0
    800068dc:	a4c080e7          	jalr	-1460(ra) # 80006324 <cpuid>
    800068e0:	0085171b          	slliw	a4,a0,0x8
    800068e4:	0c0027b7          	lui	a5,0xc002
    800068e8:	00e787b3          	add	a5,a5,a4
    800068ec:	40200713          	li	a4,1026
    800068f0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800068f4:	00813083          	ld	ra,8(sp)
    800068f8:	00013403          	ld	s0,0(sp)
    800068fc:	00d5151b          	slliw	a0,a0,0xd
    80006900:	0c2017b7          	lui	a5,0xc201
    80006904:	00a78533          	add	a0,a5,a0
    80006908:	00052023          	sw	zero,0(a0)
    8000690c:	01010113          	addi	sp,sp,16
    80006910:	00008067          	ret

0000000080006914 <plic_claim>:
    80006914:	ff010113          	addi	sp,sp,-16
    80006918:	00813023          	sd	s0,0(sp)
    8000691c:	00113423          	sd	ra,8(sp)
    80006920:	01010413          	addi	s0,sp,16
    80006924:	00000097          	auipc	ra,0x0
    80006928:	a00080e7          	jalr	-1536(ra) # 80006324 <cpuid>
    8000692c:	00813083          	ld	ra,8(sp)
    80006930:	00013403          	ld	s0,0(sp)
    80006934:	00d5151b          	slliw	a0,a0,0xd
    80006938:	0c2017b7          	lui	a5,0xc201
    8000693c:	00a78533          	add	a0,a5,a0
    80006940:	00452503          	lw	a0,4(a0)
    80006944:	01010113          	addi	sp,sp,16
    80006948:	00008067          	ret

000000008000694c <plic_complete>:
    8000694c:	fe010113          	addi	sp,sp,-32
    80006950:	00813823          	sd	s0,16(sp)
    80006954:	00913423          	sd	s1,8(sp)
    80006958:	00113c23          	sd	ra,24(sp)
    8000695c:	02010413          	addi	s0,sp,32
    80006960:	00050493          	mv	s1,a0
    80006964:	00000097          	auipc	ra,0x0
    80006968:	9c0080e7          	jalr	-1600(ra) # 80006324 <cpuid>
    8000696c:	01813083          	ld	ra,24(sp)
    80006970:	01013403          	ld	s0,16(sp)
    80006974:	00d5179b          	slliw	a5,a0,0xd
    80006978:	0c201737          	lui	a4,0xc201
    8000697c:	00f707b3          	add	a5,a4,a5
    80006980:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80006984:	00813483          	ld	s1,8(sp)
    80006988:	02010113          	addi	sp,sp,32
    8000698c:	00008067          	ret

0000000080006990 <consolewrite>:
    80006990:	fb010113          	addi	sp,sp,-80
    80006994:	04813023          	sd	s0,64(sp)
    80006998:	04113423          	sd	ra,72(sp)
    8000699c:	02913c23          	sd	s1,56(sp)
    800069a0:	03213823          	sd	s2,48(sp)
    800069a4:	03313423          	sd	s3,40(sp)
    800069a8:	03413023          	sd	s4,32(sp)
    800069ac:	01513c23          	sd	s5,24(sp)
    800069b0:	05010413          	addi	s0,sp,80
    800069b4:	06c05c63          	blez	a2,80006a2c <consolewrite+0x9c>
    800069b8:	00060993          	mv	s3,a2
    800069bc:	00050a13          	mv	s4,a0
    800069c0:	00058493          	mv	s1,a1
    800069c4:	00000913          	li	s2,0
    800069c8:	fff00a93          	li	s5,-1
    800069cc:	01c0006f          	j	800069e8 <consolewrite+0x58>
    800069d0:	fbf44503          	lbu	a0,-65(s0)
    800069d4:	0019091b          	addiw	s2,s2,1
    800069d8:	00148493          	addi	s1,s1,1
    800069dc:	00001097          	auipc	ra,0x1
    800069e0:	a9c080e7          	jalr	-1380(ra) # 80007478 <uartputc>
    800069e4:	03298063          	beq	s3,s2,80006a04 <consolewrite+0x74>
    800069e8:	00048613          	mv	a2,s1
    800069ec:	00100693          	li	a3,1
    800069f0:	000a0593          	mv	a1,s4
    800069f4:	fbf40513          	addi	a0,s0,-65
    800069f8:	00000097          	auipc	ra,0x0
    800069fc:	9e4080e7          	jalr	-1564(ra) # 800063dc <either_copyin>
    80006a00:	fd5518e3          	bne	a0,s5,800069d0 <consolewrite+0x40>
    80006a04:	04813083          	ld	ra,72(sp)
    80006a08:	04013403          	ld	s0,64(sp)
    80006a0c:	03813483          	ld	s1,56(sp)
    80006a10:	02813983          	ld	s3,40(sp)
    80006a14:	02013a03          	ld	s4,32(sp)
    80006a18:	01813a83          	ld	s5,24(sp)
    80006a1c:	00090513          	mv	a0,s2
    80006a20:	03013903          	ld	s2,48(sp)
    80006a24:	05010113          	addi	sp,sp,80
    80006a28:	00008067          	ret
    80006a2c:	00000913          	li	s2,0
    80006a30:	fd5ff06f          	j	80006a04 <consolewrite+0x74>

0000000080006a34 <consoleread>:
    80006a34:	f9010113          	addi	sp,sp,-112
    80006a38:	06813023          	sd	s0,96(sp)
    80006a3c:	04913c23          	sd	s1,88(sp)
    80006a40:	05213823          	sd	s2,80(sp)
    80006a44:	05313423          	sd	s3,72(sp)
    80006a48:	05413023          	sd	s4,64(sp)
    80006a4c:	03513c23          	sd	s5,56(sp)
    80006a50:	03613823          	sd	s6,48(sp)
    80006a54:	03713423          	sd	s7,40(sp)
    80006a58:	03813023          	sd	s8,32(sp)
    80006a5c:	06113423          	sd	ra,104(sp)
    80006a60:	01913c23          	sd	s9,24(sp)
    80006a64:	07010413          	addi	s0,sp,112
    80006a68:	00060b93          	mv	s7,a2
    80006a6c:	00050913          	mv	s2,a0
    80006a70:	00058c13          	mv	s8,a1
    80006a74:	00060b1b          	sext.w	s6,a2
    80006a78:	00006497          	auipc	s1,0x6
    80006a7c:	ce048493          	addi	s1,s1,-800 # 8000c758 <cons>
    80006a80:	00400993          	li	s3,4
    80006a84:	fff00a13          	li	s4,-1
    80006a88:	00a00a93          	li	s5,10
    80006a8c:	05705e63          	blez	s7,80006ae8 <consoleread+0xb4>
    80006a90:	09c4a703          	lw	a4,156(s1)
    80006a94:	0984a783          	lw	a5,152(s1)
    80006a98:	0007071b          	sext.w	a4,a4
    80006a9c:	08e78463          	beq	a5,a4,80006b24 <consoleread+0xf0>
    80006aa0:	07f7f713          	andi	a4,a5,127
    80006aa4:	00e48733          	add	a4,s1,a4
    80006aa8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80006aac:	0017869b          	addiw	a3,a5,1
    80006ab0:	08d4ac23          	sw	a3,152(s1)
    80006ab4:	00070c9b          	sext.w	s9,a4
    80006ab8:	0b370663          	beq	a4,s3,80006b64 <consoleread+0x130>
    80006abc:	00100693          	li	a3,1
    80006ac0:	f9f40613          	addi	a2,s0,-97
    80006ac4:	000c0593          	mv	a1,s8
    80006ac8:	00090513          	mv	a0,s2
    80006acc:	f8e40fa3          	sb	a4,-97(s0)
    80006ad0:	00000097          	auipc	ra,0x0
    80006ad4:	8c0080e7          	jalr	-1856(ra) # 80006390 <either_copyout>
    80006ad8:	01450863          	beq	a0,s4,80006ae8 <consoleread+0xb4>
    80006adc:	001c0c13          	addi	s8,s8,1
    80006ae0:	fffb8b9b          	addiw	s7,s7,-1
    80006ae4:	fb5c94e3          	bne	s9,s5,80006a8c <consoleread+0x58>
    80006ae8:	000b851b          	sext.w	a0,s7
    80006aec:	06813083          	ld	ra,104(sp)
    80006af0:	06013403          	ld	s0,96(sp)
    80006af4:	05813483          	ld	s1,88(sp)
    80006af8:	05013903          	ld	s2,80(sp)
    80006afc:	04813983          	ld	s3,72(sp)
    80006b00:	04013a03          	ld	s4,64(sp)
    80006b04:	03813a83          	ld	s5,56(sp)
    80006b08:	02813b83          	ld	s7,40(sp)
    80006b0c:	02013c03          	ld	s8,32(sp)
    80006b10:	01813c83          	ld	s9,24(sp)
    80006b14:	40ab053b          	subw	a0,s6,a0
    80006b18:	03013b03          	ld	s6,48(sp)
    80006b1c:	07010113          	addi	sp,sp,112
    80006b20:	00008067          	ret
    80006b24:	00001097          	auipc	ra,0x1
    80006b28:	1d8080e7          	jalr	472(ra) # 80007cfc <push_on>
    80006b2c:	0984a703          	lw	a4,152(s1)
    80006b30:	09c4a783          	lw	a5,156(s1)
    80006b34:	0007879b          	sext.w	a5,a5
    80006b38:	fef70ce3          	beq	a4,a5,80006b30 <consoleread+0xfc>
    80006b3c:	00001097          	auipc	ra,0x1
    80006b40:	234080e7          	jalr	564(ra) # 80007d70 <pop_on>
    80006b44:	0984a783          	lw	a5,152(s1)
    80006b48:	07f7f713          	andi	a4,a5,127
    80006b4c:	00e48733          	add	a4,s1,a4
    80006b50:	01874703          	lbu	a4,24(a4)
    80006b54:	0017869b          	addiw	a3,a5,1
    80006b58:	08d4ac23          	sw	a3,152(s1)
    80006b5c:	00070c9b          	sext.w	s9,a4
    80006b60:	f5371ee3          	bne	a4,s3,80006abc <consoleread+0x88>
    80006b64:	000b851b          	sext.w	a0,s7
    80006b68:	f96bf2e3          	bgeu	s7,s6,80006aec <consoleread+0xb8>
    80006b6c:	08f4ac23          	sw	a5,152(s1)
    80006b70:	f7dff06f          	j	80006aec <consoleread+0xb8>

0000000080006b74 <consputc>:
    80006b74:	10000793          	li	a5,256
    80006b78:	00f50663          	beq	a0,a5,80006b84 <consputc+0x10>
    80006b7c:	00001317          	auipc	t1,0x1
    80006b80:	9f430067          	jr	-1548(t1) # 80007570 <uartputc_sync>
    80006b84:	ff010113          	addi	sp,sp,-16
    80006b88:	00113423          	sd	ra,8(sp)
    80006b8c:	00813023          	sd	s0,0(sp)
    80006b90:	01010413          	addi	s0,sp,16
    80006b94:	00800513          	li	a0,8
    80006b98:	00001097          	auipc	ra,0x1
    80006b9c:	9d8080e7          	jalr	-1576(ra) # 80007570 <uartputc_sync>
    80006ba0:	02000513          	li	a0,32
    80006ba4:	00001097          	auipc	ra,0x1
    80006ba8:	9cc080e7          	jalr	-1588(ra) # 80007570 <uartputc_sync>
    80006bac:	00013403          	ld	s0,0(sp)
    80006bb0:	00813083          	ld	ra,8(sp)
    80006bb4:	00800513          	li	a0,8
    80006bb8:	01010113          	addi	sp,sp,16
    80006bbc:	00001317          	auipc	t1,0x1
    80006bc0:	9b430067          	jr	-1612(t1) # 80007570 <uartputc_sync>

0000000080006bc4 <consoleintr>:
    80006bc4:	fe010113          	addi	sp,sp,-32
    80006bc8:	00813823          	sd	s0,16(sp)
    80006bcc:	00913423          	sd	s1,8(sp)
    80006bd0:	01213023          	sd	s2,0(sp)
    80006bd4:	00113c23          	sd	ra,24(sp)
    80006bd8:	02010413          	addi	s0,sp,32
    80006bdc:	00006917          	auipc	s2,0x6
    80006be0:	b7c90913          	addi	s2,s2,-1156 # 8000c758 <cons>
    80006be4:	00050493          	mv	s1,a0
    80006be8:	00090513          	mv	a0,s2
    80006bec:	00001097          	auipc	ra,0x1
    80006bf0:	e40080e7          	jalr	-448(ra) # 80007a2c <acquire>
    80006bf4:	02048c63          	beqz	s1,80006c2c <consoleintr+0x68>
    80006bf8:	0a092783          	lw	a5,160(s2)
    80006bfc:	09892703          	lw	a4,152(s2)
    80006c00:	07f00693          	li	a3,127
    80006c04:	40e7873b          	subw	a4,a5,a4
    80006c08:	02e6e263          	bltu	a3,a4,80006c2c <consoleintr+0x68>
    80006c0c:	00d00713          	li	a4,13
    80006c10:	04e48063          	beq	s1,a4,80006c50 <consoleintr+0x8c>
    80006c14:	07f7f713          	andi	a4,a5,127
    80006c18:	00e90733          	add	a4,s2,a4
    80006c1c:	0017879b          	addiw	a5,a5,1
    80006c20:	0af92023          	sw	a5,160(s2)
    80006c24:	00970c23          	sb	s1,24(a4)
    80006c28:	08f92e23          	sw	a5,156(s2)
    80006c2c:	01013403          	ld	s0,16(sp)
    80006c30:	01813083          	ld	ra,24(sp)
    80006c34:	00813483          	ld	s1,8(sp)
    80006c38:	00013903          	ld	s2,0(sp)
    80006c3c:	00006517          	auipc	a0,0x6
    80006c40:	b1c50513          	addi	a0,a0,-1252 # 8000c758 <cons>
    80006c44:	02010113          	addi	sp,sp,32
    80006c48:	00001317          	auipc	t1,0x1
    80006c4c:	eb030067          	jr	-336(t1) # 80007af8 <release>
    80006c50:	00a00493          	li	s1,10
    80006c54:	fc1ff06f          	j	80006c14 <consoleintr+0x50>

0000000080006c58 <consoleinit>:
    80006c58:	fe010113          	addi	sp,sp,-32
    80006c5c:	00113c23          	sd	ra,24(sp)
    80006c60:	00813823          	sd	s0,16(sp)
    80006c64:	00913423          	sd	s1,8(sp)
    80006c68:	02010413          	addi	s0,sp,32
    80006c6c:	00006497          	auipc	s1,0x6
    80006c70:	aec48493          	addi	s1,s1,-1300 # 8000c758 <cons>
    80006c74:	00048513          	mv	a0,s1
    80006c78:	00003597          	auipc	a1,0x3
    80006c7c:	99058593          	addi	a1,a1,-1648 # 80009608 <CONSOLE_STATUS+0x5f8>
    80006c80:	00001097          	auipc	ra,0x1
    80006c84:	d88080e7          	jalr	-632(ra) # 80007a08 <initlock>
    80006c88:	00000097          	auipc	ra,0x0
    80006c8c:	7ac080e7          	jalr	1964(ra) # 80007434 <uartinit>
    80006c90:	01813083          	ld	ra,24(sp)
    80006c94:	01013403          	ld	s0,16(sp)
    80006c98:	00000797          	auipc	a5,0x0
    80006c9c:	d9c78793          	addi	a5,a5,-612 # 80006a34 <consoleread>
    80006ca0:	0af4bc23          	sd	a5,184(s1)
    80006ca4:	00000797          	auipc	a5,0x0
    80006ca8:	cec78793          	addi	a5,a5,-788 # 80006990 <consolewrite>
    80006cac:	0cf4b023          	sd	a5,192(s1)
    80006cb0:	00813483          	ld	s1,8(sp)
    80006cb4:	02010113          	addi	sp,sp,32
    80006cb8:	00008067          	ret

0000000080006cbc <console_read>:
    80006cbc:	ff010113          	addi	sp,sp,-16
    80006cc0:	00813423          	sd	s0,8(sp)
    80006cc4:	01010413          	addi	s0,sp,16
    80006cc8:	00813403          	ld	s0,8(sp)
    80006ccc:	00006317          	auipc	t1,0x6
    80006cd0:	b4433303          	ld	t1,-1212(t1) # 8000c810 <devsw+0x10>
    80006cd4:	01010113          	addi	sp,sp,16
    80006cd8:	00030067          	jr	t1

0000000080006cdc <console_write>:
    80006cdc:	ff010113          	addi	sp,sp,-16
    80006ce0:	00813423          	sd	s0,8(sp)
    80006ce4:	01010413          	addi	s0,sp,16
    80006ce8:	00813403          	ld	s0,8(sp)
    80006cec:	00006317          	auipc	t1,0x6
    80006cf0:	b2c33303          	ld	t1,-1236(t1) # 8000c818 <devsw+0x18>
    80006cf4:	01010113          	addi	sp,sp,16
    80006cf8:	00030067          	jr	t1

0000000080006cfc <panic>:
    80006cfc:	fe010113          	addi	sp,sp,-32
    80006d00:	00113c23          	sd	ra,24(sp)
    80006d04:	00813823          	sd	s0,16(sp)
    80006d08:	00913423          	sd	s1,8(sp)
    80006d0c:	02010413          	addi	s0,sp,32
    80006d10:	00050493          	mv	s1,a0
    80006d14:	00003517          	auipc	a0,0x3
    80006d18:	8fc50513          	addi	a0,a0,-1796 # 80009610 <CONSOLE_STATUS+0x600>
    80006d1c:	00006797          	auipc	a5,0x6
    80006d20:	b807ae23          	sw	zero,-1124(a5) # 8000c8b8 <pr+0x18>
    80006d24:	00000097          	auipc	ra,0x0
    80006d28:	034080e7          	jalr	52(ra) # 80006d58 <__printf>
    80006d2c:	00048513          	mv	a0,s1
    80006d30:	00000097          	auipc	ra,0x0
    80006d34:	028080e7          	jalr	40(ra) # 80006d58 <__printf>
    80006d38:	00002517          	auipc	a0,0x2
    80006d3c:	67050513          	addi	a0,a0,1648 # 800093a8 <CONSOLE_STATUS+0x398>
    80006d40:	00000097          	auipc	ra,0x0
    80006d44:	018080e7          	jalr	24(ra) # 80006d58 <__printf>
    80006d48:	00100793          	li	a5,1
    80006d4c:	00005717          	auipc	a4,0x5
    80006d50:	86f72623          	sw	a5,-1940(a4) # 8000b5b8 <panicked>
    80006d54:	0000006f          	j	80006d54 <panic+0x58>

0000000080006d58 <__printf>:
    80006d58:	f3010113          	addi	sp,sp,-208
    80006d5c:	08813023          	sd	s0,128(sp)
    80006d60:	07313423          	sd	s3,104(sp)
    80006d64:	09010413          	addi	s0,sp,144
    80006d68:	05813023          	sd	s8,64(sp)
    80006d6c:	08113423          	sd	ra,136(sp)
    80006d70:	06913c23          	sd	s1,120(sp)
    80006d74:	07213823          	sd	s2,112(sp)
    80006d78:	07413023          	sd	s4,96(sp)
    80006d7c:	05513c23          	sd	s5,88(sp)
    80006d80:	05613823          	sd	s6,80(sp)
    80006d84:	05713423          	sd	s7,72(sp)
    80006d88:	03913c23          	sd	s9,56(sp)
    80006d8c:	03a13823          	sd	s10,48(sp)
    80006d90:	03b13423          	sd	s11,40(sp)
    80006d94:	00006317          	auipc	t1,0x6
    80006d98:	b0c30313          	addi	t1,t1,-1268 # 8000c8a0 <pr>
    80006d9c:	01832c03          	lw	s8,24(t1)
    80006da0:	00b43423          	sd	a1,8(s0)
    80006da4:	00c43823          	sd	a2,16(s0)
    80006da8:	00d43c23          	sd	a3,24(s0)
    80006dac:	02e43023          	sd	a4,32(s0)
    80006db0:	02f43423          	sd	a5,40(s0)
    80006db4:	03043823          	sd	a6,48(s0)
    80006db8:	03143c23          	sd	a7,56(s0)
    80006dbc:	00050993          	mv	s3,a0
    80006dc0:	4a0c1663          	bnez	s8,8000726c <__printf+0x514>
    80006dc4:	60098c63          	beqz	s3,800073dc <__printf+0x684>
    80006dc8:	0009c503          	lbu	a0,0(s3)
    80006dcc:	00840793          	addi	a5,s0,8
    80006dd0:	f6f43c23          	sd	a5,-136(s0)
    80006dd4:	00000493          	li	s1,0
    80006dd8:	22050063          	beqz	a0,80006ff8 <__printf+0x2a0>
    80006ddc:	00002a37          	lui	s4,0x2
    80006de0:	00018ab7          	lui	s5,0x18
    80006de4:	000f4b37          	lui	s6,0xf4
    80006de8:	00989bb7          	lui	s7,0x989
    80006dec:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80006df0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80006df4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80006df8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80006dfc:	00148c9b          	addiw	s9,s1,1
    80006e00:	02500793          	li	a5,37
    80006e04:	01998933          	add	s2,s3,s9
    80006e08:	38f51263          	bne	a0,a5,8000718c <__printf+0x434>
    80006e0c:	00094783          	lbu	a5,0(s2)
    80006e10:	00078c9b          	sext.w	s9,a5
    80006e14:	1e078263          	beqz	a5,80006ff8 <__printf+0x2a0>
    80006e18:	0024849b          	addiw	s1,s1,2
    80006e1c:	07000713          	li	a4,112
    80006e20:	00998933          	add	s2,s3,s1
    80006e24:	38e78a63          	beq	a5,a4,800071b8 <__printf+0x460>
    80006e28:	20f76863          	bltu	a4,a5,80007038 <__printf+0x2e0>
    80006e2c:	42a78863          	beq	a5,a0,8000725c <__printf+0x504>
    80006e30:	06400713          	li	a4,100
    80006e34:	40e79663          	bne	a5,a4,80007240 <__printf+0x4e8>
    80006e38:	f7843783          	ld	a5,-136(s0)
    80006e3c:	0007a603          	lw	a2,0(a5)
    80006e40:	00878793          	addi	a5,a5,8
    80006e44:	f6f43c23          	sd	a5,-136(s0)
    80006e48:	42064a63          	bltz	a2,8000727c <__printf+0x524>
    80006e4c:	00a00713          	li	a4,10
    80006e50:	02e677bb          	remuw	a5,a2,a4
    80006e54:	00002d97          	auipc	s11,0x2
    80006e58:	7e4d8d93          	addi	s11,s11,2020 # 80009638 <digits>
    80006e5c:	00900593          	li	a1,9
    80006e60:	0006051b          	sext.w	a0,a2
    80006e64:	00000c93          	li	s9,0
    80006e68:	02079793          	slli	a5,a5,0x20
    80006e6c:	0207d793          	srli	a5,a5,0x20
    80006e70:	00fd87b3          	add	a5,s11,a5
    80006e74:	0007c783          	lbu	a5,0(a5)
    80006e78:	02e656bb          	divuw	a3,a2,a4
    80006e7c:	f8f40023          	sb	a5,-128(s0)
    80006e80:	14c5d863          	bge	a1,a2,80006fd0 <__printf+0x278>
    80006e84:	06300593          	li	a1,99
    80006e88:	00100c93          	li	s9,1
    80006e8c:	02e6f7bb          	remuw	a5,a3,a4
    80006e90:	02079793          	slli	a5,a5,0x20
    80006e94:	0207d793          	srli	a5,a5,0x20
    80006e98:	00fd87b3          	add	a5,s11,a5
    80006e9c:	0007c783          	lbu	a5,0(a5)
    80006ea0:	02e6d73b          	divuw	a4,a3,a4
    80006ea4:	f8f400a3          	sb	a5,-127(s0)
    80006ea8:	12a5f463          	bgeu	a1,a0,80006fd0 <__printf+0x278>
    80006eac:	00a00693          	li	a3,10
    80006eb0:	00900593          	li	a1,9
    80006eb4:	02d777bb          	remuw	a5,a4,a3
    80006eb8:	02079793          	slli	a5,a5,0x20
    80006ebc:	0207d793          	srli	a5,a5,0x20
    80006ec0:	00fd87b3          	add	a5,s11,a5
    80006ec4:	0007c503          	lbu	a0,0(a5)
    80006ec8:	02d757bb          	divuw	a5,a4,a3
    80006ecc:	f8a40123          	sb	a0,-126(s0)
    80006ed0:	48e5f263          	bgeu	a1,a4,80007354 <__printf+0x5fc>
    80006ed4:	06300513          	li	a0,99
    80006ed8:	02d7f5bb          	remuw	a1,a5,a3
    80006edc:	02059593          	slli	a1,a1,0x20
    80006ee0:	0205d593          	srli	a1,a1,0x20
    80006ee4:	00bd85b3          	add	a1,s11,a1
    80006ee8:	0005c583          	lbu	a1,0(a1)
    80006eec:	02d7d7bb          	divuw	a5,a5,a3
    80006ef0:	f8b401a3          	sb	a1,-125(s0)
    80006ef4:	48e57263          	bgeu	a0,a4,80007378 <__printf+0x620>
    80006ef8:	3e700513          	li	a0,999
    80006efc:	02d7f5bb          	remuw	a1,a5,a3
    80006f00:	02059593          	slli	a1,a1,0x20
    80006f04:	0205d593          	srli	a1,a1,0x20
    80006f08:	00bd85b3          	add	a1,s11,a1
    80006f0c:	0005c583          	lbu	a1,0(a1)
    80006f10:	02d7d7bb          	divuw	a5,a5,a3
    80006f14:	f8b40223          	sb	a1,-124(s0)
    80006f18:	46e57663          	bgeu	a0,a4,80007384 <__printf+0x62c>
    80006f1c:	02d7f5bb          	remuw	a1,a5,a3
    80006f20:	02059593          	slli	a1,a1,0x20
    80006f24:	0205d593          	srli	a1,a1,0x20
    80006f28:	00bd85b3          	add	a1,s11,a1
    80006f2c:	0005c583          	lbu	a1,0(a1)
    80006f30:	02d7d7bb          	divuw	a5,a5,a3
    80006f34:	f8b402a3          	sb	a1,-123(s0)
    80006f38:	46ea7863          	bgeu	s4,a4,800073a8 <__printf+0x650>
    80006f3c:	02d7f5bb          	remuw	a1,a5,a3
    80006f40:	02059593          	slli	a1,a1,0x20
    80006f44:	0205d593          	srli	a1,a1,0x20
    80006f48:	00bd85b3          	add	a1,s11,a1
    80006f4c:	0005c583          	lbu	a1,0(a1)
    80006f50:	02d7d7bb          	divuw	a5,a5,a3
    80006f54:	f8b40323          	sb	a1,-122(s0)
    80006f58:	3eeaf863          	bgeu	s5,a4,80007348 <__printf+0x5f0>
    80006f5c:	02d7f5bb          	remuw	a1,a5,a3
    80006f60:	02059593          	slli	a1,a1,0x20
    80006f64:	0205d593          	srli	a1,a1,0x20
    80006f68:	00bd85b3          	add	a1,s11,a1
    80006f6c:	0005c583          	lbu	a1,0(a1)
    80006f70:	02d7d7bb          	divuw	a5,a5,a3
    80006f74:	f8b403a3          	sb	a1,-121(s0)
    80006f78:	42eb7e63          	bgeu	s6,a4,800073b4 <__printf+0x65c>
    80006f7c:	02d7f5bb          	remuw	a1,a5,a3
    80006f80:	02059593          	slli	a1,a1,0x20
    80006f84:	0205d593          	srli	a1,a1,0x20
    80006f88:	00bd85b3          	add	a1,s11,a1
    80006f8c:	0005c583          	lbu	a1,0(a1)
    80006f90:	02d7d7bb          	divuw	a5,a5,a3
    80006f94:	f8b40423          	sb	a1,-120(s0)
    80006f98:	42ebfc63          	bgeu	s7,a4,800073d0 <__printf+0x678>
    80006f9c:	02079793          	slli	a5,a5,0x20
    80006fa0:	0207d793          	srli	a5,a5,0x20
    80006fa4:	00fd8db3          	add	s11,s11,a5
    80006fa8:	000dc703          	lbu	a4,0(s11)
    80006fac:	00a00793          	li	a5,10
    80006fb0:	00900c93          	li	s9,9
    80006fb4:	f8e404a3          	sb	a4,-119(s0)
    80006fb8:	00065c63          	bgez	a2,80006fd0 <__printf+0x278>
    80006fbc:	f9040713          	addi	a4,s0,-112
    80006fc0:	00f70733          	add	a4,a4,a5
    80006fc4:	02d00693          	li	a3,45
    80006fc8:	fed70823          	sb	a3,-16(a4)
    80006fcc:	00078c93          	mv	s9,a5
    80006fd0:	f8040793          	addi	a5,s0,-128
    80006fd4:	01978cb3          	add	s9,a5,s9
    80006fd8:	f7f40d13          	addi	s10,s0,-129
    80006fdc:	000cc503          	lbu	a0,0(s9)
    80006fe0:	fffc8c93          	addi	s9,s9,-1
    80006fe4:	00000097          	auipc	ra,0x0
    80006fe8:	b90080e7          	jalr	-1136(ra) # 80006b74 <consputc>
    80006fec:	ffac98e3          	bne	s9,s10,80006fdc <__printf+0x284>
    80006ff0:	00094503          	lbu	a0,0(s2)
    80006ff4:	e00514e3          	bnez	a0,80006dfc <__printf+0xa4>
    80006ff8:	1a0c1663          	bnez	s8,800071a4 <__printf+0x44c>
    80006ffc:	08813083          	ld	ra,136(sp)
    80007000:	08013403          	ld	s0,128(sp)
    80007004:	07813483          	ld	s1,120(sp)
    80007008:	07013903          	ld	s2,112(sp)
    8000700c:	06813983          	ld	s3,104(sp)
    80007010:	06013a03          	ld	s4,96(sp)
    80007014:	05813a83          	ld	s5,88(sp)
    80007018:	05013b03          	ld	s6,80(sp)
    8000701c:	04813b83          	ld	s7,72(sp)
    80007020:	04013c03          	ld	s8,64(sp)
    80007024:	03813c83          	ld	s9,56(sp)
    80007028:	03013d03          	ld	s10,48(sp)
    8000702c:	02813d83          	ld	s11,40(sp)
    80007030:	0d010113          	addi	sp,sp,208
    80007034:	00008067          	ret
    80007038:	07300713          	li	a4,115
    8000703c:	1ce78a63          	beq	a5,a4,80007210 <__printf+0x4b8>
    80007040:	07800713          	li	a4,120
    80007044:	1ee79e63          	bne	a5,a4,80007240 <__printf+0x4e8>
    80007048:	f7843783          	ld	a5,-136(s0)
    8000704c:	0007a703          	lw	a4,0(a5)
    80007050:	00878793          	addi	a5,a5,8
    80007054:	f6f43c23          	sd	a5,-136(s0)
    80007058:	28074263          	bltz	a4,800072dc <__printf+0x584>
    8000705c:	00002d97          	auipc	s11,0x2
    80007060:	5dcd8d93          	addi	s11,s11,1500 # 80009638 <digits>
    80007064:	00f77793          	andi	a5,a4,15
    80007068:	00fd87b3          	add	a5,s11,a5
    8000706c:	0007c683          	lbu	a3,0(a5)
    80007070:	00f00613          	li	a2,15
    80007074:	0007079b          	sext.w	a5,a4
    80007078:	f8d40023          	sb	a3,-128(s0)
    8000707c:	0047559b          	srliw	a1,a4,0x4
    80007080:	0047569b          	srliw	a3,a4,0x4
    80007084:	00000c93          	li	s9,0
    80007088:	0ee65063          	bge	a2,a4,80007168 <__printf+0x410>
    8000708c:	00f6f693          	andi	a3,a3,15
    80007090:	00dd86b3          	add	a3,s11,a3
    80007094:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80007098:	0087d79b          	srliw	a5,a5,0x8
    8000709c:	00100c93          	li	s9,1
    800070a0:	f8d400a3          	sb	a3,-127(s0)
    800070a4:	0cb67263          	bgeu	a2,a1,80007168 <__printf+0x410>
    800070a8:	00f7f693          	andi	a3,a5,15
    800070ac:	00dd86b3          	add	a3,s11,a3
    800070b0:	0006c583          	lbu	a1,0(a3)
    800070b4:	00f00613          	li	a2,15
    800070b8:	0047d69b          	srliw	a3,a5,0x4
    800070bc:	f8b40123          	sb	a1,-126(s0)
    800070c0:	0047d593          	srli	a1,a5,0x4
    800070c4:	28f67e63          	bgeu	a2,a5,80007360 <__printf+0x608>
    800070c8:	00f6f693          	andi	a3,a3,15
    800070cc:	00dd86b3          	add	a3,s11,a3
    800070d0:	0006c503          	lbu	a0,0(a3)
    800070d4:	0087d813          	srli	a6,a5,0x8
    800070d8:	0087d69b          	srliw	a3,a5,0x8
    800070dc:	f8a401a3          	sb	a0,-125(s0)
    800070e0:	28b67663          	bgeu	a2,a1,8000736c <__printf+0x614>
    800070e4:	00f6f693          	andi	a3,a3,15
    800070e8:	00dd86b3          	add	a3,s11,a3
    800070ec:	0006c583          	lbu	a1,0(a3)
    800070f0:	00c7d513          	srli	a0,a5,0xc
    800070f4:	00c7d69b          	srliw	a3,a5,0xc
    800070f8:	f8b40223          	sb	a1,-124(s0)
    800070fc:	29067a63          	bgeu	a2,a6,80007390 <__printf+0x638>
    80007100:	00f6f693          	andi	a3,a3,15
    80007104:	00dd86b3          	add	a3,s11,a3
    80007108:	0006c583          	lbu	a1,0(a3)
    8000710c:	0107d813          	srli	a6,a5,0x10
    80007110:	0107d69b          	srliw	a3,a5,0x10
    80007114:	f8b402a3          	sb	a1,-123(s0)
    80007118:	28a67263          	bgeu	a2,a0,8000739c <__printf+0x644>
    8000711c:	00f6f693          	andi	a3,a3,15
    80007120:	00dd86b3          	add	a3,s11,a3
    80007124:	0006c683          	lbu	a3,0(a3)
    80007128:	0147d79b          	srliw	a5,a5,0x14
    8000712c:	f8d40323          	sb	a3,-122(s0)
    80007130:	21067663          	bgeu	a2,a6,8000733c <__printf+0x5e4>
    80007134:	02079793          	slli	a5,a5,0x20
    80007138:	0207d793          	srli	a5,a5,0x20
    8000713c:	00fd8db3          	add	s11,s11,a5
    80007140:	000dc683          	lbu	a3,0(s11)
    80007144:	00800793          	li	a5,8
    80007148:	00700c93          	li	s9,7
    8000714c:	f8d403a3          	sb	a3,-121(s0)
    80007150:	00075c63          	bgez	a4,80007168 <__printf+0x410>
    80007154:	f9040713          	addi	a4,s0,-112
    80007158:	00f70733          	add	a4,a4,a5
    8000715c:	02d00693          	li	a3,45
    80007160:	fed70823          	sb	a3,-16(a4)
    80007164:	00078c93          	mv	s9,a5
    80007168:	f8040793          	addi	a5,s0,-128
    8000716c:	01978cb3          	add	s9,a5,s9
    80007170:	f7f40d13          	addi	s10,s0,-129
    80007174:	000cc503          	lbu	a0,0(s9)
    80007178:	fffc8c93          	addi	s9,s9,-1
    8000717c:	00000097          	auipc	ra,0x0
    80007180:	9f8080e7          	jalr	-1544(ra) # 80006b74 <consputc>
    80007184:	ff9d18e3          	bne	s10,s9,80007174 <__printf+0x41c>
    80007188:	0100006f          	j	80007198 <__printf+0x440>
    8000718c:	00000097          	auipc	ra,0x0
    80007190:	9e8080e7          	jalr	-1560(ra) # 80006b74 <consputc>
    80007194:	000c8493          	mv	s1,s9
    80007198:	00094503          	lbu	a0,0(s2)
    8000719c:	c60510e3          	bnez	a0,80006dfc <__printf+0xa4>
    800071a0:	e40c0ee3          	beqz	s8,80006ffc <__printf+0x2a4>
    800071a4:	00005517          	auipc	a0,0x5
    800071a8:	6fc50513          	addi	a0,a0,1788 # 8000c8a0 <pr>
    800071ac:	00001097          	auipc	ra,0x1
    800071b0:	94c080e7          	jalr	-1716(ra) # 80007af8 <release>
    800071b4:	e49ff06f          	j	80006ffc <__printf+0x2a4>
    800071b8:	f7843783          	ld	a5,-136(s0)
    800071bc:	03000513          	li	a0,48
    800071c0:	01000d13          	li	s10,16
    800071c4:	00878713          	addi	a4,a5,8
    800071c8:	0007bc83          	ld	s9,0(a5)
    800071cc:	f6e43c23          	sd	a4,-136(s0)
    800071d0:	00000097          	auipc	ra,0x0
    800071d4:	9a4080e7          	jalr	-1628(ra) # 80006b74 <consputc>
    800071d8:	07800513          	li	a0,120
    800071dc:	00000097          	auipc	ra,0x0
    800071e0:	998080e7          	jalr	-1640(ra) # 80006b74 <consputc>
    800071e4:	00002d97          	auipc	s11,0x2
    800071e8:	454d8d93          	addi	s11,s11,1108 # 80009638 <digits>
    800071ec:	03ccd793          	srli	a5,s9,0x3c
    800071f0:	00fd87b3          	add	a5,s11,a5
    800071f4:	0007c503          	lbu	a0,0(a5)
    800071f8:	fffd0d1b          	addiw	s10,s10,-1
    800071fc:	004c9c93          	slli	s9,s9,0x4
    80007200:	00000097          	auipc	ra,0x0
    80007204:	974080e7          	jalr	-1676(ra) # 80006b74 <consputc>
    80007208:	fe0d12e3          	bnez	s10,800071ec <__printf+0x494>
    8000720c:	f8dff06f          	j	80007198 <__printf+0x440>
    80007210:	f7843783          	ld	a5,-136(s0)
    80007214:	0007bc83          	ld	s9,0(a5)
    80007218:	00878793          	addi	a5,a5,8
    8000721c:	f6f43c23          	sd	a5,-136(s0)
    80007220:	000c9a63          	bnez	s9,80007234 <__printf+0x4dc>
    80007224:	1080006f          	j	8000732c <__printf+0x5d4>
    80007228:	001c8c93          	addi	s9,s9,1
    8000722c:	00000097          	auipc	ra,0x0
    80007230:	948080e7          	jalr	-1720(ra) # 80006b74 <consputc>
    80007234:	000cc503          	lbu	a0,0(s9)
    80007238:	fe0518e3          	bnez	a0,80007228 <__printf+0x4d0>
    8000723c:	f5dff06f          	j	80007198 <__printf+0x440>
    80007240:	02500513          	li	a0,37
    80007244:	00000097          	auipc	ra,0x0
    80007248:	930080e7          	jalr	-1744(ra) # 80006b74 <consputc>
    8000724c:	000c8513          	mv	a0,s9
    80007250:	00000097          	auipc	ra,0x0
    80007254:	924080e7          	jalr	-1756(ra) # 80006b74 <consputc>
    80007258:	f41ff06f          	j	80007198 <__printf+0x440>
    8000725c:	02500513          	li	a0,37
    80007260:	00000097          	auipc	ra,0x0
    80007264:	914080e7          	jalr	-1772(ra) # 80006b74 <consputc>
    80007268:	f31ff06f          	j	80007198 <__printf+0x440>
    8000726c:	00030513          	mv	a0,t1
    80007270:	00000097          	auipc	ra,0x0
    80007274:	7bc080e7          	jalr	1980(ra) # 80007a2c <acquire>
    80007278:	b4dff06f          	j	80006dc4 <__printf+0x6c>
    8000727c:	40c0053b          	negw	a0,a2
    80007280:	00a00713          	li	a4,10
    80007284:	02e576bb          	remuw	a3,a0,a4
    80007288:	00002d97          	auipc	s11,0x2
    8000728c:	3b0d8d93          	addi	s11,s11,944 # 80009638 <digits>
    80007290:	ff700593          	li	a1,-9
    80007294:	02069693          	slli	a3,a3,0x20
    80007298:	0206d693          	srli	a3,a3,0x20
    8000729c:	00dd86b3          	add	a3,s11,a3
    800072a0:	0006c683          	lbu	a3,0(a3)
    800072a4:	02e557bb          	divuw	a5,a0,a4
    800072a8:	f8d40023          	sb	a3,-128(s0)
    800072ac:	10b65e63          	bge	a2,a1,800073c8 <__printf+0x670>
    800072b0:	06300593          	li	a1,99
    800072b4:	02e7f6bb          	remuw	a3,a5,a4
    800072b8:	02069693          	slli	a3,a3,0x20
    800072bc:	0206d693          	srli	a3,a3,0x20
    800072c0:	00dd86b3          	add	a3,s11,a3
    800072c4:	0006c683          	lbu	a3,0(a3)
    800072c8:	02e7d73b          	divuw	a4,a5,a4
    800072cc:	00200793          	li	a5,2
    800072d0:	f8d400a3          	sb	a3,-127(s0)
    800072d4:	bca5ece3          	bltu	a1,a0,80006eac <__printf+0x154>
    800072d8:	ce5ff06f          	j	80006fbc <__printf+0x264>
    800072dc:	40e007bb          	negw	a5,a4
    800072e0:	00002d97          	auipc	s11,0x2
    800072e4:	358d8d93          	addi	s11,s11,856 # 80009638 <digits>
    800072e8:	00f7f693          	andi	a3,a5,15
    800072ec:	00dd86b3          	add	a3,s11,a3
    800072f0:	0006c583          	lbu	a1,0(a3)
    800072f4:	ff100613          	li	a2,-15
    800072f8:	0047d69b          	srliw	a3,a5,0x4
    800072fc:	f8b40023          	sb	a1,-128(s0)
    80007300:	0047d59b          	srliw	a1,a5,0x4
    80007304:	0ac75e63          	bge	a4,a2,800073c0 <__printf+0x668>
    80007308:	00f6f693          	andi	a3,a3,15
    8000730c:	00dd86b3          	add	a3,s11,a3
    80007310:	0006c603          	lbu	a2,0(a3)
    80007314:	00f00693          	li	a3,15
    80007318:	0087d79b          	srliw	a5,a5,0x8
    8000731c:	f8c400a3          	sb	a2,-127(s0)
    80007320:	d8b6e4e3          	bltu	a3,a1,800070a8 <__printf+0x350>
    80007324:	00200793          	li	a5,2
    80007328:	e2dff06f          	j	80007154 <__printf+0x3fc>
    8000732c:	00002c97          	auipc	s9,0x2
    80007330:	2ecc8c93          	addi	s9,s9,748 # 80009618 <CONSOLE_STATUS+0x608>
    80007334:	02800513          	li	a0,40
    80007338:	ef1ff06f          	j	80007228 <__printf+0x4d0>
    8000733c:	00700793          	li	a5,7
    80007340:	00600c93          	li	s9,6
    80007344:	e0dff06f          	j	80007150 <__printf+0x3f8>
    80007348:	00700793          	li	a5,7
    8000734c:	00600c93          	li	s9,6
    80007350:	c69ff06f          	j	80006fb8 <__printf+0x260>
    80007354:	00300793          	li	a5,3
    80007358:	00200c93          	li	s9,2
    8000735c:	c5dff06f          	j	80006fb8 <__printf+0x260>
    80007360:	00300793          	li	a5,3
    80007364:	00200c93          	li	s9,2
    80007368:	de9ff06f          	j	80007150 <__printf+0x3f8>
    8000736c:	00400793          	li	a5,4
    80007370:	00300c93          	li	s9,3
    80007374:	dddff06f          	j	80007150 <__printf+0x3f8>
    80007378:	00400793          	li	a5,4
    8000737c:	00300c93          	li	s9,3
    80007380:	c39ff06f          	j	80006fb8 <__printf+0x260>
    80007384:	00500793          	li	a5,5
    80007388:	00400c93          	li	s9,4
    8000738c:	c2dff06f          	j	80006fb8 <__printf+0x260>
    80007390:	00500793          	li	a5,5
    80007394:	00400c93          	li	s9,4
    80007398:	db9ff06f          	j	80007150 <__printf+0x3f8>
    8000739c:	00600793          	li	a5,6
    800073a0:	00500c93          	li	s9,5
    800073a4:	dadff06f          	j	80007150 <__printf+0x3f8>
    800073a8:	00600793          	li	a5,6
    800073ac:	00500c93          	li	s9,5
    800073b0:	c09ff06f          	j	80006fb8 <__printf+0x260>
    800073b4:	00800793          	li	a5,8
    800073b8:	00700c93          	li	s9,7
    800073bc:	bfdff06f          	j	80006fb8 <__printf+0x260>
    800073c0:	00100793          	li	a5,1
    800073c4:	d91ff06f          	j	80007154 <__printf+0x3fc>
    800073c8:	00100793          	li	a5,1
    800073cc:	bf1ff06f          	j	80006fbc <__printf+0x264>
    800073d0:	00900793          	li	a5,9
    800073d4:	00800c93          	li	s9,8
    800073d8:	be1ff06f          	j	80006fb8 <__printf+0x260>
    800073dc:	00002517          	auipc	a0,0x2
    800073e0:	24450513          	addi	a0,a0,580 # 80009620 <CONSOLE_STATUS+0x610>
    800073e4:	00000097          	auipc	ra,0x0
    800073e8:	918080e7          	jalr	-1768(ra) # 80006cfc <panic>

00000000800073ec <printfinit>:
    800073ec:	fe010113          	addi	sp,sp,-32
    800073f0:	00813823          	sd	s0,16(sp)
    800073f4:	00913423          	sd	s1,8(sp)
    800073f8:	00113c23          	sd	ra,24(sp)
    800073fc:	02010413          	addi	s0,sp,32
    80007400:	00005497          	auipc	s1,0x5
    80007404:	4a048493          	addi	s1,s1,1184 # 8000c8a0 <pr>
    80007408:	00048513          	mv	a0,s1
    8000740c:	00002597          	auipc	a1,0x2
    80007410:	22458593          	addi	a1,a1,548 # 80009630 <CONSOLE_STATUS+0x620>
    80007414:	00000097          	auipc	ra,0x0
    80007418:	5f4080e7          	jalr	1524(ra) # 80007a08 <initlock>
    8000741c:	01813083          	ld	ra,24(sp)
    80007420:	01013403          	ld	s0,16(sp)
    80007424:	0004ac23          	sw	zero,24(s1)
    80007428:	00813483          	ld	s1,8(sp)
    8000742c:	02010113          	addi	sp,sp,32
    80007430:	00008067          	ret

0000000080007434 <uartinit>:
    80007434:	ff010113          	addi	sp,sp,-16
    80007438:	00813423          	sd	s0,8(sp)
    8000743c:	01010413          	addi	s0,sp,16
    80007440:	100007b7          	lui	a5,0x10000
    80007444:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80007448:	f8000713          	li	a4,-128
    8000744c:	00e781a3          	sb	a4,3(a5)
    80007450:	00300713          	li	a4,3
    80007454:	00e78023          	sb	a4,0(a5)
    80007458:	000780a3          	sb	zero,1(a5)
    8000745c:	00e781a3          	sb	a4,3(a5)
    80007460:	00700693          	li	a3,7
    80007464:	00d78123          	sb	a3,2(a5)
    80007468:	00e780a3          	sb	a4,1(a5)
    8000746c:	00813403          	ld	s0,8(sp)
    80007470:	01010113          	addi	sp,sp,16
    80007474:	00008067          	ret

0000000080007478 <uartputc>:
    80007478:	00004797          	auipc	a5,0x4
    8000747c:	1407a783          	lw	a5,320(a5) # 8000b5b8 <panicked>
    80007480:	00078463          	beqz	a5,80007488 <uartputc+0x10>
    80007484:	0000006f          	j	80007484 <uartputc+0xc>
    80007488:	fd010113          	addi	sp,sp,-48
    8000748c:	02813023          	sd	s0,32(sp)
    80007490:	00913c23          	sd	s1,24(sp)
    80007494:	01213823          	sd	s2,16(sp)
    80007498:	01313423          	sd	s3,8(sp)
    8000749c:	02113423          	sd	ra,40(sp)
    800074a0:	03010413          	addi	s0,sp,48
    800074a4:	00004917          	auipc	s2,0x4
    800074a8:	11c90913          	addi	s2,s2,284 # 8000b5c0 <uart_tx_r>
    800074ac:	00093783          	ld	a5,0(s2)
    800074b0:	00004497          	auipc	s1,0x4
    800074b4:	11848493          	addi	s1,s1,280 # 8000b5c8 <uart_tx_w>
    800074b8:	0004b703          	ld	a4,0(s1)
    800074bc:	02078693          	addi	a3,a5,32
    800074c0:	00050993          	mv	s3,a0
    800074c4:	02e69c63          	bne	a3,a4,800074fc <uartputc+0x84>
    800074c8:	00001097          	auipc	ra,0x1
    800074cc:	834080e7          	jalr	-1996(ra) # 80007cfc <push_on>
    800074d0:	00093783          	ld	a5,0(s2)
    800074d4:	0004b703          	ld	a4,0(s1)
    800074d8:	02078793          	addi	a5,a5,32
    800074dc:	00e79463          	bne	a5,a4,800074e4 <uartputc+0x6c>
    800074e0:	0000006f          	j	800074e0 <uartputc+0x68>
    800074e4:	00001097          	auipc	ra,0x1
    800074e8:	88c080e7          	jalr	-1908(ra) # 80007d70 <pop_on>
    800074ec:	00093783          	ld	a5,0(s2)
    800074f0:	0004b703          	ld	a4,0(s1)
    800074f4:	02078693          	addi	a3,a5,32
    800074f8:	fce688e3          	beq	a3,a4,800074c8 <uartputc+0x50>
    800074fc:	01f77693          	andi	a3,a4,31
    80007500:	00005597          	auipc	a1,0x5
    80007504:	3c058593          	addi	a1,a1,960 # 8000c8c0 <uart_tx_buf>
    80007508:	00d586b3          	add	a3,a1,a3
    8000750c:	00170713          	addi	a4,a4,1
    80007510:	01368023          	sb	s3,0(a3)
    80007514:	00e4b023          	sd	a4,0(s1)
    80007518:	10000637          	lui	a2,0x10000
    8000751c:	02f71063          	bne	a4,a5,8000753c <uartputc+0xc4>
    80007520:	0340006f          	j	80007554 <uartputc+0xdc>
    80007524:	00074703          	lbu	a4,0(a4)
    80007528:	00f93023          	sd	a5,0(s2)
    8000752c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80007530:	00093783          	ld	a5,0(s2)
    80007534:	0004b703          	ld	a4,0(s1)
    80007538:	00f70e63          	beq	a4,a5,80007554 <uartputc+0xdc>
    8000753c:	00564683          	lbu	a3,5(a2)
    80007540:	01f7f713          	andi	a4,a5,31
    80007544:	00e58733          	add	a4,a1,a4
    80007548:	0206f693          	andi	a3,a3,32
    8000754c:	00178793          	addi	a5,a5,1
    80007550:	fc069ae3          	bnez	a3,80007524 <uartputc+0xac>
    80007554:	02813083          	ld	ra,40(sp)
    80007558:	02013403          	ld	s0,32(sp)
    8000755c:	01813483          	ld	s1,24(sp)
    80007560:	01013903          	ld	s2,16(sp)
    80007564:	00813983          	ld	s3,8(sp)
    80007568:	03010113          	addi	sp,sp,48
    8000756c:	00008067          	ret

0000000080007570 <uartputc_sync>:
    80007570:	ff010113          	addi	sp,sp,-16
    80007574:	00813423          	sd	s0,8(sp)
    80007578:	01010413          	addi	s0,sp,16
    8000757c:	00004717          	auipc	a4,0x4
    80007580:	03c72703          	lw	a4,60(a4) # 8000b5b8 <panicked>
    80007584:	02071663          	bnez	a4,800075b0 <uartputc_sync+0x40>
    80007588:	00050793          	mv	a5,a0
    8000758c:	100006b7          	lui	a3,0x10000
    80007590:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80007594:	02077713          	andi	a4,a4,32
    80007598:	fe070ce3          	beqz	a4,80007590 <uartputc_sync+0x20>
    8000759c:	0ff7f793          	andi	a5,a5,255
    800075a0:	00f68023          	sb	a5,0(a3)
    800075a4:	00813403          	ld	s0,8(sp)
    800075a8:	01010113          	addi	sp,sp,16
    800075ac:	00008067          	ret
    800075b0:	0000006f          	j	800075b0 <uartputc_sync+0x40>

00000000800075b4 <uartstart>:
    800075b4:	ff010113          	addi	sp,sp,-16
    800075b8:	00813423          	sd	s0,8(sp)
    800075bc:	01010413          	addi	s0,sp,16
    800075c0:	00004617          	auipc	a2,0x4
    800075c4:	00060613          	mv	a2,a2
    800075c8:	00004517          	auipc	a0,0x4
    800075cc:	00050513          	mv	a0,a0
    800075d0:	00063783          	ld	a5,0(a2) # 8000b5c0 <uart_tx_r>
    800075d4:	00053703          	ld	a4,0(a0) # 8000b5c8 <uart_tx_w>
    800075d8:	04f70263          	beq	a4,a5,8000761c <uartstart+0x68>
    800075dc:	100005b7          	lui	a1,0x10000
    800075e0:	00005817          	auipc	a6,0x5
    800075e4:	2e080813          	addi	a6,a6,736 # 8000c8c0 <uart_tx_buf>
    800075e8:	01c0006f          	j	80007604 <uartstart+0x50>
    800075ec:	0006c703          	lbu	a4,0(a3)
    800075f0:	00f63023          	sd	a5,0(a2)
    800075f4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800075f8:	00063783          	ld	a5,0(a2)
    800075fc:	00053703          	ld	a4,0(a0)
    80007600:	00f70e63          	beq	a4,a5,8000761c <uartstart+0x68>
    80007604:	01f7f713          	andi	a4,a5,31
    80007608:	00e806b3          	add	a3,a6,a4
    8000760c:	0055c703          	lbu	a4,5(a1)
    80007610:	00178793          	addi	a5,a5,1
    80007614:	02077713          	andi	a4,a4,32
    80007618:	fc071ae3          	bnez	a4,800075ec <uartstart+0x38>
    8000761c:	00813403          	ld	s0,8(sp)
    80007620:	01010113          	addi	sp,sp,16
    80007624:	00008067          	ret

0000000080007628 <uartgetc>:
    80007628:	ff010113          	addi	sp,sp,-16
    8000762c:	00813423          	sd	s0,8(sp)
    80007630:	01010413          	addi	s0,sp,16
    80007634:	10000737          	lui	a4,0x10000
    80007638:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000763c:	0017f793          	andi	a5,a5,1
    80007640:	00078c63          	beqz	a5,80007658 <uartgetc+0x30>
    80007644:	00074503          	lbu	a0,0(a4)
    80007648:	0ff57513          	andi	a0,a0,255
    8000764c:	00813403          	ld	s0,8(sp)
    80007650:	01010113          	addi	sp,sp,16
    80007654:	00008067          	ret
    80007658:	fff00513          	li	a0,-1
    8000765c:	ff1ff06f          	j	8000764c <uartgetc+0x24>

0000000080007660 <uartintr>:
    80007660:	100007b7          	lui	a5,0x10000
    80007664:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80007668:	0017f793          	andi	a5,a5,1
    8000766c:	0a078463          	beqz	a5,80007714 <uartintr+0xb4>
    80007670:	fe010113          	addi	sp,sp,-32
    80007674:	00813823          	sd	s0,16(sp)
    80007678:	00913423          	sd	s1,8(sp)
    8000767c:	00113c23          	sd	ra,24(sp)
    80007680:	02010413          	addi	s0,sp,32
    80007684:	100004b7          	lui	s1,0x10000
    80007688:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000768c:	0ff57513          	andi	a0,a0,255
    80007690:	fffff097          	auipc	ra,0xfffff
    80007694:	534080e7          	jalr	1332(ra) # 80006bc4 <consoleintr>
    80007698:	0054c783          	lbu	a5,5(s1)
    8000769c:	0017f793          	andi	a5,a5,1
    800076a0:	fe0794e3          	bnez	a5,80007688 <uartintr+0x28>
    800076a4:	00004617          	auipc	a2,0x4
    800076a8:	f1c60613          	addi	a2,a2,-228 # 8000b5c0 <uart_tx_r>
    800076ac:	00004517          	auipc	a0,0x4
    800076b0:	f1c50513          	addi	a0,a0,-228 # 8000b5c8 <uart_tx_w>
    800076b4:	00063783          	ld	a5,0(a2)
    800076b8:	00053703          	ld	a4,0(a0)
    800076bc:	04f70263          	beq	a4,a5,80007700 <uartintr+0xa0>
    800076c0:	100005b7          	lui	a1,0x10000
    800076c4:	00005817          	auipc	a6,0x5
    800076c8:	1fc80813          	addi	a6,a6,508 # 8000c8c0 <uart_tx_buf>
    800076cc:	01c0006f          	j	800076e8 <uartintr+0x88>
    800076d0:	0006c703          	lbu	a4,0(a3)
    800076d4:	00f63023          	sd	a5,0(a2)
    800076d8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800076dc:	00063783          	ld	a5,0(a2)
    800076e0:	00053703          	ld	a4,0(a0)
    800076e4:	00f70e63          	beq	a4,a5,80007700 <uartintr+0xa0>
    800076e8:	01f7f713          	andi	a4,a5,31
    800076ec:	00e806b3          	add	a3,a6,a4
    800076f0:	0055c703          	lbu	a4,5(a1)
    800076f4:	00178793          	addi	a5,a5,1
    800076f8:	02077713          	andi	a4,a4,32
    800076fc:	fc071ae3          	bnez	a4,800076d0 <uartintr+0x70>
    80007700:	01813083          	ld	ra,24(sp)
    80007704:	01013403          	ld	s0,16(sp)
    80007708:	00813483          	ld	s1,8(sp)
    8000770c:	02010113          	addi	sp,sp,32
    80007710:	00008067          	ret
    80007714:	00004617          	auipc	a2,0x4
    80007718:	eac60613          	addi	a2,a2,-340 # 8000b5c0 <uart_tx_r>
    8000771c:	00004517          	auipc	a0,0x4
    80007720:	eac50513          	addi	a0,a0,-340 # 8000b5c8 <uart_tx_w>
    80007724:	00063783          	ld	a5,0(a2)
    80007728:	00053703          	ld	a4,0(a0)
    8000772c:	04f70263          	beq	a4,a5,80007770 <uartintr+0x110>
    80007730:	100005b7          	lui	a1,0x10000
    80007734:	00005817          	auipc	a6,0x5
    80007738:	18c80813          	addi	a6,a6,396 # 8000c8c0 <uart_tx_buf>
    8000773c:	01c0006f          	j	80007758 <uartintr+0xf8>
    80007740:	0006c703          	lbu	a4,0(a3)
    80007744:	00f63023          	sd	a5,0(a2)
    80007748:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000774c:	00063783          	ld	a5,0(a2)
    80007750:	00053703          	ld	a4,0(a0)
    80007754:	02f70063          	beq	a4,a5,80007774 <uartintr+0x114>
    80007758:	01f7f713          	andi	a4,a5,31
    8000775c:	00e806b3          	add	a3,a6,a4
    80007760:	0055c703          	lbu	a4,5(a1)
    80007764:	00178793          	addi	a5,a5,1
    80007768:	02077713          	andi	a4,a4,32
    8000776c:	fc071ae3          	bnez	a4,80007740 <uartintr+0xe0>
    80007770:	00008067          	ret
    80007774:	00008067          	ret

0000000080007778 <kinit>:
    80007778:	fc010113          	addi	sp,sp,-64
    8000777c:	02913423          	sd	s1,40(sp)
    80007780:	fffff7b7          	lui	a5,0xfffff
    80007784:	00006497          	auipc	s1,0x6
    80007788:	15b48493          	addi	s1,s1,347 # 8000d8df <end+0xfff>
    8000778c:	02813823          	sd	s0,48(sp)
    80007790:	01313c23          	sd	s3,24(sp)
    80007794:	00f4f4b3          	and	s1,s1,a5
    80007798:	02113c23          	sd	ra,56(sp)
    8000779c:	03213023          	sd	s2,32(sp)
    800077a0:	01413823          	sd	s4,16(sp)
    800077a4:	01513423          	sd	s5,8(sp)
    800077a8:	04010413          	addi	s0,sp,64
    800077ac:	000017b7          	lui	a5,0x1
    800077b0:	01100993          	li	s3,17
    800077b4:	00f487b3          	add	a5,s1,a5
    800077b8:	01b99993          	slli	s3,s3,0x1b
    800077bc:	06f9e063          	bltu	s3,a5,8000781c <kinit+0xa4>
    800077c0:	00005a97          	auipc	s5,0x5
    800077c4:	120a8a93          	addi	s5,s5,288 # 8000c8e0 <end>
    800077c8:	0754ec63          	bltu	s1,s5,80007840 <kinit+0xc8>
    800077cc:	0734fa63          	bgeu	s1,s3,80007840 <kinit+0xc8>
    800077d0:	00088a37          	lui	s4,0x88
    800077d4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800077d8:	00004917          	auipc	s2,0x4
    800077dc:	df890913          	addi	s2,s2,-520 # 8000b5d0 <kmem>
    800077e0:	00ca1a13          	slli	s4,s4,0xc
    800077e4:	0140006f          	j	800077f8 <kinit+0x80>
    800077e8:	000017b7          	lui	a5,0x1
    800077ec:	00f484b3          	add	s1,s1,a5
    800077f0:	0554e863          	bltu	s1,s5,80007840 <kinit+0xc8>
    800077f4:	0534f663          	bgeu	s1,s3,80007840 <kinit+0xc8>
    800077f8:	00001637          	lui	a2,0x1
    800077fc:	00100593          	li	a1,1
    80007800:	00048513          	mv	a0,s1
    80007804:	00000097          	auipc	ra,0x0
    80007808:	5e4080e7          	jalr	1508(ra) # 80007de8 <__memset>
    8000780c:	00093783          	ld	a5,0(s2)
    80007810:	00f4b023          	sd	a5,0(s1)
    80007814:	00993023          	sd	s1,0(s2)
    80007818:	fd4498e3          	bne	s1,s4,800077e8 <kinit+0x70>
    8000781c:	03813083          	ld	ra,56(sp)
    80007820:	03013403          	ld	s0,48(sp)
    80007824:	02813483          	ld	s1,40(sp)
    80007828:	02013903          	ld	s2,32(sp)
    8000782c:	01813983          	ld	s3,24(sp)
    80007830:	01013a03          	ld	s4,16(sp)
    80007834:	00813a83          	ld	s5,8(sp)
    80007838:	04010113          	addi	sp,sp,64
    8000783c:	00008067          	ret
    80007840:	00002517          	auipc	a0,0x2
    80007844:	e1050513          	addi	a0,a0,-496 # 80009650 <digits+0x18>
    80007848:	fffff097          	auipc	ra,0xfffff
    8000784c:	4b4080e7          	jalr	1204(ra) # 80006cfc <panic>

0000000080007850 <freerange>:
    80007850:	fc010113          	addi	sp,sp,-64
    80007854:	000017b7          	lui	a5,0x1
    80007858:	02913423          	sd	s1,40(sp)
    8000785c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80007860:	009504b3          	add	s1,a0,s1
    80007864:	fffff537          	lui	a0,0xfffff
    80007868:	02813823          	sd	s0,48(sp)
    8000786c:	02113c23          	sd	ra,56(sp)
    80007870:	03213023          	sd	s2,32(sp)
    80007874:	01313c23          	sd	s3,24(sp)
    80007878:	01413823          	sd	s4,16(sp)
    8000787c:	01513423          	sd	s5,8(sp)
    80007880:	01613023          	sd	s6,0(sp)
    80007884:	04010413          	addi	s0,sp,64
    80007888:	00a4f4b3          	and	s1,s1,a0
    8000788c:	00f487b3          	add	a5,s1,a5
    80007890:	06f5e463          	bltu	a1,a5,800078f8 <freerange+0xa8>
    80007894:	00005a97          	auipc	s5,0x5
    80007898:	04ca8a93          	addi	s5,s5,76 # 8000c8e0 <end>
    8000789c:	0954e263          	bltu	s1,s5,80007920 <freerange+0xd0>
    800078a0:	01100993          	li	s3,17
    800078a4:	01b99993          	slli	s3,s3,0x1b
    800078a8:	0734fc63          	bgeu	s1,s3,80007920 <freerange+0xd0>
    800078ac:	00058a13          	mv	s4,a1
    800078b0:	00004917          	auipc	s2,0x4
    800078b4:	d2090913          	addi	s2,s2,-736 # 8000b5d0 <kmem>
    800078b8:	00002b37          	lui	s6,0x2
    800078bc:	0140006f          	j	800078d0 <freerange+0x80>
    800078c0:	000017b7          	lui	a5,0x1
    800078c4:	00f484b3          	add	s1,s1,a5
    800078c8:	0554ec63          	bltu	s1,s5,80007920 <freerange+0xd0>
    800078cc:	0534fa63          	bgeu	s1,s3,80007920 <freerange+0xd0>
    800078d0:	00001637          	lui	a2,0x1
    800078d4:	00100593          	li	a1,1
    800078d8:	00048513          	mv	a0,s1
    800078dc:	00000097          	auipc	ra,0x0
    800078e0:	50c080e7          	jalr	1292(ra) # 80007de8 <__memset>
    800078e4:	00093703          	ld	a4,0(s2)
    800078e8:	016487b3          	add	a5,s1,s6
    800078ec:	00e4b023          	sd	a4,0(s1)
    800078f0:	00993023          	sd	s1,0(s2)
    800078f4:	fcfa76e3          	bgeu	s4,a5,800078c0 <freerange+0x70>
    800078f8:	03813083          	ld	ra,56(sp)
    800078fc:	03013403          	ld	s0,48(sp)
    80007900:	02813483          	ld	s1,40(sp)
    80007904:	02013903          	ld	s2,32(sp)
    80007908:	01813983          	ld	s3,24(sp)
    8000790c:	01013a03          	ld	s4,16(sp)
    80007910:	00813a83          	ld	s5,8(sp)
    80007914:	00013b03          	ld	s6,0(sp)
    80007918:	04010113          	addi	sp,sp,64
    8000791c:	00008067          	ret
    80007920:	00002517          	auipc	a0,0x2
    80007924:	d3050513          	addi	a0,a0,-720 # 80009650 <digits+0x18>
    80007928:	fffff097          	auipc	ra,0xfffff
    8000792c:	3d4080e7          	jalr	980(ra) # 80006cfc <panic>

0000000080007930 <kfree>:
    80007930:	fe010113          	addi	sp,sp,-32
    80007934:	00813823          	sd	s0,16(sp)
    80007938:	00113c23          	sd	ra,24(sp)
    8000793c:	00913423          	sd	s1,8(sp)
    80007940:	02010413          	addi	s0,sp,32
    80007944:	03451793          	slli	a5,a0,0x34
    80007948:	04079c63          	bnez	a5,800079a0 <kfree+0x70>
    8000794c:	00005797          	auipc	a5,0x5
    80007950:	f9478793          	addi	a5,a5,-108 # 8000c8e0 <end>
    80007954:	00050493          	mv	s1,a0
    80007958:	04f56463          	bltu	a0,a5,800079a0 <kfree+0x70>
    8000795c:	01100793          	li	a5,17
    80007960:	01b79793          	slli	a5,a5,0x1b
    80007964:	02f57e63          	bgeu	a0,a5,800079a0 <kfree+0x70>
    80007968:	00001637          	lui	a2,0x1
    8000796c:	00100593          	li	a1,1
    80007970:	00000097          	auipc	ra,0x0
    80007974:	478080e7          	jalr	1144(ra) # 80007de8 <__memset>
    80007978:	00004797          	auipc	a5,0x4
    8000797c:	c5878793          	addi	a5,a5,-936 # 8000b5d0 <kmem>
    80007980:	0007b703          	ld	a4,0(a5)
    80007984:	01813083          	ld	ra,24(sp)
    80007988:	01013403          	ld	s0,16(sp)
    8000798c:	00e4b023          	sd	a4,0(s1)
    80007990:	0097b023          	sd	s1,0(a5)
    80007994:	00813483          	ld	s1,8(sp)
    80007998:	02010113          	addi	sp,sp,32
    8000799c:	00008067          	ret
    800079a0:	00002517          	auipc	a0,0x2
    800079a4:	cb050513          	addi	a0,a0,-848 # 80009650 <digits+0x18>
    800079a8:	fffff097          	auipc	ra,0xfffff
    800079ac:	354080e7          	jalr	852(ra) # 80006cfc <panic>

00000000800079b0 <kalloc>:
    800079b0:	fe010113          	addi	sp,sp,-32
    800079b4:	00813823          	sd	s0,16(sp)
    800079b8:	00913423          	sd	s1,8(sp)
    800079bc:	00113c23          	sd	ra,24(sp)
    800079c0:	02010413          	addi	s0,sp,32
    800079c4:	00004797          	auipc	a5,0x4
    800079c8:	c0c78793          	addi	a5,a5,-1012 # 8000b5d0 <kmem>
    800079cc:	0007b483          	ld	s1,0(a5)
    800079d0:	02048063          	beqz	s1,800079f0 <kalloc+0x40>
    800079d4:	0004b703          	ld	a4,0(s1)
    800079d8:	00001637          	lui	a2,0x1
    800079dc:	00500593          	li	a1,5
    800079e0:	00048513          	mv	a0,s1
    800079e4:	00e7b023          	sd	a4,0(a5)
    800079e8:	00000097          	auipc	ra,0x0
    800079ec:	400080e7          	jalr	1024(ra) # 80007de8 <__memset>
    800079f0:	01813083          	ld	ra,24(sp)
    800079f4:	01013403          	ld	s0,16(sp)
    800079f8:	00048513          	mv	a0,s1
    800079fc:	00813483          	ld	s1,8(sp)
    80007a00:	02010113          	addi	sp,sp,32
    80007a04:	00008067          	ret

0000000080007a08 <initlock>:
    80007a08:	ff010113          	addi	sp,sp,-16
    80007a0c:	00813423          	sd	s0,8(sp)
    80007a10:	01010413          	addi	s0,sp,16
    80007a14:	00813403          	ld	s0,8(sp)
    80007a18:	00b53423          	sd	a1,8(a0)
    80007a1c:	00052023          	sw	zero,0(a0)
    80007a20:	00053823          	sd	zero,16(a0)
    80007a24:	01010113          	addi	sp,sp,16
    80007a28:	00008067          	ret

0000000080007a2c <acquire>:
    80007a2c:	fe010113          	addi	sp,sp,-32
    80007a30:	00813823          	sd	s0,16(sp)
    80007a34:	00913423          	sd	s1,8(sp)
    80007a38:	00113c23          	sd	ra,24(sp)
    80007a3c:	01213023          	sd	s2,0(sp)
    80007a40:	02010413          	addi	s0,sp,32
    80007a44:	00050493          	mv	s1,a0
    80007a48:	10002973          	csrr	s2,sstatus
    80007a4c:	100027f3          	csrr	a5,sstatus
    80007a50:	ffd7f793          	andi	a5,a5,-3
    80007a54:	10079073          	csrw	sstatus,a5
    80007a58:	fffff097          	auipc	ra,0xfffff
    80007a5c:	8ec080e7          	jalr	-1812(ra) # 80006344 <mycpu>
    80007a60:	07852783          	lw	a5,120(a0)
    80007a64:	06078e63          	beqz	a5,80007ae0 <acquire+0xb4>
    80007a68:	fffff097          	auipc	ra,0xfffff
    80007a6c:	8dc080e7          	jalr	-1828(ra) # 80006344 <mycpu>
    80007a70:	07852783          	lw	a5,120(a0)
    80007a74:	0004a703          	lw	a4,0(s1)
    80007a78:	0017879b          	addiw	a5,a5,1
    80007a7c:	06f52c23          	sw	a5,120(a0)
    80007a80:	04071063          	bnez	a4,80007ac0 <acquire+0x94>
    80007a84:	00100713          	li	a4,1
    80007a88:	00070793          	mv	a5,a4
    80007a8c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80007a90:	0007879b          	sext.w	a5,a5
    80007a94:	fe079ae3          	bnez	a5,80007a88 <acquire+0x5c>
    80007a98:	0ff0000f          	fence
    80007a9c:	fffff097          	auipc	ra,0xfffff
    80007aa0:	8a8080e7          	jalr	-1880(ra) # 80006344 <mycpu>
    80007aa4:	01813083          	ld	ra,24(sp)
    80007aa8:	01013403          	ld	s0,16(sp)
    80007aac:	00a4b823          	sd	a0,16(s1)
    80007ab0:	00013903          	ld	s2,0(sp)
    80007ab4:	00813483          	ld	s1,8(sp)
    80007ab8:	02010113          	addi	sp,sp,32
    80007abc:	00008067          	ret
    80007ac0:	0104b903          	ld	s2,16(s1)
    80007ac4:	fffff097          	auipc	ra,0xfffff
    80007ac8:	880080e7          	jalr	-1920(ra) # 80006344 <mycpu>
    80007acc:	faa91ce3          	bne	s2,a0,80007a84 <acquire+0x58>
    80007ad0:	00002517          	auipc	a0,0x2
    80007ad4:	b8850513          	addi	a0,a0,-1144 # 80009658 <digits+0x20>
    80007ad8:	fffff097          	auipc	ra,0xfffff
    80007adc:	224080e7          	jalr	548(ra) # 80006cfc <panic>
    80007ae0:	00195913          	srli	s2,s2,0x1
    80007ae4:	fffff097          	auipc	ra,0xfffff
    80007ae8:	860080e7          	jalr	-1952(ra) # 80006344 <mycpu>
    80007aec:	00197913          	andi	s2,s2,1
    80007af0:	07252e23          	sw	s2,124(a0)
    80007af4:	f75ff06f          	j	80007a68 <acquire+0x3c>

0000000080007af8 <release>:
    80007af8:	fe010113          	addi	sp,sp,-32
    80007afc:	00813823          	sd	s0,16(sp)
    80007b00:	00113c23          	sd	ra,24(sp)
    80007b04:	00913423          	sd	s1,8(sp)
    80007b08:	01213023          	sd	s2,0(sp)
    80007b0c:	02010413          	addi	s0,sp,32
    80007b10:	00052783          	lw	a5,0(a0)
    80007b14:	00079a63          	bnez	a5,80007b28 <release+0x30>
    80007b18:	00002517          	auipc	a0,0x2
    80007b1c:	b4850513          	addi	a0,a0,-1208 # 80009660 <digits+0x28>
    80007b20:	fffff097          	auipc	ra,0xfffff
    80007b24:	1dc080e7          	jalr	476(ra) # 80006cfc <panic>
    80007b28:	01053903          	ld	s2,16(a0)
    80007b2c:	00050493          	mv	s1,a0
    80007b30:	fffff097          	auipc	ra,0xfffff
    80007b34:	814080e7          	jalr	-2028(ra) # 80006344 <mycpu>
    80007b38:	fea910e3          	bne	s2,a0,80007b18 <release+0x20>
    80007b3c:	0004b823          	sd	zero,16(s1)
    80007b40:	0ff0000f          	fence
    80007b44:	0f50000f          	fence	iorw,ow
    80007b48:	0804a02f          	amoswap.w	zero,zero,(s1)
    80007b4c:	ffffe097          	auipc	ra,0xffffe
    80007b50:	7f8080e7          	jalr	2040(ra) # 80006344 <mycpu>
    80007b54:	100027f3          	csrr	a5,sstatus
    80007b58:	0027f793          	andi	a5,a5,2
    80007b5c:	04079a63          	bnez	a5,80007bb0 <release+0xb8>
    80007b60:	07852783          	lw	a5,120(a0)
    80007b64:	02f05e63          	blez	a5,80007ba0 <release+0xa8>
    80007b68:	fff7871b          	addiw	a4,a5,-1
    80007b6c:	06e52c23          	sw	a4,120(a0)
    80007b70:	00071c63          	bnez	a4,80007b88 <release+0x90>
    80007b74:	07c52783          	lw	a5,124(a0)
    80007b78:	00078863          	beqz	a5,80007b88 <release+0x90>
    80007b7c:	100027f3          	csrr	a5,sstatus
    80007b80:	0027e793          	ori	a5,a5,2
    80007b84:	10079073          	csrw	sstatus,a5
    80007b88:	01813083          	ld	ra,24(sp)
    80007b8c:	01013403          	ld	s0,16(sp)
    80007b90:	00813483          	ld	s1,8(sp)
    80007b94:	00013903          	ld	s2,0(sp)
    80007b98:	02010113          	addi	sp,sp,32
    80007b9c:	00008067          	ret
    80007ba0:	00002517          	auipc	a0,0x2
    80007ba4:	ae050513          	addi	a0,a0,-1312 # 80009680 <digits+0x48>
    80007ba8:	fffff097          	auipc	ra,0xfffff
    80007bac:	154080e7          	jalr	340(ra) # 80006cfc <panic>
    80007bb0:	00002517          	auipc	a0,0x2
    80007bb4:	ab850513          	addi	a0,a0,-1352 # 80009668 <digits+0x30>
    80007bb8:	fffff097          	auipc	ra,0xfffff
    80007bbc:	144080e7          	jalr	324(ra) # 80006cfc <panic>

0000000080007bc0 <holding>:
    80007bc0:	00052783          	lw	a5,0(a0)
    80007bc4:	00079663          	bnez	a5,80007bd0 <holding+0x10>
    80007bc8:	00000513          	li	a0,0
    80007bcc:	00008067          	ret
    80007bd0:	fe010113          	addi	sp,sp,-32
    80007bd4:	00813823          	sd	s0,16(sp)
    80007bd8:	00913423          	sd	s1,8(sp)
    80007bdc:	00113c23          	sd	ra,24(sp)
    80007be0:	02010413          	addi	s0,sp,32
    80007be4:	01053483          	ld	s1,16(a0)
    80007be8:	ffffe097          	auipc	ra,0xffffe
    80007bec:	75c080e7          	jalr	1884(ra) # 80006344 <mycpu>
    80007bf0:	01813083          	ld	ra,24(sp)
    80007bf4:	01013403          	ld	s0,16(sp)
    80007bf8:	40a48533          	sub	a0,s1,a0
    80007bfc:	00153513          	seqz	a0,a0
    80007c00:	00813483          	ld	s1,8(sp)
    80007c04:	02010113          	addi	sp,sp,32
    80007c08:	00008067          	ret

0000000080007c0c <push_off>:
    80007c0c:	fe010113          	addi	sp,sp,-32
    80007c10:	00813823          	sd	s0,16(sp)
    80007c14:	00113c23          	sd	ra,24(sp)
    80007c18:	00913423          	sd	s1,8(sp)
    80007c1c:	02010413          	addi	s0,sp,32
    80007c20:	100024f3          	csrr	s1,sstatus
    80007c24:	100027f3          	csrr	a5,sstatus
    80007c28:	ffd7f793          	andi	a5,a5,-3
    80007c2c:	10079073          	csrw	sstatus,a5
    80007c30:	ffffe097          	auipc	ra,0xffffe
    80007c34:	714080e7          	jalr	1812(ra) # 80006344 <mycpu>
    80007c38:	07852783          	lw	a5,120(a0)
    80007c3c:	02078663          	beqz	a5,80007c68 <push_off+0x5c>
    80007c40:	ffffe097          	auipc	ra,0xffffe
    80007c44:	704080e7          	jalr	1796(ra) # 80006344 <mycpu>
    80007c48:	07852783          	lw	a5,120(a0)
    80007c4c:	01813083          	ld	ra,24(sp)
    80007c50:	01013403          	ld	s0,16(sp)
    80007c54:	0017879b          	addiw	a5,a5,1
    80007c58:	06f52c23          	sw	a5,120(a0)
    80007c5c:	00813483          	ld	s1,8(sp)
    80007c60:	02010113          	addi	sp,sp,32
    80007c64:	00008067          	ret
    80007c68:	0014d493          	srli	s1,s1,0x1
    80007c6c:	ffffe097          	auipc	ra,0xffffe
    80007c70:	6d8080e7          	jalr	1752(ra) # 80006344 <mycpu>
    80007c74:	0014f493          	andi	s1,s1,1
    80007c78:	06952e23          	sw	s1,124(a0)
    80007c7c:	fc5ff06f          	j	80007c40 <push_off+0x34>

0000000080007c80 <pop_off>:
    80007c80:	ff010113          	addi	sp,sp,-16
    80007c84:	00813023          	sd	s0,0(sp)
    80007c88:	00113423          	sd	ra,8(sp)
    80007c8c:	01010413          	addi	s0,sp,16
    80007c90:	ffffe097          	auipc	ra,0xffffe
    80007c94:	6b4080e7          	jalr	1716(ra) # 80006344 <mycpu>
    80007c98:	100027f3          	csrr	a5,sstatus
    80007c9c:	0027f793          	andi	a5,a5,2
    80007ca0:	04079663          	bnez	a5,80007cec <pop_off+0x6c>
    80007ca4:	07852783          	lw	a5,120(a0)
    80007ca8:	02f05a63          	blez	a5,80007cdc <pop_off+0x5c>
    80007cac:	fff7871b          	addiw	a4,a5,-1
    80007cb0:	06e52c23          	sw	a4,120(a0)
    80007cb4:	00071c63          	bnez	a4,80007ccc <pop_off+0x4c>
    80007cb8:	07c52783          	lw	a5,124(a0)
    80007cbc:	00078863          	beqz	a5,80007ccc <pop_off+0x4c>
    80007cc0:	100027f3          	csrr	a5,sstatus
    80007cc4:	0027e793          	ori	a5,a5,2
    80007cc8:	10079073          	csrw	sstatus,a5
    80007ccc:	00813083          	ld	ra,8(sp)
    80007cd0:	00013403          	ld	s0,0(sp)
    80007cd4:	01010113          	addi	sp,sp,16
    80007cd8:	00008067          	ret
    80007cdc:	00002517          	auipc	a0,0x2
    80007ce0:	9a450513          	addi	a0,a0,-1628 # 80009680 <digits+0x48>
    80007ce4:	fffff097          	auipc	ra,0xfffff
    80007ce8:	018080e7          	jalr	24(ra) # 80006cfc <panic>
    80007cec:	00002517          	auipc	a0,0x2
    80007cf0:	97c50513          	addi	a0,a0,-1668 # 80009668 <digits+0x30>
    80007cf4:	fffff097          	auipc	ra,0xfffff
    80007cf8:	008080e7          	jalr	8(ra) # 80006cfc <panic>

0000000080007cfc <push_on>:
    80007cfc:	fe010113          	addi	sp,sp,-32
    80007d00:	00813823          	sd	s0,16(sp)
    80007d04:	00113c23          	sd	ra,24(sp)
    80007d08:	00913423          	sd	s1,8(sp)
    80007d0c:	02010413          	addi	s0,sp,32
    80007d10:	100024f3          	csrr	s1,sstatus
    80007d14:	100027f3          	csrr	a5,sstatus
    80007d18:	0027e793          	ori	a5,a5,2
    80007d1c:	10079073          	csrw	sstatus,a5
    80007d20:	ffffe097          	auipc	ra,0xffffe
    80007d24:	624080e7          	jalr	1572(ra) # 80006344 <mycpu>
    80007d28:	07852783          	lw	a5,120(a0)
    80007d2c:	02078663          	beqz	a5,80007d58 <push_on+0x5c>
    80007d30:	ffffe097          	auipc	ra,0xffffe
    80007d34:	614080e7          	jalr	1556(ra) # 80006344 <mycpu>
    80007d38:	07852783          	lw	a5,120(a0)
    80007d3c:	01813083          	ld	ra,24(sp)
    80007d40:	01013403          	ld	s0,16(sp)
    80007d44:	0017879b          	addiw	a5,a5,1
    80007d48:	06f52c23          	sw	a5,120(a0)
    80007d4c:	00813483          	ld	s1,8(sp)
    80007d50:	02010113          	addi	sp,sp,32
    80007d54:	00008067          	ret
    80007d58:	0014d493          	srli	s1,s1,0x1
    80007d5c:	ffffe097          	auipc	ra,0xffffe
    80007d60:	5e8080e7          	jalr	1512(ra) # 80006344 <mycpu>
    80007d64:	0014f493          	andi	s1,s1,1
    80007d68:	06952e23          	sw	s1,124(a0)
    80007d6c:	fc5ff06f          	j	80007d30 <push_on+0x34>

0000000080007d70 <pop_on>:
    80007d70:	ff010113          	addi	sp,sp,-16
    80007d74:	00813023          	sd	s0,0(sp)
    80007d78:	00113423          	sd	ra,8(sp)
    80007d7c:	01010413          	addi	s0,sp,16
    80007d80:	ffffe097          	auipc	ra,0xffffe
    80007d84:	5c4080e7          	jalr	1476(ra) # 80006344 <mycpu>
    80007d88:	100027f3          	csrr	a5,sstatus
    80007d8c:	0027f793          	andi	a5,a5,2
    80007d90:	04078463          	beqz	a5,80007dd8 <pop_on+0x68>
    80007d94:	07852783          	lw	a5,120(a0)
    80007d98:	02f05863          	blez	a5,80007dc8 <pop_on+0x58>
    80007d9c:	fff7879b          	addiw	a5,a5,-1
    80007da0:	06f52c23          	sw	a5,120(a0)
    80007da4:	07853783          	ld	a5,120(a0)
    80007da8:	00079863          	bnez	a5,80007db8 <pop_on+0x48>
    80007dac:	100027f3          	csrr	a5,sstatus
    80007db0:	ffd7f793          	andi	a5,a5,-3
    80007db4:	10079073          	csrw	sstatus,a5
    80007db8:	00813083          	ld	ra,8(sp)
    80007dbc:	00013403          	ld	s0,0(sp)
    80007dc0:	01010113          	addi	sp,sp,16
    80007dc4:	00008067          	ret
    80007dc8:	00002517          	auipc	a0,0x2
    80007dcc:	8e050513          	addi	a0,a0,-1824 # 800096a8 <digits+0x70>
    80007dd0:	fffff097          	auipc	ra,0xfffff
    80007dd4:	f2c080e7          	jalr	-212(ra) # 80006cfc <panic>
    80007dd8:	00002517          	auipc	a0,0x2
    80007ddc:	8b050513          	addi	a0,a0,-1872 # 80009688 <digits+0x50>
    80007de0:	fffff097          	auipc	ra,0xfffff
    80007de4:	f1c080e7          	jalr	-228(ra) # 80006cfc <panic>

0000000080007de8 <__memset>:
    80007de8:	ff010113          	addi	sp,sp,-16
    80007dec:	00813423          	sd	s0,8(sp)
    80007df0:	01010413          	addi	s0,sp,16
    80007df4:	1a060e63          	beqz	a2,80007fb0 <__memset+0x1c8>
    80007df8:	40a007b3          	neg	a5,a0
    80007dfc:	0077f793          	andi	a5,a5,7
    80007e00:	00778693          	addi	a3,a5,7
    80007e04:	00b00813          	li	a6,11
    80007e08:	0ff5f593          	andi	a1,a1,255
    80007e0c:	fff6071b          	addiw	a4,a2,-1
    80007e10:	1b06e663          	bltu	a3,a6,80007fbc <__memset+0x1d4>
    80007e14:	1cd76463          	bltu	a4,a3,80007fdc <__memset+0x1f4>
    80007e18:	1a078e63          	beqz	a5,80007fd4 <__memset+0x1ec>
    80007e1c:	00b50023          	sb	a1,0(a0)
    80007e20:	00100713          	li	a4,1
    80007e24:	1ae78463          	beq	a5,a4,80007fcc <__memset+0x1e4>
    80007e28:	00b500a3          	sb	a1,1(a0)
    80007e2c:	00200713          	li	a4,2
    80007e30:	1ae78a63          	beq	a5,a4,80007fe4 <__memset+0x1fc>
    80007e34:	00b50123          	sb	a1,2(a0)
    80007e38:	00300713          	li	a4,3
    80007e3c:	18e78463          	beq	a5,a4,80007fc4 <__memset+0x1dc>
    80007e40:	00b501a3          	sb	a1,3(a0)
    80007e44:	00400713          	li	a4,4
    80007e48:	1ae78263          	beq	a5,a4,80007fec <__memset+0x204>
    80007e4c:	00b50223          	sb	a1,4(a0)
    80007e50:	00500713          	li	a4,5
    80007e54:	1ae78063          	beq	a5,a4,80007ff4 <__memset+0x20c>
    80007e58:	00b502a3          	sb	a1,5(a0)
    80007e5c:	00700713          	li	a4,7
    80007e60:	18e79e63          	bne	a5,a4,80007ffc <__memset+0x214>
    80007e64:	00b50323          	sb	a1,6(a0)
    80007e68:	00700e93          	li	t4,7
    80007e6c:	00859713          	slli	a4,a1,0x8
    80007e70:	00e5e733          	or	a4,a1,a4
    80007e74:	01059e13          	slli	t3,a1,0x10
    80007e78:	01c76e33          	or	t3,a4,t3
    80007e7c:	01859313          	slli	t1,a1,0x18
    80007e80:	006e6333          	or	t1,t3,t1
    80007e84:	02059893          	slli	a7,a1,0x20
    80007e88:	40f60e3b          	subw	t3,a2,a5
    80007e8c:	011368b3          	or	a7,t1,a7
    80007e90:	02859813          	slli	a6,a1,0x28
    80007e94:	0108e833          	or	a6,a7,a6
    80007e98:	03059693          	slli	a3,a1,0x30
    80007e9c:	003e589b          	srliw	a7,t3,0x3
    80007ea0:	00d866b3          	or	a3,a6,a3
    80007ea4:	03859713          	slli	a4,a1,0x38
    80007ea8:	00389813          	slli	a6,a7,0x3
    80007eac:	00f507b3          	add	a5,a0,a5
    80007eb0:	00e6e733          	or	a4,a3,a4
    80007eb4:	000e089b          	sext.w	a7,t3
    80007eb8:	00f806b3          	add	a3,a6,a5
    80007ebc:	00e7b023          	sd	a4,0(a5)
    80007ec0:	00878793          	addi	a5,a5,8
    80007ec4:	fed79ce3          	bne	a5,a3,80007ebc <__memset+0xd4>
    80007ec8:	ff8e7793          	andi	a5,t3,-8
    80007ecc:	0007871b          	sext.w	a4,a5
    80007ed0:	01d787bb          	addw	a5,a5,t4
    80007ed4:	0ce88e63          	beq	a7,a4,80007fb0 <__memset+0x1c8>
    80007ed8:	00f50733          	add	a4,a0,a5
    80007edc:	00b70023          	sb	a1,0(a4)
    80007ee0:	0017871b          	addiw	a4,a5,1
    80007ee4:	0cc77663          	bgeu	a4,a2,80007fb0 <__memset+0x1c8>
    80007ee8:	00e50733          	add	a4,a0,a4
    80007eec:	00b70023          	sb	a1,0(a4)
    80007ef0:	0027871b          	addiw	a4,a5,2
    80007ef4:	0ac77e63          	bgeu	a4,a2,80007fb0 <__memset+0x1c8>
    80007ef8:	00e50733          	add	a4,a0,a4
    80007efc:	00b70023          	sb	a1,0(a4)
    80007f00:	0037871b          	addiw	a4,a5,3
    80007f04:	0ac77663          	bgeu	a4,a2,80007fb0 <__memset+0x1c8>
    80007f08:	00e50733          	add	a4,a0,a4
    80007f0c:	00b70023          	sb	a1,0(a4)
    80007f10:	0047871b          	addiw	a4,a5,4
    80007f14:	08c77e63          	bgeu	a4,a2,80007fb0 <__memset+0x1c8>
    80007f18:	00e50733          	add	a4,a0,a4
    80007f1c:	00b70023          	sb	a1,0(a4)
    80007f20:	0057871b          	addiw	a4,a5,5
    80007f24:	08c77663          	bgeu	a4,a2,80007fb0 <__memset+0x1c8>
    80007f28:	00e50733          	add	a4,a0,a4
    80007f2c:	00b70023          	sb	a1,0(a4)
    80007f30:	0067871b          	addiw	a4,a5,6
    80007f34:	06c77e63          	bgeu	a4,a2,80007fb0 <__memset+0x1c8>
    80007f38:	00e50733          	add	a4,a0,a4
    80007f3c:	00b70023          	sb	a1,0(a4)
    80007f40:	0077871b          	addiw	a4,a5,7
    80007f44:	06c77663          	bgeu	a4,a2,80007fb0 <__memset+0x1c8>
    80007f48:	00e50733          	add	a4,a0,a4
    80007f4c:	00b70023          	sb	a1,0(a4)
    80007f50:	0087871b          	addiw	a4,a5,8
    80007f54:	04c77e63          	bgeu	a4,a2,80007fb0 <__memset+0x1c8>
    80007f58:	00e50733          	add	a4,a0,a4
    80007f5c:	00b70023          	sb	a1,0(a4)
    80007f60:	0097871b          	addiw	a4,a5,9
    80007f64:	04c77663          	bgeu	a4,a2,80007fb0 <__memset+0x1c8>
    80007f68:	00e50733          	add	a4,a0,a4
    80007f6c:	00b70023          	sb	a1,0(a4)
    80007f70:	00a7871b          	addiw	a4,a5,10
    80007f74:	02c77e63          	bgeu	a4,a2,80007fb0 <__memset+0x1c8>
    80007f78:	00e50733          	add	a4,a0,a4
    80007f7c:	00b70023          	sb	a1,0(a4)
    80007f80:	00b7871b          	addiw	a4,a5,11
    80007f84:	02c77663          	bgeu	a4,a2,80007fb0 <__memset+0x1c8>
    80007f88:	00e50733          	add	a4,a0,a4
    80007f8c:	00b70023          	sb	a1,0(a4)
    80007f90:	00c7871b          	addiw	a4,a5,12
    80007f94:	00c77e63          	bgeu	a4,a2,80007fb0 <__memset+0x1c8>
    80007f98:	00e50733          	add	a4,a0,a4
    80007f9c:	00b70023          	sb	a1,0(a4)
    80007fa0:	00d7879b          	addiw	a5,a5,13
    80007fa4:	00c7f663          	bgeu	a5,a2,80007fb0 <__memset+0x1c8>
    80007fa8:	00f507b3          	add	a5,a0,a5
    80007fac:	00b78023          	sb	a1,0(a5)
    80007fb0:	00813403          	ld	s0,8(sp)
    80007fb4:	01010113          	addi	sp,sp,16
    80007fb8:	00008067          	ret
    80007fbc:	00b00693          	li	a3,11
    80007fc0:	e55ff06f          	j	80007e14 <__memset+0x2c>
    80007fc4:	00300e93          	li	t4,3
    80007fc8:	ea5ff06f          	j	80007e6c <__memset+0x84>
    80007fcc:	00100e93          	li	t4,1
    80007fd0:	e9dff06f          	j	80007e6c <__memset+0x84>
    80007fd4:	00000e93          	li	t4,0
    80007fd8:	e95ff06f          	j	80007e6c <__memset+0x84>
    80007fdc:	00000793          	li	a5,0
    80007fe0:	ef9ff06f          	j	80007ed8 <__memset+0xf0>
    80007fe4:	00200e93          	li	t4,2
    80007fe8:	e85ff06f          	j	80007e6c <__memset+0x84>
    80007fec:	00400e93          	li	t4,4
    80007ff0:	e7dff06f          	j	80007e6c <__memset+0x84>
    80007ff4:	00500e93          	li	t4,5
    80007ff8:	e75ff06f          	j	80007e6c <__memset+0x84>
    80007ffc:	00600e93          	li	t4,6
    80008000:	e6dff06f          	j	80007e6c <__memset+0x84>

0000000080008004 <__memmove>:
    80008004:	ff010113          	addi	sp,sp,-16
    80008008:	00813423          	sd	s0,8(sp)
    8000800c:	01010413          	addi	s0,sp,16
    80008010:	0e060863          	beqz	a2,80008100 <__memmove+0xfc>
    80008014:	fff6069b          	addiw	a3,a2,-1
    80008018:	0006881b          	sext.w	a6,a3
    8000801c:	0ea5e863          	bltu	a1,a0,8000810c <__memmove+0x108>
    80008020:	00758713          	addi	a4,a1,7
    80008024:	00a5e7b3          	or	a5,a1,a0
    80008028:	40a70733          	sub	a4,a4,a0
    8000802c:	0077f793          	andi	a5,a5,7
    80008030:	00f73713          	sltiu	a4,a4,15
    80008034:	00174713          	xori	a4,a4,1
    80008038:	0017b793          	seqz	a5,a5
    8000803c:	00e7f7b3          	and	a5,a5,a4
    80008040:	10078863          	beqz	a5,80008150 <__memmove+0x14c>
    80008044:	00900793          	li	a5,9
    80008048:	1107f463          	bgeu	a5,a6,80008150 <__memmove+0x14c>
    8000804c:	0036581b          	srliw	a6,a2,0x3
    80008050:	fff8081b          	addiw	a6,a6,-1
    80008054:	02081813          	slli	a6,a6,0x20
    80008058:	01d85893          	srli	a7,a6,0x1d
    8000805c:	00858813          	addi	a6,a1,8
    80008060:	00058793          	mv	a5,a1
    80008064:	00050713          	mv	a4,a0
    80008068:	01088833          	add	a6,a7,a6
    8000806c:	0007b883          	ld	a7,0(a5)
    80008070:	00878793          	addi	a5,a5,8
    80008074:	00870713          	addi	a4,a4,8
    80008078:	ff173c23          	sd	a7,-8(a4)
    8000807c:	ff0798e3          	bne	a5,a6,8000806c <__memmove+0x68>
    80008080:	ff867713          	andi	a4,a2,-8
    80008084:	02071793          	slli	a5,a4,0x20
    80008088:	0207d793          	srli	a5,a5,0x20
    8000808c:	00f585b3          	add	a1,a1,a5
    80008090:	40e686bb          	subw	a3,a3,a4
    80008094:	00f507b3          	add	a5,a0,a5
    80008098:	06e60463          	beq	a2,a4,80008100 <__memmove+0xfc>
    8000809c:	0005c703          	lbu	a4,0(a1)
    800080a0:	00e78023          	sb	a4,0(a5)
    800080a4:	04068e63          	beqz	a3,80008100 <__memmove+0xfc>
    800080a8:	0015c603          	lbu	a2,1(a1)
    800080ac:	00100713          	li	a4,1
    800080b0:	00c780a3          	sb	a2,1(a5)
    800080b4:	04e68663          	beq	a3,a4,80008100 <__memmove+0xfc>
    800080b8:	0025c603          	lbu	a2,2(a1)
    800080bc:	00200713          	li	a4,2
    800080c0:	00c78123          	sb	a2,2(a5)
    800080c4:	02e68e63          	beq	a3,a4,80008100 <__memmove+0xfc>
    800080c8:	0035c603          	lbu	a2,3(a1)
    800080cc:	00300713          	li	a4,3
    800080d0:	00c781a3          	sb	a2,3(a5)
    800080d4:	02e68663          	beq	a3,a4,80008100 <__memmove+0xfc>
    800080d8:	0045c603          	lbu	a2,4(a1)
    800080dc:	00400713          	li	a4,4
    800080e0:	00c78223          	sb	a2,4(a5)
    800080e4:	00e68e63          	beq	a3,a4,80008100 <__memmove+0xfc>
    800080e8:	0055c603          	lbu	a2,5(a1)
    800080ec:	00500713          	li	a4,5
    800080f0:	00c782a3          	sb	a2,5(a5)
    800080f4:	00e68663          	beq	a3,a4,80008100 <__memmove+0xfc>
    800080f8:	0065c703          	lbu	a4,6(a1)
    800080fc:	00e78323          	sb	a4,6(a5)
    80008100:	00813403          	ld	s0,8(sp)
    80008104:	01010113          	addi	sp,sp,16
    80008108:	00008067          	ret
    8000810c:	02061713          	slli	a4,a2,0x20
    80008110:	02075713          	srli	a4,a4,0x20
    80008114:	00e587b3          	add	a5,a1,a4
    80008118:	f0f574e3          	bgeu	a0,a5,80008020 <__memmove+0x1c>
    8000811c:	02069613          	slli	a2,a3,0x20
    80008120:	02065613          	srli	a2,a2,0x20
    80008124:	fff64613          	not	a2,a2
    80008128:	00e50733          	add	a4,a0,a4
    8000812c:	00c78633          	add	a2,a5,a2
    80008130:	fff7c683          	lbu	a3,-1(a5)
    80008134:	fff78793          	addi	a5,a5,-1
    80008138:	fff70713          	addi	a4,a4,-1
    8000813c:	00d70023          	sb	a3,0(a4)
    80008140:	fec798e3          	bne	a5,a2,80008130 <__memmove+0x12c>
    80008144:	00813403          	ld	s0,8(sp)
    80008148:	01010113          	addi	sp,sp,16
    8000814c:	00008067          	ret
    80008150:	02069713          	slli	a4,a3,0x20
    80008154:	02075713          	srli	a4,a4,0x20
    80008158:	00170713          	addi	a4,a4,1
    8000815c:	00e50733          	add	a4,a0,a4
    80008160:	00050793          	mv	a5,a0
    80008164:	0005c683          	lbu	a3,0(a1)
    80008168:	00178793          	addi	a5,a5,1
    8000816c:	00158593          	addi	a1,a1,1
    80008170:	fed78fa3          	sb	a3,-1(a5)
    80008174:	fee798e3          	bne	a5,a4,80008164 <__memmove+0x160>
    80008178:	f89ff06f          	j	80008100 <__memmove+0xfc>

000000008000817c <__putc>:
    8000817c:	fe010113          	addi	sp,sp,-32
    80008180:	00813823          	sd	s0,16(sp)
    80008184:	00113c23          	sd	ra,24(sp)
    80008188:	02010413          	addi	s0,sp,32
    8000818c:	00050793          	mv	a5,a0
    80008190:	fef40593          	addi	a1,s0,-17
    80008194:	00100613          	li	a2,1
    80008198:	00000513          	li	a0,0
    8000819c:	fef407a3          	sb	a5,-17(s0)
    800081a0:	fffff097          	auipc	ra,0xfffff
    800081a4:	b3c080e7          	jalr	-1220(ra) # 80006cdc <console_write>
    800081a8:	01813083          	ld	ra,24(sp)
    800081ac:	01013403          	ld	s0,16(sp)
    800081b0:	02010113          	addi	sp,sp,32
    800081b4:	00008067          	ret

00000000800081b8 <__getc>:
    800081b8:	fe010113          	addi	sp,sp,-32
    800081bc:	00813823          	sd	s0,16(sp)
    800081c0:	00113c23          	sd	ra,24(sp)
    800081c4:	02010413          	addi	s0,sp,32
    800081c8:	fe840593          	addi	a1,s0,-24
    800081cc:	00100613          	li	a2,1
    800081d0:	00000513          	li	a0,0
    800081d4:	fffff097          	auipc	ra,0xfffff
    800081d8:	ae8080e7          	jalr	-1304(ra) # 80006cbc <console_read>
    800081dc:	fe844503          	lbu	a0,-24(s0)
    800081e0:	01813083          	ld	ra,24(sp)
    800081e4:	01013403          	ld	s0,16(sp)
    800081e8:	02010113          	addi	sp,sp,32
    800081ec:	00008067          	ret

00000000800081f0 <console_handler>:
    800081f0:	fe010113          	addi	sp,sp,-32
    800081f4:	00813823          	sd	s0,16(sp)
    800081f8:	00113c23          	sd	ra,24(sp)
    800081fc:	00913423          	sd	s1,8(sp)
    80008200:	02010413          	addi	s0,sp,32
    80008204:	14202773          	csrr	a4,scause
    80008208:	100027f3          	csrr	a5,sstatus
    8000820c:	0027f793          	andi	a5,a5,2
    80008210:	06079e63          	bnez	a5,8000828c <console_handler+0x9c>
    80008214:	00074c63          	bltz	a4,8000822c <console_handler+0x3c>
    80008218:	01813083          	ld	ra,24(sp)
    8000821c:	01013403          	ld	s0,16(sp)
    80008220:	00813483          	ld	s1,8(sp)
    80008224:	02010113          	addi	sp,sp,32
    80008228:	00008067          	ret
    8000822c:	0ff77713          	andi	a4,a4,255
    80008230:	00900793          	li	a5,9
    80008234:	fef712e3          	bne	a4,a5,80008218 <console_handler+0x28>
    80008238:	ffffe097          	auipc	ra,0xffffe
    8000823c:	6dc080e7          	jalr	1756(ra) # 80006914 <plic_claim>
    80008240:	00a00793          	li	a5,10
    80008244:	00050493          	mv	s1,a0
    80008248:	02f50c63          	beq	a0,a5,80008280 <console_handler+0x90>
    8000824c:	fc0506e3          	beqz	a0,80008218 <console_handler+0x28>
    80008250:	00050593          	mv	a1,a0
    80008254:	00001517          	auipc	a0,0x1
    80008258:	35c50513          	addi	a0,a0,860 # 800095b0 <CONSOLE_STATUS+0x5a0>
    8000825c:	fffff097          	auipc	ra,0xfffff
    80008260:	afc080e7          	jalr	-1284(ra) # 80006d58 <__printf>
    80008264:	01013403          	ld	s0,16(sp)
    80008268:	01813083          	ld	ra,24(sp)
    8000826c:	00048513          	mv	a0,s1
    80008270:	00813483          	ld	s1,8(sp)
    80008274:	02010113          	addi	sp,sp,32
    80008278:	ffffe317          	auipc	t1,0xffffe
    8000827c:	6d430067          	jr	1748(t1) # 8000694c <plic_complete>
    80008280:	fffff097          	auipc	ra,0xfffff
    80008284:	3e0080e7          	jalr	992(ra) # 80007660 <uartintr>
    80008288:	fddff06f          	j	80008264 <console_handler+0x74>
    8000828c:	00001517          	auipc	a0,0x1
    80008290:	42450513          	addi	a0,a0,1060 # 800096b0 <digits+0x78>
    80008294:	fffff097          	auipc	ra,0xfffff
    80008298:	a68080e7          	jalr	-1432(ra) # 80006cfc <panic>
	...
