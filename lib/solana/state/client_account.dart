import 'package:bookreader/solana/state/store.dart';
import 'package:solana/solana.dart' show RPCClient;


import 'base_account.dart';

/*
 * Simple Address Client to watch over an specific address
 */
class ClientAccount extends BaseAccount implements Account {
  final AccountType accountType = AccountType.Client;

  ClientAccount(address, double balance, name, url, TokenTrackers valuesTracker)
      : super(balance, name, url, valuesTracker) {
    this.address = address;
    this.client = RPCClient(this.url);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "address": address,
      "balance": balance,
      "url": url,
      "accountType": accountType.toString(),
      "transactions": transactions.map((tx) => tx.toJson()).toList()
    };
  }
}
