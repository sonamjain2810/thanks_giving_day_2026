import 'dart:async';
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:thanks_giving_day/AdManager/ad_manager.dart';
import 'package:thanks_giving_day/Singleton/project_manager.dart';
import 'package:thanks_giving_day/utils/pass_data_between_screens.dart';
import 'AdManager/ad_helper.dart';
import 'Enums/project_routes_enum.dart';
import 'data/Messages.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/AppStoreAppsItemWidget1.dart';
import 'widgets/CustomBannerWidget.dart';
import 'widgets/CustomFBTextWidget.dart';
import 'widgets/CustomFeatureCard.dart';
import 'data/Gifs.dart';
import 'data/Images.dart';
import 'data/Quotes.dart';
import 'data/Status.dart';
import 'utils/SizeConfig.dart';
import 'MyDrawer.dart';
import 'widgets/CustomTextOnlyWidget.dart';
import 'widgets/DesignerContainer.dart';

// Height = 8.96
// Width = 4.14

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    implements ProjectListener, AdListener {
  String _authStatus = 'Unknown';

  BannerAd? _bannerAd;
  ProjectManager projectManager = ProjectManager.instance;
  AdManager adManager = AdManager.instance;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback(
      (_) => initPlugin(),
    );

    projectManager.listener = this;

    adManager.adListener = this;

    projectManager.startApp();

    adManager.loadAdsInAdManager();
  }

  BannerAd loadBannerAd() {
    return BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    debugPrint("Home Page: Dispose Called");
    projectManager.listener = null;
    adManager.adListener = null;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final TrackingStatus status =
          await AppTrackingTransparency.requestTrackingAuthorization();

      switch (status) {
        case TrackingStatus.authorized:
          debugPrint("Tracking Status Authorized");
          break;
        case TrackingStatus.denied:
          debugPrint("Tracking Status Denied");
          break;
        case TrackingStatus.notDetermined:
          debugPrint("Tracking Status not Determined");
          break;
        case TrackingStatus.notSupported:
          debugPrint("Tracking Status not Supported");
          break;
        case TrackingStatus.restricted:
          debugPrint("Tracking Status Restricted");
          break;
        default:
      }
    } on PlatformException {
      //setState(() => authStatus = 'PlatformException was thrown');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    debugPrint("UUID: $uuid");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: Theme.of(context).appBarTheme.toolbarTextStyle,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            TriColorBackground(size: size, color: Colors.white70, isLeft: true),
            TriColorBackground(
                size: size, color: Colors.white70, isLeft: false),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  DesignerContainer(
                    isLeft: false,
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: Center(
                        child: Text("Choose Your Type of Wishes From Below",
                            style: Theme.of(context).textTheme.headlineSmall),
                      ),
                    ),
                  ),

                  const Divider(),

                  // Wishes Start
                  DesignerContainer(
                    isLeft: true,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text("Select Your Languages For Wishes  ",
                              style: Theme.of(context).textTheme.headlineSmall),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                InkWell(
                                  child: CustomTextOnlyWidget(
                                    language: "English",
                                    size: size,
                                    color: Colors.orange,
                                    text: Messages.englishData[2],
                                  ),
                                  onTap: () {
                                    debugPrint("English Message Clicked");
                                    ProjectManager.instance.clickOnButton(ProjectRoutes.messagesList.toString(), PassDataBetweenScreens("1", "1"));
                                  },
                                ),
                                SizedBox(width: SizeConfig.width(5)),
                                InkWell(
                                  child: CustomTextOnlyWidget(
                                    size: size,
                                    language: "Deutsche",
                                    text: Messages.germanData[0],
                                    color: Colors.redAccent,
                                  ),
                                  onTap: () {
                                    debugPrint("German Clicked");
                                    ProjectManager.instance.clickOnButton(ProjectRoutes.messagesList.toString(), PassDataBetweenScreens("3", "3"));
                                  },
                                ),
                                SizedBox(width: SizeConfig.width(5)),
                                InkWell(
                                  child: CustomTextOnlyWidget(
                                    size: size,
                                    language: "français",
                                    text: Messages.frenchData[0],
                                    color: Colors.tealAccent,
                                  ),
                                  onTap: () {
                                    debugPrint("français Clicked");
                                    ProjectManager.instance.clickOnButton(ProjectRoutes.messagesList.toString(), PassDataBetweenScreens("2", "2"));
                                  },
                                ),
                                SizedBox(width: SizeConfig.width(5)),
                                InkWell(
                                  child: CustomTextOnlyWidget(
                                    size: size,
                                    language: "Italiano",
                                    text: Messages.italyData[0],
                                    color: Colors.yellowAccent,
                                  ),
                                  onTap: () {
                                    debugPrint("Italian Clicked");
                                    ProjectManager.instance.clickOnButton(ProjectRoutes.messagesList.toString(), PassDataBetweenScreens("5", "5"));
                                  },
                                ),
                                SizedBox(width: SizeConfig.width(5)),
                                InkWell(
                                    child: CustomTextOnlyWidget(
                                      size: size,
                                      language: "Português",
                                      text: Messages.portugalData[1],
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onTap: () {
                                      debugPrint("Portuguese Clicked");
                                      ProjectManager.instance.clickOnButton(ProjectRoutes.messagesList.toString(), PassDataBetweenScreens("6", "6"));
                                    }),
                                SizedBox(width: SizeConfig.width(5)),
                                InkWell(
                                    child: CustomTextOnlyWidget(
                                      size: size,
                                      language: "Español",
                                      text: Messages.spanishData[0],
                                      color: Colors.deepOrangeAccent,
                                    ),
                                    onTap: () {
                                      debugPrint("For All Clicked");
                                      ProjectManager.instance.clickOnButton(ProjectRoutes.messagesList.toString(), PassDataBetweenScreens("7", "7"));
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Wishes end
                  const Divider(),

                  // Quotes Start
                  DesignerContainer(
                    isLeft: false,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text("Thanksgiving Day Quotes",
                              style: Theme.of(context).textTheme.headlineSmall),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: InkWell(
                            child: Container(
                              width: size.width - SizeConfig.width(16),
                              height: size.width / 2,
                              decoration: BoxDecoration(
                                color: Colors.indigoAccent,
                                borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(SizeConfig.height(20)),
                                  topRight:
                                      Radius.circular(SizeConfig.height(20)),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 4,
                                      color: Colors.grey),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Icon(Icons.format_quote,
                                      color: Theme.of(context)
                                          .primaryIconTheme
                                          .color),
                                  Positioned(
                                    top: 20,
                                    width: size.width - SizeConfig.width(16),
                                    child: Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(SizeConfig.width(8)),
                                        child: Text(
                                          Quotes.quotesData[3],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    bottom: 0,
                                    right: 0,
                                    child: Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(SizeConfig.width(8)),
                                        child: Text(
                                          "Tap Here to Continue",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              debugPrint("Quotes Clicked");
                              ProjectManager.instance
                      .clickOnButton(ProjectRoutes.quotesList.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Quotes End

                  

                  const Divider(),

                  //Gifs Start

                  DesignerContainer(
                    isLeft: false,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text("Thanksgiving Day Gifs",
                              style: Theme.of(context).textTheme.headlineSmall),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CustomFeatureCard(
                                    size: size,
                                    imageUrl: Gifs.gifsPath[23], ontap: null,
                                  ),
                                  CustomFeatureCard(
                                    size: size,
                                    imageUrl: Gifs.gifsPath[27], ontap: null,
                                  ),
                                  CustomFeatureCard(
                                    size: size,
                                    imageUrl: Gifs.gifsPath[29], ontap: null,
                                  ),
                                  CustomFeatureCard(
                                    size: size,
                                    imageUrl: Gifs.gifsPath[32], ontap: null,
                                  ),
                                ],
                              ),
                              onTap: () {
                                debugPrint("Gifs Clicked");
                                ProjectManager.instance
                      .clickOnButton(ProjectRoutes.gifsList.toString());
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Gifs End

                  const Divider(),

                  //Image Start

                  DesignerContainer(
                    isLeft: true,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text("Thanksgiving Day Wishes Images",
                              style: Theme.of(context).textTheme.headlineSmall),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CustomFeatureCard(
                                    size: size,
                                    imageUrl: Images.imagesPath[7], ontap: null,
                                  ),
                                  CustomFeatureCard(
                                    size: size,
                                    imageUrl: Images.imagesPath[6], ontap: null,
                                  ),
                                  CustomFeatureCard(
                                    size: size,
                                    imageUrl: Images.imagesPath[3], ontap: null,
                                  ),
                                  CustomFeatureCard(
                                    size: size,
                                    imageUrl: Images.imagesPath[4], ontap: null,
                                  ),
                                ],
                              ),
                              onTap: () {
                                debugPrint("Images Clicked");
                                ProjectManager.instance
                      .clickOnButton(ProjectRoutes.imagesList.toString());
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Image End

                  const Divider(),
                  

                  

                  // Wish Creator Start
                  DesignerContainer(
                    isLeft: true,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text("Generate Thanksgiving Day Cards",
                              style: Theme.of(context).textTheme.headlineSmall),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: InkWell(
                              child: CustomBannerWidget(
                                size: MediaQuery.of(context).size,
                                imagePath: Gifs.gifsPath[17],
                                buttonText: "Generate Greeting",
                                topText: "Send Thanksgiving Day",
                                middleText: "Wishes & E-Cards",
                                bottomText: "Share it With Your Loved Ones",
                              ),
                              onTap: () {
                                debugPrint("Meme Clicked");
                                ProjectManager.instance.clickOnButton(ProjectRoutes.memeGenerator.toString());
                              }),
                        ),
                      ],
                    ),
                  ),
                  // Wish Creator End
                  
                  const Divider(),

                  // Status Start

                  DesignerContainer(
                    isLeft: false,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Text("Thanksgiving Day Status Wishes",
                              style: Theme.of(context).textTheme.headlineSmall),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CustomFBTextWidget(
                                    size: size,
                                    text: Status.statusData[2],
                                    color: Colors.orange[900],
                                    url: Images.imagesPath[1],
                                    isLeft: false,
                                  ),
                                  SizedBox(width: SizeConfig.width(8)),
                                  CustomFBTextWidget(
                                    size: size,
                                    text: Status.statusData[3],
                                    color: Colors.blue,
                                    url: Images.imagesPath[1],
                                    isLeft: false,
                                  ),
                                  SizedBox(width: SizeConfig.width(8)),
                                  CustomFBTextWidget(
                                    size: size,
                                    text: Status.statusData[4],
                                    color: Colors.green,
                                    url: Images.imagesPath[1],
                                    isLeft: false,
                                  ),
                                  SizedBox(width: SizeConfig.width(8)),
                                  CustomFBTextWidget(
                                    size: size,
                                    text: Status.statusData[1],
                                    color: Colors.purple,
                                    url: Images.imagesPath[1],
                                    isLeft: false,
                                  ),
                                ],
                              ),
                              onTap: () {
                                debugPrint("Status Clicked");
                                ProjectManager.instance
                      .clickOnButton(ProjectRoutes.statusList.toString());
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Status End


                  const Divider(),

                  Padding(
                    padding: EdgeInsets.all(SizeConfig.width(8)),
                    child: Text("Apps From Developer",
                        style: Theme.of(context).textTheme.headlineSmall),
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.width(8)),
                      child: Row(
                        children: <Widget>[
                          //Column1
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is1-ssl.mzstatic.com/image/thumb/Purple117/v4/8f/e7/b5/8fe7b5bc-03eb-808c-2b9e-fc2c12112a45/mzl.jivuavtz.png/292x0w.jpg",
                                  appTitle: "Good Morning Images & Messages",
                                  appUrl:
                                      "https://apps.apple.com/us/app/good-morning-images-messages-to-wish-greet-gm/id1232993917"),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/44/e0/fd/44e0fdb5-667b-5468-7b2f-53638cba539e/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/292x0w.jpg",
                                  appTitle: "Birthday Status Wishes Quotes",
                                  appUrl:
                                      "https://apps.apple.com/us/app/birthday-status-wishes-quotes/id1522542709"),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/1a/58/a4/1a58a480-a0ae-1940-2cf3-38524430f66b/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg",
                                  appTitle: "Astrology Horoscope Lal Kitab",
                                  appUrl:
                                      "https://apps.apple.com/us/app/astrology-horoscope-lal-kitab/id1448343526"),
                            ],
                          ),
                          SizedBox(width: SizeConfig.width(3)),
                          //Column2
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is2-ssl.mzstatic.com/image/thumb/Purple124/v4/e9/96/64/e99664d3-1083-5fac-6a0c-61718ee209fd/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg",
                                  appTitle: "Weight Loss My Diet Coach Tips",
                                  appUrl:
                                      "https://apps.apple.com/us/app/weight-loss-my-diet-coach-tips/id1448343218"),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is2-ssl.mzstatic.com/image/thumb/Purple127/v4/5f/7c/45/5f7c45c7-fb75-ea39-feaa-a698b0e4b09e/pr_source.jpg/292x0w.jpg",
                                  appTitle: "English Speaking Course Grammar",
                                  appUrl:
                                      "https://apps.apple.com/us/app/english-speaking-course-learn-grammar-vocabulary/id1233093288"),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is4-ssl.mzstatic.com/image/thumb/Purple128/v4/50/ad/82/50ad82d9-0d82-5007-fcdd-cc47c439bfd0/AppIcon-0-1x_U007emarketing-0-85-220-10.png/292x0w.jpg",
                                  appTitle: "English Hindi Language Diction",
                                  appUrl:
                                      "https://apps.apple.com/us/app/english-hindi-language-diction/id1441243874"),
                            ],
                          ),
                          SizedBox(width: SizeConfig.width(3)),
                          //Column3

                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              /*AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is3-ssl.mzstatic.com/image/thumb/Purple118/v4/17/f5/0c/17f50c4d-431b-72c6-b9f4-d1706da59394/AppIcon-0-1x_U007emarketing-0-0-85-220-7.png/292x0w.jpg",
                                  appTitle: "Celebrate Happy New Year 2019",
                                  appUrl:
                                      "https://apps.apple.com/us/app/celebrate-happy-new-year-2019/id1447735210"),
                              const Divider(),*/
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is1-ssl.mzstatic.com/image/thumb/Purple118/v4/79/1e/61/791e61de-500c-6c97-3947-8abbc6b887e3/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg",
                                  appTitle: "Bangladesh Passport Visa Biman",
                                  appUrl:
                                      "https://apps.apple.com/us/app/bangladesh-passport-visa-biman/id1443074171"),
                              Divider(),
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/dd/34/c3/dd34c3e8-5c9f-51aa-a3eb-3a203f5fd49b/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-10.png/292x0w.jpg",
                                  appTitle: "Complete Spoken English Course",
                                  appUrl:
                                      "https://apps.apple.com/us/app/complete-spoken-english-course/id1440118617"),
                            ],
                          ),
                          SizedBox(width: SizeConfig.width(3)),

                          //Column4
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is4-ssl.mzstatic.com/image/thumb/Purple128/v4/bd/00/ee/bd00ee3b-43af-6b07-62a6-28c68373a8b5/AppIcon-1x_U007emarketing-85-220-0-9.png/292x0w.jpg",
                                  appTitle:
                                      "Happy Thanksgiving Day Greeting SMS",
                                  appUrl:
                                      "https://apps.apple.com/us/app/happy-thanksgiving_day-greeting-sms/id1435157874"),
                              Divider(),
                              /*AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is4-ssl.mzstatic.com/image/thumb/Purple91/v4/f0/84/d7/f084d764-79a8-f6d1-3778-1cb27fabb8bd/pr_source.png/292x0w.jpg",
                                  appTitle: "Egg Recipes 100+ Recipes",
                                  appUrl:
                                      "https://apps.apple.com/us/app/egg-recipes-100-recipes-collection-for-eggetarian/id1232736881"),
                              const Divider(),*/
                              AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is1-ssl.mzstatic.com/image/thumb/Purple114/v4/0f/d6/f4/0fd6f410-9664-94a5-123f-38d787bf28c6/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/292x0w.jpg",
                                  appTitle: "Rakshabandhan Images Greetings",
                                  appUrl:
                                      "https://apps.apple.com/us/app/rakshabandhan-images-greetings/id1523619788"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
      
      
    );
  }

  @override
  void moveToScreen(String s, [PassDataBetweenScreens? object]) {
    // TODO: implement moveToScreen
    debugPrint("Home Page: Move to Screen $s");
    Navigator.of(context).pushNamed(s, arguments: object);
  }

  @override
  void moveToScreenAfterAd(String s, [PassDataBetweenScreens? object]) {
    // TODO: implement moveToScreenAfterAd
    debugPrint("Home Page: Move to Screen After Ad $s");
    Navigator.of(context).pushNamed(s, arguments: object);
  }

  @override
  void showAd(String s, [PassDataBetweenScreens? object]) {
    // TODO: implement showAd
    debugPrint("Home Page: Showing Ad Now");
    AdManager.instance.showInterstitialAd(s, object);
  }
}

