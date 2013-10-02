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
package MojoliciousTemplate::Login;
use Mojo::Base 'Mojolicious::Controller';
use utf8;

sub check {
    my $self = shift;

    return 1 if $self->is_user_authenticated;
    $self->render( template => 'login/login_form' ) and return 0;
}

sub login {
    my $self = shift;
    $self->authenticate( $self->req->param('username'), $self->req->param('password') );
    $self->redirect_to('/');
}

sub good_bye {
    my $self = shift;
    $self->logout;
    $self->redirect_to('/');
}

1;
