class IDSBotModel {
  String? destinationPort;
  String? avgBwdSegmentSize;
  String? bwdPacketLengthMean;
  String? initWinBytesForward;
  String? totalLengthOfBwdPackets;
  String? initWinBytesBackward;
  String? bwdIATMin;
  String? bwdPacketLengthMax;
  String? averagePacketSize;
  String? packetLengthMean;
  String? bot;
  String? botProb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  IDSBotModel(
      {this.destinationPort,
      this.avgBwdSegmentSize,
      this.bwdPacketLengthMean,
      this.initWinBytesForward,
      this.totalLengthOfBwdPackets,
      this.initWinBytesBackward,
      this.bwdIATMin,
      this.bwdPacketLengthMax,
      this.averagePacketSize,
      this.packetLengthMean,
      this.bot,
      this.botProb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  IDSBotModel.fromJson(Map<String, dynamic> json) {
    destinationPort = json[' Destination Port'];
    avgBwdSegmentSize = json[' Avg Bwd Segment Size'];
    bwdPacketLengthMean = json[' Bwd Packet Length Mean'];
    initWinBytesForward = json['Init_Win_bytes_forward'];
    totalLengthOfBwdPackets = json[' Total Length of Bwd Packets'];
    initWinBytesBackward = json[' Init_Win_bytes_backward'];
    bwdIATMin = json[' Bwd IAT Min'];
    bwdPacketLengthMax = json['Bwd Packet Length Max'];
    averagePacketSize = json[' Average Packet Size'];
    packetLengthMean = json[' Packet Length Mean'];
    bot = json['Bot'];
    botProb = json['Bot_prob'];
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Destination Port'] = destinationPort;
    data[' Avg Bwd Segment Size'] = avgBwdSegmentSize;
    data[' Bwd Packet Length Mean'] = bwdPacketLengthMean;
    data['Init_Win_bytes_forward'] = initWinBytesForward;
    data[' Total Length of Bwd Packets'] = totalLengthOfBwdPackets;
    data[' Init_Win_bytes_backward'] = initWinBytesBackward;
    data[' Bwd IAT Min'] = bwdIATMin;
    data['Bwd Packet Length Max'] = bwdPacketLengthMax;
    data[' Average Packet Size'] = averagePacketSize;
    data[' Packet Length Mean'] = packetLengthMean;
    data['Bot'] = bot;
    data['Bot_prob'] = botProb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
