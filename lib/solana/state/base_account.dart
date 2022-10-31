import 'dart:async';

import 'package:bookreader/solana/state/store.dart';
import 'package:solana/solana.dart';

class Token {
  late double balance = 0;
  late String usdBalance = "0";
  late String symbol;
  late String mint;

  Token(this.balance, this.mint, this.symbol);
}

class BaseAccount {
  final AccountType accountType = AccountType.Wallet;
  final String url;
  late String name;

  late RPCClient client;
  late String address;

  late double balance = 0;
  late double usdBalance = 0;
  late TokenTrackers valuesTracker;
  late List<Transaction> transactions = [];
  late List<Token> tokens = [];

  BaseAccount(this.balance, this.name, this.url, this.valuesTracker);

  /*
   * Refresh the account balance
   */
  Future<void> refreshBalance() async {
    int balance = await client.getBalance(address);
    this.balance = balance.toDouble() / 1000000000;
    this.usdBalance = this.balance * valuesTracker.getTokenValue(system_program_id);

    for (final token in tokens) {
      updateUsdFromTokenValue(token);
    }
  }

  /*
   * Sum a token value into the account's global USD balance
   */
  void updateUsdFromTokenValue(Token token) {
    try {
      Tracker? tracker = valuesTracker.getTracker(token.mint);
      if (tracker != null) {
        double tokenUsdBalance = (token.balance * tracker.usdValue);
        token.usdBalance = tokenUsdBalance.toString();
        usdBalance += tokenUsdBalance;
      }
    } catch (err) {
      print(err);
    }
  }

  /*
    * Loads all the tokens (spl-program mints) owned by this account
   */
  Future<void> loadTokens() async {
    tokens = [];
    Completer completer =  Completer();

    Iterable<AssociatedTokenAccount> tokenAccounts = await client.getTokenAccountsByOwner(
      owner: address,
      programId: token_program_id,
    );

    int completedTokenAccounts = 0;
    for (final tokenAccount in tokenAccounts) {
      var data = tokenAccount.account.data;
      if (data != null) {
        data.when(
          splToken: (parsed) async {
            double decimals = double.parse("1" + "0" * (parsed.info.tokenAmount.decimals));
            double balance = double.parse(parsed.info.tokenAmount.amount) / decimals;
            String tokenMint = parsed.info.mint;

            // Start tracking the token
            Tracker? tracker = valuesTracker.addTrackerByProgramMint(tokenMint);
            String symbol =
                tracker != null ? tracker.symbol : valuesTracker.getTokenInfo(tokenMint).symbol;

            // Add the token to this account
            tokens.add( Token(balance, tokenMint, symbol));

            completedTokenAccounts++;

            if (completedTokenAccounts == tokenAccounts.length) {
              completer.complete();
            }
          },
          empty: () {},
          fromBytes: (List<int> bytes) {},
          fromString: (String string) {},
          generic: (Map<String, dynamic> data) {},
        );
      }
    }

    // Complete the completer if the account has no tokens
    if (tokenAccounts.isEmpty) {
      completer.complete();
    }

    return completer.future;
  }

  /*
   * Load the Address's transactions into the account
   */
  Future<void> loadTransactions() async {
    final response = await client.getTransactionsList(address);

    for (var tx in response) {
      ParsedMessage? message = tx.transaction.message;
      if (message != null) {
        ParsedInstruction instruction = message.instructions[0];
        dynamic res = instruction.toJson();
        if (res['program'] == 'system') {
          dynamic parsed = res['parsed'].toJson();
          switch (parsed['type']) {
            case 'transfer':
              dynamic transfer = parsed['info'].toJson();
              bool receivedOrNot = transfer['destination'] == address;
              double ammount = transfer['lamports'] / 1000000000;
              transactions.add( Transaction(
                  transfer['source'], transfer['destination'], ammount, receivedOrNot));
              break;
            default:
              // Unsupported transaction type
              transactions.add( UnsupportedTransaction());
          }
        } else {
          // Unsupported program
        transactions.add( UnsupportedTransaction());
        }
      } else {
        return;
      }
    }
  }
}

/*
 * WalletAccount and ClientAccount implement this
 */
abstract class Account {
  final AccountType accountType;
  late String name;
  final String url;

  late double balance = 0;
  late double usdBalance = 0;
  late String address;
  late TokenTrackers valuesTracker;
  late List<Transaction> transactions = [];
  late List<Token> tokens = [];

  Account(this.accountType, this.name, this.url);

  void updateUsdFromTokenValue(Token token);
  Future<void> refreshBalance();
  Future<void> loadTransactions();
  Future<void> loadTokens();

  Map<String, dynamic> toJson();
}

class Transaction {
  final String origin;
  final String destination;
  final double ammount;
  final bool receivedOrNot;

  Transaction(this.origin, this.destination, this.ammount, this.receivedOrNot);

  Map<String, dynamic> toJson() {
    return {
      "origin": origin,
      "destination": destination,
      "ammount": ammount,
      "receivedOrNot": receivedOrNot
    };
  }

  static Transaction fromJson(dynamic tx) {
    return  Transaction(tx["origin"], tx["destination"], tx["ammount"], tx["receivedOrNot"]);
  }
}

class UnsupportedTransaction extends Transaction {
  UnsupportedTransaction() : super("Unknown", "Unknown", 0.0, false);
}
