class AppStrings {
  static const String exampleSitterBio =
      "Hi, my name is Tony and I'm a 15-year-old babysitter living in Southern San Francisco. I've been babysitting for about two years now and have experience with children of all ages, from infants to pre-teens. \n\nI love spending time with kids and have a lot of fun playing games, doing crafts, and reading stories with them. I'm also responsible and reliable, and always make sure to follow parents' instructions and keep a close eye on the children's safety. \n\nWhen I'm not babysitting, I enjoy playing basketball, listening to music, and hanging out with my friends. I'm also a straight-A student and take my schoolwork seriously.\n\nI'm excited to meet new families in the area and to provide quality care for their children. If you're looking for a trustworthy and fun babysitter, I'm your guy!";
  static const String exampleFamilyBio =
      "Hi there! We're the Lee family, a busy family of four always on the go. We have two young children who we love spending time with, but sometimes we need a break to recharge or take care of other responsibilities. That's why we're excited to be a part of SitterSwipe, where we can easily find trustworthy and reliable babysitters to help us out when we need it. We're looking forward to connecting with some great sitters and building lasting relationships with them!";

  static const String noRouteFound = "No Route Found";
  static const String appTitle = "Sitter Swipe";
  static const String login = "Login";
  static const String email = "Email";
  static const String password = "Password";
  static const String loading = "Loading";
  static const String register = "Sign Up";

  static const String forgotPassword = "Forgot Password?";
  static const String invalidEmail = "Invalid Email Format";
  static const String passwordError = "Password can't be blank";
  static const String resetPassword = "Reset Password";

  static const String location = "Location";

  static const String gotSwipe = " swiped right on you!";
  static const String gotMessage = " sent you a message.";

  static const String sitterSearch = "Find sitter...";
  static const String messageSearch = "Search messages...";

  static const String imageHeroTag = "profileImageTag";
  static const String interestedHeading = "Users who've liked your profile";

  static const String youStartedAConversation =
      "You started a conversation with";

  static const String imASitter =
      "I'm a babysitter looking to sell my services";
  static const String imAParent = "I'm a parent looking to hire a babysitter";

  static const String noMoreSitters = "Can't find anymore sitters!";

  static const String sentVerification =
      "We just texted you a verification code!";

  static const String anyTimeOnWeekdays = "Weekdays";
  static const String anyTimeOnWeekNights = "Weeknights";
  static const String weekendsOnly = "Weekends only";
  static const String anytime = "Any time";

  static const String bioLabelForSitter =
      "Enter a short bio about you. Be sure to mention your experience, hobbies, where you live, etc...";
  static const String bioLabelForParent =
      "Enter a short bio about you, your kids, and what kind of sitter you're looking for, etc...";

  static const String followGuidelinesSitter =
      "These images will be visible to potential parents that your babysit for. Please follow our Community Guidelines.";

  static const String followGuidelinesParent =
      "Potential sitters will see these, so present yourself and your children appropriately and safely. See Community Guidelines.";

  static const String noFamiliesHere =
      "No families here...yet! Why don't you start swiping to get started?";

  static const String chatAddedAutomatically =
      "Your matches, or your mutual connections, will be automatically added to your Chats";

  static const String noSittersHereYet =
      "No babysitters here...yet! Why don't you start swiping to get started?";

  static const String broadcastToSitters =
      "Press and hold your picture to broadcast a call for help to sitters nearby!";
  static const String broadcastToFamilies =
      "Press and hold your picture to alert parents nearby that you're available to babysit right now!";
  static const String alreadyBroadcastedToFamilies =
      "You've just alerted nearby parents that you're available. Wait another hour to send an alert again.";
  static const String alreadyBroadcastedToSitters =
      "You've just alerted babysitters nearby that you're in need of a sitter. Wait another hour to alert again.";
}

