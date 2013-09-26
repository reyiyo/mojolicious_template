#!/usr/bin/perl
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
use lib '../lib';
use KiokuDB;
use KiokuDB::Backend::CouchDB;
use MojoliciousTemplate::Model::User;
use MojoliciousTemplate::Configuration;

my $dir = KiokuDB->connect(MojoliciousTemplate::Configuration->instance->db_uri);
my $homero = MojoliciousTemplate::Model::User->new( username => 'hsimpson', name => "Homer Simpson", password => "duff" );

$homero->add_role('ADMIN');
my $marge = MojoliciousTemplate::Model::User->new( username => 'msimpson', name => "Marge Simpson", password => 'ringo-starr' );
$marge->add_role('ADMIN');

my $scope = $dir->new_scope;

my $homer_id = $dir->store( hsimpson => $homero );

my $marge_id = $dir->store( msimpson => $marge );