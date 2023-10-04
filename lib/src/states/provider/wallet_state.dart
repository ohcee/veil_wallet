import 'package:flutter/foundation.dart';
import 'package:veil_light_plugin/veil_light.dart';

class OwnedAddress {
  final AccountType accountType;
  final String address;

  OwnedAddress(this.accountType, this.address);
}

class WalletState with ChangeNotifier, DiagnosticableTreeMixin {
  int _selectedWallet = -1;
  String _selectedAddress = '';
  List<OwnedAddress> _ownedAddresses = [];
  double _balance = 0.0;
  double _conversionRate = 0.0;

  int get selectedWallet => _selectedWallet;
  String get selectedAddress => _selectedAddress;
  List<OwnedAddress> get ownedAddresses => _ownedAddresses;
  double get balance => _balance;
  double get conversionRate => _conversionRate;

  void setSelectedWallet(int wal) {
    _selectedWallet = wal;
    notifyListeners();
  }

  void setSelectedAddress(String addr) {
    _selectedAddress = addr;
    notifyListeners();
  }

  void setOwnedAddresses(List<OwnedAddress> addresses) {
    _ownedAddresses = addresses;
    notifyListeners();
  }

  void setBalance(double balance) {
    _balance = balance;
    notifyListeners();
  }

  void setConversionRate(double convRate) {
    _conversionRate = convRate;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('selectedWallet', _selectedWallet));
  }
}