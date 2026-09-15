import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player = AudioPlayer();
  Duration _currentPosition = Duration.zero;
  double _currentSpeed = 1.0; // Joriy tezlikni saqlab turish uchun o'zgaruvchi

  AudioPlayerHandler() {
    // Pozitsiya o'zgarganda yangilab boramiz
    _player.onPositionChanged.listen((position) {
      _currentPosition = position;
      playbackState.add(playbackState.value.copyWith(updatePosition: position));
    });

    _player.onPlayerStateChanged.listen((state) {
      playbackState.add(_transformEvent(state));
    });

    _player.onDurationChanged.listen((duration) {
      if (mediaItem.value != null) {
        mediaItem.add(mediaItem.value!.copyWith(duration: duration));
      }
    });

    _player.onPlayerComplete.listen((event) {
      // Audio to'liq tugaganda holatni yangilaymiz
      _currentPosition = Duration.zero;
      playbackState.add(
        playbackState.value.copyWith(
          playing: false,
          processingState: AudioProcessingState.completed,
          updatePosition: Duration.zero,
        ),
      );
    });
  }

  Future<void> playFile(
    String filePath,
    String title,
    String artist,
    String album,
  ) async {
    final mediaItemInstance = MediaItem(
      id: filePath,
      album: album,
      title: title,
      artist: artist,
    );

    mediaItem.add(mediaItemInstance);
    _currentPosition = Duration.zero;
    await _player.setSource(DeviceFileSource(filePath));
    
    // Yangi fayl ochilganda oldingi tanlangan tezlikni saqlab qolish
    await _player.setPlaybackRate(_currentSpeed);
    await play();
  }

  @override
  Future<void> play() async {
    if (playbackState.value.processingState == AudioProcessingState.completed) {
      _currentPosition = Duration.zero;
      if (mediaItem.value != null) {
        await _player.play(DeviceFileSource(mediaItem.value!.id));
        await _player.setPlaybackRate(_currentSpeed); // Tezlikni saqlash
      }
    } else {
      await _player.resume();
    }

    playbackState.add(
      playbackState.value.copyWith(
        playing: true,
        processingState: AudioProcessingState.ready,
      ),
    );
  }

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) async {
    _currentPosition = position;
    await _player.seek(position);
    playbackState.add(playbackState.value.copyWith(updatePosition: position));
  }

  @override
  Future<void> stop() async {
    _currentPosition = Duration.zero;
    await _player.stop();
    await super.stop();
  }

  // --- AUDIO TEZLIGINI O'ZGARTIRISH METODI ---
  @override
  Future<void> setSpeed(double speed) async {
    _currentSpeed = speed;
    await _player.setPlaybackRate(speed); // audioplayers dagi metod
    
    // Holatni yangilab, UI ga xabar beramiz
    playbackState.add(
      playbackState.value.copyWith(
        speed: speed,
      ),
    );
  }

  PlaybackState _transformEvent(PlayerState state) {
    return PlaybackState(
      controls: [
        MediaControl.rewind,
        if (state == PlayerState.playing)
          MediaControl.pause
        else
          MediaControl.play,
        MediaControl.stop,
        MediaControl.fastForward,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
        MediaAction.setSpeed, // Tizimga tezlikni o'zgartirish mumkinligini bildiramiz
      },
      androidCompactActionIndices: const [1, 2, 3],
      processingState:
          {
            PlayerState.stopped: AudioProcessingState.idle,
            PlayerState.completed: AudioProcessingState.completed,
            PlayerState.playing: AudioProcessingState.ready,
            PlayerState.paused: AudioProcessingState.ready,
          }[state] ??
          AudioProcessingState.idle,
      playing: state == PlayerState.playing,
      updatePosition: _currentPosition,
      bufferedPosition: Duration.zero,
      speed: _currentSpeed, // Joriy tezlikni uzatamiz
    );
  }
}