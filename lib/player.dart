// import 'dart:async';
// import 'dart:io';
//
// import 'package:bplayer/player_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:provider/provider.dart';
// import 'package:screen_brightness/screen_brightness.dart';
// import 'package:video_player/video_player.dart';
//
//
// // class player extends StatefulWidget {
// //   String path;
// //   player(String this.path, {Key? key}) : super(key: key);
// //
// //   @override
// //   _playerState createState() => _playerState(path);
// // }
//
// class loader extends StatelessWidget {
//   String path;
//   loader(String this.path, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => player_controller(),
//       //dispose: (context, player_controller control) {control.dispose();},
//       child: player(path),
//     );
//   }
// }
//
// class player extends StatelessWidget {
//   String path;
//   player(String this.path, {Key? key}) : super(key: key);
//
//   initialize(BuildContext context) async {
//     SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
//     Provider.of<player_controller>(context).initializeController(path);
//     // myBanner = BannerAd(
//     //   adUnitId: 'ca-app-pub-8371884269902792/5448525428',
//     //   size: AdSize.fullBanner,
//     //   request: AdRequest(),
//     //   listener: BannerAdListener(),
//     // );
//     await myBanner.load();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     initialize(context);
//     return Scaffold(
//       body: Stack(
//         children: [
//           Consumer<player_controller>(
//             builder: (context, control, child){
//               return Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: control.isInitialized() ? VideoPlayer(control.getController) : Center(child: CircularProgressIndicator()),
//               );
//             },
//           ),
//           controls(),
//           Consumer<player_controller>(
//             builder: (context, control, child) {
//               return control.isInitialized()? ( control.isPlaying() ? SizedBox() : ad()) : SizedBox();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// // VideoPlayerController? controller;
// BannerAd myBanner = BannerAd(
//   adUnitId: 'ca-app-pub-8371884269902792/5448525428',
//   size: AdSize.fullBanner,
//   request: AdRequest(),
//   listener: BannerAdListener(),
// );
//
// // class _playerState extends State<player> {
// //
// //   String path;
// //
// //   _playerState(String this.path);
// //
// //   initialize() async {
// //     controller = VideoPlayerController.file(File(path));
// //     await controller!.initialize();
// //     await myBanner.load();
// //     setState(() {
// //
// //     });
// //   }
// //
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     myBanner = BannerAd(
// //       adUnitId: 'ca-app-pub-8371884269902792/5448525428',
// //       size: AdSize.fullBanner,
// //       request: AdRequest(),
// //       listener: BannerAdListener(),
// //     );
// //     initialize();
// //     SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
// //   }
// //
// //   @override
// //   void dispose() {
// //     // TODO: implement dispose
// //     super.dispose();
// //     controller!.dispose();
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //
// //     return Scaffold(
// //       body: Stack(
// //         children: [
// //           Container(
// //             width: MediaQuery.of(context).size.width,
// //             child: controller!.value.isInitialized ? VideoPlayer(controller!) : CircularProgressIndicator(),
// //           ),
// //           controls(),
// //           // ad(),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// class ad extends StatefulWidget {
//   const ad({Key? key}) : super(key: key);
//
//   @override
//   _adState createState() => _adState();
// }
//
// class _adState extends State<ad> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//          width: myBanner.size.width.toDouble(),
//          height: myBanner.size.height.toDouble(),
//          alignment: Alignment.center,
//          child: AdWidget(ad: myBanner,),
//        ),
//     );
//   }
// }
//
//
//
// class controls extends StatefulWidget {
//   const controls({Key? key}) : super(key: key);
//
//   @override
//   _controlsState createState() => _controlsState();
// }
//
// class _controlsState extends State<controls> {
//
//   bool? visible;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     visible = true;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedOpacity(
//       opacity: visible! ? 0.0 : 1.0,
//       duration: visible! ? Duration(seconds: 3) : Duration(milliseconds: 100),
//       onEnd: () {
//         print("Visibility is " + visible.toString());
//         if(!(visible!))
//           {
//             setState(() {
//               visible = true;
//             });
//           }
//         },
//      curve: visible! ? Curves.easeInExpo : Curves.linear,
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             visible = false;
//           });
//         },
//         child: Consumer<player_controller>(
//           builder: (context, control, child) {
//             return Scaffold(
//               backgroundColor: Colors.transparent,
//               appBar: AppBar(
//                 title: Text(control.getFileName),
//                 backgroundColor: Color.fromRGBO(0, 0, 0, 0.2),
//                 elevation: 0,
//                 centerTitle: true,
//                 leading: IconButton(
//                   icon: Icon(Icons.arrow_back),
//                   onPressed: () {
//                       Navigator.pop(context);
//                   },
//                 ),
//               ),
//               body: control.isInitialized() ? Column(
//                 children: [
//                   Flexible(
//                       fit: FlexFit.tight,
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: gestures(),
//                           ),
//                         ],
//                       )
//                   ),
//                   Container(
//                     height: 100,
//                     color: Color.fromRGBO(0, 0, 0, 0.3),
//                     child: Column(
//                       children: [
//                         video_progress(),
//                         Expanded(
//                           child: Row(
//                             children: [
//                               Flexible(
//                                 fit: FlexFit.tight,
//                                 child: IconButton(
//                                     onPressed: () {
//                                          control.switchPlay();
//                                     },
//                                     icon: control.isPlaying() ? Icon(Icons.pause, size: 50, color: Colors.white,) : Icon(Icons.play_arrow, size: 50, color: Colors.white,)),
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ) : CircularProgressIndicator(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class video_progress extends StatefulWidget {
//   const video_progress({Key? key}) : super(key: key);
//
//   @override
//   _video_progressState createState() => _video_progressState();
// }
//
// class _video_progressState extends State<video_progress> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<player_controller>(
//       builder: (context, control, child){
//         return VideoProgressIndicator(control.getController, allowScrubbing: true);
//       },
//     );
//   }
// }
//
// class gestures extends StatelessWidget {
//   const gestures({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<player_controller>(
//       builder: (context, control, child){
//         return GestureDetector(
//           onVerticalDragUpdate: (details) async {
//             double width = MediaQuery.of(context).size.width;
//             if(details.localPosition.dx < (width/2))
//             {
//               double val = await ScreenBrightness().current - (details.delta.dy / 5.0);
//               if(val < 0)
//               {
//                 val=0.0;
//               }
//               else if (val > 1)
//               {
//                 val=1.0;
//               }
//               await ScreenBrightness().setScreenBrightness(val);
//             }
//             else
//             {
//               control.getController.setVolume(control.getController.value.volume - details.delta.dy);
//             }
//           },
//           onHorizontalDragUpdate: (details) {
//             control.getController.seekTo(control.getController.value.position + Duration(seconds: details.delta.dx.floor()));
//           },
//         );
//       },
//     );
//   }
// }
//



import 'dart:async';
import 'dart:io';

import 'package:bplayer/player_controller.dart';
import 'package:bplayer/visibility_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:video_player/video_player.dart';

class loader extends StatelessWidget {
  String path;
  loader(String this.path, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => player_controller()),
        ChangeNotifierProvider(create: (context) => visibility_controller())
      ],
      child: player(path),
    );
  }
}

