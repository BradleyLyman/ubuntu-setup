# Screen Setup

Lookup Device Drivers

    > sudo ubuntu-drivers devices

Install the found driver

    > sudo apt-get install nvidia-driver-390

Configure screen layout and scale

    > xrandr \
        --output DP-4 --auto \
        --output DP-0 --auto --scale 0.5x0.5 --left-of DP-4 \
        --output DP-2 --auto --left-of DP-0

Save and auto-load screen layout and scale

    > nvidia-settings -q CurrentMetaMode

         Attribute 'CurrentMetaMode' (ubuntu-desktop:0.0): id=50, switchable=no, source=nv-control :: DPY-6: nvidia-auto-select @3840x2160 +5760+0 {ViewPortIn=3840x2160, ViewPortOut=3840x2160+0+0}, DPY-4: nvidia-auto-select @1920x1080 +0+0 {ViewPortIn=1920x1080, ViewPortOut=1920x1080+0+0}, DPY-2: nvidia-auto-select @1920x1080 +1920+0 {Transform=(0.500000,0.000000,0.000000,0.000000,0.500000,0.000000,0.000000,0.000000,1.000000), ViewPortIn=1920x1080, ViewPortOut=3840x2160+0+0, ResamplingMethod=Bilinear}

The settings can be reloaded (in xinitrc, for example) like so:

    > nvidia-settings --assign "CurrentMetaMode=$ThatOutputString"

Check the Arch Linux wiki for more config details

