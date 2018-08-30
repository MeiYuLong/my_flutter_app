import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:video_player/video_player.dart';

class ImagePick extends StatefulWidget {
  @override
  _ImagePickState createState() => new _ImagePickState();
}

class _ImagePickState extends State <ImagePick>{
  File _image;
  Future <File> _imageFile;
  bool isVideo = false;
  VideoPlayerController _controller;
  VoidCallback listener;

  void _onImageButtonPressed(ImageSource source) {
    setState(() {
          if (_controller != null) {
            _controller.setVolume(0.0);
            _controller.removeListener(listener);
          } 
          
          if (isVideo) {
            ImagePicker.pickVideo(source: source).then((File file) {
              if (file != null && mounted) {
                setState(() {
                          _controller = VideoPlayerController.file(file)
                          ..addListener(listener)
                          ..setVolume(1.0)
                          ..initialize()
                          ..play();
                          });
              }
            });
          }else {
                // ImagePicker.pickImage(source: source).then((File file) {
                //   setState(() {
                //         _image = file;
                //     });
                // });
                _imageFile = ImagePicker.pickImage(source: source);
            
          }
        });
  }

@override
void deactivate(){
  if (_controller != null) {
    _controller.setVolume(0.0);
    _controller.removeListener(listener);
  }
  super.deactivate();
}

@override
void dispose(){
  if (_controller != null) {
    _controller.dispose();
  }
  super.dispose();
}

@override
void initState() {
  super.initState();
  listener = (){
     setState(() {});
  };
}
//视频预览
Widget _preViewVideo(VideoPlayerController controller) {
  if (controller == null) {
    return const Text(
      '您还没有选中视频',
      textAlign: TextAlign.center,
    );
  } else if (controller.value.initialized) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatioVideo(controller),
    );
  } else {
    return const Text(
      '加载视屏出错',
      textAlign: TextAlign.center,
    );
  }
}
//图片预览
  Widget _previewImage(){
    return FutureBuilder<File>(
      future: _imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
          return Image.file(snapshot.data);
        } else if (snapshot.error != null) {
          return const Text(
            '选择图片出错',
            textAlign: TextAlign.center,
          );
        } else {
             return const Text(
            '您还没有选择图片',
            textAlign: TextAlign.center,
          );
        }
      },
      );
  }

  // Future getImage() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //         _image = image;
  //       });
  // }
  @override
  Widget build(BuildContext context){
   return new Scaffold(
     appBar: new AppBar(
       title: new Text('图片选择'),
     ),
     body: new Center(
    //    child: _image == null
    //         ? new Text('没有选择图片')
    //         : new Image.file(_image),
      child: isVideo ? _preViewVideo(_controller) : _previewImage(),
     ),
      floatingActionButton:   Column(
        mainAxisAlignment: MainAxisAlignment.end,//主轴对其
        children: <Widget>[
          FloatingActionButton(
            onPressed: (){
              isVideo = false;
              _onImageButtonPressed(ImageSource.gallery);
            },
            heroTag: 'image0',
            tooltip: 'Pick Image from gallery',
            child: const Icon(Icons.photo_library),
          ),
          Padding(
              padding:  const EdgeInsets.only(top : 16.0),
              child: FloatingActionButton(
                onPressed: (){
                   isVideo = false;
                   _onImageButtonPressed(ImageSource.camera);
                },
                heroTag: 'image1',
                tooltip: 'Take a photo',
                child: const Icon(Icons.camera_alt),
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: (){
                isVideo = true;
                _onImageButtonPressed(ImageSource.gallery);
              },
              heroTag: 'video0',
              tooltip: 'Pick Video from gallery',
              child: const Icon(Icons.video_library),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: (){
                isVideo = true;
                _onImageButtonPressed(ImageSource.camera);
              },
              heroTag: 'video1',
              tooltip: 'Take a Video',
              child: const Icon(Icons.videocam),
            ),
          ),
        ],
      ),
   );
  }
}



class AspectRatioVideo extends StatefulWidget {
  final VideoPlayerController controller;

  AspectRatioVideo(this.controller);

  @override
  AspectRatioVideoState createState() => new AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo>{
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  VoidCallback listener;

  @override
  void initState(){
    super.initState();
    listener = (){
      if (!mounted) {
        return;
      }//设置监听初始化
      if (initialized != controller.value.initialized) {
        initialized = controller.value.initialized;
        setState(() {});
      }
    };
    controller.addListener(listener);
  }

  @override
  Widget build(BuildContext context){
  if (initialized) {
    final Size size = controller.value.size;
    return new Center(
         child: new AspectRatio(
           aspectRatio:  size.width / size.height,
           child: new VideoPlayer(controller),
         ),
    );
  } else {
    return new Container();
  }
  }
}