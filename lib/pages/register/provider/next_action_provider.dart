/*
I need this because I've separated the base register carousel
from each individual registration screen

specific actions are needed for each screen and require some sort of 
function sharing/mapping mechanism. 
*/

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sitter_swipe/pages/register/pages/role_specific_data.dart';
import 'package:sitter_swipe/pages/register/register.dart';
import 'package:sitter_swipe/pages/register/register_viewmodel.dart';
import 'package:sitter_swipe/services/di.dart';
import 'package:sitter_swipe/services/firebase/auth.dart';

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

  /*

  Map returnArgumentFormatForActionFunction() {
    return {
      NextActionType.phoneNumber: [String],
      NextActionType.phoneVerify: [String],
      NextActionType.credentials: [String, String, String, String],
      NextActionType.role: [bool],
      NextActionType.age: [DateTime],
      NextActionType.about: [String, String],
      NextActionType.images: [List<XFile>],
      NextActionType.preview: [],
    };
  }
  */

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

  execute(NextActionType nextActionType) {
    switch (nextActionType) {
      case NextActionType.phoneNumber:
        phoneNumberContinueAction(_viewModel.userPhoneNumber!);
        print("ran phone number action");
        break;
      case NextActionType.phoneVerify:
        phoneVerifyAction();
        break;
      case NextActionType.credentials:
        credentialsAction(_viewModel.userFullName!, _viewModel.userEmail!,
            _viewModel.userPassword!);
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
  void aboutAction(String bio, String homeAddress) {
    _viewModel.setUserBio(bio);
    // parse the homeaddress and put it into city/state/country/geopoint format
    _viewModel.setAddress(homeAddress);
  }

  @override
  void ageAction(DateTime date) {
    _viewModel.setAge(date);
  }

  @override
  void credentialsAction(String fullName, String email, String password) {
    _viewModel.setFullname(fullName);
    _viewModel.setEmail(email);
    _viewModel.setPassword(password);
    // do I even need the userName?
  }

  @override
  void imagesAction(List<XFile> imageLocators) {
    _viewModel.userProfileImages =
        imageLocators; // I don't think this is working
  }

  @override
  Future<void> phoneNumberContinueAction(String phoneNumber) async {
    print("phone continue action");
    // verify with firebase
    _viewModel.setPhoneNumber("+1$phoneNumber");
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
      Map? children, String? chargeRate) {
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
  void imagesAction(List<XFile> imageLocators); //  save profile images
  void previewAction(); // send and register data and login
  void roleSpecificAction(bool isSitter, dynamic sitterAvailability,
      Map children, String chargeRate);
}

/*

Thoughts - 

  Firebase + flutter is not a viable option in the future
  doing it this way now will be fine as a proof of concept! 
  Meant to get funding
  Funding will change to native architectures later
*/