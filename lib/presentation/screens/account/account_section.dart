import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                    image: ClipRRect(
                      child: Image.network(
                        'https://placehold.it/300',
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.circular(300),
                    ),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEditScreen())),
                  ),
                  SizedBox(height: 20),
                  Card(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          AccountMenuWidget(
                            image: SvgPicture.asset('assets/icons/manage_toko.svg'),
                            title: 'Manage Toko',
                            subtitle: 'Shop',
                          ),
                          DashedDivider(
                            padding: 20,
                          ),
                          AccountMenuWidget(
                            image: SvgPicture.asset('assets/icons/my_address.svg'),
                            title: 'My Address',
                            subtitle: 'Manage delivery address.',
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddressScreen())),
                          ),
                          DashedDivider(
                            padding: 20,
                          ),
                          AccountMenuWidget(
                            image: SvgPicture.asset('assets/icons/my_product.svg'),
                            title: 'My Product',
                            subtitle: 'Manage products.',
                          ),
                          DashedDivider(
                            padding: 20,
                          ),
                          AccountMenuWidget(
                            image: SvgPicture.asset('assets/icons/bantuan.svg'),
                            title: 'Bantuan',
                            subtitle: 'Help',
                          ),
                          DashedDivider(
                            padding: 20,
                          ),
                          AccountMenuWidget(
                            image: SvgPicture.asset('assets/icons/term.svg'),
                            title: 'Syarat dan Ketentuan',
                            subtitle: 'Term and services',
                          ),
                          DashedDivider(
                            padding: 20,
                          ),
                          AccountMenuWidget(
                            image: SvgPicture.asset('assets/icons/privacy.svg'),
                            title: 'Kebijakan privasi',
                            subtitle: 'Privacy policy',
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
