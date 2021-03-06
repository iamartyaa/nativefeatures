import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nativefeatures/providers/great_places.dart';
import 'package:nativefeatures/widgets/image_input.dart';
import 'package:nativefeatures/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place";

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final _titleController = TextEditingController();
  late File _pickedImage;
  void _selectImage(File pickedImage){
    _pickedImage=pickedImage;
  }
  

  void _savePlace(){
    if(_titleController.text.isEmpty || _pickedImage==null){
      return;
    }

    Provider.of<GreatPlaces>(context,listen: false).addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                  controller: _titleController,
                  ),
                  const SizedBox(height: 10,),
                  ImageInput(_selectImage),
                  const SizedBox(height: 10,),
                  LocationInput(),
                ],),
              ),
            ),
          ),
          RaisedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
              onPressed: () {
                _savePlace();
              },
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Theme.of(context).accentColor,
              ),
        ],
      ),
    );
  }
}
