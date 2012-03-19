use 5.006;

package MooseX::App::Cmd::Command;
use Moose;

our $VERSION = '0.09';    # VERSION
use Getopt::Long::Descriptive ();
use MooseX::Has::Options;
use MooseX::MarkAsMethods autoclean => 1;
extends qw(Moose::Object App::Cmd::Command);
with 'MooseX::Getopt';

has usage => (
    qw(:ro :required),
    metaclass => 'NoGetopt',
    isa       => 'Object',
);

has app => (
    qw(:ro :required),
    metaclass => 'NoGetopt',
    isa       => 'MooseX::App::Cmd',
);

override _process_args => sub {
    my ( $class, $args ) = @_;
    local @ARGV = @{$args};

    my $config_from_file;
    if ( $class->meta->does_role('MooseX::ConfigFromFile') ) {
        local @ARGV = @ARGV;

        my $configfile;
        my $opt_parser;
        {
            ## no critic (Modules::RequireExplicitInclusion)
            $opt_parser
                = Getopt::Long::Parser->new( config => ['pass_through'] );
        }
        $opt_parser->getoptions( 'configfile=s' => \$configfile );
        if ( !defined $configfile ) {
            my $cfmeta = $class->meta->find_attribute_by_name('configfile');
            if ( $cfmeta->has_default ) {
                my $default = $cfmeta->default;
                $configfile
                    = ref $default eq 'CODE' ? $default->() : $default;
            }
        }

        if ( defined $configfile ) {
            $config_from_file = $class->get_config_from_file($configfile);
        }
    }

    my %processed = $class->_parse_argv(
        params => { argv => \@ARGV },
        options => [ $class->_attrs_to_options($config_from_file) ],
    );

    return (
        $processed{params},
        $processed{argv},
        usage => $processed{usage},

        # params from CLI are also fields in MooseX::Getopt
        $config_from_file
        ? ( %{$config_from_file}, %{ $processed{params} } )
        : %{ $processed{params} },
    );
};

sub _usage_format {    ## no critic (ProhibitUnusedPrivateSubroutines)
    return shift->usage_desc;
}

## no critic (Modules::RequireExplicitInclusion)
__PACKAGE__->meta->make_immutable();
no Moose;
1;

# ABSTRACT: Base class for MooseX::Getopt based App::Cmd::Commands

__END__

=pod

=for :stopwords Yuval Kogman Guillermo Roditi Daisuke Maki Vladimir Timofeev Bruno Vecchi
Offer Kaye Mark Gardner Yanick Champoux Infinity Interactive, cpan
testmatrix url annocpan anno bugtracker rt cpants kwalitee diff irc mailto
metadata placeholders metacpan

=head1 NAME

MooseX::App::Cmd::Command - Base class for MooseX::Getopt based App::Cmd::Commands

=head1 VERSION

version 0.09

=head1 SYNOPSIS

    use Moose;

    extends qw(MooseX::App::Cmd::Command);

    # no need to set opt_spec
    # see MooseX::Getopt for documentation on how to specify options
    has option_field => (
        isa => 'Str',
        is  => 'rw',
        required => 1,
    );

    sub execute {
        my ( $self, $opts, $args ) = @_;

        print $self->option_field; # also available in $opts->{option_field}
    }

=head1 DESCRIPTION

This is a replacement base class for L<App::Cmd::Command|App::Cmd::Command>
classes that includes
L<MooseX::Getopt|MooseX::Getopt> and the glue to combine the two.

=head1 METHODS

=head2 _process_args

Replaces L<App::Cmd::Command|App::Cmd::Command>'s argument processing in favor
of L<MooseX::Getopt|MooseX::Getopt> based processing.

=head1 SUPPORT

=head2 Perldoc

You can find documentation for this module with the perldoc command.

  perldoc MooseX::App::Cmd

=head2 Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

=over 4

=item *

Search CPAN

The default CPAN search engine, useful to view POD in HTML format.

L<http://search.cpan.org/dist/MooseX-App-Cmd>

=item *

AnnoCPAN

The AnnoCPAN is a website that allows community annotations of Perl module documentation.

L<http://annocpan.org/dist/MooseX-App-Cmd>

=item *

CPAN Ratings

The CPAN Ratings is a website that allows community ratings and reviews of Perl modules.

L<http://cpanratings.perl.org/d/MooseX-App-Cmd>

=item *

CPANTS

The CPANTS is a website that analyzes the Kwalitee ( code metrics ) of a distribution.

L<http://cpants.perl.org/dist/overview/MooseX-App-Cmd>

=item *

CPAN Testers

The CPAN Testers is a network of smokers who run automated tests on uploaded CPAN distributions.

L<http://www.cpantesters.org/distro/M/MooseX-App-Cmd>

=item *

CPAN Testers Matrix

The CPAN Testers Matrix is a website that provides a visual overview of the test results for a distribution on various Perls/platforms.

L<http://matrix.cpantesters.org/?dist=MooseX-App-Cmd>

=item *

CPAN Testers Dependencies

The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

L<http://deps.cpantesters.org/?module=MooseX::App::Cmd>

=back

=head2 Bugs / Feature Requests

Please report any bugs or feature requests through the web
interface at L<https://github.com/mjgardner/moosex-app-cmd/issues>. You will be automatically notified of any
progress on the request by the system.

=head2 Source Code

The code is open to the world, and available for you to hack on. Please feel free to browse it and play
with it, or whatever. If you want to contribute patches, please send me a diff or prod me to pull
from your repository :)

L<https://github.com/mjgardner/moosex-app-cmd>

  git clone git://github.com/mjgardner/moosex-app-cmd.git

=head1 AUTHORS

=over 4

=item *

Yuval Kogman <nothingmuch@woobling.org>

=item *

Guillermo Roditi <groditi@cpan.org>

=item *

Daisuke Maki <dmaki@cpan.org>

=item *

Vladimir Timofeev <vovkasm@gmail.com>

=item *

Bruno Vecchi <brunov@cpan.org>

=item *

Offer Kaye <offerk@cpan.org>

=item *

Mark Gardner <mjgardner@cpan.org>

=item *

Yanick Champoux <yanick+cpan@babyl.dyndns.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Infinity Interactive, Yuval Kogman.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
