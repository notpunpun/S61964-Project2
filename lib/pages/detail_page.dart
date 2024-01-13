import 'package:flutter/material.dart';
import 'package:tourist_guide/misc/colors.dart';
import 'package:tourist_guide/widgets/app_buttons.dart';
import 'package:tourist_guide/widgets/app_large_text.dart';
import 'package:tourist_guide/widgets/app_text.dart';
import 'package:tourist_guide/widgets/responsive%20button.dart';
import 'package:tourist_guide/widgets/responsive button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  //selected things
  int gottenStars = 4;
  int selectedIndex = 1;

  Widget buildStarRating() {
    return Row(
      children: [
        Wrap(
          children: List.generate(5, (index) {
            return Icon(Icons.star,
                color: index < gottenStars
                    ? AppColors.starColor
                    : AppColors.textColor2);
          }),
        ),
        SizedBox(
          width: 10,
        ),
        AppText(
          text: "(4.0)",
          color: AppColors.textColor2,
          size: 14,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            // Background Image
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/97/39/7f/caption.jpg?w=1200&h=-1&s=1&cx=1920&cy=1080&chk=v1_f31158e4bb953d28a308',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Menu IconButton
            Positioned(
              top: 50,
              left: 20,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.menu),
                color: Colors.white,
              ),
            ),

            // Container
            Positioned(
              top: 320,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppLargeText(
                          text: "Tokyo",
                          color: Colors.black.withOpacity(0.8),
                        ),
                        AppLargeText(
                          text: "\$ 250",
                          color: AppColors.mainColor,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.mainColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        AppText(
                          text: "Tokyo, Japan",
                          color: AppColors.textColor1,
                          size: 16,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    buildStarRating(),
                    SizedBox(
                      height: 25,
                    ),
                    AppLargeText(
                      text: "People",
                      color: Colors.black.withOpacity(0.8),
                      size: 20,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    AppText(
                      text: "Number of People in Your Group",
                      color: AppColors.mainTextColor,
                      size: 12,
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    // box ppl (app_button.dart)
                    Wrap(
                      children: List.generate(
                        5,
                        (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: AppButtons(
                                size: 50,
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.black,
                                backgroundColor: selectedIndex == index
                                    ? Colors.black
                                    : AppColors.textColor1,
                                borderColor: selectedIndex == index
                                    ? Colors.black
                                    : AppColors.buttonBackground,
                                text: (index + 1).toString(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AppLargeText(
                      text: "Description",
                      color: Colors.black.withOpacity(0.8),
                      size: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppText(
                      text:
                          "You must go for A  Travel. Travelling helps to get rid of pressure. Visit Tokyo, the capital city of Japan. Home of ripped Nanami.",
                      color: AppColors.textColor2.withOpacity(0.8),
                      size: 14,
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                height: 500,
              ),
            ),
            //heart icon
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    AppButtons(
                      size: 60,
                      color: AppColors.textColor1,
                      backgroundColor: Colors.white,
                      borderColor: AppColors.textColor1,
                      isIcon: true,
                      icon: Icons.favorite_border,
                    ),

                    //----------button -------
                    SizedBox(
                      width: 20,
                    ),

                    //responsiv_button.dart
                    ResponsiveButton(
                      isResponsive: true,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
