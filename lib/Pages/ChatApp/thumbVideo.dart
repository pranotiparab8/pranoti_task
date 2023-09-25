import 'package:flick_video_player_custom/flick_video_player_custom.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyApp45 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player Example',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoPage(
                  videoUrl:
                      '/data/user/0/com.example.pranoti_task/cache/5d297fbb-08ac-40ac-83a8-94064ca26848/sample-mp4-file-small.mp4',
                ),
              ),
            );
          },
          child: Text('Open Video Page'),
        ),
      ),
    );
  }
}

class VideoPage extends StatefulWidget {
  final String videoUrl;

  VideoPage({required this.videoUrl});

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Page'),
      ),
      body: Container(
        child: FlickVideoPlayer(
          flickManager: FlickManager(
            videoPlayerController:
                VideoPlayerController.network(widget.videoUrl),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
