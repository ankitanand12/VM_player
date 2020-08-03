import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

onlinevideos() {
  return SamplePlayer(); // TODO Online video code return
}

class SamplePlayer extends StatefulWidget {
  SamplePlayer({Key key}) : super(key: key);

  @override
  _SamplePlayerState createState() => _SamplePlayerState();
}

class _SamplePlayerState extends State<SamplePlayer> {
  FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      autoPlay: false,
      videoPlayerController: VideoPlayerController.network(
        "https://github.com/iamurankit/videos/raw/master/IIEC.mp4",
      ),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlickVideoPlayer(flickManager: flickManager),
    );
  }
}

var onlinesongs = Playlist(
  audios: [
    Audio.network(
      'https://github.com/iamurankit/audio/raw/master/Apple%20iPhone%20X%20original%20Ringtone%20(with%20free%20download%20link!!!).mp3',
      metas: Metas(
        title: 'Apple iPhone Ringtone',
      ),
    ),
    Audio.network(
      'https://github.com/iamurankit/audio/raw/master/the%20apple%20ringtone.mp3',
      metas: Metas(
        title: 'Apple iPhone Ringtone',
      ),
    ),
    Audio.network(
      'https://github.com/iamurankit/audio/raw/master/DIVINE%20-%20Gandhi%20Money%20Official%20Music%20Video%20(Prod.%20by%20Phenom).mp3',
      metas: Metas(
        title: 'Gandhi Money',
        artist: 'Divine',
      ),
    ),
    Audio.network(
      'https://github.com/iamurankit/audio/raw/master/Lauv%20-%20I%20Like%20Me%20Better%20%5BOfficial%20Audio%5D.mp3',
      metas: Metas(
        title: 'I Like Me Beter',
        artist: 'Lauv',
      ),
    ),
  ],
);

online() {
  // TODO Online Audio Code
  var audio = AssetsAudioPlayer();
  return Container(
    child: Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 550,
          decoration: BoxDecoration(
            border: Border.all(
              width: 3,
              color: Colors.black,
            ),
          ),
          child: onlinevideos(),
        ),
        Container(
          margin: EdgeInsets.only(top: 550),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            image: DecorationImage(
              image: AssetImage('image/music.jpg'),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'AUDIO SONGS',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  height: -1,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dashed,
                  backgroundColor: Colors.lime,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    iconSize: 50,
                    icon: Icon(
                      Icons.play_arrow,
                      size: 60,
                    ),
                    onPressed: () async {
                      try {
                        await audio.open(onlinesongs,
                            showNotification: true,
                            loopMode: LoopMode.playlist);
                        // audio.previous();
                      } catch (t) {
                        // mp3 unreachable
                      }
                    },
                  ),
                  IconButton(
                    iconSize: 50,
                    icon: Icon(
                      Icons.pause_circle_filled,
                      size: 60,
                    ),
                    onPressed: () {
                      audio.playOrPause();
                    },
                  ),
                  IconButton(
                    iconSize: 50,
                    icon: Icon(
                      Icons.skip_next,
                      size: 60,
                    ),
                    onPressed: () {
                      audio.next();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
