FOLDER := src
OS := $(shell uname)
ifeq ($(OS),Darwin)
	TOOLS=xcode-select --install
	GCC=../downloads/gcc-arm-none-eabi-5_4-2016q3-20160926-mac.tar.bz2
	DOWN=https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-mac.tar.bz2
	TARBALL=downloads/gcc-arm-none-eabi-5_4-2016q3-20160926-mac.tar.bz2
else
	TOOLS=sudo apt-get install -y build-essential
	GCC=../downloads/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2
	DOWN=https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2
	TARBALL=downloads/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2
#	-sudo dpkg --add-architecture i386
#	-sudo apt-get update
#	-sudo apt-get install --reinstall libc6-i386
endif

all: tools repos

prepare:
	-mkdir $(FOLDER)


$(TARBALL):
	-mkdir downloads;
	cd downloads;wget --no-check-certificate $(DOWN)


tools: $(TARBALL)
	-mkdir src
	-$(TOOLS)
	-(cd $(FOLDER);tar xjvf $(GCC))



repos:
	cd $(FOLDER);git clone git@github.com:SHC-Robotics-Team-8255/example-vex.git
	cd $(FOLDER);git clone git@github.com:SHC-Robotics-Team-8255/convex-vexilla.git
	cd $(FOLDER);git clone git@github.com:SHC-Robotics-Team-8255/ChibiOS.git
	cd $(FOLDER);git clone git@github.com:SHC-Robotics-Team-8255/stm32flashCortex.git

refresh:
	cd $(FOLDER)/example-vex;git pull
	cd $(FOLDER)/convex-vexilla;git pull
	cd $(FOLDER)/ChibiOS;git pull
	cd $(FOLDER)/stm32flashCortex;git pull

