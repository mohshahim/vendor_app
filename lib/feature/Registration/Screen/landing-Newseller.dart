import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pinput.dart';
import 'package:tharakart_vendor_app/model/vendorModel.dart';
import '../../../core/common/uploadmessage.dart';
import '../../../core/theme/color.dart';
import '../../../model/userModel.dart';
import '../../login/screen/splash.dart';
import 'package:cloud_functions/cloud_functions.dart';




class Landing_Newseller extends StatefulWidget {
 final String? userId;

 final VendorModel? userData;

  Landing_Newseller({
    Key? key,
    this.userId,
    this.userData,
  });

  @override
  State<Landing_Newseller> createState() => _Landing_NewsellerState();
}


class _Landing_NewsellerState extends State<Landing_Newseller> {
  TextEditingController companyDescription = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController bankName = TextEditingController();
  TextEditingController accountName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController ifsc = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController? phoneNumber ;
  TextEditingController? email ;

  List<String> documents = <String>[
    "GST Certificate",
    "FSSAI Registration",
    "Udyam",
    "Shop & Establishment License",
    "Trade Certificate/Licence",
    "Other(Any ID or Document with Business Name)"
  ];
  String? dropdownValue;
  File? image;
  bool read = true;
  final picker = ImagePicker();
  int? requests;
  int? status;
  bool isVerified = false;
  Timer? timer;

