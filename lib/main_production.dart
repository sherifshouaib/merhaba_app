import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/routing/app_router.dart';
import 'package:merhaba/core/utils/globals.dart';
import 'package:merhaba/core/utils/providers/app_settings_provider.dart';
import 'package:merhaba/core/utils/providers/bottom_navbar_view_provider.dart';
import 'package:merhaba/core/utils/providers/location_viewer_provider.dart';
import 'package:merhaba/core/utils/providers/login_provider.dart';
import 'package:merhaba/core/utils/providers/create_account_provider.dart';
import 'package:merhaba/core/utils/providers/new_post_provider.dart';
import 'package:merhaba/core/utils/providers/post_provider.dart';
import 'package:merhaba/core/utils/providers/profile_tab_provider.dart';
import 'package:merhaba/core/utils/providers/timeline_provider.dart';
import 'package:merhaba/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

final FlutterLocalization localization = FlutterLocalization.instance;

final FlutterSecureStorage secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
  iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
);

final appLinks = AppLinks();

Future<void> initDeepLink() async {
  // 🔥 لو التطبيق كان مقفول
  final uri = await appLinks.getInitialLink();

  if (uri != null) {
    debugPrint("🔥 Initial Link: $uri");
    handleUri(uri); // ✅ استخدمها هنا
  }

  // 🔥 لو التطبيق مفتوح
  appLinks.uriLinkStream.listen((uri) {
    debugPrint("🔥 Stream Link: $uri");
    handleUri(uri); // ✅ وهنا
  });
}

void handleUri(Uri uri) {
  debugPrint("🔥 FULL URI: $uri");

  final code = uri.queryParameters['code'];
  final isRecovery = uri.fragment.contains('type=recovery');
  debugPrint("query: ${uri.queryParameters}");
  debugPrint("fragment: ${uri.fragment}");
  if (code != null || isRecovery) {
    debugPrint("✅ Recovery flow detected");
    Future.delayed(const Duration(milliseconds: 900), () {
      AppRouter.router.push(AppRouter.kUpdatePasswordView);
    });
    //  AppRouter.router.push(AppRouter.kUpdatePasswordView);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint(e.toString());
  }

  try {
    await Supabase.initialize(
      url: dotenv.env["SUPABASE_URL"].toString(),
      anonKey: dotenv.env["SUPABASE_KEY"].toString(),
    );
  } catch (e) {
    debugPrint(e.toString());
  }

  try {
    await FlutterLocalization.instance.ensureInitialized();
  } catch (e) {
    debugPrint(e.toString());
  }

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint(e.toString());
  }

  try {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode != null) {
      if (savedThemeMode == AdaptiveThemeMode.light) {
        Globals.theme = "Light";
      } else {
        Globals.theme = "Dark";
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  try {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
  } catch (e) {
    debugPrint(e.toString());
  }

  // runApp(const MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => CreateAccountProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavBarViewProvider()),
        ChangeNotifierProvider(create: (_) => ProfileTabProvider()),
        ChangeNotifierProvider(create: (_) => AppSettingsProvider()),
        ChangeNotifierProvider(create: (_) => NewPostProvider()),
        ChangeNotifierProvider(create: (_) => LocationViewerProvider()),
        ChangeNotifierProvider(create: (_) => TimelineProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: const Merhaba(),
    ),
  );
}

class Merhaba extends StatefulWidget {
  const Merhaba({super.key});

  @override
  State<Merhaba> createState() => _MerhabaState();
}

class _MerhabaState extends State<Merhaba> {
  @override
  void initState() {
    super.initState();

    localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('ar', AppLocale.AR),
      ],
      initLanguageCode: 'en',
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initDeepLink();
    });
  }

  // the setState function here is a must to add
  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => ScreenUtilInit(
        designSize: const Size(375, 812), // مقاس التصميم من Figma
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return FluentApp.router(
            routerConfig: AppRouter.router,
            supportedLocales: localization.supportedLocales,
            localizationsDelegates: localization.localizationsDelegates,
            title: 'Merhaba App',
            theme: theme == ThemeData.light(useMaterial3: true)
                ? FluentThemeData.light()
                : FluentThemeData.dark(),
            darkTheme: darkTheme == ThemeData.dark(useMaterial3: true)
                ? FluentThemeData.dark()
                : FluentThemeData.light(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
