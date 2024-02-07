import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'balancesheet.dart';
Widget buildSalomonBottomBar(int currentIndex, Function(int) onTap) {
  return SalomonBottomBar(
    currentIndex: currentIndex,
    onTap: onTap,
    items: [
      SalomonBottomBarItem(
        icon: Icon(Icons.home),
        title: Text("Home"),
        selectedColor: Colors.purple,
      ),
      SalomonBottomBarItem(
        icon: Icon(Icons.search),
        title: Text("Balance Sheet"),
        selectedColor: Colors.orange,
      ),
      SalomonBottomBarItem(
        icon: Icon(Icons.camera),
        title: Text("Scan"),
        selectedColor: Colors.blue,
      ),
    ],
  );
}

void handleSalomonBottomBarNavigation(BuildContext context, int currentIndex, int targetIndex) {
  
  if (currentIndex != targetIndex) {
    
    switch (targetIndex) {
      case 0:
        // Navigate to the home page
        Navigator.popUntil(context, (route) => route.isFirst);
        break;
      case 1:
      if(context!=BalanceSheetPage())
        Navigator.push(context, MaterialPageRoute(builder: (context) => BalanceSheetPage()));
      break;
      case 2:
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
                      // Add your logic for 'Take Photo' here
                    },
                    child: Text('Take Photo'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      // Add your logic for 'Choose from Gallery' here
                    },
                    icon: Icon(Icons.image),
                    label: Text('Choose from Gallery'),
                  ),
                ],
              ),
            );
          },
        );
        break;
    }

  }
}
