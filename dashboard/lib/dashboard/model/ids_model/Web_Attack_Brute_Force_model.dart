class WebAttackBruteForceModel {
  String? initWinBytesBackward;
  String? fwdIATMin;
  String? maxPacketLength;
  String? fwdIATStd;
  String? initWinBytesForward;
  String? avgFwdSegmentSize;
  String? fwdPacketLengthMean;
  String? fwdPacketLengthMax;
  String? averagePacketSize;
  String? destinationPort;
  String? webAttackBruteForceLogic;
  String? webAttackBruteForceProbLogic;
  String? webAttackBruteForceNn;
  String? webAttackBruteForceProbNn;
  String? webAttackBruteForceSgd;
  String? webAttackBruteForceXgb;
  double? webAttackBruteForceProbXgb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  WebAttackBruteForceModel(
      {this.initWinBytesBackward,
      this.fwdIATMin,
      this.maxPacketLength,
      this.fwdIATStd,
      this.initWinBytesForward,
      this.avgFwdSegmentSize,
      this.fwdPacketLengthMean,
      this.fwdPacketLengthMax,
      this.averagePacketSize,
      this.destinationPort,
      this.webAttackBruteForceLogic,
      this.webAttackBruteForceProbLogic,
      this.webAttackBruteForceNn,
      this.webAttackBruteForceProbNn,
      this.webAttackBruteForceSgd,
      this.webAttackBruteForceXgb,
      this.webAttackBruteForceProbXgb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  WebAttackBruteForceModel.fromJson(Map<String, dynamic> json) {
    initWinBytesBackward = json[' Init_Win_bytes_backward'];
    fwdIATMin = json[' Fwd IAT Min'];
    maxPacketLength = json[' Max Packet Length'];
    fwdIATStd = json[' Fwd IAT Std'];
    initWinBytesForward = json['Init_Win_bytes_forward'];
    avgFwdSegmentSize = json[' Avg Fwd Segment Size'];
    fwdPacketLengthMean = json[' Fwd Packet Length Mean'];
    fwdPacketLengthMax = json[' Fwd Packet Length Max'];
    averagePacketSize = json[' Average Packet Size'];
    destinationPort = json[' Destination Port'];
    webAttackBruteForceLogic = json['Web_Attack_Brute_Force_logic'];
    webAttackBruteForceProbLogic = json['Web_Attack_Brute_Force_prob_logic'];
    webAttackBruteForceNn = json['Web_Attack_Brute_Force_nn'];
    webAttackBruteForceProbNn = json['Web_Attack_Brute_Force_prob_nn'];
    webAttackBruteForceSgd = json['Web_Attack_Brute_Force_sgd'];
    webAttackBruteForceXgb = json['Web_Attack_Brute_Force_xgb'];
    webAttackBruteForceProbXgb = double.parse(json['Web_Attack_Brute_Force_prob_xgb']);
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Init_Win_bytes_backward'] = initWinBytesBackward;
    data[' Fwd IAT Min'] = fwdIATMin;
    data[' Max Packet Length'] = maxPacketLength;
    data[' Fwd IAT Std'] = fwdIATStd;
    data['Init_Win_bytes_forward'] = initWinBytesForward;
    data[' Avg Fwd Segment Size'] = avgFwdSegmentSize;
    data[' Fwd Packet Length Mean'] = fwdPacketLengthMean;
    data[' Fwd Packet Length Max'] = fwdPacketLengthMax;
    data[' Average Packet Size'] = averagePacketSize;
    data[' Destination Port'] = destinationPort;
    data['Web_Attack_Brute_Force_logic'] = webAttackBruteForceLogic;
    data['Web_Attack_Brute_Force_prob_logic'] = webAttackBruteForceProbLogic;
    data['Web_Attack_Brute_Force_nn'] = webAttackBruteForceNn;
    data['Web_Attack_Brute_Force_prob_nn'] = webAttackBruteForceProbNn;
    data['Web_Attack_Brute_Force_sgd'] = webAttackBruteForceSgd;
    data['Web_Attack_Brute_Force_xgb'] = webAttackBruteForceXgb;
    data['Web_Attack_Brute_Force_prob_xgb'] = webAttackBruteForceProbXgb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
