import 'dart:convert';

import 'package:chatapp/model/video_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

class CourseView extends StatefulWidget {
  final String title;

  const CourseView({super.key, required this.title});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  VideoModel videoModel = VideoModel();
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    videoModel.data == null ? getListOfVideos() : print("Data has");
  }

  void getListOfVideos() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
        Uri.parse('https://application.nahid24.com/api/show-video-course/7'));

    if (response.statusCode == 200) {
      var data = VideoModel.fromJson(jsonDecode(response.body));

      videoModel = data;
      youtubeInitilization();
    }
  }

  youtubeInitilization() {
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(videoModel.data!.video!.first.url!)!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
    setState(() {
      isLoading = false;
    });
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : YoutubePlayerBuilder(
            onExitFullScreen: () {
              // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
              SystemChrome.setPreferredOrientations(DeviceOrientation.values);
            },
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.black,
            ),
            builder: (context, player) => Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(child: player),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(3)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const Icon(
                                        Icons.arrow_back_ios_new_outlined,
                                        color: Colors.black)),
                              ),
                              Text(
                                videoModel.data!.instructorName.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                            itemCount: videoModel.data!.video!.length,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) {
                              var videos = videoModel.data!.video![index];
                              return InkWell(
                                onTap: () {
                                  String videoId;
                                  videoId = YoutubePlayer.convertUrlToId(
                                      videos.url!)!;
                                  print(videoId);
                                  _controller.load(videoId);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Center(
                                      child: Text(
                                        videos.title!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
