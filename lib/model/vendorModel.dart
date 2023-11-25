
import 'package:cloud_firestore/cloud_firestore.dart';

VendorModel? vendorModel;

class VendorModel{
  Map bankDetails;
  String bannerImage;
  String videoUrl;
  List brandList;
  bool cashOnDelivery;
  List categoryList;
  String companyDescription;
  List companyDetails;
  DateTime date;
  String deliveryPolicy;
  int displayStatus;
  String document;
  String email;
  String flatRateAmount;
  String gstNo;
  String id;
  String invoiceNumber;
  String logo;
  String name;
  String orderCancellationAge;
  String orderReturnAge;
  String paymentPolicy;
  String phone;
  String photoUrl;
  List productList;
  String profileUrl;
  DateTime? resetInvoiceNumber;
  String sellerWiseFlatRateShipping;
  String shipmentTime;
  String signature;
  int status;
  DocumentReference? reference;

  VendorModel({
    required this.bankDetails,
    required this.bannerImage,
    required this.videoUrl,
    required this.brandList,
    required this.cashOnDelivery,
    required this.categoryList,
    required this.companyDescription,
    required this.companyDetails,
    required this.date,
    required this.deliveryPolicy,
    required this.displayStatus,
    required this.document,
    required this.email,
    required this.flatRateAmount,
    required this.gstNo,
    required this.id,
    required this.invoiceNumber,
    required this.logo,
    required this.name,
    required this.orderCancellationAge,
    required this.orderReturnAge,
    required this.paymentPolicy,
    required this.phone,
    required this.photoUrl,
    required this.productList,
    required this.profileUrl,
    this.resetInvoiceNumber,
    required this.sellerWiseFlatRateShipping,
    required this.shipmentTime,
    required this.signature,
    required this.status,
    this.reference,
  });

 factory  VendorModel.fromJson(Map<String, dynamic> json) {
return VendorModel(
    bankDetails:json['bankDetails'] as Map,
    bannerImage:json['bannerImage'] as String,
    videoUrl:json['videoUrl'] as String,
    brandList:json['brandList'] as List,
    cashOnDelivery:json['cashOnDelivery'] as bool,
    categoryList:json['categoryList'] as List,
    companyDescription:json['companyDescription'] as String,
    companyDetails:json['companyDetails'] as List,
    date:DateTime.tryParse(json['date']) as DateTime,
    deliveryPolicy:json['deliveryPolicy'] as String,
    displayStatus:DateTime.tryParse(json['displayStatus']) as int,
    document:json['document'] as String,
    email:json['email'] as String,
    flatRateAmount:json['flatRateAmount'] as String,
    gstNo:json['gstNo'] as String,
    id:json['id'] as String,
    invoiceNumber:json['invoiceNumber'] as String,
    logo:json['logo'] as String,
    name:json['name'] as String,
    orderCancellationAge:json['orderCancellationAge'] as String,
    orderReturnAge:json['orderReturnAge'] as String,
    paymentPolicy:json['paymentPolicy'] as String,
    phone:json['phone'] as String,
    photoUrl:json['photoUrl'] as String,
    productList:json['productList'] as List,
    profileUrl:json['profileUrl'] as String,
    resetInvoiceNumber:DateTime.tryParse(json['resetInvoiceNumber']) as DateTime,
    sellerWiseFlatRateShipping:json['sellerWiseFlatRateShipping'] as String,
    shipmentTime:json['shipmentTime'] as String,
    signature:json['signature'] as String,
    status:int.tryParse(json['status']) as int,
    reference:json['reference'] as DocumentReference,
);
  }

