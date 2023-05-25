import 'dart:async';
import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sitter_swipe/models/base_viewmodel.dart';
import 'package:sitter_swipe/models/person/child.dart';
import 'package:sitter_swipe/models/user_data.dart';
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
  List<File>? userProfileImages = []; // list of download urls
  String? userBio;
  String? userCity;
  String? userStateOrProvince;
  String? userCountry;
  String? userHomeAddress;
  List<Child>? children = [
    const Child(name: "", age: "", hobbies: "")
  ]; //init with default 1 kid
  String? sitterAvailability;
  String? sitterChargeRate = "10.00";
  Location? userLocation;

  @override
  void dispose() {}

  @override
  void start() {}

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
            location:
                GeoFirePoint(userLocation!.latitude, userLocation!.longitude),
            gender: userGender,
            profileImages: userProfileImages, // userProfileImages!,
            profilePicture: userProfileImages![0].path,
            stars: null,
            isSitter: userIsSitter,
            phoneNumber: userPhoneNumber,
            city: userCity,
            stateOrProvince: userStateOrProvince,
            country: userCountry,
            bio: userBio,
            willPayRate: sitterChargeRate,
            availability: sitterAvailability,
            children: children!
                .map((Child child) => {
                      child.name: {"age": child.age, "hobbies": child.hobbies}
                    })
                .toList(),
            reviews: []));
  }

  //********* Setters *********//

  @override
  setAddress(String address) async {
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
  addProfileDisplayImage(File image) {
    userProfileImages?.add(image);
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
  setChildrenInfo(List<Child>? childrenInfo) {
    children = childrenInfo;
  }

  @override
  setUserCoordinates(Location? location) {
    userLocation = location;
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
  addProfileDisplayImage(File image);
  setCity(String city);
  setStateOrProvince(String stateOrProvince);
  setUserBio(String bio);
  setCountry(String country);
  setAvailability(dynamic dateRange);
  setRate(String rate);
  setChildrenInfo(List<Child>? childrenInfo);
  setUserCoordinates(Location? location);
}

class RegisterViewModelOutputs {}
