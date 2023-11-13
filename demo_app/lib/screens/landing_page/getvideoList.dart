import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoListScreen extends StatelessWidget {
  final List<String> videoPaths;

  VideoListScreen({required this.videoPaths});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video List')),
      body: ListView.builder(
        itemCount: videoPaths.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Video ${index + 1}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(videoPath: videoPaths[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;

  VideoPlayerScreen({required this.videoPath});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _videoPlayerFuture;
  late bool _isPlaying = false;
  late Duration _duration = Duration.zero;
  late Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(File(widget.videoPath));
    _videoPlayerFuture = _videoPlayerController.initialize();

    _videoPlayerController.addListener(() {
      if (!_videoPlayerController.value.isPlaying) {
        setState(() {
          _isPlaying = false;
        });
      }

      if (_videoPlayerController.value.position == _videoPlayerController.value.duration) {
        // Video has reached the end
        _videoPlayerController.seekTo(Duration(seconds: 0));
        setState(() {
          _isPlaying = false;
        });
      }

      setState(() {
        _position = _videoPlayerController.value.position;
        _duration = _videoPlayerController.value.duration;
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _playPause() {
    if (_isPlaying) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _rewind() {
    final Duration newPosition = _videoPlayerController.value.position - Duration(seconds: 5);
    _videoPlayerController.seekTo(newPosition);
  }

  void _forward() {
    final Duration newPosition = _videoPlayerController.value.position + Duration(seconds: 5);
    _videoPlayerController.seekTo(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Player')),
      body: FutureBuilder(
        future: _videoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _rewind,
                      icon: Icon(Icons.replay_5),
                    ),
                    IconButton(
                      onPressed: _playPause,
                      icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                    ),
                    IconButton(
                      onPressed: _forward,
                      icon: Icon(Icons.forward_5),
                    ),
                  ],
                ),
                Slider(
                  value: _position.inSeconds.toDouble(),
                  max: _duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _videoPlayerController.seekTo(Duration(seconds: value.toInt()));
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')}'),
                      Text('${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}'),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

