/*
 * Copyright (c) 2012
 *      MIPS Technologies, Inc., California.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the MIPS Technologies, Inc., nor the names of its
 *    contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE MIPS TECHNOLOGIES, INC. ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE MIPS TECHNOLOGIES, INC. BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 * Author:  Nemanja Lukic (nlukic@mips.com)
 */

#include "pixman-mips-dspr2-asm.h"

LEAF_MIPS_DSPR2(pixman_fill_buff16_mips)
/*
 * a0 - *dest
 * a1 - count (bytes)
 * a2 - value to fill buffer with
 */

    beqz     a1, 3f
     andi    t1, a0, 0x0002
    beqz     t1, 0f          /* check if address is 4-byte aligned */
     nop
    sh       a2, 0(a0)
    addiu    a0, a0, 2
    addiu    a1, a1, -2
0:
    srl      t1, a1, 5       /* t1 how many multiples of 32 bytes */
    replv.ph a2, a2          /* replicate fill value (16bit) in a2 */
    beqz     t1, 2f
     nop
1:
    addiu    t1, t1, -1
    beqz     t1, 11f
     addiu   a1, a1, -32
    pref     30, 32(a0)
    sw       a2, 0(a0)
    sw       a2, 4(a0)
    sw       a2, 8(a0)
    sw       a2, 12(a0)
    sw       a2, 16(a0)
    sw       a2, 20(a0)
    sw       a2, 24(a0)
    sw       a2, 28(a0)
    b        1b
     addiu   a0, a0, 32
11:
    sw       a2, 0(a0)
    sw       a2, 4(a0)
    sw       a2, 8(a0)
    sw       a2, 12(a0)
    sw       a2, 16(a0)
    sw       a2, 20(a0)
    sw       a2, 24(a0)
    sw       a2, 28(a0)
    addiu    a0, a0, 32
2:
    blez     a1, 3f
     addiu   a1, a1, -2
    sh       a2, 0(a0)
    b        2b
     addiu   a0, a0, 2
3:
    jr       ra
     nop

END(pixman_fill_buff16_mips)

LEAF_MIPS32R2(pixman_fill_buff32_mips)
/*
 * a0 - *dest
 * a1 - count (bytes)
 * a2 - value to fill buffer with
 */

    beqz     a1, 3f
     nop
    srl      t1, a1, 5 /* t1 how many multiples of 32 bytes */
    beqz     t1, 2f
     nop
1:
    addiu    t1, t1, -1
    beqz     t1, 11f
     addiu   a1, a1, -32
    pref     30, 32(a0)
    sw       a2, 0(a0)
    sw       a2, 4(a0)
    sw       a2, 8(a0)
    sw       a2, 12(a0)
    sw       a2, 16(a0)
    sw       a2, 20(a0)
    sw       a2, 24(a0)
    sw       a2, 28(a0)
    b        1b
     addiu   a0, a0, 32
11:
    sw       a2, 0(a0)
    sw       a2, 4(a0)
    sw       a2, 8(a0)
    sw       a2, 12(a0)
    sw       a2, 16(a0)
    sw       a2, 20(a0)
    sw       a2, 24(a0)
    sw       a2, 28(a0)
    addiu    a0, a0, 32
2:
    blez     a1, 3f
     addiu   a1, a1, -4
    sw       a2, 0(a0)
    b        2b
     addiu   a0, a0, 4
3:
    jr       ra
     nop

END(pixman_fill_buff32_mips)

LEAF_MIPS_DSPR2(pixman_composite_src_8888_0565_asm_mips)
/*
 * a0 - dst (r5g6b5)
 * a1 - src (a8r8g8b8)
 * a2 - w
 */

    beqz     a2, 3f
     nop
    addiu    t1, a2, -1
    beqz     t1, 2f
     nop
    li       t4, 0xf800f800
    li       t5, 0x07e007e0
    li       t6, 0x001f001f
