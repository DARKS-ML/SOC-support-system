class SSHPatatorModel {
  String? totalLengthOfFwdPackets;
  String? packetLengthMean;
  String? averagePacketSize;
  String? subflowFwdBytes;
  String? pSHFlagCount;
  String? flowIATMax;
  String? avgFwdSegmentSize;
  String? packetLengthStd;
  String? bwdPacketLengthMax;
  String? bwdPacketLengthMin;
  String? portScan;
  String? portScanProb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  SSHPatatorModel(
      {this.totalLengthOfFwdPackets,
      this.packetLengthMean,
      this.averagePacketSize,
      this.subflowFwdBytes,
      this.pSHFlagCount,
      this.flowIATMax,
      this.avgFwdSegmentSize,
      this.packetLengthStd,
      this.bwdPacketLengthMax,
      this.bwdPacketLengthMin,
      this.portScan,
      this.portScanProb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  SSHPatatorModel.fromJson(Map<String, dynamic> json) {
    totalLengthOfFwdPackets = json['Total Length of Fwd Packets'];
    packetLengthMean = json[' Packet Length Mean'];
    averagePacketSize = json[' Average Packet Size'];
    subflowFwdBytes = json[' Subflow Fwd Bytes'];
    pSHFlagCount = json[' PSH Flag Count'];
    flowIATMax = json[' Flow IAT Max'];
    avgFwdSegmentSize = json[' Avg Fwd Segment Size'];
    packetLengthStd = json[' Packet Length Std'];
    bwdPacketLengthMax = json['Bwd Packet Length Max'];
    bwdPacketLengthMin = json[' Bwd Packet Length Min'];
    portScan = json['PortScan'];
    portScanProb = json['PortScan_prob'];
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Total Length of Fwd Packets'] = totalLengthOfFwdPackets;
    data[' Packet Length Mean'] = packetLengthMean;
    data[' Average Packet Size'] = averagePacketSize;
    data[' Subflow Fwd Bytes'] = subflowFwdBytes;
    data[' PSH Flag Count'] = pSHFlagCount;
    data[' Flow IAT Max'] = flowIATMax;
    data[' Avg Fwd Segment Size'] = avgFwdSegmentSize;
    data[' Packet Length Std'] = packetLengthStd;
    data['Bwd Packet Length Max'] = bwdPacketLengthMax;
    data[' Bwd Packet Length Min'] = bwdPacketLengthMin;
    data['PortScan'] = portScan;
    data['PortScan_prob'] = portScanProb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
