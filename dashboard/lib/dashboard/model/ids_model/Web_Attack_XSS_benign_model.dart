class WebAttackXSSbenignModel {
  String? initWinBytesBackward;
  String? maxPacketLength;
  String? fwdIATMin;
  String? totalLengthOfFwdPackets;
  String? flowIATMean;
  String? packetLengthMean;
  String? fwdHeaderLength1;
  String? fwdHeaderLength;
  String? subflowFwdBytes;
  String? flowIATStd;
  String? webAttackXSSBenignLogic;
  String? webAttackXSSBenignProbLogic;
  String? webAttackXSSBenignNn;
  String? webAttackXSSBenignProbNn;
  String? webAttackXSSBenignSgd;
  String? webAttackXSSBenignXgb;
  double? webAttackXSSBenignProbXgb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  WebAttackXSSbenignModel(
      {this.initWinBytesBackward,
      this.maxPacketLength,
      this.fwdIATMin,
      this.totalLengthOfFwdPackets,
      this.flowIATMean,
      this.packetLengthMean,
      this.fwdHeaderLength1,
      this.fwdHeaderLength,
      this.subflowFwdBytes,
      this.flowIATStd,
      this.webAttackXSSBenignLogic,
      this.webAttackXSSBenignProbLogic,
      this.webAttackXSSBenignNn,
      this.webAttackXSSBenignProbNn,
      this.webAttackXSSBenignSgd,
      this.webAttackXSSBenignXgb,
      this.webAttackXSSBenignProbXgb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  WebAttackXSSbenignModel.fromJson(Map<String, dynamic> json) {
    initWinBytesBackward = json[' Init_Win_bytes_backward'];
    maxPacketLength = json[' Max Packet Length'];
    fwdIATMin = json[' Fwd IAT Min'];
    totalLengthOfFwdPackets = json['Total Length of Fwd Packets'];
    flowIATMean = json[' Flow IAT Mean'];
    packetLengthMean = json[' Packet Length Mean'];
    fwdHeaderLength1 = json[' Fwd Header Length.1'];
    fwdHeaderLength = json[' Fwd Header Length'];
    subflowFwdBytes = json[' Subflow Fwd Bytes'];
    flowIATStd = json[' Flow IAT Std'];
    webAttackXSSBenignLogic = json['Web_Attack_XSS_benign_logic'];
    webAttackXSSBenignProbLogic = json['Web_Attack_XSS_benign_prob_logic'];
    webAttackXSSBenignNn = json['Web_Attack_XSS_benign_nn'];
    webAttackXSSBenignProbNn = json['Web_Attack_XSS_benign_prob_nn'];
    webAttackXSSBenignSgd = json['Web_Attack_XSS_benign_sgd'];
    webAttackXSSBenignXgb = json['Web_Attack_XSS_benign_xgb'];
    webAttackXSSBenignProbXgb = double.parse(json['Web_Attack_XSS_benign_prob_xgb']);
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Init_Win_bytes_backward'] = initWinBytesBackward;
    data[' Max Packet Length'] = maxPacketLength;
    data[' Fwd IAT Min'] = fwdIATMin;
    data['Total Length of Fwd Packets'] = totalLengthOfFwdPackets;
    data[' Flow IAT Mean'] = flowIATMean;
    data[' Packet Length Mean'] = packetLengthMean;
    data[' Fwd Header Length.1'] = fwdHeaderLength1;
    data[' Fwd Header Length'] = fwdHeaderLength;
    data[' Subflow Fwd Bytes'] = subflowFwdBytes;
    data[' Flow IAT Std'] = flowIATStd;
    data['Web_Attack_XSS_benign_logic'] = webAttackXSSBenignLogic;
    data['Web_Attack_XSS_benign_prob_logic'] = webAttackXSSBenignProbLogic;
    data['Web_Attack_XSS_benign_nn'] = webAttackXSSBenignNn;
    data['Web_Attack_XSS_benign_prob_nn'] = webAttackXSSBenignProbNn;
    data['Web_Attack_XSS_benign_sgd'] = webAttackXSSBenignSgd;
    data['Web_Attack_XSS_benign_xgb'] = webAttackXSSBenignXgb;
    data['Web_Attack_XSS_benign_prob_xgb'] = webAttackXSSBenignProbXgb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
