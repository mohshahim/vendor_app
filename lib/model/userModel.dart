
import 'package:cloud_firestore/cloud_firestore.dart';

UserModel? currentUser;

class UserModel {
  List search;
  String profileUrl;
  int displayStatus;
  String freeshippingAmount;
  String sellerWiseFlatRateShipping;
  String flatRateAmount;
  bool cashOnDelivery;
  String orderReturnAge;
  String orderCancellationAge;
  String shipmentTime;
  String invoiceNumber;
  String signature;
  String logo;
  String bannerVideo;
  String bannerImage;
  String paymentPolicy;
  String deliveryPolicy;
  DateTime? resetInvoiceNumber;
  DocumentReference? reference;
  String Fullname;
  String id;
  String phone;
  String email;
  String document;
  String companyDescription;
  List brandList;
  List categoryList;
  List productList;
  Map<String, dynamic> bankdetails;
  List companyDetails;
  String photoUrl;
  dynamic gstNo;
  int status;
  DateTime date;

  UserModel(
      {
        this.reference,
        required this.Fullname,
        required this.profileUrl,
        required this.search,
        required this.id,
        required this.phone,
        required this.email,
        required this.photoUrl,
        required this.gstNo,
        required this.status,
        required this.bankdetails,
        required this.companyDescription,
        required this.brandList,
        required this.categoryList,
        required this.companyDetails,
        required this.document,
        required this.date,
        required this.displayStatus,
        required this.freeshippingAmount,
        required this.sellerWiseFlatRateShipping,
        required this.flatRateAmount,
        required this.cashOnDelivery,
        required this.orderReturnAge,
        required this.orderCancellationAge,
        required this.shipmentTime,
        required this.invoiceNumber,
        required this.logo,
        required this.productList,
        required this.signature,
        required this.bannerVideo,
        required this.bannerImage,
        required this.paymentPolicy,
        this.resetInvoiceNumber,
        required this.deliveryPolicy
      });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      reference:json['reference']  as DocumentReference,
      search:json['search'] as List,
      profileUrl:json['profileUrl'] as String,
      displayStatus:int.tryParse(json['displayStatus']) as int,
      freeshippingAmount:json['freeshippingAmount'] as String,
      sellerWiseFlatRateShipping:json['sellerWiseFlatRateShipping'] as String,
      flatRateAmount:json['flatRateAmount'] as String,
      cashOnDelivery:json['cashOnDelivery'] as bool,
      orderReturnAge:json['orderReturnAge'] as String,
      orderCancellationAge:json['orderCancellationAge'] as String,
      shipmentTime:json['shipmentTime'] as String,
      invoiceNumber:json['invoiceNumber'] as String,
      signature:json['signature'] as String,
      logo:json['logo'] as String,
      bannerVideo:json['bannerVideo'] as String,
      bannerImage:json['bannerImage'] as String,
      paymentPolicy:json['paymentPolicy'] as String,
      deliveryPolicy:json['deliveryPolicy'] as String,
      resetInvoiceNumber:DateTime.tryParse(json['resetInvoiceNumber']) as DateTime,
      Fullname:json['Fullname'] as String,
      id:json['id'] as String,
      phone:json['phone'] as String,
      email:json['email'] as String,
      document:json['document'] as String,
      companyDescription:json['companyDescription'] as String,
      brandList:json['brandList'] as List,
      categoryList:json['categoryList'] as List,
      productList:json['productList'] as List,
      bankdetails:(json['bankdetails'] as Map<String, dynamic>?)!,
      companyDetails:json['companyDetails'] as List,
      photoUrl:json['photoUrl'] as String,
      gstNo:json['gstNo'] as dynamic,
      status:int.tryParse(json['status']) as int,
      date:DateTime.tryParse(json['date'] )as DateTime,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = Fullname ?? "";
    data["reference"]=reference;
    data["profileUrl"] = profileUrl ?? "";
    data["id"] = id ?? "";
    data["phone"] = phone ?? "";
    data["email"] = email ?? "";
    data["photoUrl"] = photoUrl ?? "";
    data["gstNo"] = gstNo ?? "";
    data["status"] = status ?? 0;
    data["companyDescription"] = companyDescription ?? "";
    data["bankDetails"] = bankdetails ?? {};
    data["brandList"] = brandList ?? [];
    data["categoryList"] = categoryList ?? [];
    data["productList"] = productList ?? [];
    data["search"] = search ?? [];
    data["companyDetails"] = companyDetails ?? [];
    data["date"]=date??DateTime.now();
    data["document"] = document ?? '';
    data["orderReturnAge"] = orderReturnAge ?? "";
    data["cashOnDelivery"] = cashOnDelivery ?? false;
    data["paymentPolicy"] = paymentPolicy ?? "";
    data["deliveryPolicy"] = deliveryPolicy ?? "";
    data["logo"] = logo ?? "";
    data["bannerVideoUrl"] = bannerVideo ?? "";
    data["bannerImage"] = bannerImage ?? "";
    data["orderCancellationAge"] = orderCancellationAge ?? "";
    data["shipmentTime"] = shipmentTime ?? "";
    data["displayStatus"] = displayStatus ?? 0;
    data["invoiceNumber"] = invoiceNumber ?? "";
    data["resetInvoiceNumber"] = resetInvoiceNumber ?? "";
    data["flatRateAmount"] = flatRateAmount ?? "";
    data["flatshippingAmount"] = freeshippingAmount ?? "";
    data["sellerWiseFlatRateShipping"] = sellerWiseFlatRateShipping ?? "";
    data["signature"] = signature ?? "";
    data["resetInvoiceNumber"] = resetInvoiceNumber??DateTime.now();



