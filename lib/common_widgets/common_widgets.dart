import 'package:bordeaux/common_widgets/page_transition.dart';
import 'package:flutter/material.dart';

import '../screens/profile_screen.dart';
import 'colors.dart';

class CommonWidgets {
  static Widget CommonAppBar(VoidCallback onDrawerTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                PageTransition.fadeInNavigation(page: ProfileScreen());
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logo_white.png',
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'BORDEAUX',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'ManropeBold'),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: onDrawerTap,
              child: Image.asset(
                'assets/images/drawer.png',
                height: 20,
                width: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget footer() {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon.png',
              color: Colors.black,
              height: 35,
              width: 35,
            ),
            const SizedBox(
              width: 8,
            ),
            const Text(
              'BORDEAUX',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'ManropeBold'),
            )
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Text(
            'This site is protected by reCAPTCHA and the google privacy Policy and Terms of Service apply.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.black.withOpacity(0.9),
                height: 1.9,
                fontSize: 11),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/twitter_icon.png',
              scale: 3,
            ),
            const SizedBox(
              width: 20,
            ),
            Image.asset(
              'assets/images/instagram_icon.png',
              scale: 3,
            ),
            const SizedBox(
              width: 20,
            ),
            Image.asset(
              'assets/images/facebook.png',
              scale: 3,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Get Help', style: textStyle()),
                  size10(),
                  Text('Explore food PAIRINGS', style: textStyle()),
                  size10(),
                  Text('Explore recipes', style: textStyle()),
                  size10(),
                  Text('Explore wine celler', style: textStyle()),
                  size10(),
                  Text('Shop groceries or food',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black)),
                  size10(),
                  Text('delivery',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black)),
                  size10(),
                  Text('Sitemap', style: textStyle()),
                  size10(),
                  Text('Privacy Policy', style: textStyle()),
                  size10(),
                  Text('Terms', style: textStyle()),
                  size10(),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Community', style: textStyle()),
                  size10(),
                  Text('View store', style: textStyle()),
                  size10(),
                  Text('Shpping policy', style: textStyle()),
                  size10(),
                  Text('Return policy', style: textStyle()),
                  size10(),
                  Text('About Bordeaux', style: textStyle()),
                  size10(),
                  Text('English', style: textStyle()),
                  size10(),
                  Text('Pricing', style: textStyle()),
                  size10(),
                  Text('Do not sell or share my',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle()),
                  size10(),
                  Text('personal information',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle()),
                  size10(),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        const Divider(
          height: 2,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Copyright@2023 bordeaux.',
              style: TextStyle(
                  color: AppColors.black.withOpacity(0.5), fontSize: 13),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  static Widget size10() {
    return const SizedBox(
      height: 20,
    );
  }

  static textStyle() {
    return const TextStyle(
        fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.black);
  }
}
