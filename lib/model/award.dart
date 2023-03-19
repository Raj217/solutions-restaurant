class Award {
  String id;
  String name;
  String image;
  int peopleReceived;
  Award(
      {required this.id,
      required this.name,
      required this.image,
      this.peopleReceived = 0});
}
