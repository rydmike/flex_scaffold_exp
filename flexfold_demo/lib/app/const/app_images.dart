import '../../navigation/constants/app_routes.dart';

/// Image assets used in this application.
class AppImages {
  // This class is not meant to be instantiated or extended. This constructor
  // prevents external instantiation and extension, plus it does not show up
  // in IDE code completion. We like static classes for constants because it
  // name spaces them and gives them a self documenting group and context that
  // they belong to.
  AppImages._();

  // Just a bundled profile image for demo purposes.
  static const String profileImage = 'assets/images/RM400.jpg';
  // An app image or logo of sorts, it is used in the about dialog.
  static const String flexfold = 'assets/images/flexfold1.png';

  // Image used as choices for wrapping the app in a device frame.
  static const String asDevice = 'assets/images/flexfold_as_device1.png';
  // Image used as choices for running the app in native normal view.
  static const String noDevice = 'assets/images/flexfold_no_device1.png';
  // Image used to show them 'main.dart' file to show how the wrapping is done.
  static const String mainDart = 'assets/images/flexfold_main.png';

  // Constant references for all the bundled theme image assets.
  static const String themeBathDecor = 'assets/theme_images/bath_decor.jpg';
  static const String themeBird = 'assets/theme_images/bird.jpg';
  static const String themeBlueBird = 'assets/theme_images/bluebird.jpg';
  static const String themeDashBird = 'assets/theme_images/dash2022_crop.jpg';
  static const String themeBuildings = 'assets/theme_images/buildings.jpg';
  static const String themeRedBoat = 'assets/theme_images/red_boat.jpg';
  static const String themeDiner = 'assets/theme_images/diner.jpg';
  static const String themeFallTrees = 'assets/theme_images/fall_trees.jpg';
  static const String themeIsland = 'assets/theme_images/island.jpg';
  static const String themeLandscape = 'assets/theme_images/landscape.png';
  static const String themeWinterRiver = 'assets/theme_images/winter_river.jpg';
  static const String themeCoffee = 'assets/theme_images/coffee.jpg';
  static const String themeRedSunset = 'assets/theme_images/red_sunset.jpg';
  static const String themeAutumn = 'assets/theme_images/autumn.jpg';
  static const String themeWedding = 'assets/theme_images/wedding.jpg';
  static const String themeBlueFlowers = 'assets/theme_images/blue_flowers.jpg';
  static const String themeBlossom = 'assets/theme_images/blossom.jpg';
  static const String themeRedSky = 'assets/theme_images/red_sky_drawing.jpg';
  static const String themePinkTropic = 'assets/theme_images/pink_tropics.jpg';
  static const String themeDragon = 'assets/theme_images/dragon.jpg';
  static const String themeTherapy = 'assets/theme_images/grouptherapy.jpg';
  static const String themeMerlin = 'assets/theme_images/merlin.jpg';
  static const String themeOmg = 'assets/theme_images/omg.jpg';
  static const String themeKawham = 'assets/theme_images/kawham.jpg';
  static const String themeItsOk = 'assets/theme_images/itsok.jpg';
  static const String themeGroovinChip = 'assets/theme_images/GrovinChip.jpg';
  static const String themeAle = 'assets/theme_images/Ale.jpg';

  // All the above theme image asset strings in a list.
  static const List<String> themeImages = <String>[
    AppImages.themeBathDecor,
    AppImages.themeBird,
    AppImages.themeBlueBird,
    AppImages.themeDashBird,
    AppImages.themeBuildings,
    AppImages.themeRedBoat,
    AppImages.themeDiner,
    AppImages.themeFallTrees,
    AppImages.themeIsland,
    AppImages.themeLandscape,
    AppImages.themeWinterRiver,
    AppImages.themeCoffee,
    AppImages.themeRedSunset,
    AppImages.themeAutumn,
    AppImages.themeWedding,
    AppImages.themeBlueFlowers,
    AppImages.themeBlossom,
    AppImages.themeRedSky,
    AppImages.themePinkTropic,
    AppImages.themeDragon,
    AppImages.themeTherapy,
    AppImages.themeMerlin,
    AppImages.themeOmg,
    AppImages.themeKawham,
    AppImages.themeItsOk,
    AppImages.themeGroovinChip,
    AppImages.themeAle,
  ];

