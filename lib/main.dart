import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mollet/dependency_injection.dart';
import 'package:mollet/model/services/auth_service.dart';
import 'package:mollet/screens/getstarted_screens/intro_screen.dart';
import 'package:mollet/screens/home_screens/home.dart';
import 'package:mollet/screens/home_screens/settings.dart';
import 'package:mollet/screens/register_screens/login_screen.dart';
import 'package:mollet/screens/register_screens/registration_screen.dart';
import 'package:mollet/screens/register_screens/reset_screen.dart';
import 'package:mollet/screens/register_screens/verification_screen.dart';
import 'package:mollet/screens/settings_screens/cards.dart';
import 'package:mollet/screens/settings_screens/changePassword.dart';
import 'package:mollet/screens/settings_screens/editProfile.dart';
import 'package:mollet/screens/settings_screens/inviteFriend.dart';
import 'package:mollet/screens/settings_screens/passwordSecurity.dart';
import 'package:mollet/widgets/provider.dart';
import 'package:mollet/widgets/tabsLayout.dart';

// import 'model/services/provider.dart';

void main() async {
  Injector.configure(Flavor.MOCK);

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

final routes = {
  '/Registration': (BuildContext context) => RegistrationScreen(),
  '/Homescreen': (BuildContext context) => HomeScreen(),
  '/Verification': (BuildContext context) => VerificationScreen(),
  '/Login': (BuildContext context) => LoginScreen(),
  '/Reset': (BuildContext context) => ResetScreen(),
  '/home': (BuildContext context) => HomeController(),
  '/EditProfile': (BuildContext context) => EditProfile(),
  '/Settings': (BuildContext context) => SettingsScreen(),
  '/Security': (BuildContext context) => SecurityScreen(),
  '/ChangePassword': (BuildContext context) => ChangePasswordScreen(),
  '/Cards': (BuildContext context) => Cards(),
  '/InviteFriend': (BuildContext context) => InviteFriendScreen(),
  '/MyTabs': (BuildContext context) => TabsLayout(),
};

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: HomeController(),
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  const HomeController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;

    return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final bool signedIn = snapshot.hasData;
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: signedIn ? TabsLayout() : IntroScreen(),
            );
          }
          return CircularProgressIndicator();
        });
  }
}
