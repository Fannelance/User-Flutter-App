import 'package:fannelance/core/constants.dart';
import 'package:fannelance/models/store_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PopularStoreHomeWidget extends StatelessWidget {
  final StoreModel storeModel;

  const PopularStoreHomeWidget({
    super.key,
    required this.storeModel,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    launchStoreURL() async {
      final Uri url = Uri.parse(storeModel.url);
      if (await launchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: launchStoreURL,
          child: Column(
            children: [
              Expanded(
                // Cover Container
                child: Container(
                  height: screenWidth / 7,
                  width: screenWidth / 2.3,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: AssetImage(storeModel.cover!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // White Container
              Expanded(
                child: Container(
                  height: screenWidth / 7,
                  width: screenWidth / 2.3,
                  decoration: const BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kGrey8,
                        blurRadius: 0.2,
                      ),
                    ],
                  ),
                  // Title
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 24),
                    child: Text(
                      storeModel.name,
                      style: TextStyle(
                        fontSize: screenWidth / 30,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Logo
        Positioned(
          top: 40,
          left: 15,
          child: CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage(storeModel.logo),
          ),
        ),
      ],
    );
  }
}
