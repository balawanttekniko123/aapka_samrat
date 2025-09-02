import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/presentation/Culture_Heritage/provider/culture_heritage_detail_pro.dart';
import 'package:samrat_chaudhary/presentation/feedBack/provider/feedbackProvider.dart';
import 'package:samrat_chaudhary/presentation/leadershipVision/provider/home_provider.dart';
import 'package:samrat_chaudhary/presentation/notification/provider/notificationProvider.dart';
import 'package:samrat_chaudhary/presentation/publicFeedback/provider/subDirectoriesProvider.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/provider/allSchemesCategoryWisePro.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/provider/commonSchemesCategoryWisePro.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/provider/departmentProvider.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/provider/scheme_category_provider.dart';
import 'package:samrat_chaudhary/presentation/cms/provider/cmsProvider.dart';
import 'package:samrat_chaudhary/presentation/editProfile/provider/editProfileProvider.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/provider/govermentProvider.dart';
import 'package:samrat_chaudhary/presentation/socialMedia/provider/youTubeProvider.dart';
import 'package:samrat_chaudhary/presentation/splash_screen.dart';
import 'package:samrat_chaudhary/presentation/youth/provider/youthProvider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'core/api/api_helper.dart';
import 'presentation/Culture_Heritage/provider/districkDetailProvider.dart';
import 'core/network/environment.dart';
import 'core/network/network_info.dart';
import 'core/storage/auth_token_provider.dart';
import 'presentation/publicEngagement_communication/provider/PublicEngagementCommunicationProvider.dart';
import 'presentation/Culture_Heritage/provider/culture_heritage_Provider.dart';
import 'presentation/publicFeedback/provider/directory_Details_provider.dart';
import 'presentation/publicFeedback/provider/directory_category_provider.dart';
import 'presentation/leadershipVision/provider/language_provider.dart';
import 'presentation/publicEngagement_communication/provider/photoBoothProvider.dart';
import 'presentation/scheme_and_policies/provider/policyListProvider.dart';
import 'presentation/scheme_and_policies/provider/scheme_provider.dart';
import 'presentation/auth/provider/user_provider.dart';
import 'data/services/api_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Environment.setEnvironment(AppEnvironment.live);

  final authTokenProvider = AuthTokenProvider();
  final networkInfo = NetworkInfo(); // Or your implementation
  final apiHelper = ApiHelper(networkInfo, authTokenProvider);
  final userService = UserService(apiHelper);
  runApp(MyApp(userService: userService,apiHelper: apiHelper,));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final UserService userService;
  final ApiHelper apiHelper;

  const MyApp({super.key, required this.userService,required this.apiHelper});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpProvider(userService)),
        ChangeNotifierProvider(create: (_) => HomeProvider(userService)),
        ChangeNotifierProvider(create: (_) => SchemeCategoryProvider(userService)),
        ChangeNotifierProvider(create: (_) => DirectoryCategoryProvider(userService)),
        ChangeNotifierProvider(create: (_) => SchemeProvider(userService)),
        ChangeNotifierProvider(create: (_) => SubDirectoryProvider(userService)),
        ChangeNotifierProvider(create: (_) => DirectoryDetailsProvider(userService,apiHelper)),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider2()),
        ChangeNotifierProvider(create: (context) => PhotoBoothProvider(userService),),
        ChangeNotifierProvider(create: (context) => CultureHeritageProvider(userService),),
        ChangeNotifierProvider(create:(context) => DistrictDetailProvider(userService), ),
        ChangeNotifierProvider(create: (context) => YouthProvider(userService),),
        ChangeNotifierProvider(create: (context) => CMSProvider(userService),),
        ChangeNotifierProvider(create: (_) => PublicEngagementCommunicationProvider(userService)),
        ChangeNotifierProvider(create: (_) => EditProfileProvider(userService)),
        ChangeNotifierProvider(create: (_) => PolicyListProvider(userService)),
        ChangeNotifierProvider(create: (context) => GovermentProvider(userService),),
        ChangeNotifierProvider(create: (context) => DepartmentProvider(userService),),
        ChangeNotifierProvider(create: (context) => CultureHeritageDetailProvider(userService),),
        ChangeNotifierProvider(create: (context) => AllSchemesCategoryWisePro(userService),),
        ChangeNotifierProvider(create: (context) => CommonSchemesCategoryWisePro(userService),),
        ChangeNotifierProvider(create: (context) => YouTubeProvider()..fetchLatestVideo()),
        ChangeNotifierProvider(create: (context) => FeedbackProvider(userService)),
        ChangeNotifierProvider(create: (context) => NotificationProvider(userService)),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Samrat Chaudhary',
        //correct buy dhruv sept git par bhi hai
        navigatorKey: navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          primarySwatch: Colors.orange,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        //home: YouTubeScreen(),
      ),
    );
  }
}


