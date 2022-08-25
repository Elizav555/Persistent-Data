import 'package:flutter/material.dart';
import 'package:users_db/pages/add_user_page.dart';
import 'package:users_db/pages/home_page.dart';
import 'package:users_db/pages/user_page.dart';
import 'package:users_db/utils/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Users app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Users List'),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.usersList:
            {
              return MaterialPageRoute(
                builder: (context) {
                  return const HomePage(title: 'Users List');
                },
              );
            }
          case Routes.user:
            {
              final args = settings.arguments as UserArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return UserPage(
                    user: args.user,
                    updateUser: args.updateUser,
                    creditCardNumb: args.creditCardNumb,
                  );
                },
              );
            }
          case Routes.addUser:
            {
              final args = settings.arguments as AddUserArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return AddUserPage(
                    addUser: args.addUser,
                    updateUser: args.updateUser,
                    user: args.user,
                  );
                },
              );
            }
          default:
            {
              assert(false, 'Need to implement ${settings.name}');
              return null;
            }
        }
      },
    );
  }
}
