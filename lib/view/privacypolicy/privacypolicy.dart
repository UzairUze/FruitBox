import 'package:flutter/material.dart';
import 'package:fruitbox/resources/color/app_colors.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final padding = mediaQuery.padding;

    // Calculate responsive sizes
    double fontSizeTitle = screenWidth * 0.06; // 6% of screen width
    double fontSizeSubTitle = screenWidth * 0.05; // 5% of screen width
    double fontSizeBody = screenWidth * 0.04; // 4% of screen width

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: TextStyle(
            color: Color(0xff27214D),
            fontSize: fontSizeTitle,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColor.primaryColor,
        iconTheme: IconThemeData(color: Color(0xff27214D)),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: fontSizeTitle,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff27214D),
                ),
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing
              Text(
                'Introduction',
                style: TextStyle(
                  fontSize: fontSizeSubTitle,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff5D577E),
                ),
              ),
              SizedBox(height: screenHeight * 0.01), // Responsive spacing
              Text(
                'Welcome to FruitBox! Your privacy is important to us. This Privacy Policy explains how we collect, use, and safeguard your information when you use our mobile application. Please read this policy carefully.',
                style:
                    TextStyle(color: Color(0xff27214D), fontSize: fontSizeBody),
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing
              Text(
                'Information Collection',
                style: TextStyle(
                  fontSize: fontSizeSubTitle,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff5D577E),
                ),
              ),
              SizedBox(height: screenHeight * 0.01), // Responsive spacing
              Text(
                'We may collect information about you when you use our app, including but not limited to your personal information, browsing behavior, and preferences. This helps us improve our services and provide a better user experience.',
                style:
                    TextStyle(color: Color(0xff27214D), fontSize: fontSizeBody),
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing
              Text(
                'Use of Information',
                style: TextStyle(
                  fontSize: fontSizeSubTitle,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff5D577E),
                ),
              ),
              SizedBox(height: screenHeight * 0.01), // Responsive spacing
              Text(
                'The information we collect is used to enhance our services, provide customer support, and improve your experience. We may also use your information to communicate with you about updates, promotions, and offers.',
                style:
                    TextStyle(color: Color(0xff27214D), fontSize: fontSizeBody),
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing
              Text(
                'Data Security',
                style: TextStyle(
                  fontSize: fontSizeSubTitle,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff5D577E),
                ),
              ),
              SizedBox(height: screenHeight * 0.01), // Responsive spacing
              Text(
                'We take reasonable measures to protect your information from unauthorized access, use, or disclosure. However, no method of transmission over the internet or electronic storage is completely secure.',
                style:
                    TextStyle(color: Color(0xff27214D), fontSize: fontSizeBody),
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing
              Text(
                'Changes to This Privacy Policy',
                style: TextStyle(
                  fontSize: fontSizeSubTitle,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff5D577E),
                ),
              ),
              SizedBox(height: screenHeight * 0.01), // Responsive spacing
              Text(
                'We may update this Privacy Policy from time to time. Any changes will be posted on this page, and you are encouraged to review this policy periodically.',
                style:
                    TextStyle(color: Color(0xff27214D), fontSize: fontSizeBody),
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: fontSizeSubTitle,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff5D577E),
                ),
              ),
              SizedBox(height: screenHeight * 0.01), // Responsive spacing
              Text(
                'If you have any questions or concerns about this Privacy Policy, please contact us at support@fruitbox.com.',
                style:
                    TextStyle(color: Color(0xff27214D), fontSize: fontSizeBody),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
