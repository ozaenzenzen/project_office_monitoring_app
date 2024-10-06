class GetListLocationDataEntity {
  String? location;

  GetListLocationDataEntity({
    this.location,
  });

  factory GetListLocationDataEntity.fromJson(Map<String, dynamic> json) => GetListLocationDataEntity(
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "location": location,
      };
}
