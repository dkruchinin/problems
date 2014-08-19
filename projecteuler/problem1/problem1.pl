#!/usr/bin/perl
# problem 1
# If we list all the natural numbers below 10 that are 
# multiples of 3 or 5, we get 3, 5, 6 and 9. 
# The sum of these multiples is 23. 
# Find the sum of all the multiples of 3 or 5 below 1000.

use strict;

# Let T = { 3, 5, -15 } and s = 0
# then
# while ti in T:
# tmp=abs(int(999/ti))
# s += ((tmp + (tmp + 1))/2)*ti

my ($sum, $lim) = (0, 999);
my @muls = (3, 5, -15);

foreach my $m (@muls) {
    my $tmp = abs(int($lim / $m));
    $sum += (($tmp * ($tmp + 1)) / 2) * $m;
}

print "The answer is $sum\n";
