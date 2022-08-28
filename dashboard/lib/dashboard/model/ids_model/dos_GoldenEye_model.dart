class DoSGoldenEyeModel {
  String? flowPacketsS;
  String? bwdPacketLengthStd;
  String? maxPacketLength;
  String? flowIATMax;
  String? bwdPacketLengthMax;
  String? flowDuration;
  String? flowIATMean;
  String? avgBwdSegmentSize;
  String? fwdPacketsS;
  String? packetLengthStd;
  String? doSGoldenEye;
  String? doSGoldenEyeProb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  DoSGoldenEyeModel(
      {this.flowPacketsS,
      this.bwdPacketLengthStd,
      this.maxPacketLength,
      this.flowIATMax,
      this.bwdPacketLengthMax,
      this.flowDuration,
      this.flowIATMean,
      this.avgBwdSegmentSize,
      this.fwdPacketsS,
      this.packetLengthStd,
      this.doSGoldenEye,
      this.doSGoldenEyeProb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  DoSGoldenEyeModel.fromJson(Map<String, dynamic> json) {
    flowPacketsS = json[' Flow Packets/s'];
    bwdPacketLengthStd = json[' Bwd Packet Length Std'];
    maxPacketLength = json[' Max Packet Length'];
    flowIATMax = json[' Flow IAT Max'];
    bwdPacketLengthMax = json['Bwd Packet Length Max'];
    flowDuration = json[' Flow Duration'];
    flowIATMean = json[' Flow IAT Mean'];
    avgBwdSegmentSize = json[' Avg Bwd Segment Size'];
    fwdPacketsS = json['Fwd Packets/s'];
    packetLengthStd = json[' Packet Length Std'];
    doSGoldenEye = json['DoS_GoldenEye'];
    doSGoldenEyeProb = json['DoS_GoldenEye_prob'];
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Flow Packets/s'] = flowPacketsS;
    data[' Bwd Packet Length Std'] = bwdPacketLengthStd;
    data[' Max Packet Length'] = maxPacketLength;
    data[' Flow IAT Max'] = flowIATMax;
    data['Bwd Packet Length Max'] = bwdPacketLengthMax;
    data[' Flow Duration'] = flowDuration;
    data[' Flow IAT Mean'] = flowIATMean;
    data[' Avg Bwd Segment Size'] = avgBwdSegmentSize;
    data['Fwd Packets/s'] = fwdPacketsS;
    data[' Packet Length Std'] = packetLengthStd;
    data['DoS_GoldenEye'] = doSGoldenEye;
    data['DoS_GoldenEye_prob'] = doSGoldenEyeProb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
