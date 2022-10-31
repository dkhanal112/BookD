import 'package:bookreader/solana/dialogs/account_info.dart';
import 'package:bookreader/solana/dialogs/editing_account.dart';
import 'package:bookreader/solana/dialogs/remove_account.dart';
import 'package:bookreader/solana/state/base_account.dart';
import 'package:bookreader/solana/state/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';


class ManageAccountsPage extends StatefulWidget {
  final StateWrapper store;

  const ManageAccountsPage({Key? key, required this.store}) : super(key: key);

  @override
  // ignore: unnecessary_this, no_logic_in_create_state
  State<StatefulWidget> createState() => ManageAccountsPageState(this.store);
}

class ManageAccountsPageState extends State<ManageAccountsPage> {
  final StateWrapper store;

  ManageAccountsPageState(this.store);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accounts"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add_alt_1_outlined),
        onPressed: () {
          Navigator.pushNamed(context, "/account_selection");
        },
      ),
      body: Padding(
        padding:const EdgeInsets.all(20),
        child: StoreConnector<AppState, List<Account>>(
          converter: (store) {
            Map<String, Account> accounts = store.state.accounts;
            return accounts.entries.map((entry) => entry.value).toList();
          },
          builder: (context, accounts) {
            return ListView(
              shrinkWrap: true,
              physics:const BouncingScrollPhysics(),
              children: accounts.map((account) {
                return Card(
                  child: ListTile(
                    subtitle:const Text("Press for more info"),
                    trailing: IconButton(
                      icon: const Icon(Icons.mode_edit_outline_outlined),
                      onPressed: () {
                        editAccountDialog(context, store, account);
                      },
                    ),
                    enableFeedback: true,
                    title:
                        Text('${account.name} (${account.address.toString().substring(0, 5)}...)'),
                    leading: IconButton(
                      icon:const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        removeAccountDialog(store, context, account);
                      },
                    ),
                    onTap: () {
                      accountInfoDialog(context, account);
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
