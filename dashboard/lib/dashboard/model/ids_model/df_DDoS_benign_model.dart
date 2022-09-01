class DDoSBenignModel {
  String? packetLengthVariance;
  String? bwdPacketLengthMean;
  String? bwdPacketLengthStd;
  String? fwdPacketLengthMax;
  String? packetLengthStd;
  String? avgBwdSegmentSize;
  String? averagePacketSize;
  String? actDataPktFwd;
  String? packetLengthMean;
  String? fwdIATStd;
  String? dfDDoSBenignLogic;
  String? dfDDoSBenignProbLogic;
  String? dfDDoSBenignNn;
  String? dfDDoSBenignProbNn;
  String? dfDDoSBenignSgd;
  String? dfDDoSBenignXgb;
  double? dfDDoSBenignProbXgb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  DDoSBenignModel(
      {this.packetLengthVariance,
      this.bwdPacketLengthMean,
      this.bwdPacketLengthStd,
      this.fwdPacketLengthMax,
      this.packetLengthStd,
      this.avgBwdSegmentSize,
      this.averagePacketSize,
      this.actDataPktFwd,
      this.packetLengthMean,
      this.fwdIATStd,
      this.dfDDoSBenignLogic,
      this.dfDDoSBenignProbLogic,
      this.dfDDoSBenignNn,
      this.dfDDoSBenignProbNn,
      this.dfDDoSBenignSgd,
      this.dfDDoSBenignXgb,
      this.dfDDoSBenignProbXgb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  DDoSBenignModel.fromJson(Map<String, dynamic> json) {
    packetLengthVariance = json[' Packet Length Variance'];
    bwdPacketLengthMean = json[' Bwd Packet Length Mean'];
    bwdPacketLengthStd = json[' Bwd Packet Length Std'];
    fwdPacketLengthMax = json[' Fwd Packet Length Max'];
    packetLengthStd = json[' Packet Length Std'];
    avgBwdSegmentSize = json[' Avg Bwd Segment Size'];
    averagePacketSize = json[' Average Packet Size'];
    actDataPktFwd = json[' act_data_pkt_fwd'];
    packetLengthMean = json[' Packet Length Mean'];
    fwdIATStd = json[' Fwd IAT Std'];
    dfDDoSBenignLogic = json['df_DDoS_benign_logic'];
    dfDDoSBenignProbLogic = json['df_DDoS_benign_prob_logic'];
    dfDDoSBenignNn = json['df_DDoS_benign_nn'];
    dfDDoSBenignProbNn = json['df_DDoS_benign_prob_nn'];
    dfDDoSBenignSgd = json['df_DDoS_benign_sgd'];
    dfDDoSBenignXgb = json['df_DDoS_benign_xgb'];
    dfDDoSBenignProbXgb = double.parse(json['df_DDoS_benign_prob_xgb']);
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Packet Length Variance'] = packetLengthVariance;
    data[' Bwd Packet Length Mean'] = bwdPacketLengthMean;
    data[' Bwd Packet Length Std'] = bwdPacketLengthStd;
    data[' Fwd Packet Length Max'] = fwdPacketLengthMax;
    data[' Packet Length Std'] = packetLengthStd;
    data[' Avg Bwd Segment Size'] = avgBwdSegmentSize;
    data[' Average Packet Size'] = averagePacketSize;
    data[' act_data_pkt_fwd'] = actDataPktFwd;
    data[' Packet Length Mean'] = packetLengthMean;
    data[' Fwd IAT Std'] = fwdIATStd;
    data['df_DDoS_benign_logic'] = dfDDoSBenignLogic;
    data['df_DDoS_benign_prob_logic'] = dfDDoSBenignProbLogic;
    data['df_DDoS_benign_nn'] = dfDDoSBenignNn;
    data['df_DDoS_benign_prob_nn'] = dfDDoSBenignProbNn;
    data['df_DDoS_benign_sgd'] = dfDDoSBenignSgd;
    data['df_DDoS_benign_xgb'] = dfDDoSBenignXgb;
    data['df_DDoS_benign_prob_xgb'] = dfDDoSBenignProbXgb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
