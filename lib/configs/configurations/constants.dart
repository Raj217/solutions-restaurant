enum StorageValues { isDarkTheme }

const String _riveBasePath = 'assets/rive_animations';
const String riveAnimButtonPath = '$_riveBasePath/button.riv';
const String riveAnimCheckPath = '$_riveBasePath/check.riv';
const String riveAnimConfettiPath = '$_riveBasePath/confetti.riv';
const String riveAnimHousePath = '$_riveBasePath/house.riv';
const String riveAnimIconsPath = '$_riveBasePath/icons.riv';
const String riveAnimMapPath = '$_riveBasePath/map.riv';
const String riveAnimMenuButtonPath = '$_riveBasePath/menu.riv';
const String riveAnimCalendarButtonPath = '$_riveBasePath/calendar.riv';

const String _svgBasePath = 'assets/svgs';
const String bgSVGPath = '$_svgBasePath/BG.svg';
const String breakfastSVGPath = '$_svgBasePath/breakfast.svg';
const String chefSVGPath = '$_svgBasePath/chef.svg';

const String _imgBasePath = 'assets/images';
const String googlImgPath = '$_imgBasePath/google.png';

const String collectionUsers = "users";
const String collectionRestaurants = "restaurants";
const String collectionEvents = "events";
const String collectionAwards = "awards";

enum Role { employee, restaurantAdmin, admin, sponsor }

Map<String, Role> stringToRole = {
  'employee': Role.employee,
  'restaurantAdmin': Role.restaurantAdmin,
  'admin': Role.admin,
  'sponsor': Role.sponsor
};

const String firestoreUrlPath = "firebasestorage.googleapis.com";