  Map<String, dynamic> toJson() {

    final Map<String,dynamic> data = Map<String,dynamic>();

      data['bankDetails']=bankDetails??{};
      data['bannerImage']=bannerImage??"";
      data['videoUrl']=videoUrl??"";
      data['brandList']=brandList??[];
      data['cashOnDelivery']=cashOnDelivery??false;
      data['categoryList']=categoryList??[];
      data['companyDescription']=companyDescription??"";
      data['companyDetails']=companyDetails??[];
      data['date']=date??DateTime.now();
      data['deliveryPolicy']=deliveryPolicy??'';
      data['displayStatus']=displayStatus??0;
      data['document']=document??'';
      data['email']=email??"";
      data['flatRateAmount']=flatRateAmount??"";
      data['gstNo']=gstNo??"";
      data['id']=id??"";
      data['invoiceNumber']=invoiceNumber??"";
      data['logo']=logo??"";
      data['name']=name??"";
      data['orderCancellationAge']=orderCancellationAge??"";
      data['orderReturnAge']=orderCancellationAge??"";
      data['paymentPolicy']=paymentPolicy??"";
    data['phone']=phone??"";
    data['photoUrl']=photoUrl??"";
    data['productList']=productList??[];
    data['profileUrl']=profileUrl??"";
    data['resetInvoiceNumber']=resetInvoiceNumber??DateTime.now();
    data['sellerWiseFlatRateShipping']=sellerWiseFlatRateShipping??"";
    data['shipmentTime']=shipmentTime??"";
    data['signature']=signature??"";
    data['status']=status??0;
    data['reference']=reference;

    return data;

  }

  VendorModel copyWith({
    Map? bankDetails,
    String? bannerImage,
    String? videoUrl,
    List? brandList,
    bool? cashOnDelivery,
    List? categoryList,
    String? companyDescription,
    List? companyDetails,
    DateTime? date,
    String? deliveryPolicy,
    int? displayStatus,
    String?document,
    String? email,
    String? flatRateAmount,
    String? gstNo,
    String? id,
    String? invoiceNumber,
    String? logo,
    String? name,
    String? orderCancellationAge,
    String? orderReturnAge,
    String? paymentPolicy,
    String? phone,
    String? photoUrl,
    List? productList,
    String? profileUrl,
    DateTime? resetInvoiceNumber,
    String? sellerWiseFlatRateShipping,
    String? shipmentTime,
    String? signature,
    int? status,
    DocumentReference? reference,
}){
    return VendorModel(bankDetails: bankDetails??this.bankDetails,
        bannerImage: bannerImage??this.bannerImage,
        videoUrl: videoUrl??this.videoUrl,
        brandList: brandList??this.brandList,
        cashOnDelivery: cashOnDelivery??this.cashOnDelivery,
        categoryList: categoryList??this.categoryList,
        companyDescription: companyDescription??this.companyDescription,
        companyDetails: companyDetails??this.companyDetails,
        date: date??this.date,
        deliveryPolicy: deliveryPolicy??this.deliveryPolicy,
        displayStatus: displayStatus??this.displayStatus,
        document: document??this.document,
        email: email??this.email,
        flatRateAmount: flatRateAmount??this.flatRateAmount,
        gstNo: gstNo??this.gstNo,
        id: id??this.id,
        invoiceNumber: invoiceNumber??this.invoiceNumber,
        logo: logo??this.logo,
        name: name??this.name,
        orderCancellationAge: orderCancellationAge??this.orderCancellationAge,
        orderReturnAge: orderReturnAge??this.orderReturnAge,
        paymentPolicy: paymentPolicy??this.paymentPolicy,
        phone: phone??this.phone,
        photoUrl: photoUrl??this.photoUrl,
        productList: productList??this.productList,
        profileUrl: profileUrl??this.profileUrl,
        resetInvoiceNumber: resetInvoiceNumber??this.resetInvoiceNumber,
        sellerWiseFlatRateShipping: sellerWiseFlatRateShipping??this. sellerWiseFlatRateShipping,
        shipmentTime: shipmentTime??this.shipmentTime,
        signature: signature??this.signature,
        status: status??this.status,
        reference: reference??this.reference,
    );
  }

}