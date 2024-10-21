import 'dart:async';
import 'dart:io';

import 'package:adopt_app/models/pet.dart';
import 'package:adopt_app/providers/pets_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

final _picker = ImagePicker();

class UpdateForm extends StatefulWidget {
  var pet;
  UpdateForm({Key? key, this.pet}) : super(key: key);

  @override
  State<UpdateForm> createState() => UpdateFormState();
}

class UpdateFormState extends State<UpdateForm> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String gendder = "";
  int age = 0;
  var _image;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Name',
                  ),
                  onSaved: (value) {
                    name = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please fill out this field";
                    } else {
                      return null;
                    }
                  }),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Age',
                ),
                onSaved: (value) {
                  age = int.parse(value!);
                },
                validator: (value) {
                  if (value == null) {
                    return "please enter an age";
                  }
                  if (int.tryParse(value) == null) {
                    return "please enter a number";
                  } else {
                    return null;
                  }
                },
                maxLines: null,
              ),
              TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Gender',
                  ),
                  onSaved: (value) {
                    gendder = value!;
                  },
                  validator: (value) {
                    if (value == "male" && value == "female") {
                      return "please fill out this field";
                    } else {
                      return null;
                    }
                  }),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        _image = File(image!.path);
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(color: Colors.blue[200]),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.blue[200]),
                        width: 200,
                        height: 200,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Image"),
                  )
                ],
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Provider.of<PetsProvider>(context, listen: false)
                          .updatePet(Pet(
                              name: name,
                              age: age,
                              image: "", //_image.path,
                              gender: gendder));
                    }
                  },
                  child: const Text("Add pet"),
                ),
              ),
            ]));
  }
}
