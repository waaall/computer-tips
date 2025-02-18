- [Transcribing MP3s with whisper-cpp on macOS](https://til.simonwillison.net/macos/whisper-cpp)
- [huggingface-whisper-large-v3-turbo-zh](https://huggingface.co/BELLE-2/Belle-whisper-large-v3-turbo-zh)
- [whisper.cpp-model](https://huggingface.co/ggerganov/whisper.cpp/tree/main)
- [OpenAI Whisper 新一代语音技术(更新至v3-turbo)](https://zhuanlan.zhihu.com/p/662906303)
## whisper
whisper有三个常见的开源项目：
1. OpenAI的whisper-python 库，是最原始也是模型的来源，开发需要最新的model可以用这个。
2. Whisper.cpp是把上述用c++重写的，并加入了mac的coreml支持，所以Mac平台更倾向。
3. faster-whisper，用ctranslate2写的，旨在优化运行速度，在windows系统优先用这个。

```bash
# 确保已安装ffmpeg和whisper-cpp
brew install ffmpeg
brew install whisper-cpp
```

### 创建sh脚本
在视频所在目录创建脚本 `gen_subtitle.sh`

```bash
# 启用Metal加速（M1/M2/M3芯片）
export WHISPER_METAL=1

# 输入视频文件（支持拖放文件到终端）
VIDEO_FILE="$1"
BASENAME=$(basename "$VIDEO_FILE" .${VIDEO_FILE##*.})
AUDIO_FILE="/tmp/${BASENAME}_audio.wav"
MODEL_PATH="/Users/zx_ll/develop/whisper_models/ggml-large-v3-turbo-q5_0.bin"

# 提取音频（16kHz单声道）
ffmpeg -i "$VIDEO_FILE" \
    -ar 16000 -ac 1 -acodec pcm_s16le \
    -hide_banner -loglevel error \
    "$AUDIO_FILE"

# 生成双语SRT字幕
whisper-ctl \
    --model "$MODEL_PATH" \
    --file "$AUDIO_FILE" \
    --output-format srt \
    --output "$BASENAME" \
    --language auto \
    --threads 8

# 清理临时音频文件
rm "$AUDIO_FILE"

echo "字幕生成完成：${BASENAME}.srt"
```
## whisper+deepseek本地字幕生成
- [Whisper+DeepSeek自动生成高精度字幕](https://www.youtube.com/watch?v=dkggWQOGnbs)

