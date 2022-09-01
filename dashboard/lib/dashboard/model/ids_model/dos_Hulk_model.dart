class DoSHulkModel {
  String? packetLengthStd;
  String? bwdPacketLengthStd;
  String? bwdPacketLengthMean;
  String? avgBwdSegmentSize;
  String? averagePacketSize;
  String? packetLengthMean;
  String? maxPacketLength;
  String? bwdPacketLengthMax;
  String? destinationPort;
  String? packetLengthVariance;
  String? doSHulkLogic;
  String? doSHulkProbLogic;
  String? doSHulkNn;
  String? doSHulkProbNn;
  String? doSHulkSgd;
  String? doSHulkXgb;
  double? doSHulkProbXgb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  DoSHulkModel(
      {this.packetLengthStd,
      this.bwdPacketLengthStd,
      this.bwdPacketLengthMean,
      this.avgBwdSegmentSize,
      this.averagePacketSize,
      this.packetLengthMean,
      this.maxPacketLength,
      this.bwdPacketLengthMax,
      this.destinationPort,
      this.packetLengthVariance,
      this.doSHulkLogic,
      this.doSHulkProbLogic,
      this.doSHulkNn,
      this.doSHulkProbNn,
      this.doSHulkSgd,
      this.doSHulkXgb,
      this.doSHulkProbXgb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  DoSHulkModel.fromJson(Map<String, dynamic> json) {
    packetLengthStd = json[' Packet Length Std'];
    bwdPacketLengthStd = json[' Bwd Packet Length Std'];
    bwdPacketLengthMean = json[' Bwd Packet Length Mean'];
    avgBwdSegmentSize = json[' Avg Bwd Segment Size'];
    averagePacketSize = json[' Average Packet Size'];
    packetLengthMean = json[' Packet Length Mean'];
    maxPacketLength = json[' Max Packet Length'];
    bwdPacketLengthMax = json['Bwd Packet Length Max'];
    destinationPort = json[' Destination Port'];
    packetLengthVariance = json[' Packet Length Variance'];
    doSHulkLogic = json['DoS_Hulk_logic'];
    doSHulkProbLogic = json['DoS_Hulk_prob_logic'];
    doSHulkNn = json['DoS_Hulk_nn'];
    doSHulkProbNn = json['DoS_Hulk_prob_nn'];
    doSHulkSgd = json['DoS_Hulk_sgd'];
    doSHulkXgb = json['DoS_Hulk_xgb'];
    doSHulkProbXgb = double.parse(json['DoS_Hulk_prob_xgb']);
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Packet Length Std'] = packetLengthStd;
    data[' Bwd Packet Length Std'] = bwdPacketLengthStd;
    data[' Bwd Packet Length Mean'] = bwdPacketLengthMean;
    data[' Avg Bwd Segment Size'] = avgBwdSegmentSize;
    data[' Average Packet Size'] = averagePacketSize;
    data[' Packet Length Mean'] = packetLengthMean;
    data[' Max Packet Length'] = maxPacketLength;
    data['Bwd Packet Length Max'] = bwdPacketLengthMax;
    data[' Destination Port'] = destinationPort;
    data[' Packet Length Variance'] = packetLengthVariance;
    data['DoS_Hulk_logic'] = doSHulkLogic;
    data['DoS_Hulk_prob_logic'] = doSHulkProbLogic;
    data['DoS_Hulk_nn'] = doSHulkNn;
    data['DoS_Hulk_prob_nn'] = doSHulkProbNn;
    data['DoS_Hulk_sgd'] = doSHulkSgd;
    data['DoS_Hulk_xgb'] = doSHulkXgb;
    data['DoS_Hulk_prob_xgb'] = doSHulkProbXgb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
