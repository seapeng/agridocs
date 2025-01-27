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
    title: "ការដាំដំណាំ",
    youtubeId: 'yQ5uCP3PqCE',
    published: DateTime.now(),
  ),
  VideoModel(
    id: 2,
    title: "ការដាំដំណាំ",
    youtubeId: 'yQ5uCP3PqCE',
    published: DateTime.now(),
  ),
];
