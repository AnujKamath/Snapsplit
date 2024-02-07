import 'package:flutter/material.dart';
import 'common_widgets.dart';
class BalanceSheetPage extends StatefulWidget {
  @override
  _BalanceSheetPageState createState() => _BalanceSheetPageState();
}

class _BalanceSheetPageState extends State<BalanceSheetPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance Sheet Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
           Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
      body: Center(
        child: Text('This is the Balance Sheet page!'),
      ),
      bottomNavigationBar: buildSalomonBottomBar(_currentIndex, (i) {
        handleSalomonBottomBarNavigation(context, _currentIndex, i);
        setState(() {
          _currentIndex = i;
        });
      }),
    );
  }
}
