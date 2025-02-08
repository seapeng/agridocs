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
        "ម្ចាស់ដេប៉ូជី-ថ្នាំកសិកម្មខេត្តបន្ទាយមានជ័យ រីករាយទទួល​បានចំណេះដឹងថ្មីៗក្នុងវិស័យកសិកម្ម",
    youtubeId: 'CGDq53fMbHo',
    published: DateTime.now(),
  ),
  VideoModel(
    id: 2,
    title: "ការដាំដំណាំ",
    youtubeId: 'qykdGycEWLk',
    published: DateTime.now(),
  ),
  VideoModel(
    id: 3,
    title: "ការដាំដំណាំ",
    youtubeId: 'ckmZCwYqBAU',
    published: DateTime.now(),
  ),
];
