

import 'package:ktpproject/data/repositories/job_repo_impl.dart';

class JobUseCases{
  final jobLocalData = JobRepoImpl();

  List<String> getJobList(){
    return jobLocalData.dataJobList();
  }
}