import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Activity extends Equatable {
  final int id;
  final String owner;
  final String address;
  final String title;
  final String description;
  final DateTime date;
  final String image;

  Activity({
    this.id,
    @required this.owner,
    @required this.address,
    @required this.title,
    @required this.description,
    @required this.date,
    this.image,
  });

  factory Activity.empty() {
    return Activity(
      owner: "",
      address: "",
      title: "",
      description: "",
      date: null,
    );
  }
  @override
  List<Object> get props => [
        id,
        owner,
        address,
        title,
        description,
        date,
        image,
      ];

  Activity copyWith({
    int id,
    String owner,
    String address,
    String title,
    String description,
    DateTime date,
    String image,
  }) {
    return Activity(
      id: id ?? this.id,
      owner: owner ?? this.owner,
      address: address ?? this.address,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      image: image ?? this.image,
    );
  }
}
