import 'package:flutter/material.dart';
import 'package:tokolink/model/bank.dart';
import 'package:tokolink/presentation/screens/widgets/dashed_divider.dart';
class PaymentScreen extends StatefulWidget {
  final List<Bank> banks;

  const PaymentScreen({
    Key key,
    this.banks,
  }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: widget.banks.length,
                        itemBuilder: (context, i) {
                          return bank(widget.banks[i]);
                        }
                      )
                    ]
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  Widget bank(Bank bank){
    return  GestureDetector(
      onTap: (){
        Navigator.pop(context, bank);
      },
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Row(children: [
            Image.asset('assets/img/'+ bank.code.toLowerCase() +'.png', width: 60),
            SizedBox(width: 10),
            Text(bank.name, style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
          SizedBox(height: 20),
          DashedDivider(),
        ]
      )
    );
  }
}
