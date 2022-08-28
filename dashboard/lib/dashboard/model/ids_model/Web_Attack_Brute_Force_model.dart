class WebAttackBruteForceModel {
  String? fwdIATMin;
  String? maxPacketLength;
  String? packetLengthMean;
  String? initWinBytesForward;
  String? initWinBytesBackward;
  String? totalLengthOfFwdPackets;
  String? averagePacketSize;
  String? fwdIATStd;
  String? fwdHeaderLength1;
  String? fwdPacketLengthMax;
  String? webAttackBruteForce;
  String? webAttackBruteForceProb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  WebAttackBruteForceModel(
      {this.fwdIATMin,
      this.maxPacketLength,
      this.packetLengthMean,
      this.initWinBytesForward,
      this.initWinBytesBackward,
      this.totalLengthOfFwdPackets,
      this.averagePacketSize,
      this.fwdIATStd,
      this.fwdHeaderLength1,
      this.fwdPacketLengthMax,
      this.webAttackBruteForce,
      this.webAttackBruteForceProb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  WebAttackBruteForceModel.fromJson(Map<String, dynamic> json) {
    fwdIATMin = json[' Fwd IAT Min'];
    maxPacketLength = json[' Max Packet Length'];
    packetLengthMean = json[' Packet Length Mean'];
    initWinBytesForward = json['Init_Win_bytes_forward'];
    initWinBytesBackward = json[' Init_Win_bytes_backward'];
    totalLengthOfFwdPackets = json['Total Length of Fwd Packets'];
    averagePacketSize = json[' Average Packet Size'];
    fwdIATStd = json[' Fwd IAT Std'];
    fwdHeaderLength1 = json[' Fwd Header Length.1'];
    fwdPacketLengthMax = json[' Fwd Packet Length Max'];
    webAttackBruteForce = json['Web_Attack_Brute_Force'];
    webAttackBruteForceProb = json['Web_Attack_Brute_Force_prob'];
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Fwd IAT Min'] = fwdIATMin;
    data[' Max Packet Length'] = maxPacketLength;
    data[' Packet Length Mean'] = packetLengthMean;
    data['Init_Win_bytes_forward'] = initWinBytesForward;
    data[' Init_Win_bytes_backward'] = initWinBytesBackward;
    data['Total Length of Fwd Packets'] = totalLengthOfFwdPackets;
    data[' Average Packet Size'] = averagePacketSize;
    data[' Fwd IAT Std'] = fwdIATStd;
    data[' Fwd Header Length.1'] = fwdHeaderLength1;
    data[' Fwd Packet Length Max'] = fwdPacketLengthMax;
    data['Web_Attack_Brute_Force'] = webAttackBruteForce;
    data['Web_Attack_Brute_Force_prob'] = webAttackBruteForceProb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
