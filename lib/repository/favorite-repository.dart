import 'package:flutter/cupertino.dart';

class FavouriteRepository extends ChangeNotifier {
  List<String> itemIds = [];

  void setListIds(List<String> id)
  {
    itemIds=id;
  }
  void add(String teacherId) {
    itemIds.add(teacherId);
    notifyListeners();
    print('Add teacher into favourite list');
  }

  void remove(String teacherId) {
    itemIds.remove(teacherId);
    notifyListeners();
    print('Remove teacher out of favourite list');
  }
}