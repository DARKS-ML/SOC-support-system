class HeartbleedModel {
  String? packetLengthMean;
  String? fwdHeaderLength1;
  String? subflowBwdBytes;
  String? packetLengthStd;
  String? bwdPacketLengthStd;
  String? bwdPacketLengthMean;
  String? fwdHeaderLength;
  String? totalBackwardPackets;
  String? averagePacketSize;
  String? avgBwdSegmentSize;
  String? heartbleedLogic;
  String? heartbleedProbLogic;
  String? heartbleedNn;
  String? heartbleedProbNn;
  String? heartbleedSgd;
  String? heartbleedXgb;
  double? heartbleedProbXgb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  HeartbleedModel(
      {this.packetLengthMean,
      this.fwdHeaderLength1,
      this.subflowBwdBytes,
      this.packetLengthStd,
      this.bwdPacketLengthStd,
      this.bwdPacketLengthMean,
      this.fwdHeaderLength,
      this.totalBackwardPackets,
      this.averagePacketSize,
      this.avgBwdSegmentSize,
      this.heartbleedLogic,
      this.heartbleedProbLogic,
      this.heartbleedNn,
      this.heartbleedProbNn,
      this.heartbleedSgd,
      this.heartbleedXgb,
      this.heartbleedProbXgb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  HeartbleedModel.fromJson(Map<String, dynamic> json) {
    packetLengthMean = json[' Packet Length Mean'];
    fwdHeaderLength1 = json[' Fwd Header Length.1'];
    subflowBwdBytes = json[' Subflow Bwd Bytes'];
    packetLengthStd = json[' Packet Length Std'];
    bwdPacketLengthStd = json[' Bwd Packet Length Std'];
    bwdPacketLengthMean = json[' Bwd Packet Length Mean'];
    fwdHeaderLength = json[' Fwd Header Length'];
    totalBackwardPackets = json[' Total Backward Packets'];
    averagePacketSize = json[' Average Packet Size'];
    avgBwdSegmentSize = json[' Avg Bwd Segment Size'];
    heartbleedLogic = json['Heartbleed_logic'];
    heartbleedProbLogic = json['Heartbleed_prob_logic'];
    heartbleedNn = json['Heartbleed_nn'];
    heartbleedProbNn = json['Heartbleed_prob_nn'];
    heartbleedSgd = json['Heartbleed_sgd'];
    heartbleedXgb = json['Heartbleed_xgb'];
    heartbleedProbXgb = double.parse(json['Heartbleed_prob_xgb']);
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Packet Length Mean'] = packetLengthMean;
    data[' Fwd Header Length.1'] = fwdHeaderLength1;
    data[' Subflow Bwd Bytes'] = subflowBwdBytes;
    data[' Packet Length Std'] = packetLengthStd;
    data[' Bwd Packet Length Std'] = bwdPacketLengthStd;
    data[' Bwd Packet Length Mean'] = bwdPacketLengthMean;
    data[' Fwd Header Length'] = fwdHeaderLength;
    data[' Total Backward Packets'] = totalBackwardPackets;
    data[' Average Packet Size'] = averagePacketSize;
    data[' Avg Bwd Segment Size'] = avgBwdSegmentSize;
    data['Heartbleed_logic'] = heartbleedLogic;
    data['Heartbleed_prob_logic'] = heartbleedProbLogic;
    data['Heartbleed_nn'] = heartbleedNn;
    data['Heartbleed_prob_nn'] = heartbleedProbNn;
    data['Heartbleed_sgd'] = heartbleedSgd;
    data['Heartbleed_xgb'] = heartbleedXgb;
    data['Heartbleed_prob_xgb'] = heartbleedProbXgb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
