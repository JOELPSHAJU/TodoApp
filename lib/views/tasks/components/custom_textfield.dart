import 'package:flutter/material.dart';
import 'package:todo/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.size,
      required this.controller,
      this.isDescription = false,
      required this.onFieldSubmitted,
      required this.onChanged});

  final Size size;
  final TextEditingController? controller;
  final bool isDescription;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
        title: TextFormField(
          cursorHeight: isDescription ? 20 : 30,
          cursorColor: AppColors.primarycolor,
          cursorWidth: 2,
          controller: controller,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          maxLines: isDescription ? 2 : 4,
          minLines: isDescription ? 1 : 1,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: !isDescription ? size.width * .06 : 15,
              decoration: TextDecoration.none),
          decoration: InputDecoration(
            prefixIcon: isDescription
                ? const Icon(
                    Icons.bookmark_border_outlined,
                    color: AppColors.primarycolor,
                  )
                : null,
            contentPadding: EdgeInsets.only(left: isDescription ? 0 : 10),
            hintText: isDescription ? 'Add description' : 'Add Title..',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade600),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.primarycolor, width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.primarycolor),
            ),
          ),
        ),
      ),
    );
  }
}

