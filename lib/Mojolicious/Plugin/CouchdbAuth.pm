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
use KiokuDB;
use KiokuDB::Backend::CouchDB;

sub load_user {
    my ( $app, $uid, $dir ) = @_;

    my $scope;
    if ( !defined($dir) ) {
        $dir = KiokuDB->connect( MojoliciousTemplate::Configuration->instance->db_uri );
        $scope = $dir->new_scope;
    }
    return $dir->lookup($uid);

}

sub validate_user {
    my ( $app, $username, $password, $extradata ) = @_;
    my $dir = KiokuDB->connect( MojoliciousTemplate::Configuration->instance->db_uri );
    my $scope = $dir->new_scope;
    my $user = load_user( $app, $username, $dir );
    if ( defined($user) && $user->has_same_password($password) ) {
        $user->last_login(time);
        $dir->update($user);
        push @{ $app->session->{success_messages} }, 'Congratulations, you have successfully logged in';
        return $user->username;
    }
    push @{ $app->session->{error_messages} }, "Invalid username or password";
    return undef;

}

sub _is_admin {
    my ($self) = @_;

    my $dir   = KiokuDB->connect( MojoliciousTemplate::Configuration->instance->db_uri );
    my $scope = $dir->new_scope;
    my $user  = $dir->lookup( $self->param('username') );

    return $user->has_role('ADMIN');
}

1;
__END__
