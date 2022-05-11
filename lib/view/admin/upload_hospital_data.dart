import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UploadHospitalData extends StatefulWidget {
  const UploadHospitalData({Key? key}) : super(key: key);

  @override
  State<UploadHospitalData> createState() => _UploadHospitalDataState();
}

class _UploadHospitalDataState extends State<UploadHospitalData> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? file;
  GlobalKey<FormState> uploadForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Hospital Data"),
      ),
      body: Form(
        key: uploadForm,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Enter title",
                    labelText: "Title",
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Please enter title";
                    }
                    if (value.toString() == "") {
                      return "Please enter title";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  maxLines: 2,
                  minLines: 2,
                  decoration: const InputDecoration(
                    hintText: "Enter short description",
                    labelText: "Description",
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Please enter description";
                    }
                    if (value.toString() == "") {
                      return "Please enter description";
                    }
                    return null;
                  },
                ),
                Card(
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf'],
                          );
                          if (result != null) {
                            file = File(result.files.single.path!);
                            setState(() {});
                          } else {
                            // User canceled the picker
                          }
                        },
                        child: const Text("Pick File"),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          file == null
                              ? "No File Selected"
                              : file!.path.split('/').last,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          file = null;
                          setState(() {});
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (uploadForm.currentState!.validate()) {
                      if (file == null) {
                        Fluttertoast.showToast(msg: "Please pick a file");
                      } else {}
                    }
                  },
                  child: Text(
                    "Upload Health Tips",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
