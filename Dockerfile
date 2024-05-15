# 使用 Ubuntu 20.04 作為基底鏡像
FROM ubuntu:20.04

# 避免在安裝過程中出現問題，設置非互動式安裝
ARG DEBIAN_FRONTEND=noninteractive

# 安裝必要的套件
RUN apt-get update && \
    apt-get install -y make wget xz-utils git vim python3.8 python3-pip && \
    rm -rf /var/lib/apt/lists/* 
RUN pip install ethos-u-vela


# 下載 Arm GNU 工具鏈並解壓縮
RUN cd /root && \
    wget https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz && \
    tar -xvf arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz && \
    rm arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz 
# 將工具鏈加到 PATH
ENV PATH="/root/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin:${PATH}"

# clone Seeed Grove Vision AI Module V2 
RUN cd /root && \
    git clone https://github.com/HimaxWiseEyePlus/Seeed_Grove_Vision_AI_Module_V2

# clone ML_FVP_EVALUATION
#https://github.com/HimaxWiseEyePlus/ML_FVP_EVALUATION

RUN cd /root && \
    git clone https://github.com/HimaxWiseEyePlus/ML_FVP_EVALUATION

# Create folder to be extracted
#mkdir temp
# Extract the archive
#tar -C temp -xvzf FVP_Corstone_SSE-300_Ethos-U55_11.14_24.tgz

COPY build-firmware.sh /root/build-firmware.sh
COPY run_vela.sh /root/run_vela.sh


CMD ["/root/build-firmware.sh"]

CMD ["/root/run_vela.sh ./ML_FVP_EVALUATION/vela/img_person_detect/person_int8_model.tflite"]

# 更改預設 shell 為 /bin/bash
RUN ln -sf /bin/bash /bin/sh

# 設定容器啟動時的工作目錄
WORKDIR /root