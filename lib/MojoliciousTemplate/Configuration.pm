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
package MojoliciousTemplate::Configuration;
use MooseX::Singleton;

has 'app_secret' => (
    isa     => 'Str',
    is      => 'rw',
    default => 'SuperMojoliciousTemplate_91d6e13f2cc2e7bba92b'
);

has 'db_uri' => (
    isa     => 'Str',
    is      => 'rw',
    default => 'couchdb:uri=http://127.0.0.1:5984/template_test'
);

1;