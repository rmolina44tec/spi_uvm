// file = 0; split type = patterns; threshold = 100000; total count = 0.
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "rmapats.h"

void  hsG_0__0 (struct dummyq_struct * I1351, EBLK  * I1346, U  I708);
void  hsG_0__0 (struct dummyq_struct * I1351, EBLK  * I1346, U  I708)
{
    U  I1611;
    U  I1612;
    U  I1613;
    struct futq * I1614;
    struct dummyq_struct * pQ = I1351;
    I1611 = ((U )vcs_clocks) + I708;
    I1613 = I1611 & ((1 << fHashTableSize) - 1);
    I1346->I753 = (EBLK  *)(-1);
    I1346->I754 = I1611;
    if (0 && rmaProfEvtProp) {
        vcs_simpSetEBlkEvtID(I1346);
    }
    if (I1611 < (U )vcs_clocks) {
        I1612 = ((U  *)&vcs_clocks)[1];
        sched_millenium(pQ, I1346, I1612 + 1, I1611);
    }
    else if ((peblkFutQ1Head != ((void *)0)) && (I708 == 1)) {
        I1346->I756 = (struct eblk *)peblkFutQ1Tail;
        peblkFutQ1Tail->I753 = I1346;
        peblkFutQ1Tail = I1346;
    }
    else if ((I1614 = pQ->I1254[I1613].I776)) {
        I1346->I756 = (struct eblk *)I1614->I774;
        I1614->I774->I753 = (RP )I1346;
        I1614->I774 = (RmaEblk  *)I1346;
    }
    else {
        sched_hsopt(pQ, I1346, I1611);
    }
}
#ifdef __cplusplus
extern "C" {
#endif
void SinitHsimPats(void);
#ifdef __cplusplus
}
#endif
