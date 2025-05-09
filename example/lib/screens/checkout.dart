/*
 * Copyright (c) Juspay Technologies.
 *
 * This source code is licensed under the AGPL 3.0 license found in the
 * LICENSE file in the root directory of this source tree.
 */

import 'package:flutter/material.dart';
import 'package:hypersdkflutter/hypersdkflutter.dart';

import '../widgets/app_bar.dart';
import '../widgets/bottom_button.dart';
import './payment_page.dart';
import './payment_page_container.dart';

class CheckoutScreen extends StatefulWidget {
  final int productOneCount;
  final int productTwoCount;
  final HyperSDK hyperSDK;
  final Map<String, dynamic> merchantDetails;
  final Map<String, dynamic> customerDetails;

  const CheckoutScreen(
      {Key? key,
      required this.productOneCount,
      required this.productTwoCount,
      required this.hyperSDK,
      required this.merchantDetails,
      required this.customerDetails})
      : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  var useContainer = false;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    var amounts = calculateAmount();

    // uncomment for Payment Widget
    // Map<String, dynamic> payload = getProcessPayload1( "2.0", widget.merchantDetails, widget.customerDetails);

    return Scaffold(
      appBar: customAppBar(text: "Checkout Screen"),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: const Color(0xFFF8F5F5),
            height: screenHeight / 12,
            child: Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                child: const Text(
                  "Call process on HyperServices instance on Checkout Button Click",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                )),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20, top: 15),
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                  "Cart Details",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFfFB8D33),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFf5f5f5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Product 1",
                    ),
                    Text("x${widget.productOneCount}"),
                    const Text("₹ 1")
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFf5f5f5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Product 2",
                    ),
                    Text("x${widget.productTwoCount}"),
                    const Text("₹ 1")
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20, top: 15),
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                  "Amount",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFfFB8D33),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFf5f5f5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Amount",
                    ),
                    Text("₹ ${amounts['totalAmount']}")
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFf5f5f5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Tax",
                    ),
                    Text("₹ ${amounts['tax']}"),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFf5f5f5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Payable Amount",
                    ),
                    Text("₹ ${amounts['totalPayable']}")
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const Text(
                  "Use Container?",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFfFB8D33),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Switch(
                    value: useContainer,
                    onChanged: (value) {
                      setState(() {
                        useContainer = !useContainer;
                      });
                      // Uncoment for Update order of Payment Widget
                      // widget.hyperSDK.process(getUpdateOrderPayload("yJczz4s5b2", widget.merchantDetails, widget.customerDetails, "4.0"), hyperSDKCallbackHandler);
                    },
                  ))
            ],
          ),
          BottomButton(
            height: screenHeight / 10,
            text: "Checkout",
            onpressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                if (useContainer) {
                  print('HH useContainer - true');
                  return ContainerPaymentPage(
                      hyperSDK: widget.hyperSDK,
                      amount: amounts['totalAmount'].toString(),
                      merchantDetails: widget.merchantDetails,
                      customerDetails: widget.customerDetails);
                } else {
                  print('HH useContainer - false');
                  return PaymentPage(
                      hyperSDK: widget.hyperSDK,
                      amount: amounts['totalAmount'].toString(),
                      merchantDetails: widget.merchantDetails,
                      customerDetails: widget.customerDetails);
                }
              }),
            ),
          ),
          // Uncomment for Payment Widget 
          // Container(
          //   height: 110,
          //   width: double.infinity,
          //   child: widget.hyperSDK.hyperFragmentView (
          //         110,
          //         double.infinity,
          //         "paymentWidget",
          //         payload, 
          //         hyperSDKCallbackHandler
          //       ),
          // ),
        ],
      ),
    );
  }

  Map<String, double> calculateAmount() {
    var amounts = <String, double>{};

    amounts["totalAmount"] =
        (widget.productOneCount + widget.productTwoCount).toDouble();

    amounts["tax"] = (amounts["totalAmount"] ?? 0) * 0.01;

    amounts["totalPayable"] =
        (amounts["totalAmount"] ?? 0) + (amounts["tax"] ?? 0);

    return amounts;
  }

  // uncomment for Payment Widget
  // void hyperSDKCallbackHandler(MethodCall methodCall) {
  // }
}
