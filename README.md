#Vexilla#

Tooling to help VEX Robotics team 8255 - SHC Robotics - program the VEX robot.

##Installation Instructions##

If you have not made a source code folder yet, do this:

```
    mkdir vex
    cd vex
```

Clone the vexilla repo:

```
git clone git@github.com:SHC-Robotics-Team-8255/vexilla.git
```

Note that you may get an error.  You may have to install git first.
You will need to have created an account on github.

You need to install things:

```
     make tools
     make repos
```

Tools will install the appropriare compiler for your computer and repos will install the four git repos you need to do work.  For reference they are:

- https://github.com/SHC-Robotics-Team-8255/ChibiOS - the real-time OS base
- https://github.com/SHC-Robotics-Team-8255/convex-vexilla - the VEX additions
- https://github.com/SHC-Robotics-Team-8255/stm32flashCortex - the flash utility
- https://github.com/SHC-Robotics-Team-8255/example-vex - example code

##Vexilla Example Code##

There is an example program in the repos/example-vex folder.  The two files you may need to edit are the Makefile and the vexuser.c file.

vexuser.c contains all the usercode for robotics behavior.  See the README file in that repo for form information.

##Making Your Own Program##

In the repo directory make a new directory for your code and then copy the example into it as a starting point.  If you wanted your program to be called testvex, you would:

```
     mkdir testvex
     cd testvex
     cp -Rv ../example-vex .
```

You would then edit the Makefile and make two important changes.  Change the name of your project from the default of "output" to a new name.  Change this:

```
# Define project name here
ifeq ($(PROJECT),)
PROJECT  = output
endif
```

to instead be:

```
# Define project name here
ifeq ($(PROJECT),)
PROJECT  = testvex
endif
```

using the name of your directory as the name instead of output.  This will embed that name into the program allowing you to see it on the robot using the shell (described later).

The other change you need to make is to use the right serial port.
You will need to detect what serial port device your computer
assignes.  You can automatically detect the name of the serial port by
doing this:

```
	make detect
```
This will generate an output that looks something like this:

```
    5a6
    > crw-rw-rw-  1 root      wheel   18,  18 Nov 24 12:39 /dev/tty.usbmodem14161
    55c56
```

Or you can do this all manually by running this set of commands:

```
    ls -al /dev/tty* >a
    (plug in the USB programmer connected through the remote control to the robot)
    ls -al /dev/tty* >b
    diff a b
```

You will see something like this:

```
    5a6
    > crw-rw-rw-  1 root      wheel   18,  18 Nov 24 12:39 /dev/tty.usbmodem14161
    55c56
```
The name of the serial port is the /dev/tty.usbmodem14161 part.  Now go edit the Makefile to make that be the defined serial port.  Change this:

```
SERIAL_PORT = /dev/ttyACM0
```

into the port you detected:

```
SERIAL_PORT = /dev/tty.usbmodem14161
```

Test that it works by connecting your terminal to the robot:

     make connect

You may see some garbage letters or nothing for a moment.  Hit the "Enter" key a few times and you should get a prompt that looks like this:

    ch>

You can see what commands are available by typing 'help' but the command you want to use to inspect the robot is 'info' which will give you a lot of good data:

```
ch>
ch>
ch> info
Kernel:       2.6.2
Compiler:     GCC 5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496]
Architecture: ARMv7-M
Core Variant: Cortex-M3
Port Info:    Advanced kernel mode
Platform:     STM32F10x Performance Line High Density
Board:        VEX CORTEX
ConVEX:       1.0.4
Build time:   Nov 24 2016 - 20:23:19
Project:      testvex
Git Hash:     4fe44de756b66c709344878c0adac0b1cec89600
```

The parts that will be the most useful are the Build time (when the program was compiled), the Project (the name you gave it in the Makefile) and the Git hash.

The git hash is very valuable since it can be used to verify that the program running on the robot is the code in your source folder.  You can cross-check like this:  in your code directory in a terminal type this:

    git log

You will see something like this:

```
commit 4fe44de756b66c709344878c0adac0b1cec89600
Author: Greg Herlein <gherlein@herlein.com>
Date:   Thu Nov 24 12:22:36 2016 -0800

    fixed git hash

```

