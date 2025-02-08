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
  String ebook = "no ebook";
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
    this.ebook = "no ebook",
    this.viewer = 0,
  });
}

List<BookModel> bookModelList = [
  BookModel(
    id: 1,
    code: '001',
    title:
        "សៀវភៅណែនាំ​ស្ដីពី​ ការ​ចិញ្ចឹម​មាន់ពូជ​ក្នុងស្រុក​សម្រាប់​ភ្ញាស់​យក​កូន​ យក​សាច់​ជា​លក្ខណៈ​ពាណិជ្ជកម្ម​",
    author: 'នាយកដ្ឋាន​ផ្សព្វផ្សាយកសិកម្ម​ រុក្ខាប្រមាញ់​ និងនេសាទ',
    issued: DateTime.now(),
    pages: 31,
    isbn: 'N/A',
    issn: 'N/A',
    image:
        'https://elibrary.maff.gov.kh/assets/images/books/f7739d5e331348ff47b72e52f63e35661705044202.jpg',
    ebook:
        'https://elibrary.maff.gov.kh/assets/files/books/f9bb05bf6cfbf8fe8b2223623d5458be1705047288.pdf',
    viewer: 100,
  ),
  BookModel(
    id: 2,
    code: '002',
    title: "ជំងឺដុំពកស្បែកគោ",
    author: 'អគ្គនាយកដ្ឋានសុខភាពសត្វ និងផលិតកម្មសត្វ',
    issued: DateTime.now(),
    pages: 2,
    isbn: 'N/A',
    issn: 'N/A',
    image:
        'https://elibrary.maff.gov.kh/assets/images/books/dcbdfd74dbc950128110851f2a8689c21716804420.jpg',
    ebook:
        'https://elibrary.maff.gov.kh/assets/files/books/b9cd2dd0610f3ffbe49de52d74e6c9a61716804420.pdf',
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
    image:
        'https://elibrary.maff.gov.kh/assets/images/books/486dcd945440099c51851bcb3ba3eb1f1714104611.jpg',
    ebook:
        'https://elibrary.maff.gov.kh/assets/files/books/ee26908bf9629eeb4b37dac350f4754a1717497909blob.pdf',
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
    image:
        'https://elibrary.maff.gov.kh/assets/images/books/536dc300219cbbf7980f4ab0b63e2d111714124268.jpg',
    ebook:
        'https://elibrary.maff.gov.kh/assets/files/books/ee26908bf9629eeb4b37dac350f4754a1717497909blob.pdf',
    viewer: 100,
  ),
  BookModel(
    id: 5,
    code: "005",
    title: "សៀវភៅកសិករ កម្រងបច្ចេកទេសកសិកម្មល្អៗ ធន់នឹងអាកាសធាតុប្រែប្រួល",
    author: 'VANNA',
    issued: DateTime.now(),
    pages: 15,
    isbn: '123456789',
    issn: '987654321',
    image:
        'https://elibrary.maff.gov.kh/assets/images/books/e06d061a77a7bde916b8a91163029d411706973135.jpg',
    ebook:
        'https://elibrary.maff.gov.kh/assets/files/books/ee26908bf9629eeb4b37dac350f4754a1717497909blob.pdf',
    viewer: 100,
  ),
];
