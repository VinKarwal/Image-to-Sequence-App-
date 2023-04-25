import 'result_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'api.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  File? _image;

  Future getImage(bool isCamera) async {
    File? image;

    // if (isCamera) {
    // } else {
    //   // image = await ImagePicker.pickImage(source: ImageSource.gallery);
    //   var t = await ImagePicker.platform.getImage(source: ImageSource.gallery);
    //   if (t != null) {}
    // }
    var c = await ImagePicker.platform
        .getImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (c != null) {
      try {
        image = File(c.path);
        print("Successfully got the image");
      } catch (e) {
        print("Error: $e");
        return;
      }
    } else {
      return;
    }

    uploadImage(image, uploadUrl);
    // Toast.show(
    //   "IMAGE UPLOADED !",
    //   duration: Toast.lengthLong,
    //   // : Colors.black,
    //   textStyle: const TextStyle(color: Colors.black),
    //   backgroundColor: Colors.white12,
    //   backgroundRadius: 15,
    //   gravity: Toast.bottom,
    // );

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.yellow[800] ?? Colors.yellow,
            Colors.yellow[700] ?? Colors.yellow,
            Colors.yellow[600] ?? Colors.yellow,
            Colors.yellow[400] ?? Colors.yellow,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            'ProxiVision',
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.insert_drive_file),
                color: Colors.white,
                iconSize: 70,
                onPressed: () {
                  getImage(false);
                },
              ),
              SizedBox(
                height: 70.0,
              ),
              IconButton(
                icon: Icon(Icons.camera_alt),
                color: Colors.white,
                iconSize: 70,
                onPressed: () {
                  getImage(true);
                },
              ),
              SizedBox(
                height: 70.0,
              ),
            ],
          ),
        ),
        floatingActionButton: _image != null
            ? FloatingActionButton.extended(
                onPressed: () {
                  // if (_image == null) {
                  //   Toast.show(
                  //     "Null Image",
                  //     textStyle: const TextStyle(color: Colors.red),
                  //   );
                  //   return;
                  // }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultPage(
                                image: _image!,
                              )));
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 30,
                ),
                label: const Text(
                  "Next",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                backgroundColor: Colors.white,
              )
            : const SizedBox(),
      ),
    );
  }
}
