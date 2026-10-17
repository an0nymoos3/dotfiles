#/bin/sh

# Unload any previous instance of v4l2loopback
sudo modprobe -r v4l2loopback

# Load v4l2 module
sudo modprobe -v v4l2loopback video_nr=9,10 exclusive_caps=1 card_label="OBS Stream","Virtual Webcam"

# Start the video with hidden window
scrcpy --video-source=camera --no-window --no-audio --camera-id=0 --camera-ar="16:9" --camera-fps=60 --crop=3840:2160:0:0 --video-bit-rate=16M --angle=180 --disable-screensaver --v4l2-sink=/dev/video10