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
package MojoliciousTemplate::Example;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render(
    message => 'Welcome to the Super Mojolicious Template!');
}

1;
