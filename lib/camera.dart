import 'dart:developer';

import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraDeepArController cameraDeepArController;
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffect = Effects.none;
  Filters currentFilter = Filters.none;
  Masks currentMask = Masks.none;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CameraDeepAr(
              onCameraReady: (bool isCameraReady) {
                log("camera is $isCameraReady");
              },
              onVideoRecorded: (String path) {
                log("path image $path");
              },
              onImageCaptured: (String path) {
                log("path image $path");
              },
              iosLicenceKey: '',
              androidLicenceKey:
                  'b73145e5284c7c0f263e963c87a30881f5d8aaeea0a9c3a787aa8f3520ca6862ed9c7f81c1c63077',
              cameraDeepArCallback: (c) async {
                // ignore: unnecessary_statements, unrelated_type_equality_checks
                cameraDeepArController = c;
                setState(() {});
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(Masks.values.length, (p) {
                        bool active = currentPage == p;
                        return GestureDetector(
                          onTap: (){
                            currentPage = p;
                            cameraDeepArController.changeMask(p);
                            //setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            width: active ? 40 : 30,
                            height: active ? 50 : 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: active ? Colors.green : Colors.white,
                              shape: BoxShape.circle
                            ),
                            child: Text("$p",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: active ? 16 : 14,
                                  color: Colors.black, fontWeight: FontWeight.w800
                            ),),
                          )
                        );
                      })
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
