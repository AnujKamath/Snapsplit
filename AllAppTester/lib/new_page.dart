import 'dart:io';
import 'package:flutter/material.dart';
import 'database_helper.dart'; // Import your database helper
import 'image_data.dart';

class NewPage extends StatefulWidget {
  final int imageId; // Pass the image ID to identify the image in the database

  NewPage(this.imageId);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  ImageData? _imageData;

  @override
  void initState() {
    super.initState();
    _loadImageData();
  }

  Future<void> _loadImageData() async {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<ImageData> imageDataList = await databaseHelper.getImageDataList();

  // Find the image with the specified ID
  ImageData imageData = imageDataList.firstWhere(
    (data) => data.id == widget.imageId,
    orElse: () => ImageData(description: 'Not found', imagePath: ''),
  );

  setState(() {
    _imageData = imageData;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_imageData?.imagePath != null && _imageData!.imagePath.isNotEmpty)
            Image.file(
              File(_imageData!.imagePath),
              height: 150,
            )
          else
            Container(),
          SizedBox(height: 20),
          if (_imageData?.description != null && _imageData!.description.isNotEmpty)
            Text(_imageData!.description)
          else
            Container(),
        ],
      ),
    );
  }
}