1:
    lw       t0, 0(a1)
    lw       t1, 4(a1)
    addiu    a1, a1, 8
    addiu    a2, a2, -2

    CONVERT_2x8888_TO_2x0565 t0, t1, t2, t3, t4, t5, t6, t7, t8

    sh       t2, 0(a0)
    sh       t3, 2(a0)

    addiu    t2, a2, -1
    bgtz     t2, 1b
     addiu   a0, a0, 4
2:
    beqz     a2, 3f
     nop
    lw       t0, 0(a1)

    CONVERT_1x8888_TO_1x0565 t0, t1, t2, t3

    sh       t1, 0(a0)
3:
    j        ra
     nop

END(pixman_composite_src_8888_0565_asm_mips)

LEAF_MIPS_DSPR2(pixman_composite_src_0565_8888_asm_mips)
/*
 * a0 - dst (a8r8g8b8)
 * a1 - src (r5g6b5)
 * a2 - w
 */

    beqz     a2, 3f
     nop
    addiu    t1, a2, -1
    beqz     t1, 2f
     nop
    li       t4, 0x07e007e0
    li       t5, 0x001F001F
1:
    lhu      t0, 0(a1)
    lhu      t1, 2(a1)
    addiu    a1, a1, 4
    addiu    a2, a2, -2

    CONVERT_2x0565_TO_2x8888 t0, t1, t2, t3, t4, t5, t6, t7, t8, t9

    sw       t2, 0(a0)
    sw       t3, 4(a0)

    addiu    t2, a2, -1
    bgtz     t2, 1b
     addiu   a0, a0, 8
2:
    beqz     a2, 3f
     nop
    lhu      t0, 0(a1)

    CONVERT_1x0565_TO_1x8888 t0, t1, t2, t3

    sw       t1, 0(a0)
3:
    j        ra
     nop

END(pixman_composite_src_0565_8888_asm_mips)

LEAF_MIPS_DSPR2(pixman_composite_src_x888_8888_asm_mips)
/*
 * a0 - dst (a8r8g8b8)
 * a1 - src (x8r8g8b8)
 * a2 - w
 */

    beqz     a2, 4f
     nop
    li       t9, 0xff000000
    srl      t8, a2, 3    /* t1 = how many multiples of 8 src pixels */
    beqz     t8, 3f       /* branch if less than 8 src pixels */
     nop
1:
    addiu    t8, t8, -1
    beqz     t8, 2f
     addiu   a2, a2, -8
    pref     0, 32(a1)
    lw       t0, 0(a1)
    lw       t1, 4(a1)
    lw       t2, 8(a1)
    lw       t3, 12(a1)
    lw       t4, 16(a1)
    lw       t5, 20(a1)
    lw       t6, 24(a1)
    lw       t7, 28(a1)
    addiu    a1, a1, 32
    or       t0, t0, t9
    or       t1, t1, t9
    or       t2, t2, t9
    or       t3, t3, t9
    or       t4, t4, t9
    or       t5, t5, t9
    or       t6, t6, t9
    or       t7, t7, t9
    pref     30, 32(a0)
    sw       t0, 0(a0)
    sw       t1, 4(a0)
    sw       t2, 8(a0)
    sw       t3, 12(a0)
    sw       t4, 16(a0)
    sw       t5, 20(a0)
    sw       t6, 24(a0)
    sw       t7, 28(a0)
    b        1b
     addiu   a0, a0, 32
2:
    lw       t0, 0(a1)
    lw       t1, 4(a1)
    lw       t2, 8(a1)
    lw       t3, 12(a1)
    lw       t4, 16(a1)
    lw       t5, 20(a1)
    lw       t6, 24(a1)
    lw       t7, 28(a1)
    addiu    a1, a1, 32
    or       t0, t0, t9
    or       t1, t1, t9
    or       t2, t2, t9
    or       t3, t3, t9
    or       t4, t4, t9
    or       t5, t5, t9
    or       t6, t6, t9
    or       t7, t7, t9
    sw       t0, 0(a0)
    sw       t1, 4(a0)
    sw       t2, 8(a0)
    sw       t3, 12(a0)
    sw       t4, 16(a0)
    sw       t5, 20(a0)
    sw       t6, 24(a0)
    sw       t7, 28(a0)
    beqz     a2, 4f
     addiu   a0, a0, 32
