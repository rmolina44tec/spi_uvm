CU_MOD_OBJS =  \
objs/zr7M1_d.o objs/hEeZs_d.o objs/uM9F1_d.o objs/IHYdB_d.o objs/amcQw_d.o  \
objs/jdG3K_d.o objs/ftg4g_d.o amcQwB.o objs/reYIK_d.o objs/F03AY_d.o  \
objs/Mk7In_d.o 

CU_MOD_C_OBJS =  \


$(CU_MOD_C_OBJS): %.o: %.c
	$(CC_CG) $(CFLAGS_CG) -c -o $@ $<
CU_UDP_OBJS = \


CU_LVL_OBJS = \
SIM_l.o 

CU_OBJS = $(CU_MOD_OBJS) $(CU_MOD_C_OBJS) $(CU_UDP_OBJS) $(CU_LVL_OBJS)

PRE_LDFLAGS += -Wl,--whole-archive
STRIPFLAGS += -Wl,--no-whole-archive
