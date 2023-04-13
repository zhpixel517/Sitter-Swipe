import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sitter_swipe/models/base_viewmodel.dart';
import 'package:sitter_swipe/models/enums/prefferred_gender.dart';
import 'package:sitter_swipe/models/user_data.dart';
import 'package:sitter_swipe/pages/register/provider/next_action_provider.dart';
import 'package:sitter_swipe/resources/strings.dart';
import 'package:sitter_swipe/services/firebase/auth.dart';

class RegisterViewModel
    with BaseViewModel, RegisterViewModelInputs, RegisterViewModelOutputs {
  String? userPhoneNumber;
  String? userFullName;
  String? userNickName;
  String? userEmail;
  String? userPassword;
  String? userGender;
  bool? userPhoneNumberIsValid;
  int? userAge;
  DateTime? userDateOfBirth;
  bool? userIsSitter;
  XFile? userProfilePicture;
  List<XFile>? userProfileImages;
  String? userBio;
  String? userCity;
  String? userStateOrProvince;
  String? userCountry;
  String? userHomeAddress;
  dynamic geoHash; // their geohash calculated later
  Map? children;
  String? sitterAvailability;
  String? sitterChargeRate;

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Future<void> register() async {
    final authService = GetIt.instance<AuthService>();
    await authService.registerWithEmailAndPassword(
        userEmail!,
        userPassword!,
        UserData(
            fullName: userFullName!,
            userName: "userName",
            age: userAge,
            location: null,
            gender: PreferredGender.female,
            profileImages: userProfileImages,
            profilePicture: userProfileImages![0].path,
            stars: null,
            isSitter: true,
            phoneNumber: userPhoneNumber,
            city: userCity,
            stateOrProvince: userStateOrProvince,
            uid: '43L8dd2koho5VCk82uFl',
            country: userCountry,
            reviews: []));
  }

  //********* Setters *********//

  @override
  setAddress(String address) {
    //TODO: parse their address for information
    setCity("city");
    setStateOrProvince("stateOrProvince");
    setCountry("");
    userHomeAddress = address;
  }

  @override
  setAge(DateTime dateOfBirth) {
    userAge = _calculateAge(dateOfBirth);
  }

  @override
  setCity(String city) {
    userCity = city;
  }

  @override
  setCountry(String country) {
    userCountry = country;
  }

  @override
  setEmail(String email) {
    userEmail = email;
  }

  @override
  setFullname(String name) {
    userFullName = name;
  }

  @override
  setGender(String gender) {
    userGender = gender;
  }

  @override
  setIsSitter(bool isSitter) {
    userIsSitter = isSitter;
  }

  @override
  setPassword(String password) {
    userPassword = password;
  }

  @override
  setPhoneNumber(String phoneNumber) {
    userPhoneNumber = phoneNumber;
  }

  @override
  setPhoneWasVerified(bool wasVerified) {
    userPhoneNumberIsValid = wasVerified;
  }

  @override
  addProfileDisplayImage(XFile image) {
    userProfileImages = [];
    userProfileImages!.add(image);
  }

  @override
  setProfileImage(image) {
    userProfilePicture = image;
  }

  @override
  setStateOrProvince(String stateOrProvince) {
    userStateOrProvince = stateOrProvince;
  }

  @override
  setUserBio(String bio) {
    userBio = bio;
  }

  @override
  setAvailability(dateRange) {
    sitterAvailability = dateRange;
  }

  @override
  setRate(String? rate) {
    sitterChargeRate = rate;
  }

  @override
  setChildrenInfo(Map? childrenInfo) {
    children = childrenInfo;
  }

  // **** Helper Functions ***** //

  int _calculateAge(DateTime dateOfBirth) {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }
}

abstract class RegisterViewModelInputs {
  Future<void> register();

  setPhoneNumber(String phoneNumber);
  setPhoneWasVerified(bool wasVerified);
  setAddress(String address);
  setFullname(String name);
  setGender(String gender);
  setEmail(String email);
  setPassword(String password);
  setIsSitter(bool isSitter);
  setAge(DateTime dateOfBirth);
  setProfileImage(image);
  addProfileDisplayImage(XFile image);
  setCity(String city);
  setStateOrProvince(String stateOrProvince);
  setUserBio(String bio);
  setCountry(String country);
  setAvailability(dynamic dateRange);
  setRate(String rate);
  setChildrenInfo(Map? childrenInfo);
}

class RegisterViewModelOutputs {}
