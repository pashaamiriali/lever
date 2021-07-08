import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  XFile _image;
  List<XFile> _images = [];

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
    var multipleImagesFAB = FloatingActionButton(
      onPressed: () async {
        try {
          await _initializeControllerFuture;
          final image = await _controller.takePicture();
          setState(() {
            _images.add(image);
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

    var displayImages = DisplayImagesScreen(
      callBackFunction: widget.visitPictureTakenCallback,
      imagePaths: _images.map((e) => e.path).toList(),
    );

    var takeHivePictureScaffold = widget.captureMode == CaptureMode.forHive
        ? Scaffold(
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
          )
        : null;
    var takeVisitPictureScaffold = widget.captureMode == CaptureMode.forVisit
        ? Scaffold(
            backgroundColor: Colors.black54,
            body: Stack(
              children: [
                FutureBuilder(
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
                Align(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 70,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom:80.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: multipleImagesFAB),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: FloatingActionButton(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              child: Stack(
                                children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.check,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      )),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(23),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      child: Center(
                                          child: Text(_images.length.toString())),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                setState(() {
                                  _displayImage = true;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          )
        : null;
    if (_displayImage) if (widget.captureMode == CaptureMode.forHive)
      return displaySingleImage;
    if (_displayImage) if (widget.captureMode == CaptureMode.forVisit)
      return displayImages;
    if (widget.captureMode == CaptureMode.forVisit)
      return takeVisitPictureScaffold;
    return takeHivePictureScaffold;
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
                        (await getApplicationSupportDirectory()).path;
                    var imageFile = File(imagePath);
                    var fileName = imageFile.path.substring(
                        imageFile.path.indexOf('/CAP'),
                        imageFile.path.length - 1);
                    var newPath =
                        appDocumentsPath + '/' + PICTURES_PATH + fileName;
                    await Directory(appDocumentsPath + '/' + PICTURES_PATH)
                        .create();
                    print(imageFile);
                    var newImage = await imageFile.copy(newPath);
                    print(newImage.uri);
                    callBackFunction(newImage.path);
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

class DisplayImagesScreen extends StatefulWidget {
  final List<String> imagePaths;
  final Function callBackFunction;

  const DisplayImagesScreen({Key key, this.imagePaths, this.callBackFunction})
      : super(key: key);

  @override
  _DisplayImagesScreenState createState() => _DisplayImagesScreenState();
}

class _DisplayImagesScreenState extends State<DisplayImagesScreen> {
  String currentImagePath;

  @override
  void initState() {
    currentImagePath = widget.imagePaths[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.file(
                File(currentImagePath),
                fit: BoxFit.contain,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(width: double.infinity,height:80,padding: EdgeInsets.all(10),
                child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.imagePaths.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          currentImagePath = widget.imagePaths[index];
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(
                              File(widget.imagePaths[index]),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
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
                  File(currentImagePath).delete();
                  Navigator.of(context).pop();
                },
                color: Theme.of(context).colorScheme.surface,
                elevation: 10,
                shape: StadiumBorder(),
                child:
                    Row(children: [Icon(Icons.close), Text('لغو')]),
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
                        (await getApplicationSupportDirectory()).path;
                    List<String> copiedPaths = [];
                    for (String imagePath in widget.imagePaths) {
                      var imageFile = File(imagePath);
                      var fileName = imageFile.path.substring(
                          imageFile.path.indexOf('/CAP'),
                          imageFile.path.length - 1);
                      var newPath =
                          appDocumentsPath + '/' + PICTURES_PATH + fileName;
                      await Directory(appDocumentsPath + '/' + PICTURES_PATH)
                          .create();
                      var newImage = await imageFile.copy(newPath);
                      copiedPaths.add(newImage.path);
                    }
                    widget.callBackFunction(copiedPaths);

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
