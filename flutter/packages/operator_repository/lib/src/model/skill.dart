import 'package:equatable/equatable.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class Skill extends Equatable {
  const Skill({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String description;
  final String? imageUrl;

  @override
  List<Object?> get props => [id, name, description, imageUrl];

  Widget get image => imageUrl != null
      ? ExtendedImage.network(
          imageUrl!,
          loadStateChanged: (state) {
            if (state.extendedImageLoadState == LoadState.failed) {
              return Icon(Icons.image);
            }
          },
        )
      : Container();

  @override
  String toString() {
    return name;
  }

  Skill copyWith({String? imageUrl}) {
    return Skill(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
