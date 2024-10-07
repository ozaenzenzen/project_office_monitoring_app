class GetListLogRequestModel {
    DateTime? startDate;
    DateTime? endDate;
    int? limit;
    int? currentPage;
    String? location;

    GetListLogRequestModel({
        this.startDate,
        this.endDate,
        this.limit,
        this.currentPage,
        this.location,
    });

    factory GetListLogRequestModel.fromJson(Map<String, dynamic> json) => GetListLogRequestModel(
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        limit: json["limit"],
        currentPage: json["current_page"],
        location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "limit": limit,
        "current_page": currentPage,
    };

    Map<String, dynamic> toJsonWithLocation() => {
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "limit": limit,
        "current_page": currentPage,
        "location": location,
    };
}


// {
//     "start_date": "2024-08-01",
//     "end_date": "2024-10-06",
//     "limit": 5,
//     "current_page": 1
// }