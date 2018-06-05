extern ImpulseResponse h;

void LoadCoefficientsIIR(void)
{
	h.irr.num[0] = 0x0e39;	h.irr.den[0] = 0x0e39;
	h.irr.num[1] = 0x1c72;	h.irr.den[1] = 0x1c72;
	h.irr.num[2] = 0x2aab;	h.irr.den[2] = 0x2aab;
	h.irr.num[3] = 0x38e4;	h.irr.den[3] = 0x38e4;
	h.irr.num[4] = 0x471d;	h.irr.den[4] = 0x471d;
	h.irr.num[5] = 0x5556;	h.irr.den[5] = 0x5556;
	h.irr.num[6] = 0x638f;	h.irr.den[6] = 0x638f;
	h.irr.num[7] = 0x71c8;	h.irr.den[7] = 0x71c8;
	h.irr.num[8] = 0x7fff;	h.irr.den[8] = 0x7fff;
}
