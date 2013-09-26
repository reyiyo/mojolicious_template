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
package MojoliciousTemplate;
use Mojo::Base 'Mojolicious';
use MojoliciousTemplate::Configuration;

# This method will run once at server start
sub startup {
    my $self = shift;

    $self->secret( MojoliciousTemplate::Configuration->instance->app_secret );
    $self->session( expiration => 3600 );

    $self->plugin('CSRFProtect');

    $self->plugin('Mojolicious::Plugin::CouchdbAuth');
    $self->static->paths->[0] = $self->home->rel_dir('public');

    # Routes
    my $r = $self->routes;

    # Normal route to controller
    $r->get('/')->to('login#login');
    $r->any('/login')->to('login#login');
    $r->get('/logout')->to('login#logout');

    # Protected route to controller
    my $logged_in = $r->under(
        sub {
            my $self = shift;
            return $self->auth() || !$self->redirect_to('/login#login');
        }
    );

    $logged_in->route('/welcome')->to('example#welcome');
}

1;
