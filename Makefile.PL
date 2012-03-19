
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Mashes up MooseX::Getopt and App::Cmd",
  "AUTHOR" => "Yuval Kogman <nothingmuch\@woobling.org>, Guillermo Roditi <groditi\@cpan.org>, Daisuke Maki <dmaki\@cpan.org>, Vladimir Timofeev <vovkasm\@gmail.com>, Bruno Vecchi <brunov\@cpan.org>, Offer Kaye <offerk\@cpan.org>, Mark Gardner <mjgardner\@cpan.org>, Yanick Champoux <yanick+cpan\@babyl.dyndns.org>",
  "BUILD_REQUIRES" => {
    "Carp" => 0,
    "Data::Dumper" => 0,
    "ExtUtils::MakeMaker" => 0,
    "File::Find" => 0,
    "File::Temp" => 0,
    "MooseX::ConfigFromFile" => 0,
    "Scalar::Util" => 0,
    "Test::More" => "0.94",
    "Test::Output" => 0,
    "Test::Requires" => 0,
    "YAML" => 0,
    "base" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "MooseX-App-Cmd",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "MooseX::App::Cmd",
  "PREREQ_PM" => {
    "App::Cmd" => "0.3",
    "App::Cmd::Command" => 0,
    "English" => 0,
    "File::Basename" => 0,
    "Getopt::Long::Descriptive" => "0.091",
    "Moose" => "0.86",
    "Moose::Object" => 0,
    "MooseX::Getopt" => "0.18",
    "MooseX::Has::Options" => 0,
    "MooseX::MarkAsMethods" => 0,
    "Test::use::ok" => 0
  },
  "VERSION" => "0.09",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



