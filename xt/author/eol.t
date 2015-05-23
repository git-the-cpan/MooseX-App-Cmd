use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::EOL 0.18

use Test::More 0.88;
use Test::EOL;

my @files = (
    'lib/MooseX/App/Cmd.pm',
    'lib/MooseX/App/Cmd/Command.pm',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t',
    't/basic.t',
    't/build_emulates_new.t',
    't/configfile.t',
    't/lib/Test/ConfigFromFile.pm',
    't/lib/Test/ConfigFromFile/Command/boo.pm',
    't/lib/Test/ConfigFromFile/Command/moo.pm',
    't/lib/Test/ConfigFromFile/config.yaml',
    't/lib/Test/MyAny/Moose.pm',
    't/lib/Test/MyAny/Moose/Command/foo.pm',
    't/lib/Test/MyCmd.pm',
    't/lib/Test/MyCmd/Command/bark.pm',
    't/lib/Test/MyCmd/Command/frobulate.pm',
    't/lib/Test/MyCmd/Command/justusage.pm',
    't/lib/Test/MyCmd/Command/stock.pm',
    't/moose.t',
    't/zzz-check-breaks.t'
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;
