use warnings;
#open(OUTFILE, ">synthetic_wires_data2_replication_1.txt");
#open(FILE, "wires7_scrambled.txt");

open(OUTFILE, ">synthetic_wires_data2_replication_1");
open(FILE, "synthetic_wires_data2");
$row=0;

while (<FILE>)
{
	next if /^\s*$/;
	next if /^\s*\d\d\d\d/;
	chop;
	$row++;
	#print OUTFILE "<$row>|";

	if ($row==1) {
		@col_desc = split(/\|/, $_);
		foreach $col_name (@col_desc) {
			print OUTFILE "$col_name|";
		}
		print OUTFILE "TXN_DATE\n";
	}		
	else {
		@val_array= split(/\|/, $_);
		
		for ($yyyy = 1960; $yyyy <= 2015; $yyyy++) {
			
				for ($mm = 1; $mm <= 12; $mm++) {
					
					$max_dd = 30;
					if($mm == 2) {$max_dd = 28;}
					elsif($mm == 1 || $mm == 3 || $mm == 5 || $mm == 7 || $mm == 8 || $mm == 10 || $mm == 12) 
					{ $max_dd = 31; }
					
					for ($dd = 1; $dd <= $max_dd; $dd++) {
					
						$date = ($yyyy * 10000) + (sprintf("%04d",($mm * 100))) + sprintf("%02d",$dd);
					
						foreach $val (@val_array) {		
							print OUTFILE "$val|";
						}
						print OUTFILE "$date\n";
					}
				}				
		}
	}
	
	#last if ($row > 2);
}

close (FILE);
close (OUTFILE);
print STDOUT "$row records processed\n";


sub scramble {
    (my $str) = @_;
		$str =~ s/0/X/;
   		$str =~ s/1/a/;
		$str =~ s/3/b/;
		$str =~ s/5/c/;
		$str =~ s/7/d/;
		$str =~ s/9/e/;	
    return $str;
}
sub scramble2 {
    (my $str) = @_;
		$str =~ s/0/o/;
   		$str =~ s/1/f/;
		$str =~ s/3/g/;
		$str =~ s/5/h/;
		$str =~ s/7/i/;
		$str =~ s/9/j/;	
    return $str;
}
sub scramble3 {
    (my $str) = @_;
		$str =~ s/0/s/;
   		$str =~ s/1/k/;
		$str =~ s/3/m/;
		$str =~ s/5/n/;
		$str =~ s/7/p/;
		$str =~ s/9/r/;	
		$str =~ s/X/0/;
    return $str;
}
sub date_gen {
	$yyyy_max = 2014;
	$yyyy_min = 1960;
	$mm_max = 12;
	$mm_min = 1;
	$dd_max = 28;
	$dd_min = 1;

	$yyyy = $yyyy_min + int(rand($yyyy_max - $yyyy_min));
	$mm = sprintf("%02d", $mm_min + int(rand($mm_max - $mm_min)));
	$dd = sprintf("%02d", $dd_min + int(rand($dd_max - $dd_min)));
	$date = ($yyyy * 10000) + ($mm * 100) + $dd;
	return $date;
}
