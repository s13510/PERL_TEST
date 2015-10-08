
open(OUTFILE, ">synthetic_wires_data2_replication_1");
open(FILE, "synthetic_wires_data2");
$row=0;

while (<FILE>)
{
	next if /^\s*$/;
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
		$c=1;
		foreach $val (@val_array) {		


			if($c >=2 && $c <=6) {
			
				$val2 = scramble($val);
				$val3 = scramble2($val2);
				$new_val = scramble3($val3);
				
				print OUTFILE "$new_val|";
			}
			else {
				print OUTFILE "$val|";
			}
			$c++;
			
		}

		print OUTFILE "\n";

		for ($x=1; $x<3; $x++) {

			$row++;
			#print OUTFILE "<$row>|";

			$dt = date_gen();
			while ($dt_array{$dt} > 0)
			{
				$dt = date_gen();
				$dt_array{$dt}++;
			}	
			
			print OUTFILE "$dt\n";
			
			$c=1;
			foreach $val (@val_array)
			{

					if($c >=2 && $c <=6) {
					$val2 = scramble($val);
					$val3 = scramble2($val2);
					$new_val = scramble3($val3);
					print OUTFILE "$new_val|";
				} else {
					print OUTFILE "$val|";
				}
				$c++;
			}
			print OUTFILE "\n";
		}
	}
	
	last if ($row > 100);
}

close (FILE);
close (OUTFILE);
print STDOUT "$row records written\n";

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
	$mm = sprintf("02d", $mm_min + int(rand($mm_max - $mm_min)));
	$dd = sprintf("02d", $mm_min + int(rand($mm_max - $mm_min)));
	$date = ($yyyy * 10000) + ($mm * 100) + $dd;
	return $date;
}
