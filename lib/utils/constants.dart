import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:todo/main.dart';
import 'package:todo/utils/app_strings.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

const h10 = SizedBox(
  height: 10,
);
const h20 = SizedBox(
  height: 20,
);
const h30 = SizedBox(
  height: 30,
);
const h40 = SizedBox(
  height: 40,
);
const h50 = SizedBox(
  height: 50,
);

const w10 = SizedBox(
  width: 10,
);
const w20 = SizedBox(
  width: 20,
);
const w30 = SizedBox(
  width: 30,
);
const w40 = SizedBox(
  width: 40,
);
const w50 = SizedBox(
  width: 50,
);

const notaskFound = 'assets/NoTaskAvailable.png';

dynamic emptyWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppStrings.oopsMessage,
      subMsg: 'You must fill all the fields!',
      corner: 20,
      padding: EdgeInsets.all(20),
      duration: 2000);
}

dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppStrings.oopsMessage,
      subMsg: 'You must edit the task and then try to update it!',
      corner: 20,
      padding: EdgeInsets.all(20),
      duration: 2000);
}

dynamic notaskDeleteWarning(BuildContext context) {
  return PanaraInfoDialog.show(context,
      title: AppStrings.oopsMessage,
      message:
          'There is no task to Delete\n Try adding some and then try to delete it!',
      buttonText: 'Okay', onTapDismiss: () {
    Navigator.pop(context);
  }, panaraDialogType: PanaraDialogType.warning);
}

dynamic deleteAllTaskConfirmation(BuildContext context) {
  return PanaraConfirmDialog.show(context,
      title: AppStrings.areYouSure,
      message:
          'Do you really want to delete all Tasks? You will not be able to undo this action!',
      confirmButtonText: 'Delete',
      cancelButtonText: 'Cancel', onTapConfirm: () {
    BaseWidget.of(context).dataStore.box.clear();
    Navigator.pop(context);
  }, onTapCancel: () {
    
    Navigator.pop(context);
  }, panaraDialogType: PanaraDialogType.error, barrierDismissible: false);
}
