class Customer {
  int? id;
  String fullName;
  String mobileNo;
  String email;
  String address;
  double latitude;
  double longitude;
  String geoAddress;
  String imagePath;

  Customer({
    this.id,
    required this.fullName,
    required this.mobileNo,
    required this.email,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.geoAddress,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'mobileNo': mobileNo,
      'email': email,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'geoAddress': geoAddress,
      'imagePath': imagePath,
    };
  }

  static Customer fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      fullName: map['fullName'],
      mobileNo: map['mobileNo'],
      email: map['email'],
      address: map['address'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      geoAddress: map['geoAddress'],
      imagePath: map['imagePath'],
    );
  }
}
