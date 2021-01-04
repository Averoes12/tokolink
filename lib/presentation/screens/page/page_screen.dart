import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:tokolink/infrastructure/constants/global.dart';
import 'package:http/http.dart' as http;
class PageScreen extends StatefulWidget {
  final int id;
  final String title;

  const PageScreen({
    Key key,
    this.id,
    this.title,
  }) : super(key: key);

  @override
  _PageScreenState createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  String data;
  bool loading;
  @override
  void initState() {
    super.initState();
    _getData();
  }
  void  _getData() async{
    setState(() {
      loading = true;
    });
    var response = await http.get(GlobalConstant.BASE_URL+'/page/index/'+ widget.id.toString());
    setState(() {
      loading = false;
      data = response.body;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: (loading) ? Center(child:CircularProgressIndicator() ) : Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Html(
                      data: data,
                      style: {
                          'p': Style(
                            color: Colors.grey[700],
                            lineHeight: 2
                          ),
                        }
                    )
                  ]
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
