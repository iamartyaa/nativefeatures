import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:nativefeatures/models/place.dart';

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
  }
}
