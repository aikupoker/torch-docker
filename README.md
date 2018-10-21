# torch-docker

[![Build Status](https://travis-ci.org/aikupoker/torch-docker.svg?branch=master)](https://travis-ci.org/aikupoker/torch-docker)

This images contains Torch with Lua 5.3. Also contains nVIDIA CUDA enabled to be use to train your models with GPU.

This Torch build is a bit special because it includes a modification in his source code. There is a function that is not added by default "scatterAdd" and you can use it in your Lua applications.

You can install all your luarocks packages. Just write following:

```
luarocks install luasocket
```

Enjoy!
