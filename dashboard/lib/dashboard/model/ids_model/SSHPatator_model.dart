class SSHPatatorModel {
  String? destinationPort;
  String? initWinBytesBackward;
  String? flowBytesS;
  String? bwdHeaderLength;
  String? totalBackwardPackets;
  String? initWinBytesForward;
  String? fwdHeaderLength;
  String? maxPacketLength;
  String? bwdPacketsS;
  String? averagePacketSize;
  String? sSHPatator;
  String? sSHPatatorProb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  SSHPatatorModel(
      {this.destinationPort,
      this.initWinBytesBackward,
      this.flowBytesS,
      this.bwdHeaderLength,
      this.totalBackwardPackets,
      this.initWinBytesForward,
      this.fwdHeaderLength,
      this.maxPacketLength,
      this.bwdPacketsS,
      this.averagePacketSize,
      this.sSHPatator,
      this.sSHPatatorProb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  SSHPatatorModel.fromJson(Map<String, dynamic> json) {
    destinationPort = json[' Destination Port'];
    initWinBytesBackward = json[' Init_Win_bytes_backward'];
    flowBytesS = json['Flow Bytes/s'];
    bwdHeaderLength = json[' Bwd Header Length'];
    totalBackwardPackets = json[' Total Backward Packets'];
    initWinBytesForward = json['Init_Win_bytes_forward'];
    fwdHeaderLength = json[' Fwd Header Length'];
    maxPacketLength = json[' Max Packet Length'];
    bwdPacketsS = json[' Bwd Packets/s'];
    averagePacketSize = json[' Average Packet Size'];
    sSHPatator = json['SSHPatator'];
    sSHPatatorProb = json['SSHPatator_prob'];
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Destination Port'] = destinationPort;
    data[' Init_Win_bytes_backward'] = initWinBytesBackward;
    data['Flow Bytes/s'] = flowBytesS;
    data[' Bwd Header Length'] = bwdHeaderLength;
    data[' Total Backward Packets'] = totalBackwardPackets;
    data['Init_Win_bytes_forward'] = initWinBytesForward;
    data[' Fwd Header Length'] = fwdHeaderLength;
    data[' Max Packet Length'] = maxPacketLength;
    data[' Bwd Packets/s'] = bwdPacketsS;
    data[' Average Packet Size'] = averagePacketSize;
    data['SSHPatator'] = sSHPatator;
    data['SSHPatator_prob'] = sSHPatatorProb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
