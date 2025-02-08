class VideoModel {
  int id = 0;
  String title = "no title";
  String youtubeId = "no youtube id";
  DateTime published;

  VideoModel({
    this.id = 0,
    this.title = "no title",
    this.youtubeId = "no youtube id",
    required this.published,
  });
}

List<VideoModel> videoModelList = [
  VideoModel(
    id: 1,
    title:
        "សហគមន៍កសិកម្មទំនើប៖ រួមគ្នាប្រែក្លាយកសិកម្មលក្ខណៈគ្រួសារ ទៅជាទម្រង់សហគ្រាសសេដ្ឋកិច្ចរឹងមាំ",
    youtubeId: 'oeWmwk-5nrI',
    published: DateTime.now(),
  ),
  VideoModel(
    id: 2,
    title: "មន្ដ្រីកសិកម្មឃុំ បម្រើប្រជាកសិករខ្មែរ",
    youtubeId: 'qykdGycEWLk',
    published: DateTime.now(),
  ),
  VideoModel(
    id: 3,
    title:
        "ឯកឧត្តម ឃឹម ហ្វីណង់៖ សហគមន៍កសិកម្មសាមគ្គីត្រពាំងចក នឹងប្រែក្លាយខ្លួនទៅជាសហគមន៍កសិកម្មទំនើបគំរូ",
    youtubeId: 'Ga_9GVXSi30',
    published: DateTime.now(),
  ),
  VideoModel(
    id: 4,
    title:
        "សំណង់ជម្រកត្រីសិប្បនិម្មិត៖ ក្ដីសង្ឃឹមថ្មីនៃប្រព័ន្ធអេកូឡូស៊ីបាតសមុទ្រកម្ពុជា",
    youtubeId: '5xz59UlyAOs',
    published: DateTime.now(),
  ),
  VideoModel(
    id: 5,
    title:
        "សំណង់ជម្រកត្រីសិប្បនិម្មិត៖ ក្ដីសង្ឃឹមថ្មីនៃប្រព័ន្ធអេកូឡូស៊ីបាតសមុទ្រកម្ពុជា",
    youtubeId: 'FosAOtNVJjo',
    published: DateTime.now(),
  ),
];
