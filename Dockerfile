FROM nvidia/cuda:9.2-devel-ubuntu16.04

ENV TORCH_NVCC_FLAGS="-D__CUDA_NO_HALF_OPERATORS__"
ENV TORCH_LUA_VERSION=LUA53

RUN apt-get -qq update && \
  apt-get install -y lua5.3 git build-essential cmake sudo libreadline-dev python-pycurl python-apt && \
  rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/torch/distro.git /root/torch --recursive

COPY torch/extra/cutorch/TensorMath.lua /root/torch/extra/cutorch/TensorMath.lua
COPY torch/pkg/torch/TensorMath.lua /root/torch/pkg/torch/TensorMath.lua

RUN cd /root/torch && \
  bash install-deps && \
  ./clean.sh && \
  yes no | ./install.sh

# Export the LUA evironment variables manually
ENV LUA_PATH='/root/.luarocks/share/lua/5.3/?.lua;/root/.luarocks/share/lua/5.3/?/init.lua;/root/torch/install/share/lua/5.3/?.lua;/root/torch/install/share/lua/5.3/?/init.lua;./?.lua;/root/torch/install/share/luajit-2.1.0-beta1/?.lua;/usr/local/share/lua/5.3/?.lua;/usr/local/share/lua/5.3/?/init.lua'
ENV LUA_CPATH='/root/.luarocks/lib/lua/5.3/?.so;/root/torch/install/lib/lua/5.3/?.so;./?.so;/usr/local/lib/lua/5.3/?.so;/usr/local/lib/lua/5.3/loadall.so'
ENV PATH=/root/torch/install/bin:$PATH
ENV LD_LIBRARY_PATH=/root/torch/install/lib:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH=/root/torch/install/lib:$DYLD_LIBRARY_PATH
ENV LUA_CPATH='/root/torch/install/lib/?.so;'$LUA_CPATH
