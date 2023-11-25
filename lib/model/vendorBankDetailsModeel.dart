class BankDetails{
  String? accountName;
  String? accountNumber;
  String? bankname;
  String? ifsc;

//<editor-fold desc="Data Methods">
  BankDetails({
    this.accountName,
    this.accountNumber,
    this.bankname,
    this.ifsc,
  });


  BankDetails copyWith({
    String? accountName,
    String? accountNumber,
    String? bankname,
    String? ifsc,
  }) {
    return BankDetails(
      accountName: accountName ?? this.accountName,
      accountNumber: accountNumber ?? this.accountNumber,
      bankname: bankname ?? this.bankname,
      ifsc: ifsc ?? this.ifsc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accountName': this.accountName,
      'accountNumber': this.accountNumber,
      'bankname': this.bankname,
      'ifsc': this.ifsc,
    };
  }

  factory BankDetails.fromMap(Map<String, dynamic> map) {
    return BankDetails(
      accountName: map['accountName'] as String,
      accountNumber: map['accountNumber'] as String,
      bankname: map['bankname'] as String,
      ifsc: map['ifsc'] as String,
    );
  }

//</editor-fold>
}