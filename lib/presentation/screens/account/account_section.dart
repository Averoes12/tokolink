import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokolink/presentation/screens/account/profile/toko_edit_screen.dart';
import 'package:tokolink/presentation/screens/manageproduct/manage_product_screen.dart';
import 'package:tokolink/presentation/screens/order/order_store_screen.dart';
import 'package:tokolink/presentation/screens/page/page_screen.dart';
import 'package:tokolink/presentation/screens/widgets/dashed_divider.dart';
import 'package:tokolink/presentation/utils/mixins/has_size_mixin.dart';

import 'address/address_screen.dart';
import 'profile/profile_edit_screen.dart';
import 'widgets/account_menu_widget.dart';
import 'widgets/profile_menu_widget.dart';

class AccountSection extends StatefulWidget {
  @override
  _AccountSectionState createState() => _AccountSectionState();
}

class _AccountSectionState extends State<AccountSection> with HasSizeMixin {
  SharedPreferences prefs;
  String _name ;
  bool isStore = false;

  @override
  void initState() {
    super.initState();
    _goProfile();
    _goHome();
  }

  void _goHome() async{
    prefs = await SharedPreferences.getInstance();
    if(prefs.getString('storeToken') != null){
      setState(() {
        isStore = true;
      });
    }
  }
  void _goProfile() async{
    prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name');
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: appSize.blockSizeVertical * 6),
          Text('Account', textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
          SizedBox(height: appSize.blockSizeVertical * 2),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 10),
                  ProfileMenuWidget(
                    name: _name,
                    image: ClipRRect(
                      child: Image.network(
                        'https://placehold.it/300',
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.circular(300),
                    ),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEditScreen())),
                  ),
                  SizedBox(height: 10),
                  (isStore) ? ProfileMenuWidget(
                    name: 'tokolink',
                    phone: 'Edit Toko',
                    image: ClipRRect(
                      child: Image.asset(
                        'assets/img/logo-mark.png',
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.circular(300),
                    ),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TokoEditScreen())),
                  ) : Container(),
                  SizedBox(height: 20),
                  Card(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          (isStore) ? AccountMenuWidget(
                            image: SvgPicture.asset('assets/icons/manage_toko.svg'),
                            title: 'Manage Pesanan',
                            subtitle: 'Shop',
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrderStoreScreen())),
                          ) : Container(),
                          (isStore) ? DashedDivider(
                            padding: 20,
                          ) : Container(),
                          (isStore) ? AccountMenuWidget(
                            image: SvgPicture.asset('assets/icons/my_product.svg'),
                            title: 'My Product',
                            subtitle: 'Manage products.',
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ManageProductScreen())),
                          ) : Container(),
                          (isStore) ? DashedDivider(
                            padding: 20,
                          ) : Container(),
                          AccountMenuWidget(
                            image: SvgPicture.asset('assets/icons/my_address.svg'),
                            title: 'My Address',
                            subtitle: 'Manage delivery address.',
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddressScreen(isedit:true))),
                          ),
                          DashedDivider(
                            padding: 20,
                          ),
                          AccountMenuWidget(
                            image: SvgPicture.asset('assets/icons/bantuan.svg'),
                            title: 'Bantuan',
                            subtitle: 'Help',
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PageScreen(title: 'Bantuan',id:4)))
                          ),
                          DashedDivider(
                            padding: 20,
                          ),
                          AccountMenuWidget(
                            image: SvgPicture.asset('assets/icons/term.svg'),
                            title: 'Syarat dan Ketentuan',
                            subtitle: 'Term and services',
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PageScreen(title: 'Syarat dan Ketentuan',id:1)))
                          ),
                          DashedDivider(
                            padding: 20,
                          ),
                          AccountMenuWidget(
                            image: SvgPicture.asset('assets/icons/privacy.svg'),
                            title: 'Kebijakan privasi',
                            subtitle: 'Privacy policy',
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PageScreen(title: 'Kebijakan privasi',id:2)))
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
