# biqub1-klipper-mainsail-setup-guide
A guide to configuring klipper and mainsail for your Biqu B1 3D printer

# Pre-requisites
1) A raspberry pi of some version.  I have successfully used a pi2b 1GB and a pi4b 8GB
2) 2x micro SD cards are ideal; One for the pi and one for flashing firmware which must be less than 16GB iirc, though 32GB may be possible.  A pi2b only supports up to 64GB, iirc a pi4b can go up to and above 1TB (I have an overkill 500GB one in mine).
4) Either a slot in your PC to allow you to transfer files to your SD card or an adapter for the SD card to use via USB.
5) A USB cable suitable for your pi for power.
6) A USB2 to USB-B cable for the Biqu B1 printer to feed it gcode data live when you're setup.

# Notes
If you're familiar with settings for Raspberry pi imager then make your own decisions on exact settings; this is just a useful starter guide.

# PI setup steps
1) Plug your large pi SD card into your PC/laptop.
2) Download the Mainsail zip file you will need from here (latest release): https://github.com/mainsail-crew/MainsailOS/releases
3) Install Raspberry pi imager (this is a macos tool but I'm sure it's available on windows too)
4) Run it and select Choose OS, choose custom and the mainsail OS zip file.
5) Select Choose Storage and select your SD card.
6) Click on the settings cog and specify all your settings e.g. as follows:
6a) Set hostname to be the name you want to advertise as your pi name to login to over ssh etc..
6b) Enable SSH
6c) Select Use Password Authentication
7) Set username and password: DO NOT FORGET this information.  You will need it to login to your pi over SSH and your password to perform superuser operations via sudo on your pi in the linux based raspbian OS.
8) Configure WiFi.  Set your SSID (this is your router id as advertised when you refresh your wifi on e.g. a mobile phone or a PC/mac) and your router password.
9) Set your Wifi country.
10) Tick locale settings and set for your location in the world; this configures language and timezone defaults for your pi.
11) Set keyboard layout type if you are plugging in a keyboard to your pi.
12) I recommend leaving persistent settings on for all items so enable the following:
12a) Play sound when finished.
12b) Eject media when finished.
12c) Enable telemetry.

# Creating the klipper firmware binary for your Biqu B1
You will need to flash the firmware with klipper firmware on your Biqu B1.  You cannot do this over USB.
1) Boot your pi.
2) When it's ready, usually about 3-5 mins time, maybe sooner, you will be able to ssh in.
3) To ssh in run the following command: ssh@<insert hostname here without corner brackets> or ssh@<insert IP address without corner brackets>
  If for some reason you need to use the IP address instead of the hostname, you can determine this either by logging into your router or by downloading an app called 'Fing' - within this app you can click devices and refresh from your PC/laptop/mac and see all devices on your router's network (assuming your pi and PC/laptop/mac are on that network).  When you see your pi's hostname, click on it and then you will see your IP address; this is necessary if you are using an RJ45 cable for networking and maybe aren't using wifi or you've not setup wifi properly.
  You'll be asked to enter your password and may be asked whether you are happy to accept the unrecognised device from your network when you first login; this is fine, just say yes.
4) Once on the pi, you'll be located in the home directory (~).  You can always return here by typing: cd ~
  To move back a directory type: cd ..
  To move into a directory type: cd klipper (if klipper is the name of the directory you want to enter)
  Firstly, type: cd klipper
5) Enter the command: make menuconfig
  You are now in a command line wizard that will setup the make files for a build of the firmware.
  Select target board uses smoothieware bootloader (NEW)
  Select microcontroller architecture and then choose LPC176x (Smoothieboard)
  Ensure the processor model is 100MHz (there is a turbo board but if you have the Biqu B1 default purchased you are unlikely to have that; adjust if necessary)
  Set communication interface to USB but frankly that is not really required as we won't be using it.
  Save and exit
6) Enter the command: make
  Now wait while it performs the build; you will probably see stuff scrolling past in the command prompt and that just indicates progress.  If it pauses, just be patient, you pi may be struggling for a short while, especially if it's an earlier model.
7) Once the make is done, you should have an 'out' directory in the klipper directory.
8) Copy the output firmware file (I think it's called klipper.bin) to the ~ directory as follows:
  Enter the command: cp ~/klipper/out/klipper.bin ~/klipper.bin (I think I have the path right but please check this)
9) Enter the command: exit
  This will leave the ssh session on your pi.
10) Ensure you have scp (secure copy) installed on your machine.  For a mac, you _may_ need to install brew (the missing package manager for macos) and then do brew install scp (I can't remember), for windows, you can probably install WinSCP.
  Now either use a fancy flashy WinSCP UI on Windows, or on a linux or macos box, type the command: scp pi@<insert IP address here for pi>:klipper.bin klipper.bin
  This will copy the klipper.bin file to your machine if you are using the command line approach.

# Prepping the firmware binary for flashing your Biqu B1
1) Plug in the small SD card with any necessary adapter to your PC/laptop/mac.
2) Format your small SD card if you haven't done so already.
3) Copy the file klipper.bin to the SD card.
4) Rename the file klipper.bin to firmware.bin
5) Eject the SD card and take it out.
  
# Flashing the firmware on your Biqu B1
1) Turn off your Biqu B1 printer.
2) There are 2 slots for SD cards on the right hand side of the Biqu B1.  Do NOT plug the SD card into the slot by the touch screen.  Incidentally your touch screen will be obsolete by the end of this process; at least until someone writes some software to support it with klipper but you won't need it now anyhow so don't worry.
Plug the SD card into the slot in the middle of the right side of the Biqu B1 where it says TF card.
3) Turn your printer on.  Wait about 10 minutes while it flashes.  FYI there is NO indication that it is complete but I find that 10 minutes is sufficient in my experience; it may be done sooner but just to be safe, allow 10 minutes.
4) Turn off your printer.
5) Remove the SD firmware SD card.
6) Turn the printer on and wait about 10 minutes.

# Final steps
1) Either unplug and replug in your pi (assuming you don't have a handy USB switch), or ssh in and type reboot (it will log you out automatically)
2) Wait for the pi to reboot.
3) scp the files in klipper_config from the git clone to your pi and copy them into the klipper_config directory, replacing what's there on the pi.  These are files I use; you can adjust them later as you feel comfortable.
4) In your browser you should now be able to go to the IP address of your pi and see MainSail.  You may need to do a restart of mainsail and/or do a firmware restart as needed.  If you are using wifi then you can use mainsail.local (I think; I'm not certain as I use a cable and an IP address; I'll leave that up to you).

# Exquisite final touches...
  1. gcode start and end setups for klipper on the Biqu B1
Go into cura or your favourite slicer and copy and paste the start and end gcode text from the relevant files in the gcode directory in this repository into the
gcode start and end sections of your slicer.  e.g. in cura, go to Ultimaker Cura | Preferences | Printers | Machine Settings, then paste in each lump of text as is.
  
  2. To setup a webcam, follow the instructions in webcam-setup-guide.txt
  
  3. For timelapsed videos, you can go here and follow the instructions: https://github.com/mainsail-crew/moonraker-timelapse
  
  4. Make sure you copy and paste or scp in the timelapse.cfg file from that repo into the klipper_config directory.
  
  5. Make sure you configure MainSail with your required settings in the GUI to use the timelapsed video capability.

  
