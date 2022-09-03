class DoSSlowhttptestModel {
  String? flowPacketsS;
  String? fwdIATMean;
  String? flowIATMax;
  String? flowIATMean;
  String? flowIATStd;
  String? fwdIATStd;
  String? fwdPacketsS;
  String? fwdIATMax;
  String? idleMax;
  String? flowDuration;
  String? doSSlowhttptestLogic;
  String? doSSlowhttptestProbLogic;
  String? doSSlowhttptestNn;
  String? doSSlowhttptestProbNn;
  String? doSSlowhttptestSgd;
  String? doSSlowhttptestXgb;
  double? doSSlowhttptestProbXgb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  DoSSlowhttptestModel(
      {this.flowPacketsS,
      this.fwdIATMean,
      this.flowIATMax,
      this.flowIATMean,
      this.flowIATStd,
      this.fwdIATStd,
      this.fwdPacketsS,
      this.fwdIATMax,
      this.idleMax,
      this.flowDuration,
      this.doSSlowhttptestLogic,
      this.doSSlowhttptestProbLogic,
      this.doSSlowhttptestNn,
      this.doSSlowhttptestProbNn,
      this.doSSlowhttptestSgd,
      this.doSSlowhttptestXgb,
      this.doSSlowhttptestProbXgb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  DoSSlowhttptestModel.fromJson(Map<String, dynamic> json) {
    flowPacketsS = json[' Flow Packets/s'];
    fwdIATMean = json[' Fwd IAT Mean'];
    flowIATMax = json[' Flow IAT Max'];
    flowIATMean = json[' Flow IAT Mean'];
    flowIATStd = json[' Flow IAT Std'];
    fwdIATStd = json[' Fwd IAT Std'];
    fwdPacketsS = json['Fwd Packets/s'];
    fwdIATMax = json[' Fwd IAT Max'];
    idleMax = json[' Idle Max'];
    flowDuration = json[' Flow Duration'];
    doSSlowhttptestLogic = json['DoS_Slowhttptest_logic'];
    doSSlowhttptestProbLogic = json['DoS_Slowhttptest_prob_logic'];
    doSSlowhttptestNn = json['DoS_Slowhttptest_nn'];
    doSSlowhttptestProbNn = json['DoS_Slowhttptest_prob_nn'];
    doSSlowhttptestSgd = json['DoS_Slowhttptest_sgd'];
    doSSlowhttptestXgb = json['DoS_Slowhttptest_xgb'];
    doSSlowhttptestProbXgb = double.parse(json['DoS_Slowhttptest_prob_xgb']);
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Flow Packets/s'] = flowPacketsS;
    data[' Fwd IAT Mean'] = fwdIATMean;
    data[' Flow IAT Max'] = flowIATMax;
    data[' Flow IAT Mean'] = flowIATMean;
    data[' Flow IAT Std'] = flowIATStd;
    data[' Fwd IAT Std'] = fwdIATStd;
    data['Fwd Packets/s'] = fwdPacketsS;
    data[' Fwd IAT Max'] = fwdIATMax;
    data[' Idle Max'] = idleMax;
    data[' Flow Duration'] = flowDuration;
    data['DoS_Slowhttptest_logic'] = doSSlowhttptestLogic;
    data['DoS_Slowhttptest_prob_logic'] = doSSlowhttptestProbLogic;
    data['DoS_Slowhttptest_nn'] = doSSlowhttptestNn;
    data['DoS_Slowhttptest_prob_nn'] = doSSlowhttptestProbNn;
    data['DoS_Slowhttptest_sgd'] = doSSlowhttptestSgd;
    data['DoS_Slowhttptest_xgb'] = doSSlowhttptestXgb;
    data['DoS_Slowhttptest_prob_xgb'] = doSSlowhttptestProbXgb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
