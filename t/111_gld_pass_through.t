#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 5;

use Test::Requires {
    'Getopt::Long::Descriptive' => 0.01, # skip all if not installed
};

use_ok('MouseX::Getopt::GLD');

{
    package Engine::Foo;
    use Mouse;

    with 'MouseX::Getopt::GLD';
    sub getopt_conf { [ 'pass_through' ] }

    has 'foo' => (
        metaclass   => 'Getopt',
        is          => 'ro',
        isa         => 'Int',
    );
}

{
    package Engine::Bar;
    use Mouse;

    with 'MouseX::Getopt::GLD';
    sub getopt_conf { [ 'pass_through' ] }

    has 'bar' => (
        metaclass   => 'Getopt',
        is          => 'ro',
        isa         => 'Int',
    );
}

local @ARGV = ('--foo=10', '--bar=42');

{
    my $foo = Engine::Foo->new_with_options();
    isa_ok($foo, 'Engine::Foo');
    is($foo->foo, 10, '... got the right value (10)');
}

{
    my $bar = Engine::Bar->new_with_options();
    isa_ok($bar, 'Engine::Bar');
    is($bar->bar, 42, '... got the right value (42)');
}



