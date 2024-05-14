import 'package:dio/dio.dart';
import 'package:fannelance/core/constants.dart';
import 'package:fannelance/models/custom_icons.dart';
import 'package:fannelance/widgets/account_alertdialog_widget.dart';
import 'package:fannelance/widgets/account_listtile_widget.dart';
import 'package:fannelance/widgets/drop_down_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class AccountView extends StatefulWidget {
  const AccountView({
    super.key,
  });

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  Future<Map<String, dynamic>> getUserData() async {
    try {
      await dotenv.load(fileName: '.env');
      final String serverURL = dotenv.env['serverURL']!;

      const secureStorage = FlutterSecureStorage();
      String? token = await secureStorage.read(key: 'token');

      Dio dio = Dio();
      final String url = '$serverURL/user';

      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return true;
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        print("No data field found in the response or data is not an array");
        return response.data;
      }
    } catch (e) {
      print("Error reading/parsing JSON response from server: $e");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: black,
              ),
            );
          } else {
            final userData = snapshot.data?['data'];
            print(userData);
            var userName = toBeginningOfSentenceCase('${userData!['firstname']} ') +
                        toBeginningOfSentenceCase('${userData!['lastname']}');
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Column(
                children: [
                  box_60,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AlertDialogAccountWidget(),
                    ],
                  ),
                  CircleAvatar(
                    radius: screenWidth / 9,
                    backgroundImage: DropDownMenuWidgetState.gender == 'Female'
                        ? const AssetImage(
                            'assets/icons/female.png',
                          )
                        : const AssetImage(
                            'assets/icons/ male.png',
                          ),
                  ),
                  box_10,
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: screenWidth / 18,
                      fontFamily: bold,
                    ),
                  ),
                  box_50,
                  ListTileAccountWidget(
                    title: 'Username',
                    subTitle: userName,
                    icon: FontAwesome.user,
                  ),
                  ListTileAccountWidget(
                    title: 'Email',
                    subTitle: userData!['email'],
                    icon: Icons.mail,
                  ),
                  ListTileAccountWidget(
                    title: 'Phone number',
                    subTitle: userData!['phone'],
                    icon: Iconsax.mobile5,
                  ),
                  ListTileAccountWidget(
                    title: 'Location',
                    subTitle: userData!['location'],
                    icon: CustomIcons.location,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
