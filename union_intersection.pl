#!/usr/bin/perl

print "perl union_intersection.pl 1.txt  2.txt.\n";
print "output: union.txt, intersection.txt, subtract_1_2.txt, subtract_2_1.txt\n";
$file1 = $ARGV[0];
$file2 = $ARGV[1];

open(FILE1, "<", $file1) || die "cannot open file1.\n";
open(FILE2, "<", $file2) || die "cannot open file2.\n";

@linelist1 = <FILE1>;
@linelist2 = <FILE2>;

close(FILE1);
close(FILE2);
# use hash to unique the duplicated words.
foreach $eachline1 (@linelist1) {
    $hash1{$eachline1} = $eachline1;
}

foreach $eachline2 (@linelist2) {
    $hash2{$eachline2} = $eachline2;
}

@linelist1 = keys %hash1;
@linelist2 = keys %hash2;
foreach $eachline1 (@linelist1) {
    # in 1 or in 2
    $union_hash{$eachline1} = $eachline1;

    # in 1 and in 2
    if (grep( /^$eachline1$/, @linelist2 ) ) {
      $intersection_hash{$eachline1} = $eachline1;
    }

    # in 1 and not in 2
    if (!grep( /^$eachline1$/, @linelist2 ) ) {
      $subtract_1_2_hash{$eachline1} = $eachline1;
    }
}

foreach $eachline2 (@linelist2) {
    # in 1 or in 2
    $union_hash{$eachline2} = $eachline2;

    # in 2 and not in 1
    if (!grep( /^$eachline2$/, @linelist1 ) ) {
      $subtract_2_1_hash{$eachline2} = $eachline2;
    }
}


open(FILE, ">", "union.txt") || die "cannot open union.\n";
for $word (keys %union_hash) {
  if (length($word) > 2) {
    print FILE $word;
  }
}
close(FILE);

open(FILE, ">", "intersection.txt") || die "cannot open union.\n";
for $word (keys %intersection_hash) {
  if (length($word) > 2) {
    print FILE $word;
  }
}
close(FILE);

open(FILE, ">", "subtract_1_2.txt") || die "cannot open union.\n";
for $word (keys %subtract_1_2_hash) {
  if (length($word) > 2) {
    print FILE $word;
  }
}
close(FILE);

open(FILE, ">", "subtract_2_1.txt") || die "cannot open union.\n";
for $word (keys %subtract_2_1_hash) {
  if (length($word) > 2) {
    print FILE $word;
  }
}
close(FILE);