3:
    lw       t0, 0(a1)
    addiu    a1, a1, 4
    addiu    a2, a2, -1
    or       t1, t0, t9
    sw       t1, 0(a0)
    bnez     a2, 3b
     addiu   a0, a0, 4
4:
    jr       ra
     nop

END(pixman_composite_src_x888_8888_asm_mips)

LEAF_MIPS_DSPR2(pixman_composite_over_n_8888_8888_ca_asm_mips)
/*
 * a0 - dst  (a8r8g8b8)
 * a1 - src  (32bit constant)
 * a2 - mask (a8r8g8b8)
 * a3 - w
 */

    SAVE_REGS_ON_STACK 8, s0, s1, s2, s3, s4, s5
    beqz         a3, 4f
     nop
    li           t6, 0xff
    addiu        t7, zero, -1 /* t7 = 0xffffffff */
    srl          t8, a1, 24   /* t8 = srca */
    li           t9, 0x00ff00ff
    addiu        t1, a3, -1
    beqz         t1, 3f       /* last pixel */
     nop
    beq          t8, t6, 2f   /* if (srca == 0xff) */
     nop
1:
                              /* a1 = src */
    lw           t0, 0(a2)    /* t0 = mask */
    lw           t1, 4(a2)    /* t1 = mask */
    or           t2, t0, t1
    beqz         t2, 12f      /* if (t0 == 0) && (t1 == 0) */
     addiu       a2, a2, 8
    and          t3, t0, t1
    move         t4, a1       /* t4 = src */
    move         t5, a1       /* t5 = src */
    lw           t2, 0(a0)    /* t2 = dst */
    beq          t3, t7, 11f  /* if (t0 == 0xffffffff) && (t1 == 0xffffffff) */
     lw          t3, 4(a0)    /* t3 = dst */
    MIPS_2xUN8x4_MUL_2xUN8x4 a1, a1, t0, t1, t4, t5, t9, s0, s1, s2, s3, s4, s5
    MIPS_2xUN8x4_MUL_2xUN8   t0, t1, t8, t8, t0, t1, t9, s0, s1, s2, s3, s4, s5
11:
    not          t0, t0
    not          t1, t1
    MIPS_2xUN8x4_MUL_2xUN8x4 t2, t3, t0, t1, t2, t3, t9, s0, s1, s2, s3, s4, s5
    addu_s.qb    t2, t4, t2
    addu_s.qb    t3, t5, t3
    sw           t2, 0(a0)
    sw           t3, 4(a0)
12:
    addiu        a3, a3, -2
    addiu        t1, a3, -1
    bgtz         t1, 1b
     addiu       a0, a0, 8
    b            3f
     nop
2:
                              /* a1 = src */
    lw           t0, 0(a2)    /* t0 = mask */
    lw           t1, 4(a2)    /* t1 = mask */
    or           t2, t0, t1
    beqz         t2, 22f      /* if (t0 == 0) & (t1 == 0) */
     addiu       a2, a2, 8
    and          t2, t0, t1
    move         t4, a1
    beq          t2, t7, 21f  /* if (t0 == 0xffffffff) && (t1 == 0xffffffff) */
     move        t5, a1
    lw           t2, 0(a0)    /* t2 = dst */
    lw           t3, 4(a0)    /* t3 = dst */
    MIPS_2xUN8x4_MUL_2xUN8x4 a1, a1, t0, t1, t4, t5, t9, s0, s1, s2, s3, s4, s5
    not          t0, t0
    not          t1, t1
    MIPS_2xUN8x4_MUL_2xUN8x4 t2, t3, t0, t1, t2, t3, t9, s0, s1, s2, s3, s4, s5
    addu_s.qb    t4, t4, t2
    addu_s.qb    t5, t5, t3
