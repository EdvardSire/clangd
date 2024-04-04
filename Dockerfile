FROM ubuntu:jammy
# Jammy for cmake 3.22 > 3.20
# or we can use kitware ppa for cmake 3.x


RUN apt update

RUN apt install -y gcc-9-arm-linux-gnueabihf
RUN apt install -y git-core
RUN git clone https://github.com/llvm/llvm-project.git


ENV DEBIAN_FRONTEND=noninteractive
RUN apt install -y cmake \
    binutils-arm-linux-gnueabihf \
    ninja-build \
    libstdc++6-armhf-cross \
    clang-12


RUN cd llvm-project && mkdir -p build && cd build && \
    cmake -G Ninja ../llvm \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DLLVM_HOST_TRIPLE=arm-linux-gnueabihf \
        -DLLVM_TARGETS_TO_BUILD=ARM \
        -DCMAKE_BUILD_TYPE=Release \
        -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" \
        -DCMAKE_C_COMPILER=clang-12 \
        -DCMAKE_CXX_COMPILER=clang++-12



