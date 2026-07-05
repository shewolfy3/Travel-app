import 'package:get/get.dart';
import '../features/auth/screens/splash_screen.dart';
import '../features/auth/screens/onboarding_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/search/screens/search_screen.dart';
import '../features/hotels/screens/hotels_screen.dart';
import '../features/flights/screens/flights_screen.dart';
import '../features/visa/screens/visa_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/activities/screens/activities_screen.dart';
import '../features/booking/screens/booking_confirmation_screen.dart';
import '../features/bookings/screens/bookings_screen.dart';
import '../features/auth/screens/otp_screen.dart';
import '../features/auth/screens/forgot_password_screen.dart';
import '../features/profile/screens/edit_profile_screen.dart';
import '../features/profile/screens/notifications_screen.dart';
import '../features/profile/screens/help_center_screen.dart';
import '../features/profile/screens/change_password_screen.dart';
import '../features/profile/screens/privacy_policy_screen.dart';
import '../features/profile/screens/about_screen.dart';
import '../features/profile/screens/my_flights_screen.dart';
import '../features/profile/screens/my_hotels_screen.dart';
import '../features/profile/screens/my_visas_screen.dart';
import '../features/hotels/screens/hotel_details_screen.dart';
import '../features/flights/screens/flight_details_screen.dart';
import '../features/activities/screens/activity_details_screen.dart';
import '../features/visa/screens/visa_details_screen.dart';
import '../features/profile/screens/settings_screen.dart';
import '../features/profile/screens/wallet_screen.dart';
import '../features/activities/screens/packages_screen.dart';
import '../features/profile/screens/payments_screen.dart';
import '../features/search/screens/destination_screen.dart';


class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const search = '/search';
  static const hotels = '/hotels';
  static const flights = '/flights';
  static const visa = '/visa';
  static const profile = '/profile';
  static const activities = '/activities';
  static const bookingConfirmation = '/booking-confirmation';
  static const bookings = '/bookings';
  static const otp = '/otp';
  static const forgotPassword = '/forgot-password';
  static const editProfile = '/edit-profile';
  static const notifications = '/notifications';
  static const helpCenter = '/help-center';
  static const changePassword = '/change-password';
  static const privacyPolicy = '/privacy-policy';
  static const about = '/about';
  static const myFlights = '/my-flights';
  static const myHotels = '/my-hotels';
  static const myVisas = '/my-visas';
  static const hotelDetails = '/hotel-details';
  static const flightDetails = '/flight-details';
  static const activityDetails = '/activity-details';
  static const visaDetails = '/visa-details';
  static const settings = '/settings';
  static const wallet = '/wallet';
  static const packages = '/packages';
  static const payments = '/payments';
  static const destination = '/destination';

  static final routes = [
    GetPage(name: splash, page: () => const HomeScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: search, page: () => const SearchScreen()),
    GetPage(name: hotels, page: () => const HotelsScreen()),
    GetPage(name: flights, page: () => const FlightsScreen()),
    GetPage(name: visa, page: () => const VisaScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: activities, page: () => const ActivitiesScreen()),
    GetPage(name: bookingConfirmation, page: () => const BookingConfirmationScreen()),
    GetPage(name: bookings, page: () => const BookingsScreen()),
    GetPage(name: AppRoutes.otp, page: () => const OtpScreen()),
    GetPage(name: forgotPassword, page: () => const ForgotPasswordScreen()),
    GetPage(name: editProfile, page: () => const EditProfileScreen()),
    GetPage(name: notifications, page: () => const NotificationsScreen()),
    GetPage(name: helpCenter, page: () => const HelpCenterScreen()),
    GetPage(name: changePassword, page: () => const ChangePasswordScreen()),
    GetPage(name: privacyPolicy, page: () => const PrivacyPolicyScreen()),
    GetPage(name: about, page: () => const AboutScreen()),
    GetPage(name: myFlights, page: () => MyFlightsScreen()),
    GetPage(name: myHotels, page: () => MyHotelsScreen()),
    GetPage(name: myVisas, page: () => MyVisasScreen()),
    GetPage(name: hotelDetails, page: () => const HotelDetailsScreen()),
    GetPage(name: flightDetails, page: () => const FlightDetailsScreen()),
    GetPage(name: activityDetails, page: () => const ActivityDetailsScreen()),
    GetPage(name: visaDetails, page: () => const VisaDetailsScreen()),
    GetPage(name: settings, page: () => const SettingsScreen()),
    GetPage(name: wallet, page: () => WalletScreen()),
    GetPage(name: packages, page: () => const PackagesScreen()),
    GetPage(name: payments, page: () => const PaymentsScreen()),
    GetPage(name: destination, page: () => const DestinationScreen()),
  ];
}