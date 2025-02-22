class BookCategoryModel {
  int id = 0;
  String name = "no name";
  String image = "no image";
  BookCategoryModel({
    this.id = 0,
    this.name = "no name",
    this.image = "no image",
  });
}

List<BookCategoryModel> bookCategoryModelList = [
  BookCategoryModel(
    id: 0,
    name: "ទាំងអស់",
    image:
        'https://elibrary.maff.gov.kh/assets/images/book-categories/b4c5b2ec5fd39f48fa674a6e322e08cc1702627902.jpg',
  ),
  BookCategoryModel(
    id: 1,
    name: "ការដាំដំណាំ",
    image:
        'https://elibrary.maff.gov.kh/assets/images/book-categories/b4c5b2ec5fd39f48fa674a6e322e08cc1702627902.jpg',
  ),
  BookCategoryModel(
    id: 2,
    name: "ការចិញ្ចឹមសត្វ",
    image:
        'https://elibrary.maff.gov.kh/assets/images/book-categories/dac6cab695799c4f95f31bb715899c1c1699127373.jpg',
  ),
  BookCategoryModel(
    id: 3,
    name: "វារីវប្បកម្ម",
    image:
        'https://elibrary.maff.gov.kh/assets/images/book-categories/101b9c279e00ba341c1ee022e192ede01704185754.jpg',
  ),
  BookCategoryModel(
    id: 4,
    name: "ការផលិតជី",
    image:
        'https://elibrary.maff.gov.kh/assets/images/book-categories/f3ccdd27d2000e3f9255a7e3e2c488001737961885.jpg',
  ),
  BookCategoryModel(
    id: 5,
    name: "ថ្នាំកសិកម្ម",
    image:
        'https://elibrary.maff.gov.kh/assets/images/book-categories/62947d2c96b0ca28e0fadaecee163ca11737961688.png',
  ),
];
