import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '';
import '../color/app_colors.dart';

class generalExceptionWidget extends StatefulWidget {
  final VoidCallback onPress;

  const generalExceptionWidget({super.key, required this.onPress});

  @override
  State<generalExceptionWidget> createState() => _generalExceptionWidgetState();
}

class _generalExceptionWidgetState extends State<generalExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    ///here is we show the General Exceptions widget
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: height * .14,
          ),
          Icon(
            Icons.error_outline,
            color: AppColor.redColor,
            size: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
                child: Text(
              'general_exception'.tr,
              textAlign: TextAlign.center,
            )),
          ),
          SizedBox(
            height: height * .1,
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: widget.onPress,
            child: Container(
              height: 45,
              width: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColor.primaryColor),
              child: Center(
                child: Text(
                  'Retry',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
