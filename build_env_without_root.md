1. create your own install dir, eg: 
  mkdir ~/software/usr/
you can mkdir lib lib64 bin include in software/usr

2. configure your env.
vim ~/.bashrc
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/home/my/software/install/usr/include/
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/home/my/software/install/usr/include/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/my/software/install/usr/lib64/:/home/yuansheng.lys/software/install/usr/lib/
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/home/my/software/install/usr/pkgconfig

3. when you install software, please use --prefix=/home/my/software/install/usr/
