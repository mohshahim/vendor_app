import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tharakart_vendor_app/model/addressModel.dart';
import 'package:tharakart_vendor_app/model/vendorModel.dart';
import '../../../core/common/imageView.dart';
import '../../../core/common/upload_media.dart';
import '../../../core/common/uploadmessage.dart';
import '../../../core/theme/color.dart';
import '../../../model/userModel.dart';
import '../../login/screen/login_screen.dart';
import '../../login/screen/splash.dart';
import 'landing-Newseller.dart';




class SellerRegistration extends StatefulWidget {


  String? name;
  String? email;
  String? userid;
  VendorModel? userData;


  SellerRegistration({
    Key? key,
    this.name,
    this.email,
    this.userid,
    this.userData,
  });

  @override
  State<SellerRegistration> createState() => _SellerRegistrationState();
}

class _SellerRegistrationState extends State<SellerRegistration> {

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController solePropritorController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController gstNoController = TextEditingController();

  TextEditingController  name= TextEditingController();
  int currentStatus=0;

  getStatus(){
    FirebaseFirestore.instance.collection("vendor").doc(widget.userid).snapshots().listen((event) {
      currentStatus=event.data()!['status'];
    });
  }

  setSearchParam(String caseNumber) {
    List <String> caseSearchList = <String>[];
    String temp = "";

    List<String> nameSplits = caseNumber.split(" ");
    for (int i = 0; i < nameSplits.length; i++) {
      String name = "";

      for (int k = i; k < nameSplits.length; k++) {
        name = name + nameSplits[k] + " ";
      }
      temp = "";

      for (int j = 0; j < name.length; j++) {
        temp = temp + name[j];
        caseSearchList.add(temp.toUpperCase());
      }
    }
    return caseSearchList;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // getUser();
  }

  String uploadedFileUrl1='';

  List<String> documents = [
    "GST Certificate",
    "FSSAI Registration",
    "Udyam",
    "Shop & Establishment License",
    "Trade Certificate/Licence",
    "Other(Any ID or Document with Business Name)"
  ];
  String? dropdownValue1;

