import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tharakart_vendor_app/feature/login/controller/login_controller.dart';
import 'package:tharakart_vendor_app/feature/login/screen/splash.dart';
import '../../../core/common/uploadmessage.dart';
import '../../../core/theme/color.dart';
import '../../../main.dart';
import '../../../model/userModel.dart';
import '../../../model/vendorModel.dart' as modal;
import '../../../model/vendorModel.dart';
import '../../Registration/Screen/SellerRegistration.dart';

var CurrentUserId;
late String phoneNumber;
String otpSession = "";
String otpNo = "";
String status = "";

class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  login(String id, String phone) {
    print("logiiiiiiiinnnnn");
    ref.read(LogincontrollerProvider).login(id, phone);
  }

  updateVenderNo() {
    ref.read(LogincontrollerProvider).updateVenderNo();
  }

  Future<DocumentSnapshot> getVendorNo() {
    return ref.read(LogincontrollerProvider).getVendorNo();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getvendorPhoneNumber(
      String phone) {
    return ref.read(LogincontrollerProvider).getvendorPhoneNumber(phone);
  }

  otpLogin() {
    ref.read(LogincontrollerProvider).otpLogin();
  }

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late TextEditingController phoneNumberController;
  String otp = "";
  bool valid = false;

  @override
  void initState() {
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Container(
                  height: h * 0.50,
                  width: w * 1,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xff8C31FF),
                          Color(0xff601AB9),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(w * 0.05),
                          bottomLeft: Radius.circular(w * 0.05))),
                ),
                Container(
                  height: h * 0.30,
                  width: w * 0.60,
                  child: SvgPicture.asset(
                    "assets/group.svg",
                    height: h * 0.05,
                  ),
                ),
                Positioned(
                  top: h * 0.20,
                  left: w * 0.40,
                  child: Container(
                    height: h * 0.10,
                    width: w * 0.55,
                    child: SvgPicture.asset(
                      "assets/tharname.svg",
                      height: h * 0.03,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: h * 0.35),
                  child: Center(
                    child: Container(
                      height: h * 0.55,
                      width: w * 0.90,
                      decoration: BoxDecoration(
                          color: Color(0xffFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: w * 0.005,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(w * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: h * 0.03,
                            ),
                            Container(
                              height: h * 0.075,
                              width: w * 0.72,
                              decoration: BoxDecoration(
                                  gradient: gradient,
                                  borderRadius:
                                      BorderRadius.circular(w * 0.02)),
                              child: Center(
                                  child: Text(
                                "Welcome Back!",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontSize: h * 0.030,
                                        color: Color(0xffFFFFFF))),
                              )),
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            Text("Login to Seller Account",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontSize: w * 0.035,
                                        fontWeight: FontWeight.w400))),
                            Divider(
                              thickness: h * 0.003,
                              color: Color(0xff530CAD),
                              endIndent: w * 0.07,
                              indent: w * 0.08,
                            ),
                            SizedBox(
                              height: h * 0.05,
                            ),
                            Text("Enter Your Mobile Number",
                                style: TextStyle(
                                    fontSize: h * 0.015,
                                    fontFamily: "verdana_regular")),
                            SizedBox(
                              height: h * 0.01,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: w * 0.70,
                                height: h * 0.1,
                                color: Colors.white,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: phoneNumberController,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 14),
                                  decoration: InputDecoration(
                                    prefixText: "+91 | ",
                                    prefixStyle: GoogleFonts.roboto(
                                        color: Colors.black, fontSize: 15),
                                    suffixIcon:
                                        phoneNumberController.text.length == 10
                                            ? Icon(
                                                Icons.check_circle_outline,
                                                color: Colors.green,
                                              )
                                            : SizedBox(),
                                    // contentPadding: const EdgeInsets.only(
                                    //     top: 38, left: 10),
                                    fillColor: Colors.white,
                                    hintText: ' Enter a valid Phone Number',
                                    hintStyle: GoogleFonts.roboto(
                                        color: Colors.black, fontSize: 14),
                                    labelText: 'Phone Number',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: GoogleFonts.roboto(
                                        color: Colors.black, fontSize: 14),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: primaryColor, width: 1),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: primaryColor, width: 1),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                                  ),
                                  maxLength: 10,
                                  onChanged: (value) {
                                    phoneNumber = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            // phoneNumberController.text.length < 10
                            valid == true
                                ? Text(
                                    "Please Enter a valid phone number",
                                    style: TextStyle(color: Colors.red),
                                  )
                                : SizedBox(),

                            InkWell(
                              onTap: () async {
                                if (phoneNumberController.text.length == 10 &&
                                    phoneNumberController.text != '') {
                                  otpNo = phoneNumberController.text;
                                  var url = Uri.parse(
                                      'https://2factor.in/API/V1/$apiKey/SMS/${phoneNumberController.text}/AUTOGEN/Login OTP');
                                  var response = await http.get(url);
                                  otpSession =
                                      json.decode(response.body)["Details"];
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25.0),
                                        ),
                                      ),
                                      isScrollControlled: true,
                                      isDismissible: false,
                                      builder: (context) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: Wrap(
                                            children: [
                                              Container(
                                                height: h * 0.400,
                                                width: w * 1,
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topRight,
                                                      end: Alignment.bottomLeft,
                                                      colors: [
                                                        Color(0xff8C31FF),
                                                        Color(0xff601AB9),
                                                      ],
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topRight: Radius
                                                                .circular(
                                                                    w * 0.06),
                                                            topLeft:
                                                                Radius.circular(
                                                                    w * 0.06))),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: h * 0.01,
                                                    ),
                                                    Container(
                                                      height: h * 0.008,
                                                      width: w * 0.180,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                    ),
                                                    Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .cancel_outlined,
                                                              color:
                                                                  Colors.white,
                                                              size: h * 0.040,
                                                            ))),
                                                    Text(
                                                      "Enter Verification Code",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize:
                                                                  h * 0.02),
                                                          color: Color(
                                                              0xffFFFFFF)),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.02,
                                                    ),
                                                    Text(
                                                      "Automatically detecting a SMS Send to your",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize:
                                                                  w * 0.03),
                                                          color: Color(
                                                              0xffFFFFFF)),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "mobile number ******${phoneNumberController.text.substring(phoneNumberController.text.length - 4)}",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize:
                                                                      w * 0.03),
                                                              color: Color(
                                                                  0xffFFFFFF)),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            phoneNumberController
                                                                .clear();
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          },
                                                          child: Text(
                                                            "  Change",
                                                            style: GoogleFonts.roboto(
                                                                textStyle: TextStyle(
                                                                    fontSize: w *
                                                                        0.03,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                color: Color(
                                                                    0xffFFFFFF)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.02,
                                                    ),
                                                    OTPTextField(
                                                      onChanged: (value) {
                                                        otp = value;
                                                      },
                                                      length: 6,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              34,
                                                      fieldWidth: 50,
                                                      otpFieldStyle:
                                                          OtpFieldStyle(
                                                        backgroundColor:
                                                            Color(0xffFFFFFF),
                                                      ),
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.black),
                                                      textFieldAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      fieldStyle:
                                                          FieldStyle.underline,
                                                      outlineBorderRadius: 22,
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.02,
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          var url = Uri.parse(
                                                              'https://2factor.in/API/V1/$apiKey/SMS/VERIFY/$otpSession/$otp');
                                                          var response =
                                                              await http
                                                                  .get(url);
                                                          if (json.decode(
                                                                      response
                                                                          .body)[
                                                                  "Details"] ==
                                                              "OTP Matched") {
                                                            QuerySnapshot<
                                                                    Map<String,
                                                                        dynamic>>
                                                                userRecord =
                                                                await getvendorPhoneNumber(
                                                                    phoneNumberController
                                                                        .text);

                                                            if (userRecord.docs
                                                                .isNotEmpty) {
                                                              print(
                                                                  'user exist');
                                                              vendorModel =
                                                                  VendorModel.fromJson(
                                                                      (userRecord
                                                                          .docs[
                                                                              0]
                                                                          .data()));
                                                              print(
                                                                  currentUser);

                                                              print(currentUser
                                                                  ?.id);

                                                              print(
                                                                  '================');
                                                              final Future<
                                                                      SharedPreferences>
                                                                  _prefs =
                                                                  SharedPreferences
                                                                      .getInstance();
                                                              SharedPreferences
                                                                  prefs =
                                                                  await _prefs;
                                                              prefs.setString(
                                                                  'Id',
                                                                  currentUser
                                                                          ?.id ??
                                                                      "");
                                                              prefs.setBool(
                                                                  'firstTime',
                                                                  false);

                                                              // _btnController1.success();
                                                              // Navigator.popUntil(
                                                              //     context,
                                                              //         (Route<dynamic>
                                                              //     predicate) =>
                                                              //     predicate
                                                              //         .isFirst);
                                                              Navigator.of(
                                                                      context)
                                                                  .pushReplacement(
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              SplashScreen()));
                                                            } else {
                                                              print(
                                                                  'elseeeeeeeee');
                                                              print(
                                                                  'user not exist');
                                                              DocumentSnapshot
                                                                  doc =
                                                                  await getVendorNo();
                                                              print(doc);
                                                              updateVenderNo();
                                                              int i = doc[
                                                                  "vendorNo"];
                                                              i++;
                                                              String Id = 'V' +
                                                                  i.toString();

                                                              final data = modal.VendorModel(
                                                                  bannerImage:
                                                                      "",
                                                                  brandList: [],
                                                                  cashOnDelivery:
                                                                      false,
                                                                  categoryList: [],
                                                                  companyDescription:
                                                                      "",
                                                                  companyDetails: [],
                                                                  deliveryPolicy:
                                                                      "",
                                                                  displayStatus:
                                                                      0,
                                                                  document: "",
                                                                  email: "",
                                                                  flatRateAmount:
                                                                      "",
                                                                  name: "",
                                                                  gstNo: "",
                                                                  invoiceNumber:
                                                                      "",
                                                                  logo: "",
                                                                  orderCancellationAge:
                                                                      '',
                                                                  orderReturnAge:
                                                                      "",
                                                                  paymentPolicy:
                                                                      "",
                                                                  photoUrl: "",
                                                                  productList: [],
                                                                  profileUrl:
                                                                      "",
                                                                  sellerWiseFlatRateShipping:
                                                                      "",
                                                                  shipmentTime:
                                                                      "",
                                                                  signature: "",
                                                                  status: 0,
                                                                  phone:
                                                                      phoneNumber,
                                                                  id: Id,
                                                                  date: DateTime
                                                                      .now(),
                                                                  bankDetails: {}, videoUrl: '');

                                                              vendorModel =
                                                                  data;
                                                              await login(Id,
                                                                  phoneNumber);
                                                              final Future<
                                                                      SharedPreferences>
                                                                  _prefs =
                                                                  SharedPreferences
                                                                      .getInstance();
                                                              SharedPreferences
                                                                  prefs =
                                                                  await _prefs;
                                                              prefs.setString(
                                                                  'Id', Id);

                                                              print('out');
                                                              Navigator.popUntil(
                                                                  context,
                                                                  (Route<dynamic>
                                                                          predicate) =>
                                                                      predicate
                                                                          .isFirst);
                                                              Navigator.of(
                                                                      context)
                                                                  .pushReplacement(
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              SellerRegistration(
                                                                                userid: data.id,
                                                                                userData: data,
                                                                              )));

                                                              //  // print(currentUserModel!.id);
                                                              // // await maybeCreateOtpUser(otpUser);
                                                              // if(currentUserModel?.id==otpNo){
                                                              //   print('666666666');
                                                              //   f
                                                              //   print('7777777777');
                                                              //   print(currentUserModel?.id);
                                                              //   print(userDocument.data());
                                                              //    Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
                                                              //   Navigator.of(context).pushReplacement(
                                                              //       MaterialPageRoute(builder: (context) =>SellerRegistration(
                                                              //         userid: currentUserModel?.id,
                                                              //         userData: UserModel.fromJson(userDocument.data()!),
                                                              //       )));
                                                              // }
                                                            }
                                                          } else {
                                                            showUploadMessage(
                                                                context,
                                                                'Incorrect OTP');
                                                            // _btnController1.reset();
                                                          }
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: Colors
                                                              .white, // Background color
                                                        ),
                                                        child: Text(
                                                          "SUBMIT",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  color: Color(
                                                                      0xff7C29E5))),
                                                        )),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Don't Receive OTP? ",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize:
                                                                      w * 0.03,
                                                                  color: Color(
                                                                      0xffFFFFFF))),
                                                        ),
                                                        TextButton(
                                                            onPressed:
                                                                () async {
                                                              otpLogin();
                                                              // var url = Uri.parse(
                                                              //     'https://2factor.in/API/V1/$apiKey/SMS/$otpNo/AUTOGEN/Login OTP');
                                                              // var response =
                                                              // await http
                                                              //     .get(url);
                                                              // print(
                                                              //     'Response body: ${response.body}');
                                                              // otpSession = json
                                                              //     .decode(response
                                                              //     .body)[
                                                              // "Details"];
                                                              // setState(() {});

                                                              // _signInWithPhoneNumber(context);
                                                              // Navigator.of(context, rootNavigator: true).pop();
                                                            },
                                                            child: Text(
                                                              "RESEND OTP",
                                                              style: GoogleFonts.roboto(
                                                                  textStyle: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Color(
                                                                        0xffFFFFFF,
                                                                      ),
                                                                      fontSize: w * 0.03)),
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                } else {
                                  valid = true;
                                  // showUploadMessage(context, 'Enter  valid MobileNumber');
                                  // _btnController1.reset();
                                }
                                //TODO
                                // setState(() {});
                              },

                              // {Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile_Details()));},

                              child: Container(
                                height: h * 0.060,
                                width: w * 0.70,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xff7C29E5)),
                                    borderRadius: BorderRadius.circular(5),
                                    color: primaryColor1),
                                child: Center(
                                    child: Text(
                                  "Get OTP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.03,
                            ),
                            Center(
                                child: Text(
                              " By Continuing you agree to tharacart\n Terms and Conditions & Privacy Policy",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: "verdana",
                                  fontWeight: FontWeight.w400),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]),
              SizedBox(
                height: h * 0.07,
              ),
              Container(
                height: h * 0.03,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xff8C31FF),
                      Color(0xff601AB9),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: w * 0.06),
                      child: Text(
                        "App V.1.1.0",
                        style: TextStyle(fontSize: 9, color: Color(0xffFFFFFF)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
