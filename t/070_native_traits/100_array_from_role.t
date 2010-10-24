#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Fatal;

{
    package Foo;
    use Moose;

    has 'bar' => ( is => 'rw' );

    package Stuffed::Role;
    use Moose::Role;

    has 'options' => (
        traits => ['Array'],
        is     => 'ro',
        isa    => 'ArrayRef[Foo]',
    );

    package Bulkie::Role;
    use Moose::Role;

    has 'stuff' => (
        traits  => ['Array'],
        is      => 'ro',
        isa     => 'ArrayRef',
        handles => {
            get_stuff => 'get',
        }
    );

    package Stuff;
    use Moose;

    ::ok ! ::exception { with 'Stuffed::Role';
        }, '... this should work correctly';

    ::ok ! ::exception { with 'Bulkie::Role';
        }, '... this should work correctly';
}

done_testing;
