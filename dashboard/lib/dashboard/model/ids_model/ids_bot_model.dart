class IDSBotModel {
  String? destinationPort;
  String? bwdIATMin;
  String? avgBwdSegmentSize;
  String? totalLengthOfBwdPackets;
  String? bwdPacketLengthMean;
  String? initWinBytesForward;
  String? bwdIATMean;
  String? subflowBwdBytes;
  String? flowDuration;
  String? packetLengthMean;
  String? botLogic;
  String? botProbLogic;
  String? botNn;
  String? botProbNn;
  String? botSgd;
  String? botXgb;
  double? botProbXgb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  IDSBotModel(
      {this.destinationPort,
      this.bwdIATMin,
      this.avgBwdSegmentSize,
      this.totalLengthOfBwdPackets,
      this.bwdPacketLengthMean,
      this.initWinBytesForward,
      this.bwdIATMean,
      this.subflowBwdBytes,
      this.flowDuration,
      this.packetLengthMean,
      this.botLogic,
      this.botProbLogic,
      this.botNn,
      this.botProbNn,
      this.botSgd,
      this.botXgb,
      this.botProbXgb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  IDSBotModel.fromJson(Map<String, dynamic> json) {
    destinationPort = json[' Destination Port'];
    bwdIATMin = json[' Bwd IAT Min'];
    avgBwdSegmentSize = json[' Avg Bwd Segment Size'];
    totalLengthOfBwdPackets = json[' Total Length of Bwd Packets'];
    bwdPacketLengthMean = json[' Bwd Packet Length Mean'];
    initWinBytesForward = json['Init_Win_bytes_forward'];
    bwdIATMean = json[' Bwd IAT Mean'];
    subflowBwdBytes = json[' Subflow Bwd Bytes'];
    flowDuration = json[' Flow Duration'];
    packetLengthMean = json[' Packet Length Mean'];
    botLogic = json['Bot_logic'];
    botProbLogic = json['Bot_prob_logic'];
    botNn = json['Bot_nn'];
    botProbNn = json['Bot_prob_nn'];
    botSgd = json['Bot_sgd'];
    botXgb = json['Bot_xgb'];
    botProbXgb = double.parse(json['Bot_prob_xgb']);
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Destination Port'] = destinationPort;
    data[' Bwd IAT Min'] = bwdIATMin;
    data[' Avg Bwd Segment Size'] = avgBwdSegmentSize;
    data[' Total Length of Bwd Packets'] = totalLengthOfBwdPackets;
    data[' Bwd Packet Length Mean'] = bwdPacketLengthMean;
    data['Init_Win_bytes_forward'] = initWinBytesForward;
    data[' Bwd IAT Mean'] = bwdIATMean;
    data[' Subflow Bwd Bytes'] = subflowBwdBytes;
    data[' Flow Duration'] = flowDuration;
    data[' Packet Length Mean'] = packetLengthMean;
    data['Bot_logic'] = botLogic;
    data['Bot_prob_logic'] = botProbLogic;
    data['Bot_nn'] = botNn;
    data['Bot_prob_nn'] = botProbNn;
    data['Bot_sgd'] = botSgd;
    data['Bot_xgb'] = botXgb;
    data['Bot_prob_xgb'] = botProbXgb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
