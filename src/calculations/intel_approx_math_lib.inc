macro sse_sincos_ess {
	movaps	xmm7, xmm0
	movss	xmm1, [_ps_am_inv_sign_mask]
	movss	xmm2, [_ps_am_sign_mask]
	movss	xmm3, [_ps_am_2_o_pi]
	andps	xmm0, xmm1
	andps	xmm7, xmm2
	mulss	xmm0, xmm3

	pxor	xmm3, xmm3
	movd	xmm5, [_epi32_1]
	movss	xmm4, [_ps_am_1]

	cvttps2dq	xmm2, xmm0
	pand	xmm5, xmm2
	movd	xmm1, [_epi32_2]
	pcmpeqd	xmm5, xmm3
	movd	xmm3, [_epi32_1]
	cvtdq2ps	xmm6, xmm2
	paddd	xmm3, xmm2
	pand	xmm2, xmm1
	pand	xmm3, xmm1
	subss	xmm0, xmm6
	pslld	xmm2, (31 - 1)
	minss	xmm0, xmm4
	subss	xmm4, xmm0
	pslld	xmm3, (31 - 1)

	movaps	xmm6, xmm4
	xorps	xmm2, xmm7
	movaps	xmm7, xmm5
	andps	xmm6, xmm7
	andnps	xmm7, xmm0
	andps	xmm0, xmm5
	andnps	xmm5, xmm4
	movss	xmm4, [_ps_sincos_p3]
	orps	xmm6, xmm7
	orps	xmm0, xmm5
	movss	xmm5, [_ps_sincos_p2]

	movaps	xmm1, xmm0
	movaps	xmm7, xmm6
	mulss	xmm0, xmm0
	mulss	xmm6, xmm6
	orps	xmm1, xmm2
	orps	xmm7, xmm3
	movaps	xmm2, xmm0
	movaps	xmm3, xmm6
	mulss	xmm0, xmm4
	mulss	xmm6, xmm4
	movss	xmm4, [_ps_sincos_p1]
	addss	xmm0, xmm5
	addss	xmm6, xmm5
	movss	xmm5, [_ps_sincos_p0]
	mulss	xmm0, xmm2
	mulss	xmm6, xmm3
	addss	xmm0, xmm4
	addss	xmm6, xmm4
	mulss	xmm0, xmm2
	mulss	xmm6, xmm3
	addss	xmm0, xmm5
	addss	xmm6, xmm5
	mulss	xmm0, xmm1
	mulss	xmm6, xmm7

	movaps	xmm1, xmm6
}

macro sse_atan2_ess {
	movss	xmm2, [_ps_am_sign_mask]
	xorps	xmm3, xmm3
	movss	xmm5, [_ps_am_1]
	andps	xmm2, xmm0
	mulss	xmm0, xmm1
	orps	xmm2, xword[_ps_am_pi]
	cmpless	xmm3, xmm1

	movss	xmm6, [_ps_am_m1]
	rcpss	xmm4, xmm0

	cmpltss	xmm5, xmm0
	cmpnless	xmm6, xmm0
	movss	xmm1, [_ps_atan_s0]
	orps	xmm5, xmm6

	movss	[esp - 4], xmm2
	movss	[esp - 8], xmm3

	andps	xmm4, xmm5
	movss	xmm2, [_ps_atan_t0]
	movaps	xmm7, xmm5
	andnps	xmm5, xmm0
	movss	xmm3, [_ps_atan_s1]
	orps	xmm4, xmm5
	movaps	xmm0, xmm4

	movss	xmm6, [_ps_atan_t1]
	mulss	xmm4, xmm4

	addss	xmm1, xmm4
	movss	xmm5, [_ps_atan_s2]
	rcpss	xmm1, xmm1
	mulss	xmm1, xmm2
	movss	xmm2, [_ps_atan_t2]
	addss	xmm3, xmm4
	addss	xmm1, xmm3

	movss	xmm3, [_ps_atan_s3]
	rcpss	xmm1, xmm1
	mulss	xmm1, xmm6
	movss	xmm6, [_ps_atan_t3]
	addss	xmm5, xmm4
	addss	xmm1, xmm5

	movss	xmm5, [_ps_am_sign_mask]
	rcpss	xmm1, xmm1
	mulss	xmm1, xmm2
	addss	xmm3, xmm4
	movss	xmm4, [_ps_am_pi_o_2]
	mulss	xmm6, xmm0
	addss	xmm1, xmm3

	andps	xmm0, xmm5
	rcpss	xmm1, xmm1
	movss	xmm3, [esp - 8]
	mulss	xmm1, xmm6

	orps	xmm0, xmm4
	subss	xmm0, xmm1
	movss	xmm2, [esp - 4]

	andps	xmm0, xmm7
	andnps	xmm7, xmm1
	orps	xmm0, xmm7

	movaps	xmm1, xmm0
	andps	xmm0, xmm3
	addss	xmm1, xmm2
	andnps	xmm3, xmm1
	orps	xmm0, xmm3
}

