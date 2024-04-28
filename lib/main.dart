import 'package:expense_tracker_2024/constants/constants.dart';
import 'package:expense_tracker_2024/model/accounts_model.dart';
import 'package:expense_tracker_2024/model/category_model.dart';
import 'package:expense_tracker_2024/model/transaction_model.dart';
import 'package:expense_tracker_2024/view/screens/splash.dart';
import 'package:expense_tracker_2024/viewModel/accounts_view_model.dart';
import 'package:expense_tracker_2024/viewModel/category_view_model.dart';
import 'package:expense_tracker_2024/viewModel/transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initializing Hive local database
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(AccountsModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  await Hive.openBox<TransactionModel>(HIVE_TRANSACTION_BOX_NAME);
  await Hive.openBox<AccountsModel>(HIVE_ACCOUNTS_BOX_NAME);
  await Hive.openBox<CategoryModel>(HIVE_CATEGORY_BOX_NAME);

  // runApp(
  //   DevicePreview(
  //     builder: (context) => const MyApp(),
  //     enabled: !kReleaseMode,
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionViewModel()),
        ChangeNotifierProvider(create: (_) => AccountsViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
