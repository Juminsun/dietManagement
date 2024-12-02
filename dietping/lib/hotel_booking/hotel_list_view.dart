import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/hotel_booking/hotel_app_theme.dart';
import 'package:best_flutter_ui_templates/hotel_booking/model/hotel_list_data.dart'; // HotelListData import

class HotelListView extends StatelessWidget {
  const HotelListView({
    Key? key,
    this.hotelData,
    this.animationController,
    this.animation,
    this.callback,
  }) : super(key: key);

  final VoidCallback? callback;
  final HotelListData? hotelData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 2,
                              child: Image.network(
                                hotelData!.imagePath, // 이미지 표시
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              color: HotelAppTheme.buildLightTheme()
                                  .backgroundColor,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      hotelData!.titleTxt,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      hotelData!.subTxt,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color:
                                          Colors.grey.withOpacity(0.8)),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Calories: ${hotelData!.calories}',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