/*class DesignerContainer extends StatelessWidget {
  const DesignerContainer({
    Key? key,
    required this.child,
    required this.isLeft,
  }) : super(key: key);

  final Widget child;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isLeft
          ? BoxDecoration(
              color: Colors.yellow[700],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(SizeConfig.height(20)),
              ),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 0), blurRadius: 4, color: Colors.grey),
              ],
            )
          : BoxDecoration(
              color: Colors.pink[400],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(SizeConfig.height(20)),
              ),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 0), blurRadius: 4, color: Colors.grey),
              ],
            ),
      child: child,
    );
  }
}
*/
class TriColorBackground extends StatelessWidget {
  const TriColorBackground({
    Key? key,
    @required this.size,
    this.color,
    this.isLeft,
  }) : super(key: key);

  final Size? size;
  final Color? color;
  final bool? isLeft;
  @override
  Widget build(BuildContext context) {
    return isLeft!
        ? Positioned(
            left: 0,
            width: size!.width * 0.33,
            top: 0,
            height: size!.height,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(SizeConfig.width(100)),
                bottomRight: Radius.circular(SizeConfig.width(100)),
              ),
              child: ColoredBox(color: color!),
            ))
        : Positioned(
            right: 0,
            width: size!.width * 0.33,
            top: 0,
            height: size!.height,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(SizeConfig.width(100)),
                bottomLeft: Radius.circular(SizeConfig.width(100)),
              ),
              child: ColoredBox(color: color!),
            ));
  }
}

