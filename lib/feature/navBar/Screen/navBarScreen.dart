
import 'package:bottom_bar/bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/color.dart';
import '../../../main.dart';
import '../../../model/userModel.dart';
import '../../login/screen/login_screen.dart';

Map brandIdtoName = {};
//TabController? tabController;

Map brandNametoId = {};
List<String> brand1 = [];
Map categoryNametoId = {};
Map catIdToName = {};

List<String> categoryList = [];
Map parentCategoryNametoId = {};
Map parentCatIdToName = {};
List<String> parentCategoryList = [];

var bottomNavigatorKey = GlobalKey<State<BottomNavigationBar>>();

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  static  final List<Widget> _widgetOptions = <Widget>[
    //TODO
    // Tabbar(),
    // Tabbar(),
    // ManageRequest(),    //reportTab(),
    // Manage(),
    // Account()


  ];
  getUser() async {
    FirebaseFirestore.instance
        .collection('vendor').doc(Id)
    // .where("id", isEqualTo:currentUser?.id)
        .snapshots()
        .listen((event) {

      currentUser = UserModel.fromJson(event.data()??{});

      if (mounted) {
        setState(() {});
      }
    });

  }
  getBrand() {
    FirebaseFirestore.instance
        .collection("brands")
        .where('vendorId', isEqualTo: currentUser?.id)
        .get()
        .then((value) {
      brand1=[];
      for (DocumentSnapshot doc in value.docs) {
        brandNametoId[doc.get("brand")] = doc.id;
        brandIdtoName[doc.id]=doc['brand'];
        brand1.add(doc['brand']);
      }
      setState(() {});

    });

  }

  getCategory() {
    FirebaseFirestore.instance
        .collection("category")
        .where('vendorId', isEqualTo: currentUser?.id)
        .get()
        .then((value) {
      categoryList=[];
      for (DocumentSnapshot doc in value.docs) {
        categoryList.add(doc['name']);
        categoryNametoId[doc.get("name")] = doc.id;
        catIdToName[doc.id]=doc['name'];
      }
      setState(() {});
    });
  }
  getParentCategory(){
    FirebaseFirestore.instance
        .collection("category").where("status",isEqualTo: 1).where("delete",isEqualTo: false)

        .get()
        .then((value) {
      parentCategoryList=[];
      for (DocumentSnapshot doc in value.docs) {
        parentCategoryList.add(doc['name']);
        parentCategoryNametoId[doc.get("name")] = doc.id;
        parentCatIdToName[doc.id]=doc['name'];
      }
      setState(() {});
    });

  }
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getUser();
    getCategory();
    getBrand();
    getParentCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("THSR"),
      ),
    );

//TODO
    //     body: Center(
    //       child: _widgetOptions.elementAt(selectedIndex),
    //     ),
    //     bottomNavigationBar: BottomBar(
    //       itemPadding: EdgeInsets.fromLTRB(8,8,8,8),
    //       height: w*0.18,
    //       border: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(5)),
    //       backgroundColor: primaryColor,
    //       selectedIndex: selectedIndex,
    //       onTap: (index) {
    //         setState(() {
    //           selectedIndex = index;
    //           //TODO
    //           // index==0?tabController!.animateTo(0):index==1?tabController!.animateTo(1):index;
    //
    //
    //         });
    //       },
    //       items: [
    //         BottomBarItem(
    //           backgroundColorOpacity: 0.9,
    //           icon: selectedIndex != 0?Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               SvgPicture.asset('assets/images/bottamDash.svg',color: selectedIndex == 0 ?  primaryColor:Colors.white,),
    //               Text('Dashboard',style: TextStyle(color: Colors.white,fontSize: h*0.01),),
    //             ],
    //           ):
    //           SvgPicture.asset('assets/images/bottamDash.svg',color: selectedIndex == 0 ?  primaryColor:Colors.white,),
    //           title: Text('Dashboard',style:GoogleFonts.poppins(fontSize: w*0.03,fontWeight: FontWeight.w600,color: primaryColor)),
    //           activeColor: Colors.white,
    //         ),
    //         BottomBarItem(
    //           backgroundColorOpacity: 0.9,
    //           icon:selectedIndex != 1? Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               SvgPicture.asset('assets/images/bottomOrder.svg',color: selectedIndex == 1 ?  primaryColor:Colors.white,),
    //
    //               Text('Orders',style: TextStyle(color: Colors.white,fontSize: h*0.01),),
    //             ],
    //           ): SvgPicture.asset('assets/images/bottomOrder.svg',color: selectedIndex == 1 ?  primaryColor:Colors.white,),
    //           title: Text('Orders',style:GoogleFonts.poppins(fontSize: w*0.03,fontWeight: FontWeight.w600,color: primaryColor)),
    //           activeColor:  Colors.white,
    //         ),
    //         BottomBarItem(
    //           backgroundColorOpacity: 0.9,
    //           icon: selectedIndex != 2?Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               SvgPicture.asset('assets/images/bottomRequest.svg',color: selectedIndex == 2 ?  primaryColor:Colors.white),
    //               Text('Request',style: TextStyle(color: Colors.white,fontSize: h*0.01),),
    //             ],
    //           ):SvgPicture.asset('assets/images/bottomRequest.svg',color: selectedIndex == 2 ?  primaryColor:Colors.white),
    //           title: Text('Request',style:GoogleFonts.poppins(fontSize: w*0.03,fontWeight: FontWeight.w600,color: primaryColor)),
    //           activeColor:  Colors.white,
    //         ),
    //         BottomBarItem(
    //           backgroundColorOpacity: 0.9,
    //           icon: selectedIndex != 3?Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               SvgPicture.asset('assets/images/bottamManage.svg',color: selectedIndex == 3 ?  primaryColor:Colors.white),
    //               Text('Manage',style: TextStyle(color: Colors.white,fontSize: h*0.01),),
    //             ],
    //           ): SvgPicture.asset('assets/images/bottamManage.svg',color: selectedIndex == 3 ?  primaryColor:Colors.white),
    //           title: Text('Manage',style:GoogleFonts.poppins(fontSize: w*0.03,fontWeight: FontWeight.w600,color: primaryColor)),
    //           activeColor:  Colors.white,
    //         ),
    //         BottomBarItem(backgroundColorOpacity: 0.9,
    //           icon: selectedIndex != 4?Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               SvgPicture.asset('assets/images/bottomAcc.svg',color: selectedIndex == 4 ?  primaryColor:Colors.white),
    //               Text('Account',style: TextStyle(color: Colors.white,fontSize: h*0.01),),
    //             ],
    //           ): SvgPicture.asset('assets/images/bottomAcc.svg',color: selectedIndex == 4 ?  primaryColor:Colors.white),
    //           title: Text('Account',style:GoogleFonts.poppins(fontSize: w*0.03,fontWeight: FontWeight.w600,color:primaryColor)),
    //           activeColor: Colors.white,
    //         ),
    //       ],
    //     ),
    //   );
    // }
  }
}