You can compare the commit hash (4fe44de756b66c709344878c0adac0b1cec89600) to the hash in the info command.  If they are the same then you know what code is running.  If they are not then you either did not load that code into the robot or you forgot to do a git commit before compiling.  Either way you know you need to fix it.  You are no longer unsure what code is running on the robot.


##Usefull Additional Tools##

If you are connected to the robot shell you can get a lot of useful data on the robot by using the apollo command:

```
│ MTR EID  CMD ENCODER  RPM  AMPS  TEMP │  DIGITAL          │  ANALOG          │
│  1   0     0       0    0  0.00   0.0 │  1 Output       1 │  1         254   │
│  2      ----  ------  ---  ----  ---- │  2 Output       1 │  2         256   │
│  3      ----  ------  ---  ----  ---- │  3 Input        1 │  3         255   │
│  4      ----  ------  ---  ----  ---- │  4 Input        1 │  4         257   │
│  5      ----  ------  ---  ----  ---- │  5 Input        1 │  5         254   │
│  6      ----  ------  ---  ----  ---- │  6 Input        1 │  6         254   │
│  7      ----  ------  ---  ----  ---- │  7 Input        1 │  7         253   │
│  8      ----  ------  ---  ----  ---- │  8 Input        1 │  8         253   │
│  9      ----  ------  ---  ----  ---- │  9 Input        1 │                  │
│ 10   0     0       0    0  0.00   0.0 │ 10 Input        1 │                  │
│ C 1-5                      0.00   0.0 │ 11 Input        1 │                  │
│ C 6-10                     0.00   0.0 │ 12 Input        1 │                  │
├───────────────────────────────────────┴───────────────────┴──────────────────┤
│        U  D  L  R           H     V            U  D  L  R           H     V  │
│ BTN5   0  0        JS_1     0     0     BTN5   0  0        JS_1     0     0  │
│ BTN6   0  0        JS_2     0     0     BTN6   0  0        JS_2     0     0  │
│ BTN7   0  0  0  0           X     Y     BTN7   0  0  0  0           X     Y  │
│ BTN8   0  0  0  0  ACCL   -20    26     BTN8   0  0  0  0  ACCL     0     0  │
│                                                                              │
│                                                                              │
│ 00:24:27  Main 14.04V  Backup 0.24V                                          │
└──────────────────────────────────────────────────────────────────────────────┘
```

##Disconnecting From the Robot##

To disconnect from the robot shell you have to type ctrl-a (at the same time) and then

   :quit

This will disconnect from the robot.  We connect to the robot using a standard tool called 'screen' that is highly useful.  You can read all about how to use it by:

     man screen


##Flashing new Code onto the Robot##

Before this tooling will work to install compiled code onto the robot
you need to compile and install the flash utility.  From this
directory in the terminal:

	  cd src/stm32flashCortex
	  make
	  sudo make install
	  (enter your password for your computer when prompted)

This will compile and install a utility that can install code onto the
VEX.  This utility is called from the Makefile and no particular
action is needed from you other than installing it.  If you are using
a cloud server to compile vexilla programs you don't need to install
this.

##Credits##

Vexilla would not be possible without the incredible efforts of James
Pearman who wrote convex.  Vexilla is based on a snapshot of his work.

	https://github.com/jpearman/convex
	  

##Cloud Vexilla##

If you don't have access to a computer that can run the vexilla tools
but you want to at least compile programs then you can use a cloud
server we have prepared (vexilla.herlein.com).  Please ask Coach
Herlein for an account on that server.  All you have to do is ssh to
that server and follow the instructions above and you will have a
working coding environment of your own.

However, you won't be able to install that code onto a robot unless
you have help.  You will need someone who does have a working vexilla
on their computer.

On the cloud server, compile your VEX code just like you normally
would.  This will make a <project>.hex file in the bin directory of
your source directory. Then type this:

     make serve

A simple HTTP server will start.  From the computer attached to the
VEX robot, in the example-vexilla folder type this:

    make clean
    make fetch

This will connect to the cloud server and download the VEX code to the
bin directory.  On the cloud server, type ctrl-c to halt the file
server.  Then, on the computer attached to the robot, type:

    make install

(just like normal).  This will install the program you just downloaded
onto the robot.






     

