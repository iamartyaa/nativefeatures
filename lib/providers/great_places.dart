import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:nativefeatures/models/place.dart';
import 'package:nativefeatures/helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      title: title,
      location: PlaceLocation(address: "", latitude: 0.0, longitude: 0.0),
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetplaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((e) => Place(
            id: e['id'],
            title: e['title'],
            location: PlaceLocation(address: '', latitude: 0, longitude: 0),
            image: File(e['image'])))
        .toList();
    notifyListeners();
  }
}