21:
    sw           t4, 0(a0)
    sw           t5, 4(a0)
22:
    addiu        a3, a3, -2
    addiu        t1, a3, -1
    bgtz         t1, 2b
     addiu       a0, a0, 8
3:
    blez         a3, 4f
     nop
                              /* a1 = src */
    lw           t1, 0(a2)    /* t1 = mask */
    beqz         t1, 4f
     nop
    move         t2, a1       /* t2 = src */
    beq          t1, t7, 31f
     lw          t0, 0(a0)    /* t0 = dst */

    MIPS_UN8x4_MUL_UN8x4  a1, t1, t2, t9, t3, t4, t5, t6
    MIPS_UN8x4_MUL_UN8    t1, t8, t1, t9, t3, t4, t5
31:
    not          t1, t1
    MIPS_UN8x4_MUL_UN8x4  t0, t1, t0, t9, t3, t4, t5, t6
    addu_s.qb    t0, t2, t0
    sw           t0, 0(a0)
4:
    RESTORE_REGS_FROM_STACK 8, s0, s1, s2, s3, s4, s5
    j            ra
     nop

END(pixman_composite_over_n_8888_8888_ca_asm_mips)

LEAF_MIPS_DSPR2(pixman_composite_over_n_8888_0565_ca_asm_mips)
/*
 * a0 - dst  (r5g6b5)
 * a1 - src  (32bit constant)
 * a2 - mask (a8r8g8b8)
 * a3 - w
 */

    SAVE_REGS_ON_STACK 20, s0, s1, s2, s3, s4, s5, s6, s7, s8
    beqz         a3, 4f
     nop
    li           t5, 0xf800f800
    li           t6, 0x07e007e0
    li           t7, 0x001F001F
    li           t9, 0x00ff00ff

    srl          t8, a1, 24   /* t8 = srca */
    addiu        t1, a3, -1
    beqz         t1, 3f       /* last pixel */
     nop
    li           s0, 0xff     /* s0 = 0xff */
    addiu        s1, zero, -1 /* s1 = 0xffffffff */

    beq          t8, s0, 2f   /* if (srca == 0xff) */
     nop
1:
                              /* a1 = src */
    lw           t0, 0(a2)    /* t0 = mask */
    lw           t1, 4(a2)    /* t1 = mask */
    or           t2, t0, t1
    beqz         t2, 12f      /* if (t0 == 0) && (t1 == 0) */
     addiu       a2, a2, 8
    and          t3, t0, t1
    move         s2, a1       /* s2 = src */
    move         s3, a1       /* s3 = src */
    lhu          t2, 0(a0)    /* t2 = dst */
    beq          t3, s1, 11f  /* if (t0 == 0xffffffff) && (t1 == 0xffffffff) */
     lhu         t3, 2(a0)    /* t3 = dst */
    MIPS_2xUN8x4_MUL_2xUN8x4 a1, a1, t0, t1, s2, s3, t9, t4, s4, s5, s6, s7, s8
    MIPS_2xUN8x4_MUL_2xUN8   t0, t1, t8, t8, t0, t1, t9, t4, s4, s5, s6, s7, s8
11:
    not          t0, t0
    not          t1, t1
    CONVERT_2x0565_TO_2x8888 t2, t3, s4, s5, t6, t7, t4, s6, s7, s8
    MIPS_2xUN8x4_MUL_2xUN8x4 s4, s5, t0, t1, s4, s5, t9, t4, s6, s7, s8, t0, t1
    addu_s.qb    s2, s2, s4
    addu_s.qb    s3, s3, s5
    CONVERT_2x8888_TO_2x0565 s2, s3, t2, t3, t5, t6, t7, s4, s5
    sh           t2, 0(a0)
    sh           t3, 2(a0)
