#!/bin/false
#-------------------------------------------------------------------------------
#
#
#
#<<< ---------------------------------------------------------------------------
use strict;
use warnings;
use version; our $VERSION = version->declare("00.01.00"); ## no critic (RequireConstantVersion)
use English qw(-no_match_vars);
#>>> ---------------------------------------------------------------------------
package Mojolicious::Plugin::CouchdbAuth;
use Mojo::Base 'Mojolicious::Plugin';
use Moose;
use KiokuDB;
use KiokuDB::Backend::CouchDB;

sub register {
    my ( $self, $app, $conf ) = @_;

    $app->helper( auth => \&Mojolicious::Plugin::CouchdbAuth::_auth );

    $app->helper( is_admin => \&Mojolicious::Plugin::CouchdbAuth::_is_admin );

    $app->helper(
        clean_auth => sub {
            my ($self) = @_;
            $self->session( user => '' );
            return 1;
        }
    );
}

sub _set_last_login {
    my ( $dir, $user ) = @_;
    $user->last_login(time);
    $dir->update($user);
}

sub _auth {
    my ($self) = @_;
    return 1 if $self->session->{user};
    if ( $self->param('username') ) {
        my $dir   = KiokuDB->connect( MojoliciousTemplate::Configuration->instance->db_uri );
        my $scope = $dir->new_scope;
        my $user  = $dir->lookup( $self->param('username') );

        if ( defined($user) && $user->has_same_password( $self->param('password') ) ) {
            $self->param( 'password' => '' );
            _set_last_login( $dir, $user );
            $self->session->{user} = $user;
            push @{ $self->session->{success_messages} }, 'Congratulations, you have successfully logged in';
            return 1;
        }

        push @{ $self->session->{error_messages} }, "Invalid username or password";
        return;
    }
}

sub _is_admin {
    my ($self) = @_;

    my $dir   = KiokuDB->connect( MojoliciousTemplate::Configuration->instance->db_uri );
    my $scope = $dir->new_scope;
    my $user  = $dir->lookup( $self->param('username') );

    return $user->has_role('ADMIN');
}

__PACKAGE__->meta->make_immutable;
1;
__END__
