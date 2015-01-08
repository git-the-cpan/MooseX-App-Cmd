use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::PodSpelling 2.006008
use Test::Spelling 0.12;
use Pod::Wordlist;


add_stopwords(<DATA>);
all_pod_files_spelling_ok( qw( bin lib  ) );
__DATA__
יובל
קוג
Yuval
Kogman
nothingmuch
Infinity
Interactive
Inc
Mark
Gardner
mjgardner
gardnerm
Karen
Etheridge
ether
Graham
Knop
haarg
Daisuke
Maki
dmaki
Offer
Kaye
offer
vovkasm
Ken
Crowell
oeuftete
brunov
vecchi
mjg
Guillermo
Roditi
groditi
Dann
techmemo
Michael
Joyce
ubermichael
lib
MooseX
App
Cmd
Command
