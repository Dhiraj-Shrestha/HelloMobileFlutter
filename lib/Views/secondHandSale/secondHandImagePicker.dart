// import 'dart:io';
// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// class ImagePick extends StatefulWidget {
//   @override
//   _ImagePickState createState() => _ImagePickState();
// }

// AddProductsProvider addProductProvider;

// class _ImagePickState extends State<ImagePick> {
//   File _image;
//   final picker = ImagePicker();
//   String imageFileUpload;

//   Future pickImageFromCamera() async {
//     final pickedFile = await picker.getImage(source: ImageSource.camera);
//     addProductProvider.image = null;

//     setState(() {
//       if (pickedFile != null) {
//         addProductProvider.image = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   Future pickImageFromGallery() async {
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//     addProductProvider.image = null;
//     setState(() {
//       if (pickedFile != null) {
//         addProductProvider.image = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   void _showPicker(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: new Wrap(
//                 children: <Widget>[
//                   new ListTile(
//                       leading: new Icon(Icons.photo_library),
//                       title: new Text('Photo Library'),
//                       onTap: () {
//                         pickImageFromGallery();
//                         Navigator.of(context).pop();
//                       }),
//                   new ListTile(
//                     leading: new Icon(Icons.photo_camera),
//                     title: new Text('Camera'),
//                     onTap: () {
//                       pickImageFromCamera();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // addProductProvider = Provider.of<AddProductsProvider>(context);
//     return GestureDetector(
//       onTap: () {
//         _showPicker(context);
//       },
//       child: Container(
//         // decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
//         child: addProductProvider.image != null
//             ? ClipRRect(
//                 child: Image.file(
//                   addProductProvider.image,
//                   width: 184,
//                   height: 208,
//                   fit: BoxFit.contain,
//                 ),
//               )
//             : Container(
//                 decoration: BoxDecoration(
//                   color: Colors.black38,
//                 ),
//                 width: 184,
//                 height: 208,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Container(
//                       color: Color.fromRGBO(196, 196, 196, 1),
//                       height: 155,
//                       width: double.infinity,
//                       child: Icon(
//                         Icons.image,
//                         size: 100,
//                         color: Color.fromRGBO(0, 0, 0, 0.38),
//                       ),
//                     ),
//                     Container(
//                       width: 184,
//                       height: 53,
//                       decoration: BoxDecoration(
//                         color: Color.fromRGBO(217, 216, 216, 1),
//                       ),
//                       child: Center(
//                         child: Text("Upload photo",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16,
//                             )),
//                       ),
//                     )
//                   ],
//                 )),
//       ),
//     );
//   }
// }
