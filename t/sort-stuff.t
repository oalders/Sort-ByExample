#!perl
use strict;
use warnings;

use Test::More tests => 3;

use Sort::ByExample 'sbe';

{
  my @example = qw(
    foo
    bar
    baz
    quux
    pantalones
  );

  my @input  = qw(foo bar bar x foo quux foo pantalones garbage);

  {
    # We'll sort by example, falling back to sorting by length.
    my @expect = qw(foo foo foo bar bar quux pantalones x garbage);

    my $sorter = sbe(\@example, sub { length $_[0] <=> length $_[1] });
    my @sorted = $sorter->(@input);

    # diag "IN:   @input";
    # diag "OUT:  @sorted";
    # diag "WANT: @expect";
    is_deeply(\@sorted, \@expect, "it sorted as we wanted");
  }

  {
    # We'll sort by example, falling back to sorting by length.
    my @expect = qw(foo foo foo bar bar quux pantalones garbage x);

    my $sorter = sbe(\@example, sub { length $_[1] <=> length $_[0] });
    my @sorted = $sorter->(@input);

    # diag "IN:   @input";
    # diag "OUT:  @sorted";
    # diag "WANT: @expect";
    is_deeply(\@sorted, \@expect, "it sorted as we wanted");
  }
}

{
  # We'll sort by example, falling back to sorting by length.
  my $example = { x => 1, xyzzy => 1, bar => 2 };
  my @input   = qw(x xyzzy crap xyzzy bar bar lemon x x xyzzy);
  my @expect  = qw(x x x xyzzy xyzzy xyzzy bar bar crap lemon);

  my $sorter = sbe($example, sub { length $_[0] <=> length $_[1] });
  my @sorted = $sorter->(@input);

  # diag "IN:   @input";
  # diag "OUT:  @sorted";
  # diag "WANT: @expect";
  is_deeply(\@sorted, \@expect, "it sorted as we wanted");
}
