open(OUTFILE, ">OUTFILE_WITH_GENERATED_WIRES_v7.csv");
open(SCHEMA, ">SCHEMA_v7.txt");
open(FILE, "wires5.txt");
$row=0;

while (<FILE>)
{
	next if /^\s*$/;
	chop;
	$row++;
	 #print OUTFILE "<$row>|";

	if ($row==1) {
		print SCHEMA "[\n";
		@col_desc = split(/\|/, $_);
		foreach $col_name (@col_desc) {
			print SCHEMA "{\"name\": \"$col_name\",";
			print SCHEMA "\"type\": \"string\",";
			print SCHEMA "\"mode\": \"required\"},\n";
		}
		print SCHEMA "\n]\n";
	}		
	else {
		@val_array= split(/\|/, $_);
		$c=1;
		foreach $val (@val_array) {		

					$val=~ s/\-//g;
					$val=~ s/NULL/0/g;
					$val=~ s/,/ /g;

			if($c >=2 && $c <=6) {
				$new_val = $val;
				
				$random_num = int(rand(4))+1;
				if ($random_num == 1) {
					$new_val =~ s/0/M/g;
				} elsif ($random_num == 2) {
					$new_val =~ s/0/P/g;
				} elsif ($random_num == 3) {
					$new_val =~ s/0/V/g;
				} elsif ($random_num == 4) {
					$new_val =~ s/0/R/g;
				} elsif ($random_num == 5) {
					$new_val =~ s/0/T/g;
				} 
				$new_val =~ s/1/C/g;
				$new_val =~ s/2/0/g;
				$new_val =~ s/3/D/g;
				$new_val =~ s/4/K/g;
				$new_val =~ s/5/F/g;
				$new_val =~ s/6/4/g;
				$new_val =~ s/7/G/g;
				$new_val =~ s/8/1/g;
				$new_val =~ s/9/H/g;
				print OUTFILE "$new_val,";
			}
			else {
				print OUTFILE "$val,";
			}
			$c++;
			
		}

		print OUTFILE "\n";

		for ($x=1; $x<2; $x++) {

			$row++;
			#print OUTFILE "<$row>|";

			$c=1;
			foreach $val (@val_array)
			{
					$val=~ s/\-//g;
					$val=~ s/NULL/0/g;
					$val=~ s/,/ /g;

				if($c == 2) {
					$customer_id_array{$val}++;
					
					if($x < 10) { $multiplier=1000000000; }
					elsif($x < 100) { $multiplier=100000000; }
					elsif($x < 1000){ $multiplier=10000000; }
					$new_cust_id = $val + ($x * $multiplier);
					$new_val2 = $new_cust_id + $x;
					#print OUTFILE "*",$new_val2,"|";
				} 
				if($c >=2 && $c <=6) {
					$new_val = $new_val2;
					
					$random_num = int(rand(4))+1;
					if ($random_num == 1) {
						$new_val =~ s/0/M/g;
					} elsif ($random_num == 2) {
						$new_val =~ s/0/P/g;
					} elsif ($random_num == 3) {
						$new_val =~ s/0/V/g;
					} elsif ($random_num == 4) {
						$new_val =~ s/0/R/g;
					} elsif ($random_num == 5) {
						$new_val =~ s/0/T/g;
					} 
					$new_val =~ s/1/C/g;
					$new_val =~ s/2/0/g;
					$new_val =~ s/3/D/g;
					$new_val =~ s/4/K/g;
					$new_val =~ s/5/F/g;
					$new_val =~ s/6/4/g;
					$new_val =~ s/7/G/g;
					$new_val =~ s/8/1/g;
					$new_val =~ s/9/H/g;
					print OUTFILE "$new_val,";
				} else {
					print OUTFILE "$val,";
				}
				$c++;
			}
			print OUTFILE "\n";
		}
	}
	
}

close (FILE);
close (OUTFILE);
close(SCHEMA);
print STDOUT "$row records written\n"; $row=0;

open(INFILE, "OUTFILE_WITH_GENERATED_WIRES_v7.csv");
open(OUTFILE, ">GENERATED_WIRES_v7.csv");

while(<INFILE>)
{
		chop;chop;
		print OUTFILE "$_\n";
		$row++;
}
close(INFILE);
close(OUTFILE);
print STDOUT "$row records written\n"; $row=0;
