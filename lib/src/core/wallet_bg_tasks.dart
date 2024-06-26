// ignore_for_file: empty_catches
import 'dart:async';
import 'dart:convert';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/states/static/wallet_static_state.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:http/http.dart' as http;

class WalletBgTasks {
  static void runScanTask(Timer timer) async {
    try {
      await fetchData();
    } catch (e) {}
  }

  static Future runConversionTask(Timer timer) async {
    if (!BaseStaticState.homePageShownOnce) return;

    await WalletBgTasks.fetchConversionRateIfPossible();
  }

  static Future fetchConversionRateIfPossible() async {
    if (BaseStaticState.setConversionRateManually) return;
    try {
      var response =
          await http.get(Uri.parse(BaseStaticState.conversionApiAddress));
      var json = jsonDecode(response.body);
      double convRate = json['price'].toDouble();
      WalletHelper.updateConversionRate(convRate);
    } catch (e) {}
  }

  static fetchData() async {
    if (!WalletStaticState.walletWatching) return;

    for (var addr in WalletHelper.getAllAddresses()) {
      await WalletHelper.reloadTxes(addr);
    }

    await WalletHelper.uiReload();
  }
}
