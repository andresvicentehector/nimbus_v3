deletePresaList(
  List<String> presas,
  int index,
) {
  presas.removeWhere((item) => item.contains('$index,'));
}

deletePresaWall(Function sendMessage, int index) {
  sendMessage("$index.0");
}

addPresa(List<String> presas, int index, int _colorController,
    Function sendMessage) async {
  if (presas.join(" ").contains('$index,')) {
    var i = presas.indexWhere((element) => element.contains("$index,"));
    switch (_colorController) {
      case 4294198070:
        {
          //element that contain number,anycolor
          presas[i] = "$index,65280";
          sendMessage("$index.65280");
        }
        break;
      case 4280391411:
        {
          //case blue
          presas[i] = "$index,255";
          sendMessage("$index.255");
        }
        break;
      case 4283215696:
        {
          //case green
          presas[i] = "$index,16711680";
          sendMessage("$index.16711680");
        }
        break;
      case 4294967295:
        {
          //case white
          presas[i] = "$index,16777215";
          sendMessage("$index.16777215");
        }
        break;
      case 4288423856:
        {
          //case purple
          presas[i] = "$index,65535";
          sendMessage("$index.65535");
        }
        break;
      case 4294961979:
        {
          //case yellow
          presas[i] = "$index,16776960";
          sendMessage("$index.16776960");
        }
        break;
    }
  } else {
    switch (_colorController) {
      case 4294198070:
        {
          //case red
          presas.add("$index,65280");
          sendMessage("$index.65280");
        }
        break;
      case 4280391411:
        {
          //case blue
          presas.add("$index,255");
          sendMessage("$index.255");
        }
        break;
      case 4283215696:
        {
          //case green
          presas.add("$index,16711680");
          sendMessage("$index.16711680");
        }
        break;
      case 4294967295:
        {
          //case white
          presas.add("$index,16777215");
          sendMessage("$index.16777215");
        }
        break;
      case 4288423856:
        {
          //case purple
          presas.add("$index,65535");
          sendMessage("$index.65535");
        }
        break;
      case 4294961979:
        {
          //case yellow
          presas.add("$index,16776960");
          sendMessage("$index.16776960");
        }
        break;
    }
  }
}
