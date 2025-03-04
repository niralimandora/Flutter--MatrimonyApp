int getAge(String birthDate) {
  DateTime birth = DateTime.parse(
      '${birthDate.split('-')[2]}-${birthDate.split('-')[1]}-${birthDate.split('-')[0]}');
  DateTime today = DateTime.now();
  return today.year -
      birth.year -
      (today.month < birth.month ||
          (today.month == birth.month && today.day < birth.day)
          ? 1
          : 0);
}