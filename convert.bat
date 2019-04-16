ffmpeg -y -r 30 -probesize 100M -hwaccel cuvid   ^
    -f image2pipe -vcodec ppm -i gource.ppm    ^
    -vcodec libx265 -preset slow -b:v 6M -maxrate:v 10M -pix_fmt yuv420p10le -rc vbr_hq -threads 0 gource.x265.mp4

REM -c:v hevc_nvenc REM My drivers are not new enough

pause