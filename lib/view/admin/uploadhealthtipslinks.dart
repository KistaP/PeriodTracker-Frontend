import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:period_tracker/utils/remoteservices.dart';

class UploadHealthTipsLinks extends StatefulWidget {
  UploadHealthTipsLinks({Key? key}) : super(key: key);

  @override
  State<UploadHealthTipsLinks> createState() => _UploadHealthTipsLinksState();
}

class _UploadHealthTipsLinksState extends State<UploadHealthTipsLinks> {
  TextEditingController titleController = TextEditingController();

  GlobalKey<FormState> uploadForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Health Tips"),
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
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: "Enter url",
                    labelText: "Health tips Url",
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Please enter url";
                    }
                    if (value.toString() == "") {
                      return "Please enter url";
                    }
                    if (!value.toString().isURL) {
                      return "Enter valid url";
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (uploadForm.currentState!.validate()) {
                      var response = await RemoteServices.uploadHealthLinks(
                        titleController.text,
                      );
                      if (response.contains("Data Uploaded")) {
                        Fluttertoast.showToast(msg: "Data Upladed");
                        titleController.clear();
                      } else {
                        Fluttertoast.showToast(
                            msg: "Problem while uploading data");
                      }
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
