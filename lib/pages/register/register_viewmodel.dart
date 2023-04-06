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
            uid: 'uid',
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
  setProfileDisplayImages(List<XFile> images) {
    userProfileImages = images;
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

  // **** Helper Functions ***** //

  NextActionType _returnActionTypeFromPageIndex(int index) {
    switch (index) {
      case 0:
        return NextActionType.phoneNumber;
      case 1:
        return NextActionType.phoneVerify;
      case 2:
        return NextActionType.credentials;
      case 3:
        return NextActionType.role;
      case 4:
        return NextActionType.age;
      case 5:
        return NextActionType.about;
      case 6:
        return NextActionType.images;
      case 7:
        return NextActionType.preview;
      default:
        return NextActionType.none;
    }
  }

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
  setProfileDisplayImages(List<XFile> images);
  setCity(String city);
  setStateOrProvince(String stateOrProvince);
  setUserBio(String bio);
  setCountry(String country);
}

class RegisterViewModelOutputs {}



/*
class RegisterViewModel extends BaseViewModel
    with RegisterViewModelOutputs, RegisterViewModelInputs {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  //*** Stream Controllers ***//

  final StreamController<String> _userPhoneNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController<bool> _phoneNumberWasVerifiedStreamController =
      StreamController<bool>.broadcast();
  final StreamController<String> _fullNameStreamController =
      StreamController<String>.broadcast();
  //? Sink<String> get userName; ?
  final StreamController<String> _genderStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController<bool> _isSitterStreamController =
      StreamController<bool>.broadcast();
  final StreamController<int> _ageStreamController = StreamController<
      int>.broadcast(); // replace with id verification later for safety
  final StreamController<dynamic> _profileImageStreamController =
      StreamController<dynamic>.broadcast();
  final StreamController<List<dynamic>> _profileDisplayImagesStreamController =
      StreamController<List<dynamic>>.broadcast();
  final StreamController<String> _cityStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _stateOrProvinceStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _userBioStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _countryStreamController =
      StreamController<String>.broadcast();
  final StreamController<bool> _accountCreatedSuccessfullyStreamController =
      StreamController<bool>.broadcast();
  final StreamController<String> _createdUidStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _userAddressStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _outputAddressStream =
      StreamController<String>.broadcast();

  //****** Output Streams *******//

  @override
  Stream<bool> get accountCreatedSuccessfully =>
      _accountCreatedSuccessfullyStreamController.stream;

  @override
  Stream<String> get uid => _createdUidStreamController.stream;
  @override
  // TODO: implement outputAddress
  Stream<String> get outputAddress => _outputAddressStream.stream;

  @override
  // TODO: implement outputAge
  Stream<int> get outputAge => throw UnimplementedError();

  @override
  // TODO: implement outputCity
  Stream<String> get outputCity => throw UnimplementedError();

  @override
  // TODO: implement outputCountry
  Stream<String> get outputCountry => throw UnimplementedError();

  @override
  // TODO: implement outputEmail
  Stream<String> get outputEmail => throw UnimplementedError();

  @override
  // TODO: implement outputFullName
  Stream<String> get outputFullName => throw UnimplementedError();

  @override
  // TODO: implement outputGender
  Stream<String> get outputGender => throw UnimplementedError();

  @override
  // TODO: implement outputIsSitter
  Stream<bool> get outputIsSitter => throw UnimplementedError();

  @override
  // TODO: implement outputPassword
  Stream<String> get outputPassword => throw UnimplementedError();

  @override
  // TODO: implement outputPhoneNumberWasVerified
  Stream<bool> get outputPhoneNumberWasVerified => throw UnimplementedError();

  @override
  // TODO: implement outputProfileDisplayImages
  Stream<List> get outputProfileDisplayImages => throw UnimplementedError();

  @override
  // TODO: implement outputProfileImage
  Stream get outputProfileImage => throw UnimplementedError();

  @override
  // TODO: implement outputStateOrProvince
  Stream<String> get outputStateOrProvince => throw UnimplementedError();

  @override
  // TODO: implement outputUserBio
  Stream<String> get outputUserBio => throw UnimplementedError();

  @override
  // TODO: implement outputUserPhoneNumber
  Stream<String> get outputUserPhoneNumber => throw UnimplementedError();

  //*** Input Streams *****//

  @override
  Sink<int> get age => _ageStreamController.sink;

  @override
  Sink<String> get city => _cityStreamController.sink;

  @override
  Sink<String> get email => _emailStreamController.sink;

  @override
  Sink<String> get fullName => _fullNameStreamController.sink;

  @override
  Sink<String> get gender => _genderStreamController.sink;

  @override
  Sink<bool> get isSitter => _isSitterStreamController.sink;

  @override
  Sink<String> get password => _passwordStreamController.sink;

  @override
  Sink<bool> get phoneNumberWasVerified =>
      _phoneNumberWasVerifiedStreamController.sink;

  @override
  Sink<List> get profileDisplayImages =>
      _profileDisplayImagesStreamController.sink;

  @override
  Sink get profileImage => _profileImageStreamController.sink;

  @override
  Sink<String> get stateOrProvince => _stateOrProvinceStreamController.sink;

  @override
  Sink<String> get userBio => _userBioStreamController.sink;

  @override
  Sink<String> get userPhoneNumber => _userPhoneNumberStreamController.sink;

  @override
  Sink<String> get country => _countryStreamController.sink;

  @override
  Sink<String> get address => _userAddressStreamController.sink;

  //*** Setters ***//

  @override
  setAge(int _age) {
    age.add(_age);
  }

  @override
  setCity(String _city) {
    city.add(_city);
  }

  @override
  setCountry(String _country) {
    country.add(_country);
  }

  @override
  setEmail(String _email) {
    email.add(_email);
  }

  @override
  setFullname(String name) {
    fullName.add(name);
  }

  @override
  setGender(String _gender) {
    gender.add(_gender);
  }

  @override
  setIsSitter(bool _isSitter) {
    isSitter.add(_isSitter);
  }

  @override
  setPassword(String _password) {
    password.add(_password);
  }

  @override
  setPhoneNumber(String phoneNumber) {
    userPhoneNumber.add(phoneNumber);
  }

  @override
  setPhoneWasVerified(bool wasVerified) {
    phoneNumberWasVerified.add(wasVerified);
  }

  @override
  setProfileDisplayImages(List images) {
    profileDisplayImages.add(images);
  }

  @override
  setProfileImage(image) {
    profileImage.add(image);
  }

  @override
  setStateOrProvince(String _stateOrProvince) {
    stateOrProvince.add(_stateOrProvince);
  }

  @override
  setUserBio(String _bio) {
    userBio.add(_bio);
  }

  @override
  setAddress(String address) {
    throw UnimplementedError();
  }
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get accountCreatedSuccessfully;
  Stream<String> get uid;
  Stream<String> get outputUserPhoneNumber;
  Stream<bool> get outputPhoneNumberWasVerified;
  Stream<String> get outputFullName;
  Stream<String> get outputGender;
  Stream<String> get outputEmail;
  Stream<String> get outputPassword;
  Stream<bool> get outputIsSitter;
  Stream<int> get outputAge;
  Stream<dynamic> get outputProfileImage;
  Stream<List<dynamic>> get outputProfileDisplayImages;
  Stream<String> get outputCity;
  Stream<String> get outputStateOrProvince;
  Stream<String> get outputUserBio;
  Stream<String> get outputCountry;
  Stream<String> get outputAddress;
}

abstract class RegisterViewModelInputs {
  Sink<String> get userPhoneNumber;
  Sink<bool> get phoneNumberWasVerified;
  Sink<String> get fullName;
  //? Sink<String> get userName; ?
  Sink<String> get gender;
  Sink<String> get email;
  Sink<String> get password;
  Sink<bool> get isSitter;
  Sink<int> get age; // replace with id verification later for safety
  Sink<dynamic> get profileImage;
  Sink<List<dynamic>> get profileDisplayImages;
  Sink<String> get city;
  Sink<String> get stateOrProvince;
  Sink<String> get userBio;
  Sink<String> get country;
  Sink<String> get address;

  setPhoneNumber(String phoneNumber);
  setPhoneWasVerified(bool wasVerified);
  setAddress(String address);
  setFullname(String name);
  setGender(String gender);
  setEmail(String email);
  setPassword(String password);
  setIsSitter(bool isSitter);
  setAge(int age);
  setProfileImage(image);
  setProfileDisplayImages(List images);
  setCity(String city);
  setStateOrProvince(String stateOrProvince);
  setUserBio(String bio);
  setCountry(String country);
}
*/