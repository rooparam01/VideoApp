import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../resources/components/round_button.dart';
import '../../utils/utils.dart';
import 'getvideoList.dart';

class CreateUserVideoScreen extends StatefulWidget {
  @override
  _CreateUserVideoScreenState createState() => _CreateUserVideoScreenState();
}

class _CreateUserVideoScreenState extends State<CreateUserVideoScreen> {
  late List<CameraDescription> cameras;
  CameraController? _cameraController;
  String _videoPath = '';
  late VideoPlayerController _videoPlayerController;
  late Future<void> _videoPlayerFuture;
  bool _isVideoPlaying = false;
  bool _isRecording = false;
  List<String> allVideoPaths = [];

  @override
  void initState() {
    super.initState();
    _initCameras().then((_) {
      _initCameraController();
    });
    _videoPlayerController = VideoPlayerController.asset('assets/video_placeholder.mp4');
    _videoPlayerFuture = _videoPlayerController.initialize();
    _loadVideoPathsFromPreferences().then((paths) {
      setState(() {
        allVideoPaths = paths;
      });
    });
  }
  Future<void> _saveVideoPathToPreferences(List<String> videoPaths) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('videoPaths', videoPaths);
  }

  // Load video paths from shared preferences
  Future<List<String>> _loadVideoPathsFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('videoPaths') ?? [];
  }

  Future<void> _initCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  }

  void _toggleVideoPlayback() {
    if (_isVideoPlaying) {
      _stopVideo();
    } else {
      _showVideoDialog();
    }
  }

  void _saveVideo(String filePath) async {

    allVideoPaths.add(filePath);

    await _saveVideoPathToPreferences(allVideoPaths);
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String videoDirPath = '${appDir.path}/videos';

    // Create the videos directory if it doesn't exist
    await Directory(videoDirPath).create(recursive: true);

    // Generate a unique filename for the video
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String videoFileName = 'video_$timestamp.mp4';

    // Copy the recorded video to the videos directory
    final File newVideoFile = await File(filePath).copy('$videoDirPath/$videoFileName');

    // Update the _videoPath variable to the new video file path
    setState(() {
      _videoPath = newVideoFile.path;
    });
  }

  void _showVideoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              content: Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_videoPlayerController.value.isPlaying) {
                          _videoPlayerController.pause();
                        } else {
                          _videoPlayerController.play();
                        }
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      tooltip: "Play and Pause",
                      onPressed: () {
                        setState(() {
                          if (_videoPlayerController.value.isPlaying) {
                            _videoPlayerController.pause();
                          } else {
                            _videoPlayerController.play();
                          }
                        });
                      },
                      icon: Icon(
                        _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 60,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    _stopVideo();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _initCameraController() async {
    _cameraController = CameraController(
      cameras[0],
      ResolutionPreset.medium,
    );
    await _cameraController!.initialize();
    setState(() {});
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      _stopRecording();
    } else {
      _startRecording();
    }
  }

  Future<void> _startRecording() async {
    if (_cameraController!.value.isInitialized) {
      if (!_cameraController!.value.isRecordingVideo) {
        try {
          await _cameraController!.startVideoRecording();
          setState(() {
            _isRecording = true;
          });
        } catch (e) {
          print(e);
        }
      }
    } else {
      print("Camera is not initialized");
    }
  }

  Future<void> _stopRecording() async {
    if (_cameraController!.value.isRecordingVideo) {
      try {
        final XFile videoFile = await _cameraController!.stopVideoRecording();
        setState(() {
          _videoPath = videoFile.path;
          _videoPlayerController = VideoPlayerController.file(File(_videoPath));
          _videoPlayerFuture = _videoPlayerController.initialize();
          _isRecording = false;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  void _playRecordedVideo() {
    setState(() {
      _isVideoPlaying = true;
      _videoPlayerController.play();
    });
  }

  void _stopVideo() {
    setState(() {
      _isVideoPlaying = false;
      _videoPlayerController.pause();
    });
  }

  Future<void> _uploadVideoFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      File file = File(result.files.single.path!);

      if (_isRecording) {
        await _stopRecording();
      }

      setState(() {
        _videoPath = file.path;
        _videoPlayerController = VideoPlayerController.file(file);
        _videoPlayerFuture = _videoPlayerController.initialize();
      });
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Record and Play Video')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 1,
              child: _cameraController!.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _cameraController!.value.aspectRatio,
                child: CameraPreview(_cameraController!),
              )
                  : Container(),
            ),
            SizedBox(height: 16),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        tooltip: "Record and Stop Record",
                        onPressed: _toggleRecording,
                        icon: Icon(
                          _isRecording ? Icons.stop : Icons.fiber_manual_record,
                          color: _isRecording ? Colors.red : null,
                        ),
                      ),
                      SizedBox(width: 16),
                      IconButton(
                        onPressed: _toggleVideoPlayback,
                        icon: Icon(
                          _isVideoPlaying ? Icons.pause : Icons.play_arrow,
                        ),
                      ),
                      SizedBox(width: 16),
                      IconButton(
                        tooltip: "Select Video from local Storage",
                        onPressed: _uploadVideoFile,
                        icon: Icon(Icons.file_upload),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  if (_isVideoPlaying)
                    AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController),
                    ),
                  RoundButton(
                    title: "Submit Video",
                    onPress: () async {
                      _saveVideo(_videoPath);
                      Utils.flushBarSuccessMessage("Video uploaded to local storage successfully", context);
                    },
                  ),
                  RoundButton(
                    title: "Videos",
                    onPress: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoListScreen(videoPaths: allVideoPaths),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _isVideoPlaying
          ? FloatingActionButton(
        onPressed: _stopVideo,
        child: Icon(Icons.close),
      )
          : null,
    );
  }
}
