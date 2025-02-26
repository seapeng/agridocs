import 'dart:convert';

VideoCategoryModel bookCategoryModelFromJson(String str) =>
    VideoCategoryModel.fromJson(json.decode(str));
String bookCategoryModelToJson(VideoCategoryModel data) =>
    json.encode(data.toJson());

class VideoCategoryModel {
  late bool success;
  late String message;
  late Data data;

  VideoCategoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  VideoCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (success) {
      message = json['message'];
      data = Data.fromJson(json['data']);
    } else {
      message = json['message'];
      data = Data(
        categories: [],
        totalRecords: 0,
        totalPages: 0,
        currentPage: 0,
        allowNext: false,
        allowPrevious: false,
        nextPage: 0,
        previousPage: 0,
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  late List<Categories> categories;
  late int totalRecords;
  late int totalPages;
  late int currentPage;
  late bool allowNext;
  late bool allowPrevious;
  late int nextPage;
  late int previousPage;

  Data({
    required this.categories,
    required this.totalRecords,
    required this.totalPages,
    required this.currentPage,
    required this.allowNext,
    required this.allowPrevious,
    required this.nextPage,
    required this.previousPage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    categories =
        List<Categories>.from(json['books'].map((x) => Categories.fromJson(x)));
    totalRecords = json['totalRecords'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    allowNext = json['allowNext'];
    allowPrevious = json['allowPrevious'];
    nextPage = json['nextPage'];
    previousPage = json['previousPage'];
  }

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "totalRecords": totalRecords,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "allowNext": allowNext,
        "allowPrevious": allowPrevious,
        "nextPage": nextPage,
        "previousPage": previousPage,
      };
}

class Categories {
  int id;
  String name;

  Categories({
    required this.id,
    required this.name,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"] ?? 0,
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
