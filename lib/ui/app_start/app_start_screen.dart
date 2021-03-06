import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pusher_test/consts/app_colors.dart';
import 'package:pusher_test/ui/home/home_screen.dart';

class AppStartScreen extends StatefulWidget {
  static const routeName = 'app_start_screen';
  const AppStartScreen({Key? key}) : super(key: key);

  @override
  State<AppStartScreen> createState() => _AppStartScreenState();
}

class _AppStartScreenState extends State<AppStartScreen> {
  int selectedIndex = 0;
  List<Widget> screens = [HomeScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[0],
      bottomNavigationBar: Container(
        width: double.infinity,
        height: kBottomNavigationBarHeight + 20,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(color: Color.fromARGB(4, 0, 0, 0), offset: Offset(0, -1), blurRadius: 1.0, spreadRadius: 1.0)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomNavItem(
                title: 'Home',
                faIcon: FontAwesomeIcons.home,
                totalIndex: 4,
                isSelected: selectedIndex == 0,
                onSelected: () {
                  onSelected(0);
                }),
            CustomNavItem(
                title: 'Cal',
                faIcon: FontAwesomeIcons.calendar,
                totalIndex: 4,
                isSelected: selectedIndex == 1,
                onSelected: () {
                  onSelected(1);
                }),
            CustomNavItem(
                title: 'Noti',
                faIcon: FontAwesomeIcons.bell,
                totalIndex: 4,
                isSelected: selectedIndex == 2,
                onSelected: () {
                  onSelected(2);
                }),
            CustomNavItem(
                title: 'Setting',
                faIcon: FontAwesomeIcons.ellipsisVertical,
                totalIndex: 4,
                isSelected: selectedIndex == 3,
                onSelected: () {
                  onSelected(3);
                }),
          ],
        ),
      ),
    );
  }

  void onSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class CustomNavItem extends StatelessWidget {
  final IconData faIcon;
  final String title;
  final int totalIndex;
  final bool isSelected;
  final Function onSelected;
  CustomNavItem(
      {required this.isSelected,
      required this.title,
      required this.faIcon,
      required this.onSelected,
      required this.totalIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected();
      },
      child: AnimatedContainer(
        width: isSelected ? MediaQuery.of(context).size.width * (totalIndex * 0.07) : 50,
        duration: Duration(milliseconds: 400),
        curve: Curves.linear,
        decoration: isSelected
            ? BoxDecoration(
                border: Border.all(color: AppColors.inActiveGrey),
                borderRadius: BorderRadius.all(Radius.circular(20.0)))
            : BoxDecoration(
                border: Border.all(color: Colors.transparent), borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: FaIcon(
                  faIcon,
                  size: 18,
                  color: isSelected ? AppColors.activeGrey : AppColors.inActiveGrey,
                ),
              ),
              // isSelected ? SizedBox(width: 8) : SizedBox(),
              isSelected
                  ? Expanded(
                      child: Text(
                        title,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
