import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/global.dart';
import 'package:tokolink/localization/localization_const.dart';
import 'package:tokolink/model/address.dart';
import 'package:tokolink/model/bank.dart';
import 'package:tokolink/model/cart.dart';
import 'package:tokolink/model/shipping.dart';
import 'package:tokolink/model/transaction.dart';
import 'package:tokolink/presentation/screens/account/address/address_add_screen.dart';
import 'package:tokolink/presentation/screens/account/address/address_screen.dart';
import 'package:tokolink/presentation/screens/checkout/payment_screen.dart';
import 'package:tokolink/presentation/screens/payment/payment_screen.dart';
import 'package:tokolink/presentation/screens/widgets/dashed_divider.dart';
import 'package:tokolink/presentation/screens/widgets/dialogs/image_dialog.dart';
import 'package:tokolink/presentation/utils/mixins/has_size_mixin.dart';
import 'package:http/http.dart' as http;

class CheckoutSection extends StatefulWidget {
  @override
  _CheckoutSectionState createState() => _CheckoutSectionState();
}

class _CheckoutSectionState extends State<CheckoutSection> with HasSizeMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var cart;
  int total = 0;
  int items;
  Address defaultAddress;
  int selectedIndex = 0;
  List<Shipping> shippings = [];
  List<Bank> banks = [];
  Bank selectedBank;
  int bankIndex = 0;
  List<Shipping> tmp = [];
  Shipping selectedShipping;
  Map<String, String> headers;
  Transaction transaction;
  List<DetailTransaction> detail = [];
  DetailTransaction dt;
  SharedPreferences prefs;
  bool _addressLoading = false;
  bool _shippingLoading = false;
  bool _orderLoading = false;
  int _ongkir = 0;
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
  @override
  void initState() {
    super.initState();
    _getToken();
    _getCart();
    _getBank();
  }
  void _getToken() async{
    setState(() {
      _addressLoading = true;
    });
    prefs = await SharedPreferences.getInstance();
    setState(() {
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': prefs.getString('token'),
      };
      _getDefaultAddress();
    });
  }
  void _getCart() async{
    cart = Cart().cart.cartItem;
    total = 0;
    items = 0;
    for (var item in cart) {
      total = total + item.subTotal;
      items = items + item.quantity;
      dt = DetailTransaction(
        product: item.productId.toString() ,
        qty: item.quantity.toString(),
        price: item.unitPrice.toString()
      );
      detail.add(dt);
    }
    setState(() {
      total = total;
    });
  }
  
  void _getDefaultAddress() async{
    var response = await http.get(GlobalConstant.BASE_URL+'/address/default', headers: headers);
    final data = jsonDecode(response.body);
    print(data);
    if (response.statusCode != 200) {
      throw Exception(
          'Request failed with status ${response.statusCode}: ${response.body}');
    }else{
      setState(() {
        _addressLoading = false;
        if(data['data'] != null){
          defaultAddress = Address.fromJson(data['data']);
          _getShippingFee(defaultAddress.latitude,defaultAddress.longitude,cart[0].productDetails.store);
        }
        //_getShipping(defaultAddress.district.idDistrict);
      });
      
    }
  }
  void _getShippingFee(lat,lng,store) async{
    setState(() {
      _shippingLoading = true;
    });
    var response = await http.get(GlobalConstant.BASE_URL+'/transaction/shipping/'+lat+'/'+lng+'/'+store, headers: headers);
    final data = jsonDecode(response.body);
    print(data);
    if (response.statusCode != 200) {
      throw Exception(
          'Request failed with status ${response.statusCode}: ${response.body}');
    }else{
      setState(() {
        _shippingLoading = false;
        if(data['data'] != null){
          _ongkir = int.parse(data['data']['fee']);
        }
        //_getShipping(defaultAddress.district.idDistrict);
      });
      
    }
  }
 void  _getBank() async{
    prefs = await SharedPreferences.getInstance();
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': prefs.getString('token'),
    };
    var response = await http.get(GlobalConstant.BASE_URL+'/balance/banks', headers: headers);
    final data = jsonDecode(response.body);
    print(data);
    if (response.statusCode != 200) {
      throw Exception(
          'Request failed with status ${response.statusCode}: ${response.body}');
    }else{
      setState(() {
        for (Map i in data['data']) {
          banks.add(Bank.fromJson(i));
        }
        selectedBank = banks[0];
      });
      
    }
  }
  void _sendTransaction() async{
    setState(() {
      _orderLoading = true;
    });
    prefs = await SharedPreferences.getInstance();
    headers = {
      'Accept': 'application/json',
      'Authorization': prefs.getString('token'),
    };
    var body = {
      'address': defaultAddress.id_address,
      'payment': selectedBank.code,
      'subtotal': total.toString(),
      'shipping': _ongkir.toString(),
      'store' : cart[0].productDetails.store,
      'total' : (_ongkir + total).toString(),
      'detail' : jsonEncode( detail.map((v) => v.toJson()).toList() )
    };
    final response = await http.post(GlobalConstant.BASE_URL+'/transaction', body: body, headers: headers);
    
    final data = jsonDecode(response.body);
    print(data);
    setState(() {
      _orderLoading = false;
      Cart().remove();
      Navigator.of(context).pop(true);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PaymentSection(data: data['data'], bank: selectedBank)));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(getTranslated(context, 'checkout')),
        centerTitle: true,
      ),
      body:  Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    (_addressLoading == true) ? loadingAddress() : (defaultAddress == null ) ? addAddress() : address(),
                    SizedBox(height: 20),
                    cartWidget(),
                    SizedBox(height: 20),
                    payment(),
                    SizedBox(height: 20),
                    RaisedButton(
                      onPressed: () {
                        _sendTransaction();
                        if(_orderLoading){
                          showDialog(context: context,
                            //barrierDismissible: false,
                            builder: (BuildContext context){
                              if(!_orderLoading){
                                Navigator.of(context).pop(true);
                              };
                              return CustomDialogBox(
                                title: getTranslated(context, 'please_wait'),
                                descriptions: getTranslated(context, 'order_process_by_system'),
                                img: 'assets/img/loading.gif',
                              );
                            }
                          ).then((val){
                            //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PaymentSection()));
                          });
                        }
                      },
                      textColor: Colors.white,
                      child: Text(getTranslated(context, 'btn_complete_order')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
  Widget cartWidget(){
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(0.0, 2.0), //(x,y)
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(children: [
                  Image.asset('assets/icons/home.png'),
                  SizedBox(width: 10),
                  Text(
                    'Tokolink',
                    style: TextStyle(color: ColorConfig.PRIMARY),
                  )
                ]),
                SizedBox(height: 10),
                DashedDivider(),
                SizedBox(height: 10),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: cart.length,
            itemBuilder: (context, i) {
              return Container(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: Offset(0.0, 2.0), //(x,y)
                      //blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(cart[i].productDetails.name, style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Row(
                        children: <Widget>[
                          Text('Qty : ', style: TextStyle(color: Colors.grey)),
                          Text(
                            cart[i].quantity.toString(),
                            style: TextStyle(color:  ColorConfig.PRIMARY ),
                          ),
                        ],
                      ),
                      Text(formatCurrency.format( cart[i].unitPrice ), style: TextStyle(color: Colors.grey)),
                    ]),
                  ],
                ),
              );
            }
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  offset: Offset(0.0, 10.0), //(x,y)
                  blurRadius: 9.0,
                ),
              ],
            ),
            child: ClipPath(
              clipper: TicketClipPath(),
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 14),
                    DashedDivider(),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('${getTranslated(context, 'order_subtotal')}:'),
                        Text(
                          formatCurrency.format( total ),
                          style: TextStyle(
                            color: ColorConfig.PRIMARY,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('${getTranslated(context, 'order_postage')}:'),
                        Text(
                          (_shippingLoading) ? getTranslated(context, 'loading') : formatCurrency.format( _ongkir ),
                          style: TextStyle(
                            color: ColorConfig.PRIMARY,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('${getTranslated(context, 'order_total')}:'),
                        Text(
                          formatCurrency.format( total+_ongkir ),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: ColorConfig.PRIMARY,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget address(){
    return  GestureDetector(
      onTap: () async{
          var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddressScreen(isedit: false)));
          print(result);
          setState(() {
            defaultAddress = result;
            _getShippingFee(defaultAddress.latitude,defaultAddress.longitude,cart[0].productDetails.store);
          });
          
      },
      child:Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(children: [
                Image.asset('assets/icons/address.png'),
                SizedBox(width: 10),
                Text(getTranslated(context, 'order_shipping_address'), style: TextStyle(fontWeight: FontWeight.bold))
              ]),
              SizedBox(height: 10),
              DashedDivider(),
              SizedBox(height: 10),
              Row(children: [
                Text(defaultAddress.name, style: TextStyle(fontWeight: FontWeight.bold)),
              ]),
              SizedBox(height: 5),
              Text(defaultAddress.phone),
              SizedBox(height: 5),
              Text(defaultAddress.address, style: TextStyle(color: Colors.grey)),
            ]
          )
        ),
      )
    );
  }
  Widget loadingAddress(){
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(children: [
                Image.asset('assets/icons/address.png'),
                SizedBox(width: 10),
                Text(getTranslated(context, 'order_shipping_address'), style: TextStyle(fontWeight: FontWeight.bold))
              ]),
              SizedBox(height: 10),
              DashedDivider(),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 20.0,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.white,
                  child: Container(color: Colors.grey,height: 30,width: MediaQuery.of(context).size.width),
                ),
              ),
            ]
          )
        )
    );
  }
  Widget addAddress(){
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(children: [
                Image.asset('assets/icons/address.png'),
                SizedBox(width: 10),
                Text(getTranslated(context, 'order_shipping_address'), style: TextStyle(fontWeight: FontWeight.bold))
              ]),
              SizedBox(height: 10),
              DashedDivider(),
              SizedBox(height: 20),
              DottedBorder(
                strokeWidth: 3,
                color: ColorConfig.N3,
                dashPattern: [12, 12],
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton(
                    onPressed: () async { 
                      var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddressAddScreen()));
                      print(result);
                      if(result == 'new_address'){
                        _getToken();
                      }
                    },
                    textColor: ColorConfig.N3,
                    child: Text(getTranslated(context, 'btn_new_address')),
                  ),
                ),
              ),
            ]
          )
        )
    );
  }
  Widget payment(){
    return  GestureDetector(
      onTap: () async{
          selectedBank = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentScreen(banks: banks,)));
          setState(() {
            selectedBank = selectedBank;
          });
      },
      child:Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(children: [
                Image.asset('assets/icons/payment.png'),
                SizedBox(width: 10),
                Text(getTranslated(context, 'order_payment'), style: TextStyle(fontWeight: FontWeight.bold))
              ]),
              SizedBox(height: 10),
              DashedDivider(),
              SizedBox(height: 20),
              (selectedBank != null) ? Row(children: [
                Image.asset('assets/img/'+ selectedBank?.code?.toLowerCase() +'.png', height: 20),
                SizedBox(width: 10),
                Text(selectedBank?.name, style: TextStyle(fontWeight: FontWeight.bold)),
              ]) : Text(getTranslated(context, 'loading')),
            ]
          )
        ),
      )
    );
  }
}
class TicketClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final radius = 10.0;
    final path = Path();
    path.arcToPoint(Offset(0, 30), radius: Radius.circular(radius));
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 30);
    path.arcToPoint(Offset(size.width, 0), radius: Radius.circular(radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}