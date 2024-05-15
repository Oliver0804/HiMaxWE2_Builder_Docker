#!/bin/bash

# Define the path to the makefile
makefile_path="/root/Seeed_Grove_Vision_AI_Module_V2/EPII_CM55M_APP_S/makefile"

# Display available projects
echo "Available projects to compile:"
echo "1. allon_sensor_tflm"
echo "2. allon_sensor_tflm_cmsis_nn (Enable CMSIS NN with LIB_CMSIS_NN_ENABLE = 1)"
echo "3. allon_sensor_tflm_fatfs"
echo "4. allon_sensor_tflm_freertos"
echo "5. fatfs_mmc_spi"
echo "6. hello_world_freertos_tz_s_only"
echo "7. tflm_fd_fm"
echo "8. tflm_yolov8_od"
echo "9. tflm_yolov8_pose"
echo "10. pdm_record"
echo "11. imu_read"
echo "12. hello_world_cmsis_dsp"

# Prompt the user to enter the project name
echo "Please enter the project name you wish to compile from the list above:"
read project_name

# Update the makefile with the specified APP_TYPE
sed -i "s/^APP_TYPE = .*/APP_TYPE = $project_name/" $makefile_path

echo "Navigating to the firmware compilation directory..."
cd /root/Seeed_Grove_Vision_AI_Module_V2/EPII_CM55M_APP_S || exit

echo "Cleaning old build files and compiling new firmware..."
make clean && make || { echo "Compilation failed"; exit 1; }

echo "Navigating to the firmware image generation directory..."
cd /root/Seeed_Grove_Vision_AI_Module_V2 || exit

echo "Copying compiled firmware to the image generation directory..."
cp EPII_CM55M_APP_S/obj_epii_evb_icv30_bdv10/gnu_epii_evb_WLCSP65/EPII_CM55M_gnu_epii_evb_WLCSP65_s.elf we2_image_gen_local/input_case1_secboot/ || { echo "Failed to copy firmware for image generation"; exit 1; }

echo "Generating firmware image..."
cd we2_image_gen_local && ./we2_local_image_gen project_case1_blp_wlcsp.json || { echo "Image generation failed"; exit 1; }

echo "Copying generated firmware image to the external firmware directory..."
cp output_case1_sec_wlcsp/output.img /root/firmware/ || { echo "Failed to copy the firmware image. Image creation might have failed."; exit 1; }

echo "Firmware image successfully created and copied."
