class CompanyDataEntity {
  String? companyStamp;
  String? companyName;
  String? companyEmail;
  String? companyPhone;
  String? picture;
  String? city;
  String? state;
  String? zip;
  String? address;
  String? information;

  CompanyDataEntity({
    this.companyStamp,
    this.companyName,
    this.companyEmail,
    this.companyPhone,
    this.picture,
    this.city,
    this.state,
    this.zip,
    this.address,
    this.information,
  });

  CompanyDataEntity.toLocal({
    this.companyStamp,
    this.companyName,
    this.companyEmail,
    this.companyPhone,
    this.picture,
    this.city,
    this.state,
    this.zip,
    this.address,
    this.information,
  });

  factory CompanyDataEntity.fromJson(Map<String, dynamic> json) => CompanyDataEntity(
        companyStamp: json["company_stamp"],
        companyName: json["company_name"],
        companyEmail: json["company_email"],
        companyPhone: json["company_phone"],
        picture: json["picture"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        address: json["address"],
        information: json["information"],
      );

  Map<String, dynamic> toJson() => {
        "company_stamp": companyStamp,
        "company_name": companyName,
        "company_email": companyEmail,
        "company_phone": companyPhone,
        "picture": picture,
        "city": city,
        "state": state,
        "zip": zip,
        "address": address,
        "information": information,
      };
}
