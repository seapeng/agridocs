class BookModel {
  int id = 0;
  String code = "no code";
  String title = "no title";
  String author = "no author";
  DateTime issued;
  int pages = 0;
  String isbn = "no isbn";
  String issn = "no issn";
  String image = "no image";
  int viewer = 0;

  BookModel({
    this.id = 0,
    this.code = "no code",
    this.title = "no title",
    this.author = "no author",
    required this.issued,
    this.pages = 0,
    this.isbn = "no isbn",
    this.issn = "no issn",
    this.image = "no image",
    this.viewer = 0,
  });
}

List<BookModel> BookModelList = [
  BookModel(
    id: 1,
    code: '001',
    title: "ទស្សនាវដ្តីខេត្តព្រះវិហារ២០២៣",
    author: 'SOVANN',
    issued: DateTime.now(),
    pages: 10,
    isbn: '123456789',
    issn: '987654321',
    image: 'https://elibrary.maff.gov.kh/assets/images/books/7a4e785f95a8f5057e4c8662d188da3b1717489610.jpg',
    viewer: 100,
  ),
  BookModel(
    id: 2,
    code: '002',
    title: "ជំងឺដុំពកស្បែកគោ",
    author: 'VANNA',
    issued: DateTime.now(),
    pages: 15,
    isbn: '123456789',
    issn: '987654321',
    image: 'https://elibrary.maff.gov.kh/assets/images/books/dcbdfd74dbc950128110851f2a8689c21716804420.jpg',
    viewer: 100,
  ),
  BookModel(
    id: 3,
    code: "003",
    title: "សៀវភៅមគ្គុទេសក៍",
    author: 'VANNA',
    issued: DateTime.now(),
    pages: 15,
    isbn: '123456789',
    issn: '987654321',
    image: 'https://elibrary.maff.gov.kh/assets/images/books/486dcd945440099c51851bcb3ba3eb1f1714104611.jpg',
    viewer: 100,
  ),
  BookModel(
    id: 4,
    code: "004",
    title: "ខ្សែសង្វាក់ផលិតកម្មដំណាំស្វាយចន្ទី",
    author: 'VANNA',
    issued: DateTime.now(),
    pages: 15,
    isbn: '123456789',
    issn: '987654321',
    image: 'https://elibrary.maff.gov.kh/assets/images/books/536dc300219cbbf7980f4ab0b63e2d111714124268.jpg',
    viewer: 100,
  ),
  BookModel(
    id: 3,
    code: "003",
    title: "កម្រងបញ្ជីឈ្មោះ និងលេខទូរស័ព្ទនៃមន្ត្រីកសិកម្មឃុំ ក្នុងប្រទេសកម្ពុជា",
    author: 'VANNA',
    issued: DateTime.now(),
    pages: 15,
    isbn: '123456789',
    issn: '987654321',
    image: 'https://elibrary.maff.gov.kh/assets/images/books/e68968f474106a9a557114cc34b27d4a1716282293.png',
    viewer: 100,
  ),
  BookModel(
    id: 3,
    code: "003",
    title: "កម្រងបញ្ជីឈ្មោះ និងលេខទូរស័ព្ទនៃមន្ត្រីកសិកម្មឃុំ ក្នុងប្រទេសកម្ពុជា",
    author: 'VANNA',
    issued: DateTime.now(),
    pages: 15,
    isbn: '123456789',
    issn: '987654321',
    image: 'https://elibrary.maff.gov.kh/assets/images/books/e68968f474106a9a557114cc34b27d4a1716282293.png',
    viewer: 100,
  ),
];
