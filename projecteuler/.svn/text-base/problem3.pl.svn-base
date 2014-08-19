#!/usr/bin/perl
# The prime factors of 13195 are 5, 7, 13 and 29.
# What is the largest prime factor of the number 600851475143 ?

use strict;
use constant NUM => 600851475143;
 
my $lpf = 2;
my @pfs = ();
my $first = 0;
 
for (my $n = NUM; $n > 1; $lpf++) {
    if (!($n % $lpf)) {
        $n /= $lpf;
        if (!$first) {
            push @pfs, $lpf;
            $first++;
            next;
        }
 
        get_it($lpf);
    }
}
 
$lpf--;
print "The largest prime factory of ". NUM ." is $pfs[$#pfs]\n";
 
sub get_it()
{
    foreach my $p (@pfs) {
        return if !($_[0] % $p);
    }
    push @pfs, $_[0];
}
