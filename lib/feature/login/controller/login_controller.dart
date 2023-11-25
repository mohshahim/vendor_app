

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tharakart_vendor_app/feature/login/repository/login_repository.dart';

import '../../../main.dart';
import '../../navBar/Screen/navBarScreen.dart';
import '../../onBoard/screen/onBoard_Screen.dart';
import '../screen/check_status_screen.dart';
import '../screen/login_screen.dart';

final LogincontrollerProvider = Provider((ref) => LoginController(repository: ref.read(loginRepositoryProvider)));


class LoginController{
  final LoginRepository _repository;
  LoginController({
    required LoginRepository repository
}) : _repository = repository;

  login(String Id,String phone) async {
    await _repository.login(Id, phone);
  }

  getStatus({required BuildContext context,required Widget txtWidget,required Widget progressWidget}){
     _repository.getStatus(context: context,progressWidget: progressWidget,txtWidget: txtWidget);
  }

Future<DocumentSnapshot>  getVendorNo(){
  return  _repository.getVendorNo();
  }

  updateVenderNo() {
    _repository.updateVenderNo();
  }

  Future<QuerySnapshot<Map<String,dynamic>>> getvendorPhoneNumber(String phone) {
   return _repository.getvendorPhoneNumber(phone);
  }

  otpLogin() {
 _repository.otpLogin();
  }

  SplashgetStatus( bool firstTime ) {
    _repository.SplashgetStatus(firstTime);
  }

  void navigateToMainScreen(BuildContext context , bool firstTime) async {
    // Wait for some time to display the splash screen animation.
    await Future.delayed(Duration(seconds: 5));
    // Navigate to the main screen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>firstTime?
    SellerOnBoard():Id==''?Login():CheckStatusWidget()));
  }
}