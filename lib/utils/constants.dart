import 'package:flutter/material.dart';
import 'package:fruitbox/resources/color/app_colors.dart';

const KEmailTextFieldDecoration = InputDecoration(
  hintText: 'Email',
  prefixIcon: const Icon(
    Icons.person,
    color: AppColor.primaryColor,
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppColor.primaryButtonColor, // Set border color here
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppColor.blackColor, // Set border color here
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);

///usename textField
const InputDecoration KUsernameTextFieldDecoration = InputDecoration(
  hintText: 'Username',
  prefixIcon: Icon(Icons.person, color: AppColor.primaryColor),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColor.primaryColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColor.blackColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);
