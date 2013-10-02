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
use Mojolicious::Plugin::Authentication;
use Mojolicious::Plugin::CouchdbAuth;

# This method will run once at server start
sub startup {
    my $self = shift;

    $self->secret( MojoliciousTemplate::Configuration->instance->app_secret );
    $self->session( expiration => 3600 );

    $self->plugin('CSRFProtect');

    $self->plugin(
        'authentication' => {
            'autoload_user' => 1,
            'session_key'   => MojoliciousTemplate::Configuration->instance->app_secret,
            'load_user'     => \&Mojolicious::Plugin::CouchdbAuth::load_user,
            'validate_user' => \&Mojolicious::Plugin::CouchdbAuth::validate_user,
        }
    );

    $self->routes->post('/login')->to('login#login');

    my $logged_in = $self->routes->bridge('/')->to('login#check');
    $logged_in->any('/')->to('example#welcome');
    $logged_in->route('/welcome')->to('example#welcome');
    $logged_in->route('/logout')->to('login#good_bye');
}

1;
