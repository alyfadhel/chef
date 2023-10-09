const String baseApiUrl = 'https://food-api-omega.vercel.app';
const String version = '/api/v1';
const String registerEndPoint = '/chef/signup/';
const String loginEndPoint = '/chef/signin';
const String forgetPassEndPoint = '/chef/send-code';
const String resetPassEndPoint = '/chef/change-forgotten-password';
const String profileEndPoint = '/profile';
const String updateProfileEndPoint = '/update-profile';
const String logOutEndPoint = '/logout';
const String homeEndPoint = '/home';
const String cartEndPoint = '/carts';
const String categoriesEndPoint = '/categories';
const String favoritesEndPoint = '/favorites';
const String searchEndPoint = '/products/search';
String categoriesDetailsEndPoint(int id)=> '/categories/$id';
const String changeFavoritesEndPoint = '/favorites';
String productsDetailsEndPoint(int id)=> '/products/$id';



 String? token = '';
 //late String language ;