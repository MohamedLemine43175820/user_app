





import 'package:user_app/core/class/status_request.dart';

handlingData(response){
  if (response is StatusRequest){
    return response ;                // return deja contient status request par default
    //- serverfailure
    //-  offlinefailure,
  }else {
    return StatusRequest.success ;
  }
}