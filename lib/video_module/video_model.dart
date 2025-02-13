class VideoModel {
  int id = 0;
  String title = "no title";
  String youtubeId = "no youtube id";
  late DateTime published;
  String author = "no author";
  String videoCategory = "no video category";
  String language = "no language";

  VideoModel({
    this.id = 0,
    this.title = "no title",
    this.youtubeId = "no youtube id",
    required this.published,
    this.author = "no author",
    this.videoCategory = "no video category",
    this.language = "no language",
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      title: json['title'],
      youtubeId: json['youtubeId'],
      published: DateTime.parse(json['published']),
      author: json['author'],
      videoCategory: json['videoCategory'],
      language: json['language'],
    );
  }
}

// List<VideoModel> videoModelList = [
//   VideoModel(
//     id: 1,
//     title:
//         "សហគមន៍កសិកម្មទំនើប៖ រួមគ្នាប្រែក្លាយកសិកម្មលក្ខណៈគ្រួសារ ទៅជាទម្រង់សហគ្រាសសេដ្ឋកិច្ចរឹងមាំ",
//     author: "សហគមន៍កសិកម្មទំនើប",
//     youtubeId: 'oeWmwk-5nrI',
//     published: DateTime.now(),
//     view: 100,
//   ),
//   VideoModel(
//     id: 2,
//     title: "មន្ដ្រីកសិកម្មឃុំ បម្រើប្រជាកសិករខ្មែរ",
//     author: "សហគមន៍កសិកម្មទំនើប",
//     youtubeId: 'qykdGycEWLk',
//     published: DateTime.now(),
//     view: 320,
//   ),
//   VideoModel(
//     id: 3,
//     title:
//         "ឯកឧត្តម ឃឹម ហ្វីណង់៖ សហគមន៍កសិកម្មសាមគ្គីត្រពាំងចក នឹងប្រែក្លាយខ្លួនទៅជាសហគមន៍កសិកម្មទំនើបគំរូ",
//     author: "សហគមន៍កសិកម្មទំនើប",
//     youtubeId: 'Ga_9GVXSi30',
//     published: DateTime.now(),
//     view: 324,
//   ),
//   VideoModel(
//     id: 4,
//     title:
//         "សំណង់ជម្រកត្រីសិប្បនិម្មិត៖ ក្ដីសង្ឃឹមថ្មីនៃប្រព័ន្ធអេកូឡូស៊ីបាតសមុទ្រកម្ពុជា",
//     author: "សហគមន៍កសិកម្មទំនើប",
//     youtubeId: '5xz59UlyAOs',
//     published: DateTime.now(),
//     view: 344,
//   ),
//   VideoModel(
//     id: 5,
//     title:
//         "សំណង់ជម្រកត្រីសិប្បនិម្មិត៖ ក្ដីសង្ឃឹមថ្មីនៃប្រព័ន្ធអេកូឡូស៊ីបាតសមុទ្រកម្ពុជា",
//     author: "សហគមន៍កសិកម្មទំនើប",
//     youtubeId: 'FosAOtNVJjo',
//     published: DateTime.now(),
//     view: 866,
//   ),
// ];
