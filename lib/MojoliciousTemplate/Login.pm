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

sub login {
    my $self = shift;

    if ( $self->auth() ) {
        $self->redirect_to('welcome');
    } else {
        $self->render(template => 'login/login');
    }
}

sub logout {
    my $self = shift;
    $self->session( expires => 1 );
    $self->redirect_to('/');
}

1;
