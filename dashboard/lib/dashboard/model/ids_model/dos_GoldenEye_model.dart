class DoSGoldenEyeModel {
  String? flowPacketsS;
  String? bwdPacketLengthStd;
  String? flowDuration;
  String? flowIATMax;
  String? flowIATMean;
  String? packetLengthVariance;
  String? fwdIATMin;
  String? bwdPacketLengthMean;
  String? bwdPacketLengthMax;
  String? destinationPort;
  String? doSGoldenEyeLogic;
  String? doSGoldenEyeProbLogic;
  String? doSGoldenEyeNn;
  String? doSGoldenEyeProbNn;
  String? doSGoldenEyeSgd;
  String? doSGoldenEyeXgb;
  double? doSGoldenEyeProbXgb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  DoSGoldenEyeModel(
      {this.flowPacketsS,
      this.bwdPacketLengthStd,
      this.flowDuration,
      this.flowIATMax,
      this.flowIATMean,
      this.packetLengthVariance,
      this.fwdIATMin,
      this.bwdPacketLengthMean,
      this.bwdPacketLengthMax,
      this.destinationPort,
      this.doSGoldenEyeLogic,
      this.doSGoldenEyeProbLogic,
      this.doSGoldenEyeNn,
      this.doSGoldenEyeProbNn,
      this.doSGoldenEyeSgd,
      this.doSGoldenEyeXgb,
      this.doSGoldenEyeProbXgb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  DoSGoldenEyeModel.fromJson(Map<String, dynamic> json) {
    flowPacketsS = json[' Flow Packets/s'];
    bwdPacketLengthStd = json[' Bwd Packet Length Std'];
    flowDuration = json[' Flow Duration'];
    flowIATMax = json[' Flow IAT Max'];
    flowIATMean = json[' Flow IAT Mean'];
    packetLengthVariance = json[' Packet Length Variance'];
    fwdIATMin = json[' Fwd IAT Min'];
    bwdPacketLengthMean = json[' Bwd Packet Length Mean'];
    bwdPacketLengthMax = json['Bwd Packet Length Max'];
    destinationPort = json[' Destination Port'];
    doSGoldenEyeLogic = json['DoS_GoldenEye_logic'];
    doSGoldenEyeProbLogic = json['DoS_GoldenEye_prob_logic'];
    doSGoldenEyeNn = json['DoS_GoldenEye_nn'];
    doSGoldenEyeProbNn = json['DoS_GoldenEye_prob_nn'];
    doSGoldenEyeSgd = json['DoS_GoldenEye_sgd'];
    doSGoldenEyeXgb = json['DoS_GoldenEye_xgb'];
    doSGoldenEyeProbXgb = double.parse(json['DoS_GoldenEye_prob_xgb']);
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Flow Packets/s'] = flowPacketsS;
    data[' Bwd Packet Length Std'] = bwdPacketLengthStd;
    data[' Flow Duration'] = flowDuration;
    data[' Flow IAT Max'] = flowIATMax;
    data[' Flow IAT Mean'] = flowIATMean;
    data[' Packet Length Variance'] = packetLengthVariance;
    data[' Fwd IAT Min'] = fwdIATMin;
    data[' Bwd Packet Length Mean'] = bwdPacketLengthMean;
    data['Bwd Packet Length Max'] = bwdPacketLengthMax;
    data[' Destination Port'] = destinationPort;
    data['DoS_GoldenEye_logic'] = doSGoldenEyeLogic;
    data['DoS_GoldenEye_prob_logic'] = doSGoldenEyeProbLogic;
    data['DoS_GoldenEye_nn'] = doSGoldenEyeNn;
    data['DoS_GoldenEye_prob_nn'] = doSGoldenEyeProbNn;
    data['DoS_GoldenEye_sgd'] = doSGoldenEyeSgd;
    data['DoS_GoldenEye_xgb'] = doSGoldenEyeXgb;
    data['DoS_GoldenEye_prob_xgb'] = doSGoldenEyeProbXgb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
