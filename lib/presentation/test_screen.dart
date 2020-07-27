import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:tokolink/presentation/widgets/label_widget.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool keyboardOpen = false;

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        print(visible);
        setState(() => keyboardOpen = visible);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home'), backgroundColor: Colors.red),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
        ],
      ),
      floatingActionButton: keyboardOpen
          ? SizedBox()
          : FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.red,
              onPressed: () {},
              child: Container(
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: Center(
                  child: Icon(Icons.add),
                ),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              LabelWidget(text: 'Recipients name'),
              TextFormField(
                decoration: InputDecoration(hintText: 'gageg', prefixIcon: Icon(Icons.search)),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: 'gageg', prefixIcon: Icon(Icons.search)),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: 'gageg', prefixIcon: Icon(Icons.search)),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: 'gageg', prefixIcon: Icon(Icons.search)),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: 'gageg', prefixIcon: Icon(Icons.search)),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: 'gageg', prefixIcon: Icon(Icons.search)),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: 'gageg', prefixIcon: Icon(Icons.search)),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: 'gageg', prefixIcon: Icon(Icons.search)),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: 'gageg', prefixIcon: Icon(Icons.search)),
              ),
              SizedBox(height: 20),
              RaisedButton(
                onPressed: null,
                child: Text('Button'),
              ),
              FlatButton(
                child: Text('gaga'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
