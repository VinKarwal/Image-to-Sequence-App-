import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'api.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({
    super.key,
    required this.image,
  });

  final File image;
  @override
  State<ResultPage> createState() => ResultPageState();
}

class ResultPageState extends State<ResultPage> {
  String captions = "Refresh once !";
  var data;
  late File image;
  FlutterTts ftts = FlutterTts();

  @override
  void initState() {
    super.initState();
    image = widget.image;
  }

  // ResultPageState(this.image);

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                //color: Colors.white,
                //margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Text(
                  "Captions",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: displayImage(image),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                width: 200,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Text(
                  captions,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5.0,
                    ),
                    onPressed: () => getCaption(),
                    child: const Text(
                      "Refresh",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5.0,
                      // color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () => speakCaption(),
                    child: const Text(
                      "Audio",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        /*
      floatingActionButton: FloatingActionButton.extended(
                onPressed: () => Navigator.pushNamed(context, "/"),
                icon: Icon(
                Icons.arrow_back,color: Colors.black,size: 30,
                ),
                label: Text("Back",style: TextStyle(color: Colors.black),),
                ),
      */
      ),
    );
  }

  Future getCaption() async {
    data = await getData(uploadUrl);

    setState(() {
      captions = data['captions'];
    });
  }

  speakCaption() async {
    await ftts.setLanguage("en-US");
    await ftts.setPitch(1);
    await ftts.speak(captions);
  }

  Widget displayImage(File file) {
    return new SizedBox(
      height: 250.0,
      width: 200.0,
      child: file == null ? Container() : Image.file(file),
    );
  }
}

// // class ResultPage extends StatefulWidget {
// //   final File image;
// //   const ResultPage({Key key, @required this.image}) : super(key: key);

// //   @override
// //   State<StatefulWidget> createState() => ResultPageState(image);
// // }

// class ResultPageState extends State<ResultPage> {
//   String captions = "Refresh once !";
//   var data;
//   File image;
//   FlutterTts ftts = FlutterTts();

//   ResultPageState(this.image);

//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           stops: [0.1, 0.5, 0.7, 0.9],
//           colors: [
//             Colors.yellow[800],
//             Colors.yellow[700],
//             Colors.yellow[600],
//             Colors.yellow[400],
//           ],
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 //color: Colors.white,
//                 //margin: EdgeInsets.all(5),
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: Colors.white,
//                 ),
//                 child: Text(
//                   "Captions",
//                   style: TextStyle(
//                       fontSize: 40,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white, width: 3),
//                 ),
//                 child: displayImage(image),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 height: 100,
//                 width: 200,
//                 padding: EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 child: Text(
//                   captions,
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   RaisedButton(
//                     child: Text(
//                       "Refresh",
//                       style: TextStyle(
//                         color: Colors.black,
//                       ),
//                     ),
//                     elevation: 5.0,
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     onPressed: () => getCaption(),
//                   ),
//                   SizedBox(
//                     width: 25,
//                   ),
//                   RaisedButton(
//                     child: Text(
//                       "Audio",
//                       style: TextStyle(
//                         color: Colors.black,
//                       ),
//                     ),
//                     elevation: 5.0,
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     onPressed: () => speakCaption(),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         /*
//       floatingActionButton: FloatingActionButton.extended(
//                 onPressed: () => Navigator.pushNamed(context, "/"),
//                 icon: Icon(
//                 Icons.arrow_back,color: Colors.black,size: 30,
//                 ),
//                 label: Text("Back",style: TextStyle(color: Colors.black),),
//                 ),
//       */
//       ),
//     );
//   }

//   Future getCaption() async {
//     data = await getData(uploadUrl);

//     setState(() {
//       captions = data['captions'];
//     });
//   }

//   speakCaption() async {
//     await ftts.setLanguage("en-US");
//     await ftts.setPitch(1);
//     await ftts.speak(captions);
//   }

//   Widget displayImage(File file) {
//     return new SizedBox(
//       height: 250.0,
//       width: 200.0,
//       child: file == null ? Container() : Image.file(file),
//     );
//   }
// }
