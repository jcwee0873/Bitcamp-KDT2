import 'package:bitcamp_final/constant.dart';
import 'package:bitcamp_final/controllers/payment_controller.dart';
import 'package:bitcamp_final/screens/asset_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayDetailPage extends StatelessWidget {
  PayDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text('상세결제'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () => Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      '구매 상품',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView(
                        children: PaymentController.to.merchandiseList
                            .map((e) => ListTile(
                                title: Text(e.name),
                                subtitle: Text('${f.format(e.price)}원')))
                            .toList(),
                      ),
                    ),
                    Text(
                      '총 결제금액 : ${f.format(PaymentController.to.paymentAmount.value)}원',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              VerticalDivider(),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text(
                      '보유 자산',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: MyAssetList()),
                  ],
                ),
              ),
              VerticalDivider(),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '결제 방법',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    FutureBuilder<Map>(
                      future: PaymentController.to.userCurrency(
                          PaymentController.to.paymentAmount.value),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '결제코인 : ${snapshot.data!['combination'].toString()}'),
                              Text(
                                  '거래이득 : ${f.format(snapshot.data!['spread']).toString()}원'),
                              Text(
                                  '잔돈 : ${f.format(snapshot.data!['change']).toString()}원'),
                            ],
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
