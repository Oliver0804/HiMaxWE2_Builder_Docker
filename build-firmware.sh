#!/bin/bash

echo "Navigating to the firmware compilation directory..."
cd /root/Seeed_Grove_Vision_AI_Module_V2/EPII_CM55M_APP_S || exit

# 
echo "Cleaning old build files and compiling new firmware..."
make clean && make || { echo "Compilation failed"; exit 1; }

# 
echo "Navigating to the firmware image generation directory..."
cd /root/Seeed_Grove_Vision_AI_Module_V2 || exit

# 
echo "Copying compiled firmware to the image generation directory..."
cp EPII_CM55M_APP_S/obj_epii_evb_icv30_bdv10/gnu_epii_evb_WLCSP65/EPII_CM55M_gnu_epii_evb_WLCSP65_s.elf we2_image_gen_local/input_case1_secboot/ || { echo "Failed to copy firmware for image generation"; exit 1; }

# 
echo "Generating firmware image..."
cd we2_image_gen_local && ./we2_local_image_gen project_case1_blp_wlcsp.json || { echo "Image generation failed"; exit 1; }

# 
echo "Copying generated firmware image to the external firmware directory..."
cp output_case1_sec_wlcsp/output.img /root/firmware/ || { echo "Failed to copy the firmware image. Image creation might have failed."; exit 1; }

echo "Firmware image successfully created and copied."
