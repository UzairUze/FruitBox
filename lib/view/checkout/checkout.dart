import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fruitbox/resources/components/round_button.dart';
import 'package:fruitbox/view/payment/payment.dart';
import 'package:fruitbox/viewmodel/controller/checkout/checkoutController.dart';
import 'package:fruitbox/viewmodel/controller/order/OrderContrioller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheckoutPage extends StatefulWidget {
  final orderId;
  CheckoutPage({super.key, this.orderId});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _checkoutController = Get.put(CheckoutController());
  final _ordercontroller = Get.put(OrderController());

  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(33.6844, 73.0479),
    zoom: 14,
  );

  List<Marker> _marker = <Marker>[
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(33.6844, 73.0479),
      infoWindow: InfoWindow(title: 'My Position'),
    )
  ];

  Future<Position> getCurrentUserLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, StackTrace) {
      print('Error ' + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  loadData() {
    getCurrentUserLocation().then((value) async {
      print('Uzair location is');
      print(value.latitude.toString() + ' ' + value.longitude.toString());

      _marker.add(
        Marker(
          markerId: MarkerId('2'),
          draggable: true,
          position: LatLng(value.latitude, value.longitude),
          onDragEnd: ((newPosition) {
            print(newPosition.latitude);
            print(newPosition.longitude);
          }),
          infoWindow: InfoWindow(title: 'My Current Position'),
        ),
      );

      // Update the address in the controller
      _ordercontroller.fetchAndUpdateAddress(value.latitude, value.longitude);

      CameraPosition cameraPosition = CameraPosition(
        zoom: 14,
        target: LatLng(value.latitude, value.longitude),
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _ordercontroller.cartItems.clear();
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GoogleMap(
              markers: Set<Marker>.of(_marker),
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(16.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                        _ordercontroller.currentAddress.value,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(height: height * 0.02),
                  Text(
                    'Aapka rider pinned location per deliver karega. Aap apne likhay huay patay per aglay page per tabdeelian karsakte hain.',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundButton(
                        width: width * .72,
                        borderRadius: 25,
                        title: 'Confirm address',
                        onPress: () {
                          // _checkoutController.onConfirmAddress();
                          Get.to(() => PaymentScreen(
                                orderID: widget.orderId.toString(),
                              ));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
