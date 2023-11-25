import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tharakart_vendor_app/core/providers/firebase_providers.dart';
import 'package:tharakart_vendor_app/model/vendorModel.dart';
import '../../../main.dart';
import '../../Registration/Screen/SellerRegistration.dart';
import '../../navBar/Screen/navBarScreen.dart';
import '../screen/login_screen.dart';

final loginRepositoryProvider =
    Provider((ref) => LoginRepository(firestore: ref.read(firebaseProvider)));

class LoginRepository {
  final FirebaseFirestore _firestore;
  LoginRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  login(String Id, String phone) async {
    print("**************************");
    print(Id);
    print("**************************");
    VendorModel data = VendorModel(
        phone: phone,
        id: Id,
        date: DateTime.now(),
        status: 0,
        name: "",
        bankDetails: {},
        bannerImage: "",
        brandList: [],
        cashOnDelivery: false,
        categoryList: [],
        companyDescription: "",
        companyDetails: [],
        deliveryPolicy: "",
        displayStatus: 0,
        document: "",
        email: "",
        flatRateAmount: "",
        gstNo: "",
        invoiceNumber: "",
        logo: "",
        orderCancellationAge: "",
        orderReturnAge: "",
        paymentPolicy: "",
        photoUrl: "",
        productList: [],
        profileUrl: "",
        sellerWiseFlatRateShipping: "",
        shipmentTime: "",
        signature: "",
        videoUrl: "");
    print("vendorModellllllllllllll");
    vendorModel = data;
    print(vendorModel);
    print("vendorModellllllllllllll");
    await _firestore.collection("vendor").doc(Id).set(data.toJson());
  }

  getStatus(
      {required BuildContext context,
      required Widget txtWidget,
      required Widget progressWidget}) {
    return _firestore.collection('vendor').doc(Id).snapshots().listen((event) {
      if (event.exists) {
        int s = event['status'];
        if (s == 0) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SellerRegistration()),
              (route) => false);
        } else if (s == 1) {
          txtWidget;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => NavBar()),
              (route) => false);
        } else {
          progressWidget;
        }
      }
    });
  }

  Future<DocumentSnapshot> getVendorNo() async {
    return _firestore.collection("settings").doc("referenceNo").get();
  }

  updateVenderNo() {
    _firestore.collection("settings").doc("referenceNo").update({
      "vendorNo": FieldValue.increment(1),
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getvendorPhoneNumber(String phone) {
    return _firestore
        .collection('vendor')
        .where("phone", isEqualTo: phone)
        .get();
  }

  otpLogin() async {
    var url = Uri.parse(
        'https://2factor.in/API/V1/$apiKey/SMS/$otpNo/AUTOGEN/Login OTP');
    var response =
        await http
        .get(url);
    otpSession = json
        .decode(response
        .body)[
    "Details"];
  }

  SplashgetStatus( bool firstTime ) {
    SharedPreferences.getInstance().then((SharedPreferences prefs) async {
      if(prefs.getBool('firstTime') ?? true){
        prefs.setBool('firstTime', false);
      }
      else{
        firstTime=false;
      }
      if(prefs.getString('Id')!=null&&prefs.getString('Id')!=""){
        Id=prefs.getString('Id')??'';
        print("''''''''''''''''mobileNo''''''''''''''''");
        print(Id);
        print(7);
      }
    });
  }

}