macro sse_atan2_ps {
	movaps	xmm2, xword[_ps_am_sign_mask]
	xorps	xmm3, xmm3
	mov		ecx, esp
	movaps	xmm5, xword[_ps_am_1]
	andps	xmm2, xmm0
	mulps	xmm0, xmm1
	and		ecx, not 15
	orps	xmm2, xword[_ps_am_pi]
	cmpleps	xmm3, xmm1

	movaps	xmm6, xword[_ps_am_m1]
	rcpps	xmm4, xmm0

	cmpltps	xmm5, xmm0
	cmpnleps	xmm6, xmm0
	movaps	xmm1, xword[_ps_atan_s0]
	orps	xmm5, xmm6

	movaps	[ecx - 16], xmm2
	movaps	[ecx - 32], xmm3

	andps	xmm4, xmm5
	movaps	xmm2, xword[_ps_atan_t0]
	movaps	xmm7, xmm5
	andnps	xmm5, xmm0
	movaps	xmm3, xword[_ps_atan_s1]
	orps	xmm4, xmm5
	movaps	xmm0, xmm4

	movaps	xmm6, xword[_ps_atan_t1]
	mulps	xmm4, xmm4

	addps	xmm1, xmm4
	movaps	xmm5, xword[_ps_atan_s2]
	rcpps	xmm1, xmm1
	mulps	xmm1, xmm2
	movaps	xmm2, xword[_ps_atan_t2]
	addps	xmm3, xmm4
	addps	xmm1, xmm3

	movaps	xmm3, xword[_ps_atan_s3]
	rcpps	xmm1, xmm1
	mulps	xmm1, xmm6
	movaps	xmm6, xword[_ps_atan_t3]
	addps	xmm5, xmm4
	addps	xmm1, xmm5

	movaps	xmm5, xword[_ps_am_sign_mask]
	rcpps	xmm1, xmm1
	mulps	xmm1, xmm2
	addps	xmm3, xmm4
	movaps	xmm4, xword[_ps_am_pi_o_2]
	mulps	xmm6, xmm0
	addps	xmm1, xmm3

	andps	xmm0, xmm5
	rcpps	xmm1, xmm1
	movaps	xmm3, [ecx - 32]
	mulps	xmm1, xmm6

	orps	xmm0, xmm4
	subps	xmm0, xmm1
	movaps	xmm2, [ecx - 16]

	andps	xmm0, xmm7
	andnps	xmm7, xmm1
	orps	xmm0, xmm7

	movaps	xmm1, xmm0
	andps	xmm0, xmm3
	addps	xmm1, xmm2
	andnps	xmm3, xmm1
	orps	xmm0, xmm3
}


align 16
_ps_am_sign_mask		dd 4 dup 0x80000000
_ps_am_inv_sign_mask	dd 4 dup 0x7FFFFFFF
_ps_am_pi				dd 4 dup 3.14159265358979323846
_ps_am_pi_o_2			dd 4 dup 1.57079632679489661923
_ps_am_2_o_pi			dd 4 dup 0.63661977236758134307
_ps_am_m1				dd 4 dup -1.0
_epi32_1				dd 4 dup 1
_ps_am_1 				dd 4 dup 1.0
_epi32_2				dd 4 dup 2

_ps_sincos_p3			dd 4 dup -0.468175413106023168e-2
_ps_sincos_p2			dd 4 dup 0.7969262624561800806e-1
_ps_sincos_p1			dd 4 dup -0.64596409750621907082e0
_ps_sincos_p0			dd 4 dup 0.15707963267948963959e1

_ps_atan_t0				dd 4 dup -0.91646118527267623468e-1
_ps_atan_t1				dd 4 dup -0.13956945682312098640e1
_ps_atan_t2				dd 4 dup -0.94393926122725531747e2
_ps_atan_t3				dd 4 dup 0.12888383034157279340e2

_ps_atan_s0				dd 4 dup 0.12797564625607904396e1
_ps_atan_s1				dd 4 dup 0.21972168858277355914e1
_ps_atan_s2				dd 4 dup 0.68193064729268275701e1
_ps_atan_s3				dd 4 dup 0.28205206687035841409e2
