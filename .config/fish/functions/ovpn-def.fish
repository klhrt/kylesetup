function ovpn-def --wraps='sudo openvpn /home/kyle/openvpn/us-fl-65.protonvpn.udp.ovpn' --description 'alias ovpn-def=sudo openvpn /home/kyle/openvpn/us-fl-65.protonvpn.udp.ovpn'
  sudo openvpn /home/kyle/openvpn/us-fl-65.protonvpn.udp.ovpn $argv; 
end
