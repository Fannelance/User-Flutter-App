import 'package:fannelance/core/constants.dart';
import 'package:fannelance/services/user_data_service.dart';
import 'package:fannelance/widgets/account_body_widget.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: UserDataService().userDataRequest(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: kBlack,
              ),
            );
          } else {
            var userData = snapshot.data?['data'];
            
            return BodyAccountWidget(userData: userData);
          }
        },
      ),
    );
  }
}
