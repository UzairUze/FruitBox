import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '';
import '../color/app_colors.dart';

class internetExceptionWidget extends StatefulWidget {
  final VoidCallback onPress;

  const internetExceptionWidget({Key? key, required this.onPress})
      : super(key: key);

  @override
  State<internetExceptionWidget> createState() =>
      _internetExceptionWidgetState();
}

class _internetExceptionWidgetState extends State<internetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    /// here is we show the internet Exceptions widget
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: height * .14,
          ),
          Icon(
            Icons.cloud_off,
            color: AppColor.redColor,
            size: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
                child: Text(
              'internet_exception'.tr,
              textAlign: TextAlign.center,
            )),
          ),
          SizedBox(
            height: height * .1,
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
