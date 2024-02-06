class DetailEntity {
  final String? tripId;
  final String? image;
  final String? title;
  final String? url;
  final String? date;

  DetailEntity({
    this.image,
    this.title,
    this.url,
    this.date,
    this.tripId,
  });

  factory DetailEntity.fromJson(Map<String, dynamic> json) => DetailEntity(
        tripId: json["tripId"],
        image: json["image"],
        title: json["tripName"],
        url: json["url"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "tripId": tripId,
        'image': image,
        'title': title,
        'url': url,
        'date': date,
      };

  @override
  String toString() {
    return '$title, $url $image $date';
  }
}
