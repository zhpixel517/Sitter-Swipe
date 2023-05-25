double milesToKM(double miles) {
  double km = miles * 1.609344;
  return km;
}

double kmToMiles(double km) {
  double miles = km / 1.609344;
  return miles;
}

int metersToMiles(int meters) {
  return (meters * 0.000621371).round();
}

int metersToKM(int meters) {
  return (meters / 1000).round();
}
