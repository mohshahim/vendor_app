import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tharakart_vendor_app/feature/login/controller/login_controller.dart';
import 'package:tharakart_vendor_app/feature/login/screen/splash.dart';

import '../../../main.dart';
import '../../navBar/Screen/navBarScreen.dart';
import '../repository/login_repository.dart';


class CheckStatusWidget extends ConsumerStatefulWidget {
  const CheckStatusWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<CheckStatusWidget> createState() => _CheckStatusWidgetState();
}

class _CheckStatusWidgetState extends ConsumerState<CheckStatusWidget> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body:
        Center(
          child: ref.watch(LogincontrollerProvider).getStatus(txtWidget: Text("Vendor Verified"),context: context,progressWidget: CircularProgressIndicator()),
        )
    );
  }

}
