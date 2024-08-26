abstract class IpUtils {
  static bool isIpInList(String ip, List<String> ipList) {
    for (String entry in ipList) {
      if (entry.contains('/')) {
        if (_isIpInSubnet(ip, entry)) {
          return true;
        }
      } else {
        if (ip == entry) {
          return true;
        }
      }
    }
    return false;
  }

  static bool _isIpInSubnet(String ip, String subnet) {
    final parts = subnet.split('/');
    final subnetIp = parts[0];
    final prefixLength = int.parse(parts[1]);

    final ipBits = _ipToBinary(ip);
    final subnetBits = _ipToBinary(subnetIp);

    final subnetMask = '1' * prefixLength + '0' * (32 - prefixLength);

    final maskedIp = ipBits & int.parse(subnetMask, radix: 2);
    final maskedSubnet = subnetBits & int.parse(subnetMask, radix: 2);

    return maskedIp == maskedSubnet;
  }

  static int _ipToBinary(String ip) {
    final octets = ip.split('.').map(int.parse).toList();
    return (octets[0] << 24) + (octets[1] << 16) + (octets[2] << 8) + octets[3];
  }
}
