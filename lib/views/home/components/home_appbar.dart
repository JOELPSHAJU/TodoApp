import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:todo/main.dart';
import 'package:todo/utils/constants.dart';

class HomeAppbar extends StatefulWidget {
  const HomeAppbar({super.key, required this.drawerkey});
  final GlobalKey<SliderDrawerState> drawerkey;

  @override
  State<HomeAppbar> createState() => _HomeAppbarState();
}

class _HomeAppbarState extends State<HomeAppbar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool isDrawerOpen = false;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      value: 0.0,
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void onDrawerToggle() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if (isDrawerOpen) {
        animationController.forward();
        widget.drawerkey.currentState!.openSlider();
      } else {
        animationController.reverse();
        widget.drawerkey.currentState!.closeSlider();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var base = BaseWidget.of(context).dataStore.box;
    return SizedBox(
      height: 80,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: onDrawerToggle,
              icon: AnimatedIcon(
                size: 30,
                icon: AnimatedIcons.menu_close,
                progress: animationController,
              ),
            ),
            IconButton(
              onPressed: () {
                base.isEmpty
                    ? notaskDeleteWarning(context)
                    : deleteAllTaskConfirmation(context);
              },
              icon: Icon(
                CupertinoIcons.trash_fill,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
