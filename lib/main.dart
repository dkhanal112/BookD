import 'package:bookreader/solana/pages/account_selection.dart';
import 'package:bookreader/solana/pages/create_wallet.dart';
import 'package:bookreader/solana/pages/import_wallet.dart';
import 'package:bookreader/solana/pages/watch_address.dart';
import 'package:bookreader/solana/state/store.dart';
import 'package:bookreader/view/login/loginpage.dart';
import 'package:bookreader/view/navigation/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:worker_manager/worker_manager.dart';

import 'solana/pages/manage_accounts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['fonts'], license);
  });

  await Executor().warmUp();
  StateWrapper store = await createStore();
  runApp(MyApp(
    store,
  ));
}

class MyApp extends StatelessWidget {
  final StateWrapper store;
  late String initialRoute = '/home';

  MyApp(this.store, {Key? key}) : super(key: key) {
    if (store.state.accounts.isEmpty) {
  initialRoute = '/home';
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book Reader',
        theme: ThemeData(),
        initialRoute:initialRoute,
        routes: {
          '/home': (context) => NavigationPage(
                store,
              ),
          '/account_selection': (context) =>
              AccountSelectionPage(store: store),
          '/watch_address': (context) => WatchAddress(store: store),
          '/create_wallet': (context) => CreateWallet(store: store),
          '/import_wallet': (context) => ImportWallet(store: store),
          '/manage_accounts': (context) =>
              ManageAccountsPage(store: store),
        },
        home: FirebaseAuth.instance.currentUser?.uid == null
            ? const LoginPage()
            :  NavigationPage(store),
      ),
    );
  }
}
