import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationRepository{
  final FirebaseFirestore _firestore;
  RegistrationRepository({
    required FirebaseFirestore firestore
}) : _firestore = firestore;


}