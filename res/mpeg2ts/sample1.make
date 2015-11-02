cd res/mpeg2ts

mkdir sample1
mkdir sample1/m.stream
mkdir sample1/v.stream

cp player.html sample1/m.stream/index.html
cp player.html sample1/v.stream/index.html

ffmpeg -i sample1.mp4   -y -bsf:a aac_adtstoasc -vn -acodec copy sample1/a.m4a
ffmpeg -i sample1.mp4   -y -bsf:a aac_adtstoasc -an -vcodec copy sample1/v.mp4
ffmpeg -i sample1.mp4   -y -vcodec libx264 -acodec libfdk_aac -flags +loop-global_header -map 0 -bsf h264_mp4toannexb -f segment -segment_format mpegts -segment_time 5 -segment_list sample1/m.stream/playlist.m3u8 sample1/m.stream/m%03d.ts
ffmpeg -i sample1/v.mp4 -y -vcodec libx264 -an                -flags +loop-global_header -map 0 -bsf h264_mp4toannexb -f segment -segment_format mpegts -segment_time 5 -segment_list sample1/v.stream/playlist.m3u8 sample1/v.stream/v%03d.ts