12:
    addiu        a3, a3, -2
    addiu        t1, a3, -1
    bgtz         t1, 1b
     addiu       a0, a0, 4
    b            3f
     nop
2:
                              /* a1 = src */
    lw           t0, 0(a2)    /* t0 = mask */
    lw           t1, 4(a2)    /* t1 = mask */
    or           t2, t0, t1
    beqz         t2, 22f      /* if (t0 == 0) & (t1 == 0) */
     addiu       a2, a2, 8
    and          t3, t0, t1
    move         t2, a1
    beq          t3, s1, 21f  /* if (t0 == 0xffffffff) && (t1 == 0xffffffff) */
     move        t3, a1
    lhu          t2, 0(a0)    /* t2 = dst */
    lhu          t3, 2(a0)    /* t3 = dst */
    MIPS_2xUN8x4_MUL_2xUN8x4 a1, a1, t0, t1, s2, s3, t9, t4, s4, s5, s6, s7, s8
    not          t0, t0
    not          t1, t1
    CONVERT_2x0565_TO_2x8888 t2, t3, s4, s5, t6, t7, t4, s6, s7, s8
    MIPS_2xUN8x4_MUL_2xUN8x4 s4, s5, t0, t1, s4, s5, t9, t4, s6, s7, s8, t2, t3
    addu_s.qb    t2, s2, s4
    addu_s.qb    t3, s3, s5
21:
    CONVERT_2x8888_TO_2x0565 t2, t3, t0, t1, t5, t6, t7, s2, s3
    sh           t0, 0(a0)
    sh           t1, 2(a0)
22:
    addiu        a3, a3, -2
    addiu        t1, a3, -1
    bgtz         t1, 2b
     addiu       a0, a0, 4
3:
    blez         a3, 4f
     nop
                              /* a1 = src */
    lw           t1, 0(a2)    /* t1 = mask */
    beqz         t1, 4f
     nop
    move         t2, a1       /* t2 = src */
    beq          t1, t7, 31f
     lhu         t0, 0(a0)    /* t0 = dst */

    MIPS_UN8x4_MUL_UN8x4     a1, t1, t2, t9, t3, t4, t5, t6
    MIPS_UN8x4_MUL_UN8       t1, t8, t1, t9, t3, t4, t5
31:
    not          t1, t1
    CONVERT_1x0565_TO_1x8888 t0, s1, s2, s3
    MIPS_UN8x4_MUL_UN8x4     s1, t1, t3, t9, t4, t5, t6, t7
    addu_s.qb    t0, t2, t3
    CONVERT_1x8888_TO_1x0565 t0, s1, s2, s3
    sh           s1, 0(a0)
4:
    RESTORE_REGS_FROM_STACK  20, s0, s1, s2, s3, s4, s5, s6, s7, s8
    j            ra
     nop

END(pixman_composite_over_n_8888_0565_ca_asm_mips)

LEAF_MIPS_DSPR2(pixman_composite_over_n_8_8888_asm_mips)
/*
 * a0 - dst  (a8r8g8b8)
 * a1 - src  (32bit constant)
 * a2 - mask (a8)
 * a3 - w
 */

    SAVE_REGS_ON_STACK 4, s0, s1, s2, s3, s4
    beqz      a3, 4f
     nop
    li        t4, 0x00ff00ff
    li        t5, 0xff
    addiu     t0, a3, -1
    beqz      t0, 3f         /* last pixel */
     srl      t6, a1, 24     /* t6 = srca */
    not       s4, a1
    beq       t5, t6, 2f     /* if (srca == 0xff) */
     srl      s4, s4, 24
