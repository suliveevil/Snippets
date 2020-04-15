# ffmpeg


## 视频转码

```shell
- Remux MKV video to MP4 without re-encoding audio or video streams:
ffmpeg -i input_video.mkv -codec copy output_video.mp4
```