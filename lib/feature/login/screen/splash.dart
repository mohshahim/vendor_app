import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tharakart_vendor_app/feature/login/controller/login_controller.dart';

import '../../../main.dart';
import '../../onBoard/screen/onBoard_Screen.dart';
import 'check_status_screen.dart';
import 'login_screen.dart';

var h;
var w;

class SplashScreen extends ConsumerStatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  bool firstTime=true;



  @override
  void initState() {
    // getStatus();
    super.initState();
    // navigateToMainScreen();
  }


  @override
  Widget build(BuildContext context) {
    ref.watch(LogincontrollerProvider).SplashgetStatus(firstTime);
    ref.watch(LogincontrollerProvider).navigateToMainScreen(context, firstTime);
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    print('splashsssssss');
    return Scaffold(
      backgroundColor: Colors.white, // Customize the background color if needed.
      body: Center(
        child: SvgPicture.asset('assets/images/seller log svg squre bg white.svg',),
      ),
    );
  }
}
