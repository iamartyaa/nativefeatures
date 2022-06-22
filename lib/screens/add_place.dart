import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nativefeatures/providers/great_places.dart';
import 'package:nativefeatures/widgets/image_input.dart';
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
    Provider.of<GreatPlaces>(context).addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Place'),
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
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                  controller: _titleController,
                  ),
                  SizedBox(height: 10,),
                  ImageInput(_selectImage),
                ],),
              ),
            ),
          ),
          RaisedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add Place'),
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
