#!/bin/bash

# Check if a model file was passed as an argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 [path_to_model.tflite]"
  echo "Please provide the path to a .tflite model file. For example:"
  echo "./run_vela.sh ./path/to/your_model.tflite"
  exit 1
fi

# Define the config file and output directory
config_file="/root/ML_FVP_EVALUATION/vela/himax_vela.ini"
output_dir="/root/Seeed_Grove_Vision_AI_Module_V2/model_zoo"

# Ensure the config file exists
if [ ! -f "$config_file" ]; then
    echo "Config file does not exist: $config_file"
    exit 1
fi

# Retrieve the model file path
model_file=$1

# Ensure the output directory exists, create if not
mkdir -p "$output_dir"

# Execute the vela command
vela --accelerator-config ethos-u55-64 \
     --config "$config_file" \
    --system-config My_Sys_Cfg \
    --memory-mode My_Mem_Mode_Parent \
    --output-dir "$output_dir" \
    "$model_file"

echo "Script execution complete, model has been output to: $output_dir"