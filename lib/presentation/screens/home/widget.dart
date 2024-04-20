import 'package:flutter/material.dart';
import 'package:lilac_salmankv/presentation/alert/alert.dart';
import 'package:lilac_salmankv/presentation/screens/settings_screen/settings_screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreenWidget {
  Widget imageContainer(
      {required String image, required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.25,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          image,
          fit: BoxFit.fill,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 230, 230, 230),
              highlightColor: const Color.fromARGB(255, 200, 200, 200),
              child: const ColoredBox(color: Colors.grey),
            );
          },
        ),
      ),
    );
  }

  customDrawer({required BuildContext context}) {
    return Drawer(
        backgroundColor: const Color.fromARGB(156, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const SettingsScreen();
                  },
                ));
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.settings,
                      size: 30,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                      'Settings',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Alert().alertFunction(context: context);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.light
                      ? Colors.white
                      : Colors.black,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout_outlined,
                      size: 30,
                      color: Color.fromARGB(255, 214, 6, 6),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                      'Log Out',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