1:
                             /* a1 = src */
    lbu       t0, 0(a2)      /* t0 = mask */
    lbu       t1, 1(a2)      /* t1 = mask */
    or        t2, t0, t1
    beqz      t2, 111f       /* if (t0 == 0) && (t1 == 0) */
     addiu    a2, a2, 2
    and       t3, t0, t1

    lw        t2, 0(a0)      /* t2 = dst */
    beq       t3, t5, 11f    /* if (t0 == 0xff) && (t1 == 0xff) */
     lw       t3, 4(a0)      /* t3 = dst */

    MIPS_2xUN8x4_MUL_2xUN8 a1, a1, t0, t1, s0, s1, t4, t6, t7, t8, t9, s2, s3
    not       s2, s0
    not       s3, s1
    srl       s2, s2, 24
    srl       s3, s3, 24
    MIPS_2xUN8x4_MUL_2xUN8 t2, t3, s2, s3, t2, t3, t4, t0, t1, t6, t7, t8, t9
    addu_s.qb s2, t2, s0
    addu_s.qb s3, t3, s1
    sw        s2, 0(a0)
    b         111f
     sw       s3, 4(a0)
11:
    MIPS_2xUN8x4_MUL_2xUN8 t2, t3, s4, s4, t2, t3, t4, t0, t1, t6, t7, t8, t9
    addu_s.qb s2, t2, a1
    addu_s.qb s3, t3, a1
    sw        s2, 0(a0)
    sw        s3, 4(a0)

111:
    addiu     a3, a3, -2
    addiu     t0, a3, -1
    bgtz      t0, 1b
     addiu    a0, a0, 8
    b         3f
     nop
2:
                             /* a1 = src */
    lbu       t0, 0(a2)      /* t0 = mask */
    lbu       t1, 1(a2)      /* t1 = mask */
    or        t2, t0, t1
    beqz      t2, 222f       /* if (t0 == 0) && (t1 == 0) */
     addiu    a2, a2, 2
    and       t3, t0, t1
    beq       t3, t5, 22f    /* if (t0 == 0xff) && (t1 == 0xff) */
     nop
    lw        t2, 0(a0)      /* t2 = dst */
    lw        t3, 4(a0)      /* t3 = dst */

    OVER_2x8888_2x8_2x8888 a1, a1, t0, t1, t2, t3, \
                           t6, t7, t4, t8, t9, s0, s1, s2, s3
    sw        t6, 0(a0)
    b         222f
     sw        t7, 4(a0)
22:
    sw        a1, 0(a0)
    sw        a1, 4(a0)
222:
    addiu     a3, a3, -2
    addiu     t0, a3, -1
    bgtz      t0, 2b
     addiu    a0, a0, 8
3:
    blez      a3, 4f
     nop
                             /* a1 = src */
    lbu       t0, 0(a2)      /* t0 = mask */
    beqz      t0, 4f         /* if (t0 == 0) */
     addiu    a2, a2, 1
    move      t3, a1
    beq       t0, t5, 31f    /* if (t0 == 0xff) */
     lw       t1, 0(a0)      /* t1 = dst */

    MIPS_UN8x4_MUL_UN8 a1, t0, t3, t4, t6, t7, t8
31:
    not       t2, t3
    srl       t2, t2, 24
    MIPS_UN8x4_MUL_UN8 t1, t2, t1, t4, t6, t7, t8
    addu_s.qb t2, t1, t3
    sw        t2, 0(a0)
4:
    RESTORE_REGS_FROM_STACK 4, s0, s1, s2, s3, s4
    j         ra
     nop

END(pixman_composite_over_n_8_8888_asm_mips)

LEAF_MIPS_DSPR2(pixman_composite_over_n_8_0565_asm_mips)
/*
 * a0 - dst  (r5g6b5)
 * a1 - src  (32bit constant)
 * a2 - mask (a8)
 * a3 - w
 */
    SAVE_REGS_ON_STACK 24, v0, s0, s1, s2, s3, s4, s5, s6, s7, s8
    beqz     a3, 4f
     nop
    li       t4, 0x00ff00ff
    li       t5, 0xff
    li       t6, 0xf800f800
    li       t7, 0x07e007e0
    li       t8, 0x001F001F
    addiu    t1, a3, -1
    beqz     t1, 3f         /* last pixel */
     srl     t0, a1, 24     /* t0 = srca */
    not      v0, a1
    beq      t0, t5, 2f     /* if (srca == 0xff) */
     srl     v0, v0, 24
