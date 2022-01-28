
import 'package:flutter/cupertino.dart';

class FormMixin {

  String? required(String? value){
    if(value == null || value == ''){
      return 'Required';
    }
    return null;
  }

  bool validateAndSaveOnSubmit(BuildContext ctx) {
    final form = Form.of(ctx);
    if(form == null) {
      return false;
    }

    if(!form.validate()){
      return false;
    }

    form.save();
    return true;


  }

}