class player extends StatelessWidget {
  String path;
  player(String this.path, {Key? key}) : super(key: key);

  initialize(BuildContext context) async {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    Provider.of<player_controller>(context, listen: false).initializeController(path);
    Provider.of<visibility_controller>(context, listen: false).start();
    await myBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    initialize(context);
    return Scaffold(
      body: Stack(
        children: [
          Consumer<player_controller>(
            builder: (context, control, child){
              return Container(
                width: MediaQuery.of(context).size.width,
                child: control.isInitialized() ? VideoPlayer(control.getController) : Center(child: CircularProgressIndicator()),
              );
            },
          ),
          // Consumer<player_controller>(
          //   builder: (context, control, child) {
          //     return control.isInitialized()? ( control.isPlaying() ? SizedBox() : ad()) : SizedBox();
          //   },
          // ),
          controls(),
        ],
      ),
    );
  }
}

BannerAd myBanner = BannerAd(
  adUnitId: 'ca-app-pub-8371884269902792/5448525428',
  size: AdSize.fullBanner,
  request: AdRequest(),
  listener: BannerAdListener(),
);

class ad extends StatefulWidget {
  const ad({Key? key}) : super(key: key);

  @override
  _adState createState() => _adState();
}

class _adState extends State<ad> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: myBanner.size.width.toDouble(),
        height: myBanner.size.height.toDouble(),
        alignment: Alignment.center,
        child: AdWidget(ad: myBanner,),
      ),
    );
  }
}



