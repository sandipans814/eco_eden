import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
//import 'package:gallery_saver/gallery_saver.dart';
//import 'package:image_picker/image_picker.dart';
List<CameraDescription> cameras;

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool isCameraReady = false;
//  bool showCapturedPhoto = false;
//  var ImagePath;

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(firstCamera,ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final deviceRatio = size.width / size.height;

//    if (!_controller.value.isInitialized) {
//      return Container();
//    }
//    return AspectRatio(
//        aspectRatio:
//        _controller.value.aspectRatio,
//        child: CameraPreview(_controller));
//  }
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Transform.scale(
                scale: _controller.value.aspectRatio / deviceRatio,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: CameraPreview(_controller), //cameraPreview
                  ),
                ));
          } else {
            return Center(
                child: CircularProgressIndicator()); // Otherwise, display a loading indicator.
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async{
          try{
            await _initializeControllerFuture;
            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now().millisecondsSinceEpoch}.jpg',
            );
            print(path);
            //final path = "This PC\Galaxy A50s\Phone\DCIM\Camera\pic.jpg";
            await _controller.takePicture(path);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}
/*void _takePhoto() async {
  ImagePicker.pickImage(source: ImageSource.camera)
      .then((File recordedImage) {
    if (recordedImage != null && recordedImage.path != null) {
      setState(() {
        firstButtonText = 'saving in progress...';
      });
      GallerySaver.saveImage(recordedImage.path).then((String path) {
        setState(() {
          firstButtonText = 'image saved!';
        });
      });
    }
  });
}*/
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}