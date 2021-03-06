import 'package:bitcamp_final/constant.dart';
import 'package:bitcamp_final/controllers/asset_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssetPage extends StatelessWidget {
  AssetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(padding: const EdgeInsets.all(10), child: MyAssetList()),
    );
  }
}

class MyAssetList extends StatelessWidget {
  MyAssetList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: AssetController.to.getMarketData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: code_list
                  .map((e) => Market(code: e, marketData: snapshot.data![e]))
                  .toList(),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class Market extends StatelessWidget {
  Market({Key? key, required this.code, required this.marketData})
      : super(key: key);
  String code;
  Map marketData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(20),
      child: Obx(
        () => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        code,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 100),
                      Text(
                        '???????????? : ${f.format(AssetController.to.assets[code] * AssetController.to.prices[code]).toString()}???',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Text('???????????? : ${AssetController.to.assets[code].toString()}')
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Upbit : ${f.format(marketData['Upbit'])}???'),
                  Text(
                      'Upbit ?????? : ${marketData['Upbit_dollar'].toStringAsFixed(4)}??????'),
                  Text(
                      '?????? ?????????2 : ${marketData['Upbit_dum'].toStringAsFixed(4)}??????'),
                  Text(
                      'Bifinex : ${marketData['Investing'].toStringAsFixed(4)}??????'),
                  Text(
                      '?????? ?????????2 : ${marketData['Investing_dum1'].toStringAsFixed(4)}??????'),
                  Text(
                      '?????? ?????????3 : ${marketData['Investing_dum2'].toStringAsFixed(4)}??????'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
