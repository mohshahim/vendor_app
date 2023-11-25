class AddressModel{
  String solePropritor;
  String companyName;
  String address;
  String city;
  String state;
  String pincode;
  String mobileNumber;

//<editor-fold desc="Data Methods">
  AddressModel({
    required this.solePropritor,
    required this.companyName,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.mobileNumber,
  });

  AddressModel copyWith({
    String? solePropritor,
    String? companyName,
    String? address,
    String? city,
    String? state,
    String? pincode,
    String? mobileNumber,
  }) {
    return AddressModel(
      solePropritor: solePropritor ?? this.solePropritor,
      companyName: companyName ?? this.companyName,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      mobileNumber: mobileNumber ?? this.mobileNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'solePropritor': this.solePropritor,
      'companyName': this.companyName,
      'address': this.address,
      'city': this.city,
      'state': this.state,
      'pincode': this.pincode,
      'mobileNumber': this.mobileNumber,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      solePropritor: map['solePropritor'] as String,
      companyName: map['companyName'] as String,
      address: map['address'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      pincode: map['pincode'] as String,
      mobileNumber: map['mobileNumber'] as String,
    );
  }

//</editor-fold>
}