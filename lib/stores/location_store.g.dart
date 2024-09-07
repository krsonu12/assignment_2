// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LocationStore on LocationStoreBase, Store {
  late final _$latitudeAtom =
      Atom(name: 'LocationStoreBase.latitude', context: context);

  @override
  double? get latitude {
    _$latitudeAtom.reportRead();
    return super.latitude;
  }

  @override
  set latitude(double? value) {
    _$latitudeAtom.reportWrite(value, super.latitude, () {
      super.latitude = value;
    });
  }

  late final _$longitudeAtom =
      Atom(name: 'LocationStoreBase.longitude', context: context);

  @override
  double? get longitude {
    _$longitudeAtom.reportRead();
    return super.longitude;
  }

  @override
  set longitude(double? value) {
    _$longitudeAtom.reportWrite(value, super.longitude, () {
      super.longitude = value;
    });
  }

  late final _$geoAddressAtom =
      Atom(name: 'LocationStoreBase.geoAddress', context: context);

  @override
  String? get geoAddress {
    _$geoAddressAtom.reportRead();
    return super.geoAddress;
  }

  @override
  set geoAddress(String? value) {
    _$geoAddressAtom.reportWrite(value, super.geoAddress, () {
      super.geoAddress = value;
    });
  }

  late final _$getLocationAsyncAction =
      AsyncAction('LocationStoreBase.getLocation', context: context);

  @override
  Future<void> getLocation() {
    return _$getLocationAsyncAction.run(() => super.getLocation());
  }

  late final _$openGoogleMapsAsyncAction =
      AsyncAction('LocationStoreBase.openGoogleMaps', context: context);

  @override
  Future<void> openGoogleMaps(Customer customer) {
    return _$openGoogleMapsAsyncAction
        .run(() => super.openGoogleMaps(customer));
  }

  @override
  String toString() {
    return '''
latitude: ${latitude},
longitude: ${longitude},
geoAddress: ${geoAddress}
    ''';
  }
}
