import 'package:compass_app/core/size_config.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:smooth_compass/utils/src/compass_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int imageNbr = 2; //1, 2, 3, 4
  bool _hasPermissions = false;
  @override
  void initState() {
    super.initState();
    _fetchPermissionStatus();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFF212227),
      body: Builder(builder: (context) {
        if (_hasPermissions) {
          //
          return _buildCompass();
        } else {
          //
          return _permissionSheet();
        }
      }),
    );
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() {
          _hasPermissions = (status == PermissionStatus.granted);
        });
      }
    });
  }

  //compass
  Widget _buildCompass() {
    return Container(
      // color: Colors.blue,
      child: SmoothCompass(
        rotationSpeed: 200,
        //height: SizeConfig.screenHeight * 0.7,
        width: SizeConfig.screenWidth * 0.8,
        compassAsset: Center(
          child: Container(
            //height: SizeConfig.screenHeight * 0.8,
            width: SizeConfig.screenWidth * .8,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image:
                    DecorationImage(image: AssetImage('images/$imageNbr.png'))),
          ),
        ),
        compassBuilder: (context, AsyncSnapshot<CompassModel>? compassData,
            Widget compassAsset) {
          return compassAsset;
        },
      ),
    );
    // StreamBuilder(
    //     stream: FlutterCompass.events,
    //     builder: (context, snapshot) {
    //       //has error
    //       if (snapshot.hasError) {
    //         return Text(
    //           'Error sreading heading: ${snapshot.error}',
    //           style: TextStyle(
    //             fontSize: 20.0,
    //             fontWeight: FontWeight.w500,
    //             color: Colors.black87,
    //           ),
    //         );
    //       }

    //       //loading
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       //
    //       var direction = snapshot.data!.heading;
    //       return Center(
    //           child: Container(
    //         padding: EdgeInsets.all(25),
    //         child: Image.asset(
    //           'images/2.png',
    //           // color: Colors.black,
    //         ),
    //       ));
    //     });
  }

  Widget _permissionSheet() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          //
          Permission.locationWhenInUse.request().then((value) {
            _fetchPermissionStatus();
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Request Permission',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
