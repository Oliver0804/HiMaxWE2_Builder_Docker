#!/bin/bash

cd /root/Seeed_Grove_Vision_AI_Module_V2/EPII_CM55M_APP_S && \
make clean && \
make

cd /root/Seeed_Grove_Vision_AI_Module_V2 && \
cp EPII_CM55M_APP_S/obj_epii_evb_icv30_bdv10/gnu_epii_evb_WLCSP65/EPII_CM55M_gnu_epii_evb_WLCSP65_s.elf we2_image_gen_local/input_case1_secboot/ && \
cd we2_image_gen_local && \
./we2_local_image_gen project_case1_blp_wlcsp.json
