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
package MojoliciousTemplate::Model::User;
use Moose;
use Moose::Util::TypeConstraints;
use Crypt::SaltedHash;

enum 'ROLE', [qw(ADMIN USER)];

has username => (
    isa => 'Str',
    is  => 'rw',
);

has password => (
    isa => 'Str',
    is  => 'rw',
);

has name => (
    isa => 'Str',
    is  => 'rw',
);

has roles => (
    traits  => ['Array'],
    isa     => 'ArrayRef[ROLE]',
    is      => 'rw',
    default => sub { [] },
    handles => {
        all_roles    => 'elements',
        add_role     => 'push',
        map_roles    => 'map',
        roles_count  => 'count',
        sorted_roles => 'sort',
        filter_roles => 'grep',
    },
);

has last_login => (
    isa => 'Int',
    is  => 'rw'
);

sub BUILD {
    my $self = shift;
    $self->{password} = $self->get_encrypted_password( $self->password );
}

around 'password' => sub {
    my $orig = shift;
    my $self = shift;

    return $self->$orig()
      unless @_;

    my $pass = shift;
    $pass = $self->get_encrypted_password($pass);

    return $self->$orig($pass);
};

sub get_encrypted_password {
    my ( $self, $pass ) = @_;
    my $csh = Crypt::SaltedHash->new( algorithm => 'SHA-256', salt_len => 5 );
    $csh->add($pass);
    return $csh->generate;
}

sub equals {
    my ( $self, $other_user ) = @_;
    return $self->username eq $other_user->username && $self->password eq $other_user->password;
}

sub has_same_password {
    my ( $self, $password ) = @_;
    return Crypt::SaltedHash->validate( $self->password, $password, 5 ) ? 1 : 0;
}

sub has_role {
    my ( $self, $role ) = @_;
    return $self->filter_roles( sub {/$role/} );
}

__PACKAGE__->meta->make_immutable;
1;
__END__