/*class CustomHeader1 extends StatelessWidget {
  const CustomHeader1({
    Key? key,
    this.headerText,
    this.imagePath,
    this.descriptionText,
  }) : super(key: key);

  final String? headerText, imagePath, descriptionText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 3 * SizeConfig.widthMultiplier,
        bottom: 10 * SizeConfig.widthMultiplier,
        left: 10 * SizeConfig.widthMultiplier,
        right: 10 * SizeConfig.widthMultiplier,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryVariant,
        borderRadius: BorderRadius.only(
          //30
          bottomRight: Radius.circular(MediaQuery.of(context).size.width),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    headerText!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    width: 1.93 * SizeConfig.widthMultiplier,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(imagePath!),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 2 * SizeConfig.heightMultiplier,
          ),
          Text(
            descriptionText!,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class AppStoreAppsItemWidget1 extends StatelessWidget {
  const AppStoreAppsItemWidget1({
    Key? key,
    this.imageUrl,
    this.appUrl,
    this.appTitle,
  }) : super(key: key);

  final String? imageUrl, appUrl, appTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(SizeConfig.width(16))),
            child: Padding(
              padding: EdgeInsets.only(right: SizeConfig.width(3)),
              child: CachedNetworkImage(
                height: SizeConfig.height(80),
                width: SizeConfig.width(80),
                imageUrl: imageUrl!,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fadeOutDuration: const Duration(seconds: 1),
                fadeInDuration: const Duration(seconds: 3),
              ),
            ),
          ),
          Text(
            appTitle!,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onTap: () {
        launch(appUrl!);
      },
    );
  }
}
*/