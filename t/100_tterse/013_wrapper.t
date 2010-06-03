#!perl -w
use strict;
use Test::More;

use t::lib::TTSimple;

my @data = (
    [<<'T', <<'X'],
[% WRAPPER "wrapping.tt" -%]
Hello, [% lang %] world!
[% END -%]
T
------------------
Hello, Xslate world!
------------------
X

    [<<'T', <<'X'],
[% WRAPPER "hello.tt" -%]
[% END -%]
T
Hello, Xslate world!
X

    [<<'T', <<'X', 'WITH local vars'],
[% WRAPPER "hello.tt" WITH lang = "Perl" -%]
[% END -%]
T
Hello, Perl world!
X

);

foreach my $pair(@data) {
    my($in, $out, $msg) = @$pair;

    my %vars = (lang => 'Xslate', foo => "<bar>", '$lang' => 'XXX');

    is render_str($in, \%vars), $out, $msg
        or diag $in;
}

done_testing;
