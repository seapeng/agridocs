import 'dart:convert';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));
String bookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
  late bool success;
  late String message;
  late Data data;

  BookModel({
    required this.success,
    required this.message,
    required this.data,
  });

  BookModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (success) {
      message = json['message'];
      data = Data.fromJson(json['data']);
    } else {
      message = json['message'];
      data = Data(
        books: [],
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
  late List<Books> books;
  late int totalRecords;
  late int totalPages;
  late int currentPage;
  late bool allowNext;
  late bool allowPrevious;
  late int nextPage;
  late int previousPage;

  Data({
    required this.books,
    required this.totalRecords,
    required this.totalPages,
    required this.currentPage,
    required this.allowNext,
    required this.allowPrevious,
    required this.nextPage,
    required this.previousPage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    books = List<Books>.from(json['books'].map((x) => Books.fromJson(x)));
    totalRecords = json['totalRecords'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    allowNext = json['allowNext'];
    allowPrevious = json['allowPrevious'];
    nextPage = json['nextPage'];
    previousPage = json['previousPage'];
  }

  Map<String, dynamic> toJson() => {
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
        "totalRecords": totalRecords,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "allowNext": allowNext,
        "allowPrevious": allowPrevious,
        "nextPage": nextPage,
        "previousPage": previousPage,
      };
}

class Books {
  int id;
  String code;
  String title;
  String author;
  DateTime issued;
  int page;
  String isbn;
  String issn;
  String image;
  int viewer;
  String ebook;
  int bookCategoryId;
  int languageId;
  Language language;
  BookCategory bookCategory;

  Books({
    required this.id,
    required this.code,
    required this.title,
    required this.author,
    required this.issued,
    required this.page,
    required this.isbn,
    required this.issn,
    required this.image,
    required this.viewer,
    required this.ebook,
    required this.bookCategoryId,
    required this.languageId,
    required this.language,
    required this.bookCategory,
  });

  factory Books.fromJson(Map<String, dynamic> json) => Books(
        id: json["id"] ?? 0,
        code: json["code"],
        title: json["title"],
        author: json["author"],
        issued: DateTime.parse(json['issued']),
        page: json['page'] ?? 0,
        isbn: json["isbn"],
        issn: json["issn"],
        image: json["image"],
        viewer: json["viewer"] ?? 0,
        ebook: json["ebook"],
        bookCategoryId: json["bookCategoryId"],
        languageId: json["languageId"],
        language: Language.fromJson(json["language"]),
        bookCategory: BookCategory.fromJson(json["bookCategory"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "title": title,
        "author": author,
        "issued": issued.toString(),
        "page": page.toString(),
        "isbn": isbn,
        "issn": issn,
        "image": image,
        "viewer": viewer.toString(),
        "ebook": ebook,
        "bookCategoryId": bookCategoryId,
        "languageId": languageId,
        "language": language.toJson(),
        "bookCategory": bookCategory.toJson(),
      };
}

class Language {
  late int id;
  late String name;

  Language({
    required this.id,
    required this.name,
  });

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class BookCategory {
  late int id;
  late String name;

  BookCategory({
    required this.id,
    required this.name,
  });

  BookCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
