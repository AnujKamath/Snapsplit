import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'common_widgets.dart';
import 'image_data.dart';
import 'new_page.dart';
import 'database_helper.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OCR API Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      navigatorKey: navigatorKey, // Set the navigator key
      home: MyHomePage(navigatorKey: navigatorKey), // Pass the navigator key to the home page
    );
  }
}


class MyHomePage extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  MyHomePage({required this.navigatorKey});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  var _currentIndex = 0;
  List<ImageData> _savedImages = [];
  

  @override
void initState() {
  super.initState();
  _loadSavedImages();
}

Future<void> _loadSavedImages() async {
  _savedImages = await DatabaseHelper.instance.getImageDataList();
  setState(() {}); // Refresh the UI
}

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await ImagePicker().pickImage(source: source);

    if (image != null) {
      String? description = await _getDescription();

      if (description != null) {
        ImageData imageData = ImageData(description: description, imagePath: image.path);
        await DatabaseHelper.instance.insertImageData(imageData);
        await _loadSavedImages();
      }
    } else {
      print('Image selection canceled');
    }
  }


  Future<String?> _getDescription() async {
    TextEditingController descriptionController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Description'),
          content: TextField(

            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Description'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, descriptionController.text);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OCR API Demo'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            SizedBox(
              height: 35,
              child: Text(
                'Pending',
                style: TextStyle(
                  fontSize: 24, // Adjust the font size as needed
                  fontFamily: '', // Replace 'YourFontFamily' with the desired font family
                  fontWeight: FontWeight.bold, // You can adjust the fontWeight as needed
                ),
              ),
            ),
                  for (int i = 0; i < _savedImages.length; i++) 
  GestureDetector(
    onDoubleTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NewPage(_savedImages[i].id ?? 0)),
  );
},

    onLongPress: () {
      _showDeleteDialog(i);
    },
    child: Card(
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: [
          // First Column - Picture
          Container(
            width: 80.0, // Fixed width for images
            height: 80.0, // Fixed height for images
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.file(
                File(_savedImages[i].imagePath), // Use imagePath here
                fit: BoxFit.cover, // Crop the image
              ),
            ),
          ),
          SizedBox(width: 10.0), // Spacer between columns

          // Second Column - Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Image ${i + 1}', // Replace with your actual title
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  _savedImages[i].description,
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  )

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                      child: Text('Take Photo'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                      icon: Icon(Icons.image),
                      label: Text('Choose from Gallery'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.camera_alt),
      ),
      bottomNavigationBar: buildSalomonBottomBar(_currentIndex, (i) {
        handleSalomonBottomBarNavigation(context, _currentIndex, i);
        setState(() {
          _currentIndex = i;
        });
      }),
    );
  }
  void _showDeleteDialog(int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete Image?'),
        content: Text('Are you sure you want to delete this image?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _savedImages.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
        ],
      );
    },
  );
}

}