  Future getImager() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickImage != null) {
        image = File(pickImage.path);
      } else {

      }
    });
  }
  List emailList=[];

  getRequest() {
    FirebaseFirestore.instance.collection('vendor').where(
        'id', isEqualTo: currentUser?.id).snapshots().listen((event) {
      requests = event.docs.length;
      for (DocumentSnapshot doc in event.docs) {
        status = doc['status'];
        print(status);
        print("status?????????????????");
      }
      setState(() {

      });
    });
  }

  int randomNo=0;
  Future<void> send_vemail(String strEmail)  async {
     randomNo=Random().nextInt(900000) + 100000;
    HttpsCallable callable1 =
    FirebaseFunctions.instance.httpsCallable('sendVerificationMail');
    var myData = {
      "from": "accountverification@tharacart.com",
      "to": strEmail,
      "subject": "Hello ${widget.userData?.name}",
      "html": '<body><p>Your Account Verification OTP is $randomNo .</p></body>'
    };

    var results = await callable1(myData);
    showUploadMessage(context, 'Verification Message Send To Your Email');

    print(randomNo);
    print(results.toString());
    print(strEmail);
    print('randomNo');


  }
  @override
    void initState() {

    dropdownValue=widget.userData!.document;

       phoneNumber = TextEditingController(text: widget.userData!.phone);
       email = TextEditingController(text: widget.userData!.email);
      getRequest();

      super.initState();
    }
    void dispose() {
      super.dispose();
      timer?.cancel();
    }
    TextEditingController job = TextEditingController();
    @override
    Widget build(BuildContext context) {
      return status == 0 ? Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Text(
              "Waiting for approval....",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          )
        ]),
      ) : Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          title: SvgPicture.asset("assets/images/THARA LOGO WHITE.svg",width: w*0.30,),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(children: [
                      Container(
                        width: w * 1,
                        height: h * 0.45,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(23),
                                bottomRight: Radius.circular(23))),
                      ),
                      Container(
                        height: h * 0.30,
                        width: w * 0.60,
                        child: SvgPicture.asset("assets/group.svg",fit: BoxFit.fill,),
                      ),
                      Center(
                        child: Padding(
                          padding:  EdgeInsets.only(top: h * 0.03,bottom:  h * 0.05, ),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(color: Colors.grey, blurRadius: 10)],
                              borderRadius: BorderRadius.all(
                                   Radius.circular(15),
                                  ),
                              color: Colors.white,
                            ),
                            width: w * 0.90,
                            //height: h * 0.9,
                            child: SingleChildScrollView(

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Complete Your Seller Profile",
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                      ),

                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Divider(
                                        thickness: 4,

                                        color: Color(0xff530CAD),
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(left:5),
                                        child: Text("Please Complete Your Company Details.",
                                            style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700))),
                                      ),
                                      IconStepper(
                                        stepRadius: w * 0.040,
                                        lineLength: w * 0.045,
                                        nextButtonIcon:Icon(Icons.start,color: Colors.white,size: 0.0,) ,
                                        previousButtonIcon:Icon(Icons.start,color: Colors.white,size: 0.0,) ,
                                        stepColor: Color(0xff66BD46),
                                        lineColor: Color(0xff66BD46),
                                        activeStepColor: Color(0xff66BD46),
                                        icons: [
                                          status == 1 ? Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.white,
                                          ) : Icon(
                                            Icons.check_circle_outline,
                                            color: primaryColor,
                                          ),
                                          Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.white,
                                          ),
                                          Icon(
                                            Icons.looks_3,
                                            color: Colors.white,
                                          ),
                                          Icon(
                                            Icons.looks_4,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Container(
                                          width: w * 0.8,
                                          height: h * 0.045,
                                          decoration:
                                          BoxDecoration(color: Color(0xff66BD46),
                                              borderRadius: BorderRadius.circular(5)),

                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: w * 0.03,
                                              ),

                                              CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 12,
                                                child:Text('1',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),) ,
                                              ),
                                              SizedBox(
                                                width: w * 0.03,
                                              ),
                                              Text(
                                                'Company Details',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                              SizedBox(
                                                width: w * 0.03,
                                              ),

                                              Icon(
                                                Icons.check_circle_outline,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ],
                                          )),
                                      SizedBox(
                                        height: h * 0.02,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Company Description', style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: primaryColor1,
                                                    fontWeight: FontWeight.w700))),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: w*0.75 ,
                                                  child: TextFormField(
                                                    controller: companyDescription,
                                                    readOnly: false,
                                                    maxLines: 3,
                                                    decoration: InputDecoration(
                                                      enabledBorder: UnderlineInputBorder(
                                                          borderSide:
                                                          BorderSide(color: Color(0xff8C31FF))),
                                                      focusedBorder: UnderlineInputBorder(
                                                          borderSide:
                                                          BorderSide(color: Color(0xff8C31FF))),
                                                      hintText: "Company Description",
                                                      hintStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: w * 0.035),

                                                      suffixStyle: TextStyle(color: Colors.red),
                                                    ),
                                                  ),
                                                ),
                                                Text("*",style: TextStyle(color: Colors.red),)
                                              ],
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Text('Sole Proprietor/LLP/Partnership', style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: primaryColor1,
                                                    fontWeight: FontWeight.w700))),
                                            Container(
                                              width: w * 0.75,
                                              child: TextFormField(

                                                readOnly: true,
                                                decoration: InputDecoration(
                                                    enabledBorder: UnderlineInputBorder(
                                                        borderSide:
                                                        BorderSide(
                                                            color: Color(0xff8C31FF))),
                                                    focusedBorder: UnderlineInputBorder(
                                                        borderSide:
                                                        BorderSide(
                                                            color: Color(0xff8C31FF))),
                                                    suffixStyle: TextStyle(
                                                        color: Colors.red),
                                                    hintText: widget.userData!
                                                        .companyDetails![0]['solePropritor'],
                                                    hintStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: w * 0.035),
                                                    suffixText: "*"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Text('Organization/Business Name', style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: primaryColor1,
                                                    fontWeight: FontWeight.w700))),
                                            Container(
                                              width: w * 0.75,
                                              child: TextFormField(
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  hintText: widget.userData!.companyDetails![0]['companyName'],
                                                  hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: w * 0.035),
                                                  suffixText: "*",
                                                  suffixStyle: TextStyle(color: Colors.red),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Text('Company Address', style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: primaryColor1,
                                                    fontWeight: FontWeight.w700))),
                                            Container(
                                              width: w * 0.75,
                                              child: TextFormField(
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  hintText: widget.userData!.companyDetails![0]['address'],
                                                  hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: w * 0.035),
                                                  suffixText: "*",
                                                  suffixStyle: TextStyle(color: Colors.red),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Text('City', style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: primaryColor1,
                                                    fontWeight: FontWeight.w700))),
                                            Container(
                                              width: w * 0.75,
                                              child: TextFormField(
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  hintText: widget.userData!.companyDetails![0]['city'],
                                                  hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: w * 0.035),
                                                  suffixText: "*",
                                                  suffixStyle: TextStyle(color: Colors.red),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Text('State', style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: primaryColor1,
                                                    fontWeight: FontWeight.w700))),
                                            Container(
                                              width: w * 0.75,
                                              child: TextFormField(
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  hintText: widget.userData!.companyDetails![0]['state'],
                                                  hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: w * 0.035),
                                                  suffixText: "*",
                                                  suffixStyle: TextStyle(color: Colors.red),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Text('Pincode', style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: primaryColor1,
                                                    fontWeight: FontWeight.w700))),
                                            Container(
                                              width: w * 0.75,
                                              child: TextFormField(
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  hintText: widget.userData!.companyDetails![0]['pincode'],
                                                  hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: w * 0.035),
                                                  suffixText: "*",
                                                  suffixStyle: TextStyle(color: Colors.red),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Text('GST No', style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: primaryColor1,
                                                    fontWeight: FontWeight.w700))),
                                            Container(
                                              width: w * 0.75,
                                              child: TextFormField(
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  hintText: widget.userData!.gstNo,
                                                  hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: w * 0.035),
                                                  suffixText: "*",
                                                  suffixStyle: TextStyle(color: Colors.red),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Text('Select Document Type', style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: primaryColor1,
                                                    fontWeight: FontWeight.w700))),

                                            Padding(
                                              padding:  EdgeInsets.only(right: w*0.010),
                                              child: Container(
                                                width: w,
                                                child: DropdownButton<String>(
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      dropdownValue = newValue!;
                                                    });
                                                  },
                                                  value: dropdownValue,style: TextStyle(fontSize: 8,color: Colors.black),
                                                 // hint: Text('${widget.userData!.document}',style: TextStyle(color: Colors.black),),
                                                  items: documents
                                                      .map<DropdownMenuItem<String>>((
                                                      String value) {
                                                    return DropdownMenuItem<String>(
                                                      value:value ,
                                                      child: Text(
                                                        value,
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                              children: [
                                                Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    widget.userData!.photoUrl == null
                                                        ? Container(
                                                      width: w * 0.3,
                                                      height: h * 0.13,
                                                      decoration: BoxDecoration(
                                                          color: Color(0xffE9E9E9),
                                                          border: Border.all(
                                                              color: Color(0xff530CAD))),
                                                    )
                                                        : Container(
                                                      width: w * 0.3,
                                                      height: h * 0.13,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(widget
                                                                  .userData!.photoUrl!),
                                                              fit: BoxFit.cover),
                                                          color: Color(0xffE9E9E9),
                                                          border: Border.all(
                                                              color: Color(0xff530CAD))),
                                                    ),
                                                    Positioned(
                                                      left: w * 0.25,
                                                      bottom: h * 0.10,
                                                      child: InkWell(
                                                        onTap: () {
                                                          image = null;
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          width: w * 0.07,
                                                          height: h * 0.06,
                                                          child: Icon(
                                                            Icons.clear,
                                                            color: Color.fromARGB(
                                                                255, 254, 253, 255),
                                                            size: 25,
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: Color(0xff8C31FF),
                                                              shape: BoxShape.circle),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),

                                                Icon(
                                                  Icons.check_circle_outline,
                                                  color: Color(0xff66BD46),
                                                ),
                                                Container(
                                                  width: w/2.5,
                                                  child: Text(
                                                    "${widget.userData!.document}",
                                                    style: TextStyle(fontSize: w * 0.02),
                                                  ),
                                                )
                                              ],
                                            ),

                                            SizedBox(
                                              height: h * 0.02,
                                            ),

                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                getImager();
                                              },
                                              child: Container(
                                                width: w * 0.7,
                                                height: h * 0.05,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(8)),
                                                  gradient: LinearGradient(colors: [
                                                    Color(0xff8C31FF),
                                                    Color(0xff601AB9)
                                                  ]),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                      "Upload Document",
                                                      style: TextStyle(color: Colors.white),
                                                    )),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.01,
                                            ),
                                            Text("*Supported file types JPEG, PNG OR PDF ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff530CAD))),
                                            Text("*Upload Limit 1 MB",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff530CAD))),
                                            SizedBox(
                                              height: h * 0.01,
                                            ),
                                            Container(
                                              width: w * 0.75,
                                              child: TextFormField(
                                                controller: phoneNumber,
                                                decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  hintText: "Mobile number ",
                                                  hintStyle: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: w * 0.030),
                                                  suffixText: "*",
                                                  suffixStyle: TextStyle(color: Colors.red),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.01,
                                            ),
                                            Container(
                                              width: w * 0.75,
                                              child: TextFormField(
                                                controller: email,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  hintText: "Email Address ",
                                                  hintStyle: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: w * 0.030),
                                                  suffixText: "*",
                                                  suffixStyle: TextStyle(color: Colors.red),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),

                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            TextButton(
                                              onPressed: () {  },
                                              child: Container(
                                                width: w ,
                                                height: h * 0.042,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(8)),
                                                  gradient: LinearGradient(colors: [
                                                    Color(0xff8C31FF),
                                                    Color(0xff601AB9)
                                                  ]),
                                                ),
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 10,),
                                                    CircleAvatar(
                                                      backgroundColor: Colors.white,
                                                      radius: 12,
                                                      child:Text('2',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),) ,
                                                    ),
                                                    SizedBox(width: 10,),
                                                    Text(
                                                      "Verify Email Address",
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: w * 0.54,
                                                  child: TextFormField(
                                                    controller: email,
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      hintText: "email@gmail.com",
                                                      hintStyle: TextStyle(
                                                          fontSize: w * 0.035),
                                                      suffixText: "*",
                                                      suffixStyle: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: ()  {
                                                     send_vemail(widget.userData!.email??"");
                                                    setState(() {

                                                         });
                                                    },
                                                  child: Container(
                                                    width: w * 0.23,
                                                    height: h * 0.040,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(8)),
                                                      gradient: LinearGradient(colors: [
                                                        Color(0xff8C31FF),
                                                        Color(0xff601AB9)
                                                      ]),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                          "Verify",
                                                          style: TextStyle(
                                                              color: Colors.white),
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Enter Verification Code",
                                                  style: TextStyle(fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Pinput(
                                                  length: 6,
                                                  controller: otpController,
                                                  defaultPinTheme: PinTheme(
                                                      width: w * 0.09,
                                                      height: h * 0.034,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(10)),
                                                          border:
                                                              Border.all(color: primaryColor))),
                                                  onCompleted: (va){

                                                    va==randomNo.toString()?showUploadMessage(context, 'OTP Matched'):
                                                    showUploadMessage(context, 'Incorrect OTP');
                                                    setState(() {

                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: h * 0.03,
                                            ),
                                            Container(
                                              width: w ,
                                              height: h * 0.042,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.all(Radius.circular(8)),
                                                gradient: LinearGradient(colors: [
                                                  Color(0xff8C31FF),
                                                  Color(0xff601AB9)
                                                ]),
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 10,),
                                                  CircleAvatar(
                                                    backgroundColor: Colors.white,
                                                    radius: 12,
                                                    child:Text('3',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),) ,
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Text(
                                                    "Add Bank Account",
                                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: w ,
                                              child: TextFormField(
                                                controller: bankName,
                                                decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  hintText: "Bank Name ",
                                                  hintStyle: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: w * 0.035),
                                                  suffixText: "*",
                                                  suffixStyle: TextStyle(color: Colors.red),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: w ,
                                              child: TextFormField(
                                                controller: accountName,
                                                decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  hintText: "Bank Accont Name ",
                                                  hintStyle: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: w * 0.035),
                                                  suffixText: "*",
                                                  suffixStyle: TextStyle(color: Colors.red),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: w ,
                                              child: TextFormField(
                                                controller: accountNumber,
                                                decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  hintText: "Bank Accont Number ",
                                                  hintStyle: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: w * 0.035),
                                                  suffixText: "*",
                                                  suffixStyle: TextStyle(color: Colors.red),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: w ,
                                              child: TextFormField(
                                                controller: ifsc,
                                                decoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Color(0xff8C31FF))),
                                                  hintText: "IFSC CODE ",
                                                  hintStyle: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: w * 0.035),
                                                  suffixText: "*",
                                                  suffixStyle: TextStyle(color: Colors.red),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                if (bankName.text != '' &&
                                                    accountName.text != '' &&
                                                    accountNumber.text != "" &&
                                                    ifsc.text != ""&&
                                                companyDescription.text!="") {
                                                  var updatedata1 =
                                                  widget.userData?.copyWith(
                                                      companyDescription: companyDescription
                                                          .text,
                                                      status: status,
                                                      phone: phoneNumber!.text,
                                                      email: email!.text,
                                                      bankDetails: {
                                                        "bankName": bankName.text,
                                                        "accountName": accountName.text,
                                                        "accountNumber": accountNumber.text,
                                                        "ifsc": ifsc.text
                                                      });
                                                  FirebaseFirestore.instance
                                                      .collection("vendor")
                                                      .doc(widget.userId)
                                                      .update(updatedata1!.toJson())
                                                      .then((value) =>
                                                  {
                                                    //TODO
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             Stepper_Completion()))
                                                  });

                                                }
                                                else {
                                                  showUploadMessage(
                                                      context, "Please Fill All Fields");
                                                }
                                              },
                                              child: Container(
                                                width: w ,
                                                height: h * 0.045,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(8)),
                                                  gradient: LinearGradient(colors: [
                                                    Color(0xff8C31FF),
                                                    Color(0xff601AB9)
                                                  ]),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                      "Submit",
                                                      style: TextStyle(color: Colors.white),
                                                    )),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.1,
                                            )
                                          ],
                                        ),
                                      ),

                                    ]),
                              ),
                            ),
                          ),
                        ),
                      )
                    ])
                  ]),
              SizedBox(
                height: h * 0.025,
              ),
              Container(
                height: h * 0.04,
                width: w * 2,
                decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(w * 0.04),
                        topRight: Radius.circular(w * 0.04))),
              )
            ],
          ),
        ),
      );
    }
  }


