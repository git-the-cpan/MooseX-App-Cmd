package MooseX::App::Cmd; # git description: v0.30-12-g41636f4

our $VERSION = '0.31';

use Moose;
use English '-no_match_vars';
use File::Basename ();

use namespace::autoclean;
extends 'Moose::Object', 'App::Cmd';

sub BUILDARGS {
    my ( undef, @arg ) = @_;
    return {} if !@arg;
    return { arg => $arg[0] } if 1 == @arg;
    return {@arg};
}

sub BUILD {
    my $self  = shift;
    my $class = blessed $self;
    $self->{arg0}      = File::Basename::basename($PROGRAM_NAME);
    $self->{command}   = $class->_command( {} );
    $self->{full_arg0} = $PROGRAM_NAME;
    return;
}

## no critic (Modules::RequireExplicitInclusion)
__PACKAGE__->meta->make_immutable();
1;

# ABSTRACT: Mashes up MooseX::Getopt and App::Cmd

__END__

=pod

=encoding UTF-8

=head1 NAME

MooseX::App::Cmd - Mashes up MooseX::Getopt and App::Cmd

=head1 VERSION

version 0.31

=head1 SYNOPSIS

    package YourApp::Cmd;
    use Moose;

    extends qw(MooseX::App::Cmd);


    package YourApp::Cmd::Command::blort;
    use Moose;

    extends qw(MooseX::App::Cmd::Command);

    has blortex => (
        traits => [qw(Getopt)],
        isa => 'Bool',
        is  => 'rw',
        cmd_aliases   => 'X',
        documentation => 'use the blortext algorithm',
    );

    has recheck => (
        traits => [qw(Getopt)],
        isa => 'Bool',
        is  => 'rw',
        cmd_aliases => 'r',
        documentation => 'recheck all results',
    );

    sub execute {
        my ( $self, $opt, $args ) = @_;

        # you may ignore $opt, it's in the attributes anyway

        my $result = $self->blortex ? blortex() : blort();

        recheck($result) if $self->recheck;

        print $result;
    }

=head1 DESCRIPTION

This module marries L<App::Cmd|App::Cmd> with L<MooseX::Getopt|MooseX::Getopt>.

Use it like L<App::Cmd|App::Cmd> advises (especially see
L<App::Cmd::Tutorial|App::Cmd::Tutorial>), swapping
L<App::Cmd::Command|App::Cmd::Command> for
L<MooseX::App::Cmd::Command|MooseX::App::Cmd::Command>.

Then you can write your moose commands as Moose classes, with
L<MooseX::Getopt|MooseX::Getopt>
defining the options for you instead of C<opt_spec> returning a
L<Getopt::Long::Descriptive|Getopt::Long::Descriptive> spec.

=head1 METHODS

=head2 BUILD

After calling C<new> this method is automatically run, setting underlying
L<App::Cmd|App::Cmd> attributes as per its documentation.

=head1 SEE ALSO

=over

=item L<App::Cmd|App::Cmd>

=item L<App::Cmd::Tutorial|App::Cmd::Tutorial>

=item L<MooseX::Getopt|MooseX::Getopt>

=item L<MooseX::App::Cmd::Command|MooseX::App::Cmd::Command>

=back

=head1 AUTHOR

יובל קוג'מן (Yuval Kogman) <nothingmuch@woobling.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Infinity Interactive, Inc..

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 CONTRIBUTORS

=for stopwords Mark Gardner Karen Etheridge Graham Knop Daisuke Maki Offer Kaye brunov vovkasm Ken Crowell Michael Joyce Dann Guillermo Roditi

=over 4

=item *

Mark Gardner <mjgardner@cpan.org>

=item *

Karen Etheridge <ether@cpan.org>

=item *

Graham Knop <haarg@haarg.org>

=item *

Daisuke Maki <dmaki@cpan.org>

=item *

Offer Kaye <offer.kaye@gmail.com>

=item *

brunov <vecchi.b@gmail.com>

=item *

vovkasm <vovkasm@gmail.com>

=item *

Ken Crowell <oeuftete@gmail.com>

=item *

Michael Joyce <ubermichael@gmail.com>

=item *

Dann <techmemo@gmail.com>

=item *

Guillermo Roditi <groditi@gmail.com>

=back

=cut
