/*
I need this because I've separated the base register carousel
from each individual registration screen

specific actions are needed for each screen and require some sort of 
function sharing/mapping mechanism. 
*/

import 'dart:io';

import 'package:geocoding/geocoding.dart';
import 'package:get_it/get_it.dart';
import 'package:sitter_swipe/models/person/child.dart';
import 'package:sitter_swipe/pages/register/register_viewmodel.dart';
import 'package:sitter_swipe/services/di.dart';
import 'package:sitter_swipe/services/firebase/auth.dart';
import 'package:sitter_swipe/services/functions/location.dart';

enum NextActionType {
  phoneNumber,
  phoneVerify,
  credentials,
  role,
  roleSpecific,
  age,
  about,
  images,
  preview,
  none
}

class RegisterButtonActions extends ButtonActionsBase {
  final RegisterViewModel _viewModel = GetIt.instance<RegisterViewModel>();

  /// Will return the correct action function type depending on whatever index was passed in.
  /// This corresponds to each index of the [registerPages] variable in [register.dart].
  NextActionType returnActionTypeFromPageIndex(int index) {
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
        return NextActionType.roleSpecific;
      case 5:
        return NextActionType.age;
      case 6:
        return NextActionType.about;
      case 7:
        return NextActionType.images;
      case 8:
        return NextActionType.preview;
      default:
        return NextActionType.none;
    }
  }

  /// Depending on the [NextActionType], a this function executes another function, Will run each time that the next button is pressed.
  execute(NextActionType nextActionType) async {
    switch (nextActionType) {
      case NextActionType.phoneNumber:
        await phoneNumberContinueAction(_viewModel.userPhoneNumber!);
        break;
      case NextActionType.phoneVerify:
        phoneVerifyAction();
        break;
      case NextActionType.credentials:
        credentialsAction(
            _viewModel.userFullName!,
            _viewModel.userEmail!,
            _viewModel
                .userPassword!); // TODO need to check if the email is valid and not taken already FIRST
        break;
      case NextActionType.role:
        roleAction(_viewModel.userIsSitter!);
        break;
      case NextActionType.age:
        ageAction(_viewModel.userDateOfBirth!);
        break;
      case NextActionType.about:
        aboutAction(_viewModel.userBio!, _viewModel.userHomeAddress!);
        break;
      case NextActionType.images:
        imagesAction(_viewModel.userProfileImages!);
        break;
      case NextActionType.preview:
        _viewModel.register();
        break;
      case NextActionType.none:
        break;
      case NextActionType.roleSpecific:
        roleSpecificAction(
            _viewModel.userIsSitter!,
            _viewModel.sitterAvailability,
            _viewModel.children,
            _viewModel.sitterChargeRate);
        break;
    }
  }

  @override
  void aboutAction(String bio, String homeAddress) async {
    _viewModel.setUserBio(bio);
    // parse the homeaddress and put it into city/state/country/geopoint format
    Location location = await getCoordinatesFromAddress(homeAddress);
    _viewModel.setAddress(homeAddress);
    _viewModel.setUserCoordinates(location);
  }

  @override
  void ageAction(DateTime date) {
    _viewModel.setAge(date);
  }

  @override
  void credentialsAction(String fullName, String email, String password) {
    final AuthService auth = instance<AuthService>();
    _viewModel.setFullname(fullName);
    _viewModel.setEmail(email);
    _viewModel.setPassword(password);
    // _auth.registerWithEmailAndPassword(email, password, data)

    // do I even need the userName?
  }

  @override
  void imagesAction(List<File> imageLocators) {
    _viewModel.userProfileImages =
        imageLocators; // I don't think this is working
  }

  @override
  Future<void> phoneNumberContinueAction(String phoneNumber) async {
    print("phone continue action");
    // verify with firebase
    _viewModel.setPhoneNumber(phoneNumber);
    final authService = instance<AuthService>();
    await authService.verifyPhoneNumber(phoneNumber);
  }

  @override
  void phoneVerifyAction() {
    print("phone verify action");
    // TODO: implement phoneVerifyAction
  }

  @override
  void previewAction() {
    _viewModel.register();
  }

  @override
  void roleAction(bool isSitter) {
    _viewModel.setIsSitter(isSitter);
  }

  @override
  void roleSpecificAction(bool isSitter, dynamic sitterAvailability,
      List<Child>? children, String? chargeRate) {
    if (isSitter) {
      _viewModel.setAvailability(sitterAvailability);
      _viewModel.setRate(chargeRate);
    } else {
      _viewModel.setChildrenInfo(children);
    }
  }
}

abstract class ButtonActionsBase {
  Future<void> phoneNumberContinueAction(
      String phoneNumber); // send phone number to firebase
  void phoneVerifyAction(); // verify the code sent and check if its correct
  void credentialsAction(
      String fullName, String email, String password); // save credentials
  void ageAction(DateTime date); // save birthday/age
  void roleAction(bool isSitter); // user is a parent or a sitter
  void aboutAction(String bio, String homeAddress); // save info about profile
  void imagesAction(List<File> imageLocators); //  save profile images
  void previewAction(); // send and register data and login
  void roleSpecificAction(bool isSitter, dynamic sitterAvailability,
      List<Child> children, String chargeRate);
}

/*

Thoughts - 

  Firebase + flutter is not a viable option in the future
  doing it this way now will be fine as a proof of concept! 
  Meant to get funding
  Funding will change to native architectures later
*/