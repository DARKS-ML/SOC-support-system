class DoSSlowhttptestModel {
  String? flowIATMean;
  String? flowPacketsS;
  String? flowIATMax;
  String? fwdIATStd;
  String? fwdIATMax;
  String? fwdIATMean;
  String? activeMax;
  String? fwdPacketsS;
  String? flowIATStd;
  String? idleMax;
  String? doSSlowhttptest;
  String? doSSlowhttptestProb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  DoSSlowhttptestModel(
      {this.flowIATMean,
      this.flowPacketsS,
      this.flowIATMax,
      this.fwdIATStd,
      this.fwdIATMax,
      this.fwdIATMean,
      this.activeMax,
      this.fwdPacketsS,
      this.flowIATStd,
      this.idleMax,
      this.doSSlowhttptest,
      this.doSSlowhttptestProb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  DoSSlowhttptestModel.fromJson(Map<String, dynamic> json) {
    flowIATMean = json[' Flow IAT Mean'];
    flowPacketsS = json[' Flow Packets/s'];
    flowIATMax = json[' Flow IAT Max'];
    fwdIATStd = json[' Fwd IAT Std'];
    fwdIATMax = json[' Fwd IAT Max'];
    fwdIATMean = json[' Fwd IAT Mean'];
    activeMax = json[' Active Max'];
    fwdPacketsS = json['Fwd Packets/s'];
    flowIATStd = json[' Flow IAT Std'];
    idleMax = json[' Idle Max'];
    doSSlowhttptest = json['DoS_Slowhttptest'];
    doSSlowhttptestProb = json['DoS_Slowhttptest_prob'];
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Flow IAT Mean'] = flowIATMean;
    data[' Flow Packets/s'] = flowPacketsS;
    data[' Flow IAT Max'] = flowIATMax;
    data[' Fwd IAT Std'] = fwdIATStd;
    data[' Fwd IAT Max'] = fwdIATMax;
    data[' Fwd IAT Mean'] = fwdIATMean;
    data[' Active Max'] = activeMax;
    data['Fwd Packets/s'] = fwdPacketsS;
    data[' Flow IAT Std'] = flowIATStd;
    data[' Idle Max'] = idleMax;
    data['DoS_Slowhttptest'] = doSSlowhttptest;
    data['DoS_Slowhttptest_prob'] = doSSlowhttptestProb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
