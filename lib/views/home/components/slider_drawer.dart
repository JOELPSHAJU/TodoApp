import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/constants.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({super.key});
  static const List<IconData> iconList = [
    CupertinoIcons.profile_circled,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle,
    Icons.exit_to_app_outlined
  ];
  static const List<String> textList = ['Profile', 'Settings', 'Info', 'Exit'];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 80),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.primaryGradientColor)),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png'),
          ),
          h10,
          Text(
            'UserName',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: AppColors.white),
          ),
          h20,
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: iconList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: ListTile(
                      leading: Icon(
                        iconList[index],
                        color: AppColors.white,
                      ),
                      title: Text(
                        textList[index],
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
