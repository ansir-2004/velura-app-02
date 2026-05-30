import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/colors.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/wishlist_provider.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/get_started_screen.dart';
import 'screens/cart/checkout_screen.dart';
import 'screens/orders/place_order_screen.dart';
import 'widgets/bottom_nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const VeluraApp());
}

class VeluraApp extends StatelessWidget {
  const VeluraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Velura',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.background,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.background,
            elevation: 0,
            iconTheme: IconThemeData(color: AppColors.textPrimary),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            brightness: Brightness.dark,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/':           (_) => const SplashScreen(),
          '/login':      (_) => const LoginScreen(),
          '/register':   (_) => const RegisterScreen(),
          '/getstarted': (_) => const GetStartedScreen(),
          '/home':       (_) => const MainShell(),
          '/cart':       (_) => const CheckoutScreen(),
          '/checkout':   (_) => const CheckoutScreen(),
          '/placeorder': (_) => const PlaceOrderScreen(),
        },
      ),
    );
  }
}