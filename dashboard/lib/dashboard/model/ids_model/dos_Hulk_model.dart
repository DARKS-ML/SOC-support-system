class DoSHulkModel {
  String? packetLengthMean;
  String? maxPacketLength;
  String? averagePacketSize;
  String? packetLengthStd;
  String? packetLengthVariance;
  String? avgBwdSegmentSize;
  String? totalLengthOfBwdPackets;
  String? bwdPacketLengthStd;
  String? destinationPort;
  String? idleMax;
  String? doSHulk;
  String? doSHulkProb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  DoSHulkModel(
      {this.packetLengthMean,
      this.maxPacketLength,
      this.averagePacketSize,
      this.packetLengthStd,
      this.packetLengthVariance,
      this.avgBwdSegmentSize,
      this.totalLengthOfBwdPackets,
      this.bwdPacketLengthStd,
      this.destinationPort,
      this.idleMax,
      this.doSHulk,
      this.doSHulkProb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  DoSHulkModel.fromJson(Map<String, dynamic> json) {
    packetLengthMean = json[' Packet Length Mean'];
    maxPacketLength = json[' Max Packet Length'];
    averagePacketSize = json[' Average Packet Size'];
    packetLengthStd = json[' Packet Length Std'];
    packetLengthVariance = json[' Packet Length Variance'];
    avgBwdSegmentSize = json[' Avg Bwd Segment Size'];
    totalLengthOfBwdPackets = json[' Total Length of Bwd Packets'];
    bwdPacketLengthStd = json[' Bwd Packet Length Std'];
    destinationPort = json[' Destination Port'];
    idleMax = json[' Idle Max'];
    doSHulk = json['DoS_Hulk'];
    doSHulkProb = json['DoS_Hulk_prob'];
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Packet Length Mean'] = packetLengthMean;
    data[' Max Packet Length'] = maxPacketLength;
    data[' Average Packet Size'] = averagePacketSize;
    data[' Packet Length Std'] = packetLengthStd;
    data[' Packet Length Variance'] = packetLengthVariance;
    data[' Avg Bwd Segment Size'] = avgBwdSegmentSize;
    data[' Total Length of Bwd Packets'] = totalLengthOfBwdPackets;
    data[' Bwd Packet Length Std'] = bwdPacketLengthStd;
    data[' Destination Port'] = destinationPort;
    data[' Idle Max'] = idleMax;
    data['DoS_Hulk'] = doSHulk;
    data['DoS_Hulk_prob'] = doSHulkProb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
