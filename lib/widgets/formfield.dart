import 'package:atbu_pq/styles/colors.dart';
import 'package:atbu_pq/styles/fonts.dart';
import 'package:flutter/material.dart';

Widget customTextField({
  Widget? prefix,
  Color? color,
  String? hint,
  TextEditingController? controller,
  String? Function(String?)? validator,
  String? Function(String?)? onchanged,
}) {
  return Column(
    children: [
      TextFormField(
        onChanged: onchanged,
        validator: validator,
        controller: controller,
        //maxLines: maxLines,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(width: 1, color: primaryColor)),
          prefixIcon: prefix,
          prefixIconColor: color,
          // ignore: prefer_const_constructors

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: primaryColor,
            ),
          ),
          hintText: hint,
        ),
      )
    ],
  );
}

// password
Widget passwordTextField({
  Widget? prefix,
  Widget? suffix,
  Color? color,
  String? hint,
  TextEditingController? controller,
  String? Function(String?)? validator,
  String? Function(String?)? onchanged,
}) {
  return Column(
    children: [
      TextFormField(
        onChanged: onchanged,
        obscureText: true,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: primaryColor)),
            suffixIcon: suffix,
            suffixIconColor: color,
            prefixIcon: prefix,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: primaryColor,
              ),
            ),
            prefixIconColor: color,
            hintText: hint,
            hintStyle: kbodysmallgreycolor,
            border: const OutlineInputBorder(
                borderSide: BorderSide(),
                borderRadius: BorderRadius.all(Radius.circular(8)))),
      )
    ],
  );
}
