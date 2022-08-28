class FTPPatatorModel {
  String? fwdPacketLengthStd;
  String? destinationPort;
  String? averagePacketSize;
  String? fwdPacketLengthMean;
  String? packetLengthMean;
  String? fwdPacketLengthMax;
  String? packetLengthStd;
  String? avgFwdSegmentSize;
  String? packetLengthVariance;
  String? totalLengthOfFwdPackets;
  String? fTPPatator;
  String? fTPPatatorProb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  FTPPatatorModel(
      {this.fwdPacketLengthStd,
      this.destinationPort,
      this.averagePacketSize,
      this.fwdPacketLengthMean,
      this.packetLengthMean,
      this.fwdPacketLengthMax,
      this.packetLengthStd,
      this.avgFwdSegmentSize,
      this.packetLengthVariance,
      this.totalLengthOfFwdPackets,
      this.fTPPatator,
      this.fTPPatatorProb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  FTPPatatorModel.fromJson(Map<String, dynamic> json) {
    fwdPacketLengthStd = json[' Fwd Packet Length Std'];
    destinationPort = json[' Destination Port'];
    averagePacketSize = json[' Average Packet Size'];
    fwdPacketLengthMean = json[' Fwd Packet Length Mean'];
    packetLengthMean = json[' Packet Length Mean'];
    fwdPacketLengthMax = json[' Fwd Packet Length Max'];
    packetLengthStd = json[' Packet Length Std'];
    avgFwdSegmentSize = json[' Avg Fwd Segment Size'];
    packetLengthVariance = json[' Packet Length Variance'];
    totalLengthOfFwdPackets = json['Total Length of Fwd Packets'];
    fTPPatator = json['FTPPatator'];
    fTPPatatorProb = json['FTPPatator_prob'];
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Fwd Packet Length Std'] = fwdPacketLengthStd;
    data[' Destination Port'] = destinationPort;
    data[' Average Packet Size'] = averagePacketSize;
    data[' Fwd Packet Length Mean'] = fwdPacketLengthMean;
    data[' Packet Length Mean'] = packetLengthMean;
    data[' Fwd Packet Length Max'] = fwdPacketLengthMax;
    data[' Packet Length Std'] = packetLengthStd;
    data[' Avg Fwd Segment Size'] = avgFwdSegmentSize;
    data[' Packet Length Variance'] = packetLengthVariance;
    data['Total Length of Fwd Packets'] = totalLengthOfFwdPackets;
    data['FTPPatator'] = fTPPatator;
    data['FTPPatator_prob'] = fTPPatatorProb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
