import 'package:sitter_swipe/resources/strings.dart';

enum Certification {
  cpr,
}

/// Returns the correct description if depending on the inputted cert type
/// if [viewing] is true, this will return the correct string from the [CertDescriptionsForViewer] class
/// if [viewing] is not true, this will return the correct string from the [CertDescriptionsForRegistee] class.
String certDescriptionFromCert(Certification cert, bool viewing) {
  switch (cert) {
    case Certification.cpr:
      return viewing
          ? CertDescriptionsForViewer.cpr
          : CertDescriptionsForRegistee.cpr;
    default:
      return "";
  }
}

/// Returns the title of the certification from [Certification]
String certTitleFromCert(Certification cert) {
  switch (cert) {
    case Certification.cpr:
      return CertificationNames.cpr;
    default:
      return "";
  }
}

/// Returns the correct icon depending on the inputed [Certification]
iconFromCertType(Certification cert) {}

/// Returns a background color to be associated with the inputted [Certification]
colorFromCert(Certification cert) {}