1:
                            /* a1 = src */
    lbu      t0, 0(a2)      /* t0 = mask */
    lbu      t1, 1(a2)      /* t1 = mask */
    or       t2, t0, t1
    beqz     t2, 111f       /* if (t0 == 0) && (t1 == 0) */
     addiu   a2, a2, 2
    lhu      t2, 0(a0)      /* t2 = dst */
    lhu      t3, 2(a0)      /* t3 = dst */
    CONVERT_2x0565_TO_2x8888 t2, t3, s0, s1, t7, t8, t9, s2, s3, s4
    and      t9, t0, t1
    beq      t9, t5, 11f    /* if (t0 == 0xff) && (t1 == 0xff) */
     nop

    MIPS_2xUN8x4_MUL_2xUN8   a1, a1, t0, t1, s2, s3, t4, t9, s4, s5, s6, s7, s8
    not      s4, s2
    not      s5, s3
    srl      s4, s4, 24
    srl      s5, s5, 24
    MIPS_2xUN8x4_MUL_2xUN8   s0, s1, s4, s5, s0, s1, t4, t9, t0, t1, s6, s7, s8
    addu_s.qb                s4, s2, s0
    addu_s.qb                s5, s3, s1
    CONVERT_2x8888_TO_2x0565 s4, s5, t2, t3, t6, t7, t8, s0, s1
    sh       t2, 0(a0)
    b        111f
     sh      t3, 2(a0)
11:
    MIPS_2xUN8x4_MUL_2xUN8   s0, s1, v0, v0, s0, s1, t4, t9, t0, t1, s6, s7, s8
    addu_s.qb                s4, a1, s0
    addu_s.qb                s5, a1, s1
    CONVERT_2x8888_TO_2x0565 s4, s5, t2, t3, t6, t7, t8, s0, s1
    sh       t2, 0(a0)
    sh       t3, 2(a0)
111:
    addiu    a3, a3, -2
    addiu    t0, a3, -1
    bgtz     t0, 1b
     addiu   a0, a0, 4
    b        3f
     nop
2:
    CONVERT_1x8888_TO_1x0565 a1, s0, s1, s2
21:
                            /* a1 = src */
    lbu      t0, 0(a2)      /* t0 = mask */
    lbu      t1, 1(a2)      /* t1 = mask */
    or       t2, t0, t1
    beqz     t2, 222f       /* if (t0 == 0) && (t1 == 0) */
     addiu   a2, a2, 2
    and      t9, t0, t1
    move     s2, s0
    beq      t9, t5, 22f    /* if (t0 == 0xff) && (t2 == 0xff) */
     move    s3, s0
    lhu      t2, 0(a0)      /* t2 = dst */
    lhu      t3, 2(a0)      /* t3 = dst */

    CONVERT_2x0565_TO_2x8888 t2, t3, s2, s3, t7, t8, s4, s5, s6, s7
    OVER_2x8888_2x8_2x8888   a1, a1, t0, t1, s2, s3, \
                             t2, t3, t4, t9, s4, s5, s6, s7, s8
    CONVERT_2x8888_TO_2x0565 t2, t3, s2, s3, t6, t7, t8, s4, s5
22:
    sh       s2, 0(a0)
    sh       s3, 2(a0)
222:
    addiu    a3, a3, -2
    addiu    t0, a3, -1
    bgtz     t0, 21b
     addiu   a0, a0, 4