class controls extends StatefulWidget {
  const controls({Key? key}) : super(key: key);

  @override
  _controlsState createState() => _controlsState();
}

class _controlsState extends State<controls> {

  bool? visible;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visible = true;
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<player_controller>(
      builder: (context, control, child) {
        return Consumer<visibility_controller>(
          builder: (context, visibility, child){
            print("Here is: " + visibility.isVisible.toString());
            return visibility.isVisible ? Opacity(
              opacity: visibility.getvisibility.isNegative ? 0.0 : visibility.getvisibility,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text(control.getFileName),
                  backgroundColor: Color.fromRGBO(0, 0, 0, 0.2),
                  elevation: 0,
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                body: control.isInitialized() ? Column(
                  children: [
                    Flexible(
                        fit: FlexFit.tight,
                        child: Row(
                          children: [
                            Expanded(
                              child: gestures(),
                            ),
                          ],
                        )
                    ),
                    Container(
                      height: 100,
                      color: Color.fromRGBO(0, 0, 0, 0.3),
                      child: Column(
                        children: [
                          video_progress(),
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: IconButton(
                                      onPressed: () {
                                        control.switchPlay();
                                      },
                                      icon: control.isPlaying() ? Icon(Icons.pause, size: 50, color: Colors.white,) : Icon(Icons.play_arrow, size: 50, color: Colors.white,)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ) : CircularProgressIndicator(),
              ),
            ) : gestures();
          },
        );
      },
    );
  }
}

class video_progress extends StatefulWidget {
  const video_progress({Key? key}) : super(key: key);

  @override
  _video_progressState createState() => _video_progressState();
}

class _video_progressState extends State<video_progress> {
  @override
  Widget build(BuildContext context) {
    return Consumer<player_controller>(
      builder: (context, control, child){
        return VideoProgressIndicator(control.getController, allowScrubbing: true);
      },
    );
  }
}

class gestures extends StatelessWidget {
  const gestures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<player_controller>(
      builder: (context, control, child){
        return GestureDetector(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Consumer<player_controller>(
                        builder: (context, control, child){
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Text((control.getVolume * 100).toInt().toString()),
                                Expanded(
                                  child: RotatedBox(
                                      quarterTurns: -1,
                                      child: LinearProgressIndicator(
                                        value: control.getVolume,
                                        backgroundColor: Colors.grey,
                                        color: Colors.blue,
                                      )),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      height: 150,
                    ),
                    Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox(),)
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            Provider.of<visibility_controller>(context, listen: false).makeVisible();
            Provider.of<visibility_controller>(context, listen: false).start();
          },
          onVerticalDragUpdate: (details) async {
            double width = MediaQuery.of(context).size.width;
            if(details.localPosition.dx < (width/2))
            {
              double val = await ScreenBrightness().current - (details.delta.dy / 5.0);
              if(val < 0)
              {
                val=0.0;
              }
              else if (val > 1)
              {
                val=1.0;
              }
              await ScreenBrightness().setScreenBrightness(val);
            }
            else
            {
              double val = (details.primaryDelta! * 0.005);
              // val = val.clamp(0, 1);
              print("Updating: " + val.toString());
              control.setmyVolume(val);
            }
          },
          onHorizontalDragUpdate: (details) {
            control.getController.seekTo(control.getController.value.position + Duration(seconds: details.delta.dx.floor()));
          },
        );
      },
    );
  }
}

