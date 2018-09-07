# twitch it
function twitch {
    if [ ! -f ${HOME}/.twitch_key ]; then
        echo ".twitch_key not found!"
        return
    fi

    INRES="1366x768" # input resolution
    OUTRES="1366x768"
    OFFSET="0,0"
    FPS="24" # target FPS
    MAXRATE="1000k"
    BUFSIZE="1000k"
    AUDIOBITRATE="60k"
    QUAL="veryfast" # one of the many FFMPEG preset
    STREAM_KEY=$(cat ~/.twitch_key)
    URL="rtmp://live.twitch.tv/app/$STREAM_KEY"

    avconv -v verbose -f x11grab -show_region 1 -s "$INRES" -r "$FPS" -i :0.0+$OFFSET \
    -f alsa -ac 2 -b:a "$AUDIOBITRATE" -i pulse -c:v libx264 -crf 30 -preset "$QUAL" \
    -s "$OUTRES" -vol 11200 -c:a libmp3lame -ar 44100 -pix_fmt yuv420p -maxrate "$MAXRATE" -bufsize "$BUFSIZE" \
    -f flv "$URL"
}
