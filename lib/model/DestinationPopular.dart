import 'dart:convert';

List<DestinationPopular> destinationPopularFromJson(String str) => List<DestinationPopular>.from(json.decode(str).map((x) => DestinationPopular.fromJson(x)));

String destinationPopularToJson(List<DestinationPopular> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DestinationPopular {
  DestinationPopular({
    this.title,
    this.image,
  });

  String title;
  String image;

  factory DestinationPopular.fromJson(Map<String, dynamic> json) => DestinationPopular(
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
  };
}
