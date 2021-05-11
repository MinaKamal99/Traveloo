// To parse this JSON data, do
//
//     final hotel = hotelFromJson(jsonString);

import 'dart:convert';

List<Hotel> hotelFromJson(String str) => List<Hotel>.from(json.decode(str).map((x) => Hotel.fromJson(x)));

String hotelToJson(List<Hotel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Hotel {
  Hotel({
    this.id,
    this.image,
    this.title,
    this.price,
    this.sale,
    this.rating,
    this.location,
    this.description,
    this.img,
  });

  String id;
  String image;
  String title;
  String price;
  String sale;
  double rating;
  String location;
  String description;
  String img;

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
    id: json["id"],
    image: json["image"] == null ? null : json["image"],
    title: json["title"],
    price: json["price"] == null ? null : json["price"],
    sale: json["sale"] == null ? null : json["sale"],
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    location: json["location"] == null ? null : json["location"],
    description: json["description"] == null ? null : json["description"],
    img: json["img"] == null ? null : json["img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image == null ? null : image,
    "title": title,
    "price": price == null ? null : price,
    "sale": sale == null ? null : sale,
    "rating": rating == null ? null : rating,
    "location": location == null ? null : location,
    "description": description == null ? null : description,
    "img": img == null ? null : img,
  };
}
