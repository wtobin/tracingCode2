#include <stdio.h>
#include "hocdec.h"
extern int nrnmpi_myid;
extern int nrn_nobanner_;

extern void _DoubExpSynA_reg(void);
extern void _LeakConductance_reg(void);
extern void _vecevent_reg(void);

void modl_reg(){
  if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
    fprintf(stderr, "Additional mechanisms from files\n");

    fprintf(stderr," DoubExpSynA.mod");
    fprintf(stderr," LeakConductance.mod");
    fprintf(stderr," vecevent.mod");
    fprintf(stderr, "\n");
  }
  _DoubExpSynA_reg();
  _LeakConductance_reg();
  _vecevent_reg();
}
