import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Activity extends Equatable {
  final int id;
  final String owner;
  final String address;
  final String title;
  final String description;
  final DateTime date;

  Activity({
    this.id,
    @required this.owner,
    @required this.address,
    @required this.title,
    @required this.description,
    @required this.date,
  });

  @override
  List<Object> get props => [
        id,
        owner,
        address,
        title,
        description,
        date,
      ];

  Activity copyWith({
    int id,
    String owner,
    String address,
    String title,
    String description,
    DateTime date,
  }) {
    return Activity(
      id: id ?? this.id,
      owner: owner ?? this.owner,
      address: address ?? this.address,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}
