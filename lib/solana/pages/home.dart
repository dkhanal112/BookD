import 'package:bookreader/solana/components/home_tab_body.dart';
import 'package:bookreader/solana/state/base_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../state/store.dart';

/*
 * Accounts sub page
 */
class AccountSubPage extends StatelessWidget {
  final StateWrapper store;
  final List<Account> accounts;

  // ignore: use_key_in_widget_constructors
  const AccountSubPage(this.store, this.accounts);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: accounts.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Wallets"),
          actions: <Widget>[
            IconButton(
              icon:const  Icon(
                Icons.manage_accounts_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/manage_accounts");
              },
            )
          ],
          bottom:  PreferredSize(
            preferredSize: const  Size(200.0, 50.0),
            child: TabBar(
              physics:const BouncingScrollPhysics(),
              isScrollable: true,
              tabs: accounts.map(
                (account) {
                  bool isWallet = account.accountType == AccountType.Wallet;
                  IconData icon =
                      isWallet ? Icons.account_balance_wallet_outlined : Icons.person_pin_outlined;

                  return Tab(
                    child: Row(
                      children: [
                        Icon(icon),
                        Padding(
                          padding:const EdgeInsets.only(left: 5),
                          child: Text(account.name),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
        body: TabBarView(
          physics:const BouncingScrollPhysics(),
          children: accounts.map((account) {
            return RefreshIndicator(
              onRefresh: () async {
                // Refresh all account's balances when pulling
                await store.refreshAccounts();
              },
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  // This disables the Material scroll effect when overscrolling
                  // overscroll.disallowGlow();
                  overscroll.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  physics:const AlwaysScrollableScrollPhysics(),
                  child: HomeTabBody(
                    account: account,
                    store: store,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/*
 * Settings sub page
 */
class SettingsSubPage extends StatefulWidget {
  final StateWrapper store;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  SettingsSubPage(this.store);

  @override
  // ignore: unnecessary_this, no_logic_in_create_state
  State<StatefulWidget> createState() => SettingsSubPageState(this.store);
}

class SettingsSubPageState extends State<SettingsSubPage> {
  final StateWrapper store;

  SettingsSubPageState(this.store);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: ListView(
        physics:const BouncingScrollPhysics(),
        children: [
          Card(
            child: InkWell(
              splashColor: Theme.of(context).hoverColor,
              onTap: () async {
                Navigator.pushNamed(context, '/manage_accounts');
              },
              child:const ListTile(
                title:  Text('Manage accounts'),
                trailing: Icon(Icons.manage_accounts_outlined),
              ),
            ),
          ),
          Card(
            child: InkWell(
              splashColor: Theme.of(context).hoverColor,
              onTap: () async {
      
              },
              child:  const ListTile(
                title:  Text('Contribute'),
                trailing: Icon(Icons.link_outlined),
              ),
            ),
          ),
        const  Card(
            child: ListTile(
              title:  Text('Made by Marc Espín'),
              trailing: Icon(Icons.info_outline),
            ),
          )
        ],
      ),
    );
  }

  
}

/*
 * Home Page
 */
class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.store}) : super(key: key);

  final StateWrapper store;

  @override
  // ignore: unnecessary_this, no_logic_in_create_state
  HomePageState createState() => HomePageState(this.store);
}

class HomePageState extends State<HomePage> {
  final StateWrapper store;

  HomePageState(this.store);

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Account>>(converter: (store) {
      Map<String, Account> accounts = store.state.accounts;
      return accounts.entries.map((entry) => entry.value).toList();
    }, builder: (context, accounts) {
      Widget page;

      switch (currentPage) {
        // Settings sub page
        case 1:
          page = SettingsSubPage(store);
          break;

        // Wallet sub page
        default:
          page = AccountSubPage(store, accounts);
      }

      return Scaffold(
        body: page,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int page) {
            setState(() {
              currentPage = page;
            });
          },
          elevation: 0,
          currentIndex: currentPage,
          showUnselectedLabels: false,
          items:const [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.account_balance_wallet),
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: 'Accounts',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
          ],
        ),
      );
    });
  }
}