class SkillNames {
  static const String cooking = "Cooking";
  static const String glutenFreeCooking = "Gluten-Free Cooking";
  static const String cookingAccomodations = "Cooking Accomodations";
  static const String pets = "Pet care";
  static const String childCare = "Child care";
  static const String infants = "Infants";
  static const String diaperChanging = "Diaper Changing";
  static const String afterSchool = "After School Care";
  static const String toddlers = "Toddlers";
  static const String houseKeeping = "Housekeeping";
}

class CertificationNames {
  static const String cpr = "CPR Certified";
}

/// Descriptions of skills for when someone views the profile of someone else.
class SkillDescriptionsForViewer {
  static const String indicated = "This person indicated";
  static const String basicCooking =
      "$indicated that they have basic experience in cooking a variety of meals.";
  static const String glutenFreeCooking =
      "$indicated that they have experience in cooking meals for gluten-sensitive children.";
  static const String cookingAccomodations =
      "$indicated that they have experience in being accomdodating of the meal needs of those with unique health requirements.";
  static const String pets =
      "$indicated that they have experience with caring for a variety of types of pets.";
  static const String childCare =
      "$indicated that they have experience with child care.";
  static const String infants =
      "$indicated that they have experience in caring for infants.";
  static const String diaperChanging =
      "$indicated that they have experience with changing diapers.";
  static const String afterSchool =
      "$indicated that they have experience in after-school care for children. ";
  static const String toddlers =
      "$indicated that they have experience in caring for toddlers.";
  static const String houseKeeping =
      "$indicated that they have experience in housekeeping.";
}

/// Descriptions of skills for when someone registers in the app.
class SkillDescriptionsForRegistee {
  static const String select = "Selected this skill if you have experience";
  static const String basicCooking = "$select in cooking a variety of meals.";
  static const String glutenFreeCooking =
      "$select in cooking meals for gluten-sensitive children.";
  static const String cookingAccomodations =
      "$select in being accomdodating of the meal needs of those with unique health requirements.";
  static const String pets =
      "$select with caring for a variety of types of pets";
  static const String childCare = "$select with child care.";
  static const String infants = "$select in caring for infants.";
  static const String diaperChanging = "$select with changing diapers.";
  static const String afterSchool =
      "$select in after-school care for children. ";
  static const String toddlers = "$select in caring for toddlers.";
  static const String houseKeeping = "$select in house keeping";
}

/// Descriptions of certifications for when someone views the profile of someone else.
class CertDescriptionsForViewer {
  static const String indicated = "This person indicated";
  static const String cpr =
      "$indicated that they've completed CPR training and have an accompnaying certification";
}

/// Descriptions of Certifications for when someone registers in the app.
class CertDescriptionsForRegistee {
  static const String select = "Select this if";
  static const String cpr = "$select you've completed CPR training.";
}

class PageTitles {
  static const chat = "Chats";
  static const interested = "Likes";
  static const profile = "Profile";
  static const notifications = "Notifications";
  static const settings = "Settings";
  static const broadcast = "Broadcast";
}

class ButtonLabels {
  static const pass = "Pass";
  static const like = "Like";
  static const message = "Message";
}

class Countries {
  static const canada = "Canada";
  static const us = "US";
}

/// Class containing the keys of all the datapoints in the database
/// In case I need to rename one of the keys, I can do it easily now without
/// having to change every instance of those strings across the app
class FirebaseDataPointKeys {
  static const String age = "age";
  static const String availability = "availability";
  static const String bio = "bio";
  static const String children = "children";
  static const String fullName = "fullName";
  static const String gender = "gender";
  static const String isSitter = "isSitter";
  static const String likes = "likes";
  static const String location = "location";
  static const String phoneNumber = "phoneNumber";
  static const String profileImages = "profileImages";
  static const String profilePicture = "profilePicture";
  static const String reviews = "reviews";
  static const String stars = "stars";
  static const String stateOrProvince = "stateOrProvince";
  static const String uid = "uid";
  static const String userName = "userName";
  static const String willPayRate = "willPayRate";
}