  TextEditingController job = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(child: SvgPicture.asset("assets/images/THARA LOGO WHITE.svg",width: w * 0.30,)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
                children: [
                  Stack(
                      children: [
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
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.05, top: h * 0.04),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(color: Colors.grey, blurRadius: 10)],
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            width: w * 0.90,
                            height: h * 0.8,
                            child: Padding(
                              padding: EdgeInsets.only(left: w*0.04,right: w*0.02,top: h*0.02,bottom: h*0.02),
                              child: SingleChildScrollView(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Seller Registration",
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                fontSize: 15, fontWeight: FontWeight.w500)),
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Divider(
                                        thickness: 4,
                                        endIndent: 30,
                                        color: Color(0xff530CAD),
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Text("CONTACT INFORMATION",
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700))),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: w*0.800 ,
                                            child: TextFormField(
                                              controller: name,

                                              decoration: InputDecoration(
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                suffixStyle: TextStyle(color: Colors.red),
                                                hintText:"Full name",
                                              ),
                                            ),
                                          ),
                                          Text("*",style: TextStyle(color: Colors.red),)
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: w * 0.8,
                                            child: TextFormField(
                                              controller: emailController,
                                              decoration: InputDecoration(
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                hintText: 'Email',

                                                suffixStyle: TextStyle(color: Colors.red),
                                              ),
                                            ),
                                          ),
                                          Text("*",style: TextStyle(color: Colors.red),)
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      SizedBox(
                                        height: h * 0.02,
                                      ),
                                      Text("COMPANY INFORMATION",
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700))),
                                      SizedBox(
                                        height: h * 0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: w * 0.8,
                                            child: TextFormField(
                                              controller: solePropritorController,
                                              decoration: InputDecoration(
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                suffixStyle: TextStyle(color: Colors.red),
                                                hintText: "Sole Proprietor/LLP/Partnership",
                                                hintStyle: TextStyle(color: Colors.grey,fontSize: 15),

                                              ),
                                            ),
                                          ),
                                          Text("*",style: TextStyle(color: Colors.red),)
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: w * 0.8,
                                            child: TextFormField(
                                              controller: organizationController,
                                              decoration: InputDecoration(
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                hintText: "Organization/Business Name",
                                                hintStyle: TextStyle(color: Colors.grey,fontSize: 15),


                                                suffixStyle: TextStyle(color: Colors.red),
                                              ),
                                            ),
                                          ),
                                          Text("*",style: TextStyle(color: Colors.red),)
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: w * 0.8,
                                            child: TextFormField(
                                              controller: companyAddressController,
                                              decoration: InputDecoration(
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                hintText: "Company Address",
                                                hintStyle: TextStyle(color: Colors.grey,fontSize: 15),


                                                suffixStyle: TextStyle(color: Colors.red),
                                              ),
                                            ),
                                          ),
                                          Text("*",style: TextStyle(color: Colors.red),)
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: w * 0.8,
                                            child: TextFormField(
                                              controller: cityController,
                                              decoration: InputDecoration(
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                hintText: "City",
                                                hintStyle: TextStyle(color: Colors.grey,fontSize: 15),


                                                suffixStyle: TextStyle(color: Colors.red),
                                              ),
                                            ),
                                          ),
                                          Text("*",style: TextStyle(color: Colors.red),)
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: w * 0.8,
                                            child: TextFormField(
                                              controller: stateController,
                                              decoration: InputDecoration(
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                hintText: "State",
                                                hintStyle: TextStyle(color: Colors.grey,fontSize: 15),


                                                suffixStyle: TextStyle(color: Colors.red),
                                              ),
                                            ),
                                          ),
                                          Text("*",style: TextStyle(color: Colors.red),)
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: w * 0.8,
                                            child: TextFormField(
                                              keyboardType: TextInputType.phone,
                                              autovalidateMode: AutovalidateMode.onUserInteraction,

                                              maxLength: 6,
                                              validator: (pin) {
                                                const pattern =
                                                    r'^[1-9][0-9]{5}$';
                                                final regExp=RegExp(pattern);
                                                if (pin!.isEmpty) {
                                                  return "";
                                                } else if (!regExp
                                                    .hasMatch(pin!)) {
                                                  return "pin code is not valid";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              controller: pincodeController,
                                              decoration: InputDecoration(
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                hintText: "Pincode",
                                                hintStyle: TextStyle(color: Colors.grey,fontSize: 15),


                                                suffixStyle: TextStyle(color: Colors.red),
                                              ),
                                            ),

                                          ),
                                          Text("*",style: TextStyle(color: Colors.red),)
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: w * 0.8,

                                            child: TextFormField(
                                              controller: gstNoController,
                                              decoration: InputDecoration(
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xff8C31FF))),
                                                hintText:
                                                "GST NO: Leave Empty.if you don't have one",
                                                hintStyle: TextStyle(color: Colors.grey,fontSize: 15),

                                                suffixStyle: TextStyle(color: Colors.red),
                                              ),
                                            ),
                                          ),
                                          Text("*",style: TextStyle(color: Colors.red),)
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.022,
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              width: w*0.8,
                                              child: DropdownButton<String>(
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    dropdownValue1 = newValue!;
                                                  });
                                                },
                                                value: dropdownValue1,style: TextStyle(fontSize: 8,color: Colors.black),
                                                // dropdownColor: Color(0xffDBB8FF),
                                                hint: Text('Select document type',style: TextStyle(color: Colors.grey,fontSize: 15),),
                                                items: documents
                                                    .map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: TextStyle(fontSize: 14),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                          Text("*",style: TextStyle(color: Colors.red),)
                                        ],
                                      ),

                                      SizedBox(
                                        height: h * 0.02,
                                      ),
                                      uploadedFileUrl1 == ''
                                          ? Container(
                                        width: w * 0.3,
                                        height: h * 0.13,
                                        decoration: BoxDecoration(
                                            color: Color(0xffE9E9E9),
                                            border: Border.all(
                                                color: Color(0xff530CAD))),
                                      )
                                          : Stack(
                                          clipBehavior: Clip.none,
                                          children:[ InkWell(onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Imageview(image:uploadedFileUrl1 ,)));
                                          },
                                            child: Container(
                                              width: w * 0.3,
                                              height: h * 0.13,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffE9E9E9),
                                                  border: Border.all(
                                                      color: Color(0xff530CAD))),
                                              child: Image.network(uploadedFileUrl1,fit: BoxFit.fill,),

                                            ),
                                          ),
                                            Positioned(
                                              left: w * 0.24,
                                              bottom: h * 0.10,
                                              child: InkWell(
                                                onTap: () {
                                                  uploadedFileUrl1 = '';
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: w * 0.07,
                                                  height: h * 0.05,
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: Color.fromARGB(255, 254, 253, 255),
                                                    size: 20,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff8C31FF),
                                                      shape: BoxShape.circle),
                                                ),
                                              ),
                                            ),
                                          ]
                                      ),

                                      SizedBox(
                                        height: h * 0.02,
                                      ),
                                      dropdownValue1==null?Container():Text(
                                        dropdownValue1!,
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.w400, fontSize: 13)),
                                      ),
                                      SizedBox(
                                        height: h * 0.02,
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          final selectedMedia = await selectMedia(
                                            maxWidth: 1080.00,
                                            maxHeight: 1320.00,
                                          );

                                          if (selectedMedia != null &&
                                              validateFileFormat(
                                                  selectedMedia.storagePath,
                                                  context)) {
                                            showUploadMessage(context, 'Uploading file...',);
                                            final downloadUrl = await uploadData(
                                                selectedMedia.storagePath,
                                                selectedMedia.bytes);
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            if (downloadUrl != null) {
                                              setState(() =>
                                              uploadedFileUrl1 = downloadUrl);
                                              showUploadMessage(
                                                  context, 'Success!');
                                            } else {
                                              showUploadMessage(context,
                                                  'Failed to upload media');
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: w ,
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
                                      Text("* Supported file types JPEG, PNG OR PDF ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff530CAD),
                                              fontSize: w*0.030)),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Text("* Upload Limit 1 MB",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff530CAD),fontSize: w*0.030)),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      TextButton(
                                        onPressed: () async {

                                          if (
                                          name.text != '' &&
                                              emailController.text != '' &&
                                              cityController.text != '' &&
                                              solePropritorController.text != '' &&
                                              organizationController.text != '' &&
                                              companyAddressController.text != '' &&
                                              pincodeController.text != ''&&uploadedFileUrl1!='') {

                                            AddressModel(
                                                solePropritor: solePropritorController.text,
                                                companyName: organizationController.text,
                                                address: companyAddressController.text,
                                                city: cityController.text,
                                                state: stateController.text,
                                                pincode: pincodeController.text,
                                                mobileNumber: vendorModel!.phone);
                                            // Map address={
                                            //   'solePropritor':solePropritorController.text,
                                            //   'companyName':organizationController.text,
                                            //   'address':companyAddressController.text,
                                            //   'city':cityController.text,
                                            //   'state':stateController.text,
                                            //   'pincode':pincodeController.text,
                                            //   "mobileNumber":currentUser?.phone
                                            // };

                                            var updateData = widget.userData!.copyWith(
                                              bankDetails: {
                                                'accountName':"",
                                                  'accountNumber':"",
                                                  'bankName':"",
                                                  'ifsc':"",
                                              },
                                              name:name.text ,
                                              email: emailController.text,
                                              brandList: [],
                                              photoUrl: uploadedFileUrl1,
                                              gstNo: gstNoController.text,
                                              categoryList: [],
                                              productList: [],
                                              status: 0,
                                              companyDetails:[AddressModel] ,
                                              document:dropdownValue1 ,
                                              // bankdetails: {
                                              //   'accountName':"",
                                              //   'accountNumber':"",
                                              //   'bankName':"",
                                              //   'ifsc':"",
                                              // },
                                              // search: setSearchParam(name.text.toUpperCase()+' '+'${currentUser?.phone}'),

                                            );
                                            FirebaseFirestore.instance
                                                .collection("vendor")
                                                .doc(vendorModel!.id)
                                                .update(updateData.toJson())
                                                .then((value) => {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Landing_Newseller(
                                                            userId: currentUser?.id,
                                                            userData: updateData,

                                                          )))
                                            });
                                          } else {
                                            showUploadMessage(
                                                context, "Please Fill All Fields");
                                          }
                                        },
                                        child: Container(
                                          width: w ,
                                          height: h * 0.05,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(17)),
                                            gradient: LinearGradient(colors: [
                                              Color(0xff8C31FF),
                                              Color(0xff601AB9)
                                            ]),
                                          ),
                                          child: Center(
                                              child: Text(
                                                "SUBMIT FOR APPROVAL ",
                                                style: TextStyle(color: Colors.white),
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(width: w*0.07,),
                                          Text(
                                            "By Continuing you agree to tharacart Terms and ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                                fontSize: w*0.030),
                                          ),
                                        ],
                                      ),


                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children: [
                                          Text(
                                            "Conditions & Privacy Policy",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                                fontSize: w*0.030),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.018,
                                      ),

                                    ]),
                              ),
                            ),
                          ),
                        )
                      ]),
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