  // Constant references for all the bundled Undraw SVG image assets.
  static const String activeOptions = 'assets/images/Active options.svg';
  static const String appInstallation = 'assets/images/App installation.svg';
  static const String apps = 'assets/images/Apps.svg';
  static const String choice = 'assets/images/Choice.svg';
  static const String darkMode = 'assets/images/Dark mode.svg';
  static const String blocks = 'assets/images/Building blocks.svg';
  static const String fileSync = 'assets/images/File sync.svg';
  static const String healthyOptions = 'assets/images/Healthy options.svg';
  static const String homeScreen = 'assets/images/Home screen.svg';
  static const String inProgress = 'assets/images/In progress.svg';
  static const String inSync = 'assets/images/In sync.svg';
  static const String mobileApps = 'assets/images/Mobile apps.svg';
  static const String mobileDevices = 'assets/images/Mobile devices.svg';
  static const String mobileFeed = 'assets/images/Mobile feed.svg';
  static const String mobileWeb = 'assets/images/Mobile web.svg';
  static const String modernDesign = 'assets/images/Modern design.svg';
  static const String myNotifications = 'assets/images/My notifications.svg';
  static const String natureOnScreen = 'assets/images/Nature on screen.svg';
  static const String openedTabs = 'assets/images/Opened tabs.svg';
  static const String openSource = 'assets/images/Open source.svg';
  static const String postOnline = 'assets/images/Post online.svg';
  static const String postingPhoto = 'assets/images/Posting photo.svg';
  static const String prioritize = 'assets/images/Prioritise.svg';
  static const String productTeardown = 'assets/images/Product teardown.svg';
  static const String progressOverview = 'assets/images/Progress overview.svg';
  static const String progressApp = 'assets/images/Progressive app.svg';
  static const String questions = 'assets/images/Questions.svg';
  static const String setPreferences = 'assets/images/Set preferences.svg';
  static const String setupWizard = 'assets/images/Setup wizard.svg';
  static const String webDevices = 'assets/images/Web devices.svg';

  // All the above Undraw SVG asset strings in a list
  static const List<String> allImages = <String>[
    AppImages.activeOptions,
    AppImages.appInstallation,
    AppImages.apps,
    AppImages.choice,
    AppImages.darkMode,
    AppImages.blocks,
    AppImages.fileSync,
    AppImages.healthyOptions,
    AppImages.homeScreen,
    AppImages.inProgress,
    AppImages.inSync,
    AppImages.mobileApps,
    AppImages.mobileDevices,
    AppImages.mobileFeed,
    AppImages.mobileWeb,
    AppImages.modernDesign,
    AppImages.myNotifications,
    AppImages.natureOnScreen,
    AppImages.openedTabs,
    AppImages.openSource,
    AppImages.postOnline,
    AppImages.postingPhoto,
    AppImages.prioritize,
    AppImages.productTeardown,
    AppImages.progressOverview,
    AppImages.progressApp,
    AppImages.questions,
    AppImages.setPreferences,
    AppImages.setupWizard,
    AppImages.webDevices,
  ];

  // A screen 'route' map to a selected list of 'suitable' SVG images
  // for each screen (route). These are used to show and switch between images
  // that relate to the screen in question.
  static const Map<String, List<String>> route = <String, List<String>>{
    AppRoutes.home: <String>[
      AppImages.mobileApps,
      AppImages.webDevices,
      AppImages.appInstallation,
    ],
    AppRoutes.preview: <String>[
      AppImages.mobileDevices,
      AppImages.webDevices,
      AppImages.postingPhoto,
      AppImages.fileSync,
    ],
    AppRoutes.info: <String>[
      AppImages.mobileWeb,
      AppImages.postOnline,
      AppImages.progressOverview,
    ],
    AppRoutes.settings: <String>[
      AppImages.setPreferences,
      AppImages.inProgress,
      AppImages.prioritize,
      AppImages.progressApp,
    ],
    AppRoutes.theme: <String>[
      AppImages.choice,
      AppImages.activeOptions,
      AppImages.darkMode,
      AppImages.inSync,
    ],
    AppRoutes.tabs: <String>[
      AppImages.healthyOptions,
      AppImages.modernDesign,
      AppImages.openedTabs,
    ],
    AppRoutes.slivers: <String>[
      AppImages.postOnline,
      AppImages.mobileFeed,
      AppImages.blocks,
    ],
    AppRoutes.help: <String>[
      AppImages.questions,
      AppImages.setupWizard,
      AppImages.productTeardown,
    ],
    AppRoutes.about: <String>[
      AppImages.myNotifications,
      AppImages.natureOnScreen,
      AppImages.postingPhoto,
      AppImages.openSource,
    ],
  };
}
