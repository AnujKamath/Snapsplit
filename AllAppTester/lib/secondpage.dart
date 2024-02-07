import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OCR API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currentIndex = 0;
  List<File> _savedImages = [];

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await ImagePicker().pickImage(source: source);

    if (image != null) {
      setState(() {
        _savedImages.add(File(image.path));
      });
    } else {
      print('Image selection canceled');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OCR API Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              _pickImage(ImageSource.gallery);
            },
            child: Text('Pick Image'),
          ),
          SizedBox(height: 20),
          for (int i = 0; i < _savedImages.length; i++)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              child: Column(
                children: [
                  Image.file(
                    _savedImages[i],
                    height: 150,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
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
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() {
            _currentIndex = i;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.purple,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text("Likes"),
            selectedColor: Colors.pink,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
            selectedColor: Colors.orange,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Text('This is the second page!'),
      ),
    );
  }
}
