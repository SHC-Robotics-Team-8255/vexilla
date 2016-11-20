FOLDER := src
OS := $(shell uname)
ifeq ($(OS),Darwin)
	TOOLS=xcode-select --install
	GCC=cd $(FOLDER);tar xjvf ../downloads/gcc-arm-none-eabi-5_4-2016q3-20160926-mac.tar.bz2
	DOWN=cd downloads;wget https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-mac.tar.bz2
else
	TOOLS=sudo apt-get install -y build-essential
	GCC=cd $(FOLDER);tar xjvf ../downloads/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2
	DOWN=cd downloads;wget https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2
endif

prepare:
	-mkdir $(FOLDER)

download:
	-mkdir downloads;
	-$(DOWN)

install-tools: prepare
	-$(TOOLS)
	-$(GCC)
repos:
	cd $(FOLDER);git clone git@github.com:SHC-Robotics-Team-8255/example-vex.git
	cd $(FOLDER);git clone git@github.com:SHC-Robotics-Team-8255/convex-vexilla.git
	cd $(FOLDER);git clone git@github.com:SHC-Robotics-Team-8255/ChibiOS.git


