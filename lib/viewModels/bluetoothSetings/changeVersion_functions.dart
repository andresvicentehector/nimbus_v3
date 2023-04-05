import '../../template/configuration/ConstantesPropias.dart';

void changeVersion(String variable) {
  switch (variable) {
    case '15':
      quePared = "15";
      fondo = "images/fondo_trans25.png";
      paredTrans = "images/presas_trans25.png";
      version = "25";
      break;

    case '25':
      quePared = "25";
      fondo = "images/fondo_trans15.png";
      paredTrans = "images/presas_trans15.png";
      version = "15";
      break;
    default:
  }
}
