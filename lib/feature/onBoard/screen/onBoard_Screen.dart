import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/theme/color.dart';
import '../../login/screen/login_screen.dart';
import '../../login/screen/splash.dart';

class SellerOnBoard extends StatefulWidget {
  const SellerOnBoard({Key? key}) : super(key: key);

  @override
  State<SellerOnBoard> createState() => _SellerOnBoardState();
}

class _SellerOnBoardState extends State<SellerOnBoard> {
  final controller=PageController();
  bool isLastPage=false;
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:  EdgeInsets.only(bottom:h*0.07),
          child: PageView(
            controller: controller,
            onPageChanged: (index){
              setState(() {
                isLastPage=index==2;

              });
            },
            children: [
              Container(
                color: primaryColor,
                child: Stack(
                  children: [
                    Container(
                      height: h / 3,
                      width: w / 1.5,
                      color: Colors.transparent,
                      child: Image.asset(
                        "assets/Group 452.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/onboard1.svg"),
                            SizedBox(height: h*0.01,),
                            Text(
                              "Be a Seller",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h*0.023,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                            ),
                            Divider(thickness: h*0.001,
                              indent: w*0.35,
                              endIndent: w*0.35,
                              color: Colors.white,),
                            Text(
                              "Easy Setup & Configurations",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontSize: h*0.02,
                                    color: Colors.white,
                                  )),
                            ),



                          ],
                        )),
                    Positioned(
                      top: h*0.7,
                      left: w/2.35,

                      child: SmoothPageIndicator(controller: controller, count: 3,
                        effect: ExpandingDotsEffect(
                            dotColor: Colors.white,
                            activeDotColor: Colors.white,
                            dotHeight: h*0.005,
                            dotWidth: w*0.02
                        ),),
                    )
                  ],
                ),
              ),
              Container(
                color: primaryColor,
                child: Stack(
                  children: [
                    Container(
                      height: h / 3,
                      width: w / 1.5,
                      color: Colors.transparent,
                      child: Image.asset(
                        "assets/Group 452.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/onboard2.svg"),
                            SizedBox(height: h*0.01,),
                            Text(
                              "Shipments",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h*0.023,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                            ),
                            Divider(thickness: h*0.001,
                              indent: w*0.35,
                              endIndent: w*0.35,
                              color: Colors.white,),
                            Text(
                              "Easy & Convenient Shipping Methods",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontSize: h*0.02,
                                    color:Colors.white,
                                  )),
                            ),

                          ],
                        )),
                    Positioned(
                      top: h*0.7,
                      left: w/2.35,

                      child: SmoothPageIndicator(controller: controller, count: 3,
                        effect: ExpandingDotsEffect(
                            dotColor: Colors.white,
                            activeDotColor: Colors.white,
                            dotHeight: h*0.005,
                            dotWidth: w*0.02
                        ),),
                    )
                  ],
                ),
              ),
              Container(
                color: primaryColor,
                child: Stack(
                  children: [
                    Container(
                      height: h / 3,
                      width: w / 1.5,
                      color: Colors.transparent,
                      child: Image.asset(
                        "assets/Group 452.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/onboard3.svg"),
                            SizedBox(height: h*0.01,),
                            Text(
                              "Save Time & Improve Sales",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h*0.023,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                            ),
                            Divider(thickness: h*0.001,
                              indent: w*0.12,
                              endIndent: w*0.12,
                              color: Colors.white,),
                            Text(
                              "Promote your products",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontSize: h*0.02,
                                    color:Colors.white,
                                  )),
                            ),

                          ],
                        )),
                    Positioned(
                      top: h*0.7,
                      left: w/2.35,

                      child: SmoothPageIndicator(controller: controller, count: 3,
                        effect: ExpandingDotsEffect(
                            dotColor: Colors.white,
                            activeDotColor: Colors.white,
                            dotHeight: h*0.005,
                            dotWidth: w*0.02
                        ),),
                    )
                  ],
                ),
              ),

            ],
          ),

        ),

      ),
      bottomSheet:isLastPage?
      Container(
        padding: EdgeInsets.symmetric(horizontal: w*0.01),
        // height: h*0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
            }, child:  Text(
              "Skip",
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: h*0.02,
                      color: primaryColor,
                      fontWeight: FontWeight.w700)),
            ),),
            TextButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
            }, child:  Text(
              "Next",
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: h*0.02,
                      color: primaryColor,
                      fontWeight: FontWeight.w700)),
            ),)

          ],),
      )
          :
      Container(
        padding: EdgeInsets.symmetric(horizontal: w*0.01),
        // height: h*0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
            }, child:  Text(
              "Skip",
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: h*0.02,
                      color: primaryColor,
                      fontWeight: FontWeight.w700)),
            ),),
            TextButton(onPressed: (){
              controller.nextPage(duration:Duration(microseconds: 500), curve: Curves.easeInOut);

            }, child:  Text(
              "Next",
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: h*0.02,
                      color: primaryColor,
                      fontWeight: FontWeight.w700)),
            ),)

          ],),
      ) ,
    );
  }
}