3:
    blez      a3, 4f
     nop
                            /* a1 = src */
    lbu      t0, 0(a2)      /* t0 = mask */
    beqz     t0, 4f         /* if (t0 == 0) */
     nop
    lhu      t1, 0(a0)      /* t1 = dst */
    CONVERT_1x0565_TO_1x8888 t1, t2, t3, t7
    beq      t0, t5, 31f    /* if (t0 == 0xff) */
     move    t3, a1

    MIPS_UN8x4_MUL_UN8       a1, t0, t3, t4, t7, t8, t9
31:
    not      t6, t3
    srl      t6, t6, 24
    MIPS_UN8x4_MUL_UN8       t2, t6, t2, t4, t7, t8, t9
    addu_s.qb                t1, t2, t3
    CONVERT_1x8888_TO_1x0565 t1, t2, t3, t7
    sh       t2, 0(a0)
4:
    RESTORE_REGS_FROM_STACK  24, v0, s0, s1, s2, s3, s4, s5, s6, s7, s8
    j        ra
     nop

END(pixman_composite_over_n_8_0565_asm_mips)

LEAF_MIPS_DSPR2(pixman_scaled_bilinear_scanline_8888_8_8888_OVER_asm_mips)
/*
 * a0     - dst        (a8r8g8b8)
 * a1     - mask       (a8)
 * a2     - src_top    (a8r8g8b8)
 * a3     - src_bottom (a8r8g8b8)
 * 16(sp) - wt
 * 20(sp) - wb
 * 24(sp) - vx
 * 28(sp) - unit_x
 * 32(sp) - w
 */

    SAVE_REGS_ON_STACK 28, v0, v1, s0, s1, s2, s3, s4, s5, s6, s7, s8

    lw       v1, 60(sp)        /* v1 = w(sp + 32 + 28 save regs stack offset)*/
    beqz     v1, 1f
     nop

    lw       s0, 44(sp)        /* s0 = wt */
    lw       s1, 48(sp)        /* s1 = wb */
    lw       s2, 52(sp)        /* s2 = vx */
    lw       s3, 56(sp)        /* s3 = unit_x */
    li       v0, 256
    li       s8, 0x00ff00ff
0:
    andi     t4, s2, 0xffff    /* t4 = (short)vx */
    srl      t4, t4, 8         /* t4 = vx >> 8 */
    subu     t5, v0, t4        /* t5 = ( 256 - (vx>>8)) */

    mul      s4, s0, t5        /* s4 = wt*(256-(vx>>8)) */
    mul      s5, s0, t4        /* s5 = wt*(vx>>8) */
    mul      s6, s1, t5        /* s6 = wb*(256-(vx>>8)) */
    mul      s7, s1, t4        /* s7 = wb*(vx>>8) */

    sra      t9, s2, 16
    sll      t9, t9, 2
    addiu    t8, t9, 4
    lwx      t0, t9(a2)        /* t0 = tl */
    lwx      t1, t8(a2)        /* t1 = tr */
    addiu    v1, v1, -1
    lwx      t2, t9(a3)        /* t2 = bl */
    lwx      t3, t8(a3)        /* t3 = br */

    BILINEAR_INTERPOLATE_SINGLE_PIXEL t0, t1, t2, t3, \
                                      t4, t5, t6, t7, t8, t9, s4, s5, s6, s7
    lbu      t1, 0(a1)         /* t1 = mask */
    lw       t2, 0(a0)         /* t2 = dst */
    addiu    a1, a1, 1
    OVER_8888_8_8888 t0, t1, t2, t0, s8, t3, t4, t5, t6

    addu     s2, s2, s3        /* vx += unit_x; */
    sw       t0, 0(a0)
    bnez     v1, 0b
     addiu   a0, a0, 4

1:
    RESTORE_REGS_FROM_STACK 28, v0, v1, s0, s1, s2, s3, s4, s5, s6, s7, s8
    j        ra
     nop

END(pixman_scaled_bilinear_scanline_8888_8_8888_OVER_asm_mips)
