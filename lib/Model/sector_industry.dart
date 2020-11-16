
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class SectorIndustryModel with ChangeNotifier{
  String sector;
  List<dynamic> industry;

  SectorIndustryModel(this.sector, this.industry);

}

