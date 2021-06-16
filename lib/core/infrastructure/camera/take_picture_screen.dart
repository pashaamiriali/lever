import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../env.dart';

enum CaptureMode { forHive, forVisit }

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  final CaptureMode captureMode;
  final Function hivePictureTakenCallback;
  final Function visitPictureTakenCallback;
  const TakePictureScreen(
      {Key key,
      @required this.camera,
      this.captureMode = CaptureMode.forVisit,
      this.hivePictureTakenCallback,
      this.visitPictureTakenCallback})
      : super(key: key);

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future _initializeControllerFuture;
  bool _displayImage = false;
  var _image;
  @override
  void initState() {
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var singleImageFAB = FloatingActionButton(
      onPressed: () async {
        try {
          await _initializeControllerFuture;
          final image = await _controller.takePicture();
          setState(() {
            _image = image;
            _displayImage = true;
          });
        } catch (e) {
          print(e);
        }
      },
      child: Icon(Icons.camera),
    );
    var displaySingleImage = DisplaySingleImageScreen(
        imagePath: _image?.path,
        callBackFunction: widget.hivePictureTakenCallback);
    if (_displayImage) if (widget.captureMode == CaptureMode.forHive)
      return displaySingleImage;
    else
      return Container();
    else {
      return Scaffold(
        backgroundColor: Colors.black54,
        body: FutureBuilder(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return CameraPreview(_controller);
            else if (snapshot.hasError)
              return Center(child: Text(snapshot.error.toString()));
            else
              return Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: widget.captureMode == CaptureMode.forHive
                ? singleImageFAB
                : Container(),
          ),
        ),
      );
    }
  }
}

class DisplaySingleImageScreen extends StatelessWidget {
  final imagePath;
  final Function callBackFunction;
  const DisplaySingleImageScreen(
      {Key key, this.imagePath, this.callBackFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Image.file(
          File(imagePath),
          fit: BoxFit.contain,
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              margin: EdgeInsets.only(bottom: 30),
              child: MaterialButton(
                onPressed: () {
                  File(imagePath).delete();
                  Navigator.of(context).pop();
                },
                color: Theme.of(context).colorScheme.surface,
                elevation: 10,
                shape: StadiumBorder(),
                child:
                    Row(children: [Icon(Icons.cached_rounded), Text('دوباره')]),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 60,
              width: 60,
              margin: EdgeInsets.only(bottom: 30),
              child: MaterialButton(
                  onPressed: () async {
                    var appDocumentsPath =
                        (await getApplicationDocumentsDirectory()).path;
                    var imageFile = File(imagePath);
                    var newPath = join(appDocumentsPath, PICTURES_PATH);
                    imageFile.copy(newPath).then((value) {
                      print(value.path);
                      callBackFunction(value.path);
                    });
                    Navigator.of(context).pop();
                  },
                  color: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  elevation: 15,
                  shape: StadiumBorder(),
                  child: Icon(Icons.check)),
            ),
          ],
        ),
      ),
    );
  }
}
