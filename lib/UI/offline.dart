import 'package:VSplayer/UI/online.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

offlinevideos() {
  return SamplePlayer();
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
      videoPlayerController: VideoPlayerController.asset(
        "video/vimalDaga.mp4",
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

myApp() {
  var assetsAudioPlayer = AssetsAudioPlayer();

  network() {
    return online();
  }

  var offlinesongs = Playlist(
    audios: [
      Audio(
        'assets/audios/Bacardi_Sessions.mp3',
        metas: Metas(
          title: 'Barcardi Sessions',
          artist: 'Ritviz',
        ),
      ),
      Audio(
        'assets/audios/YALGAAR.mp3',
        metas: Metas(
          title: 'Yalgaar',
          artist: 'Carry Minati',
        ),
      ),
    ],
  );

  offline() {
    //TODO Whole Offline Function
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 490,
          decoration: BoxDecoration(
            border: Border.all(
              width: 3,
              color: Colors.black,
            ),
          ),
          child: offlinevideos(), //TODO offlineVideo Function
        ),
        Container(
          margin: EdgeInsets.only(top: 490),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'AUDIO',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  height: -1,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dashed,
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
                        await assetsAudioPlayer.open(offlinesongs,
                            showNotification: true,
                            loopMode: LoopMode.playlist);
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
                      assetsAudioPlayer.playOrPause();
                    },
                  ),
                  IconButton(
                    iconSize: 50,
                    icon: Icon(
                      Icons.skip_next,
                      size: 60,
                    ),
                    onPressed: () {
                      assetsAudioPlayer.next();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
      // ),
    );
  }

  var mydesign = Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.pink[500],
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.notifications_active),
          onPressed: () => print(''),
        ),
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () => print(''),
        ),
      ],
      leading: IconButton(
        icon: Icon(Icons.camera_alt),
        onPressed: () => print(''),
      ),
      elevation: 15,
      title: Text(
        'VM Player',
      ),
      bottom: TabBar(
        indicatorWeight: 1,
        indicatorColor: Colors.pink,
        tabs: [
          Tab(text: 'OFFLINE'),
          Tab(text: 'ONLINE'),
        ],
      ),
    ),
    body: TabBarView(
      children: [
        offline(),
        network(),
      ],
    ),
  );

  return MaterialApp(
    home: DefaultTabController(
      length: 2,
      child: mydesign,
    ),
    debugShowCheckedModeBanner: false,
  );
}