    return data;
  }

  UserModel copyWith({
    int? displayStatus,
    String? freeshippingAmount,
    String? sellerWiseFlatRateShipping,
    String? flatRateAmount,
    bool? cashOnDelivery,
    String? orderReturnAge,
    String? orderCancellationAge,
    String? shipmentTime,
    String? invoiceNumber,
    String? signature,
    String? logo,
    String? bannerVideo,
    String? bannerImage,
    String? paymentPolicy,
    String? deliveryPolicy,
    DateTime? resetInvoiceNumber,
    String? Fullname,
    String? profileUrl,
    String? id,
    String? phone,
    String? email,
    String? city,
    String? state,
    String? pincode,
    String? Soleproprietor,
    String? Organization,
    String? CompanyAddress,
    String? photoUrl,
    dynamic gstNo,
    List? brandList,
    List? search,
    List? categoryList,
    int? status,
    // String?countryCode,
    String? companyDescription,
    Map<String, dynamic>? bankdetails,
    List? companyDetails,
    List? productList,
    String? document,
    DateTime? date,
  }) {
    return UserModel(
      reference: reference??this.reference,
      Fullname: Fullname ?? this.Fullname,
      profileUrl: profileUrl ?? this.profileUrl,
      id: id ?? this.id,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      gstNo: gstNo ?? this.gstNo,
      status: status ?? this.status,
      companyDescription: companyDescription ?? this.companyDescription,
      brandList: brandList ?? this.brandList,
      categoryList: categoryList ?? this.categoryList,
      productList: productList ?? this.productList,
      companyDetails: companyDetails??this.companyDetails,
      bankdetails: bankdetails ?? this.bankdetails,
      document: document ?? this.document,
      search: search ?? this.search,
      date: date??this.date,
      displayStatus: displayStatus ?? this.displayStatus,
      freeshippingAmount: freeshippingAmount ?? this.freeshippingAmount,
      sellerWiseFlatRateShipping:
      sellerWiseFlatRateShipping ?? this.sellerWiseFlatRateShipping,
      flatRateAmount: flatRateAmount ?? this.flatRateAmount,
      orderReturnAge: orderReturnAge ?? this.orderReturnAge,
      orderCancellationAge: orderCancellationAge ?? this.orderCancellationAge,
      shipmentTime: shipmentTime ?? this.shipmentTime,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      logo: logo ?? this.logo,
      bannerVideo: bannerVideo ?? this.bannerVideo,
      bannerImage: bannerImage ?? this.bannerImage,
      signature: signature ?? this.signature,
      paymentPolicy: paymentPolicy ?? this.paymentPolicy,
      deliveryPolicy: deliveryPolicy ?? this.deliveryPolicy,
      resetInvoiceNumber: resetInvoiceNumber ?? this.resetInvoiceNumber,
      cashOnDelivery:cashOnDelivery?? this.cashOnDelivery,
    );
  }

}

