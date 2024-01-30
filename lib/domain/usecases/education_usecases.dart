

import 'package:ktpproject/data/repositories/education_repo_impl.dart';

class EducationUseCases{
  final educationLocalData = EducationRepoImpl();

  List<String> getEducationList(){
    return educationLocalData.dataEducationList();
  }
}