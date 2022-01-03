import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class player_controller extends ChangeNotifier{
  VideoPlayerController? controller;


  Future<void> initializeController(String path) async {
    if(controller == null)
      {
        controller = VideoPlayerController.file(File(path));
        await controller!.initialize();
        notifyListeners();
      }
  }

  VideoPlayerController get getController {
    return controller!;
  }

  double get getVolume {
  return controller!.value.volume;
  }

  String get getFileName {
    return isInitialized() ? controller!.dataSource.substring(controller!.dataSource.lastIndexOf("/") + 1) : "";
  }

  void setmyVolume(double change) {
    controller!.setVolume(double.parse((getVolume - change).toStringAsFixed(2)));
    notifyListeners();
  }

  @override
  void dispose(){
    if(controller != null)
      controller!.dispose();
    super.dispose();
  }
  bool isInitialized() {
    return controller == null ? false : controller!.value.isInitialized;
  }

  bool isPlaying() {
    return controller!.value.isPlaying;
  }

  Future<void> switchPlay() async {
    isPlaying() ? await controller!.pause() : await controller!.play();
    notifyListeners();
  }

}