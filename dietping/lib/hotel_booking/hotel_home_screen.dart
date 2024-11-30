import 'package:best_flutter_ui_templates/hotel_booking/hotel_app_theme.dart';
import 'package:best_flutter_ui_templates/hotel_booking/hotel_list_view.dart';
import 'package:best_flutter_ui_templates/hotel_booking/model/hotel_list_data.dart';
import 'package:flutter/material.dart';

class HotelHomeScreen extends StatefulWidget {
  @override
  _HotelHomeScreenState createState() => _HotelHomeScreenState();
}

class _HotelHomeScreenState extends State<HotelHomeScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  List<HotelListData> hotelList = HotelListData.hotelList;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HotelAppTheme.buildLightTheme().backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        /*floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final newHotel = await Navigator.push( //+ 버튼
              context,
              MaterialPageRoute(
                builder: (context) => AddHotelScreen(),
              ),
            );
            if (newHotel != null) {
              setState(() {
                hotelList.add(newHotel);
              });
            }
          },
          child: Icon(Icons.add),
        ),*/
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                getAppBarUI(),
                Expanded(
                  child: NestedScrollView(
                    controller: _scrollController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return Column(
                                children: <Widget>[
                                  getSearchBarUI(),
                                ],
                              );
                            },
                            childCount: 1,
                          ),
                        ),
                      ];
                    },
                    body: Container(
                      color: HotelAppTheme.buildLightTheme().backgroundColor,
                      child: ListView.builder(
                        itemCount: hotelList.length,
                        padding: const EdgeInsets.only(top: 8),
                        itemBuilder: (BuildContext context, int index) {
                          final int count =
                          hotelList.length > 10 ? 10 : hotelList.length;
                          final Animation<double> animation = Tween<double>(
                            begin: 0.0,
                            end: 1.0,
                          ).animate(
                            CurvedAnimation(
                              parent: animationController!,
                              curve: Interval(
                                (1 / count) * index,
                                1.0,
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                          );
                          animationController?.forward();

                          return HotelItem(
                            hotelData: hotelList[index],
                            animation: animation,
                            animationController: animationController,
                            callback: () {
                              // 여기에 아이템 클릭 시의 동작을 추가할 수 있습니다.
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return AppBar(
      title: Text('Community'),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
