use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    VERSION   => '0.01',
    PREREQ_PM => {
        'Mojolicious'                      => '4.41',
        'Moose'                            => '2.1',
        'MooseX::Singleton'                => '0.29',
        'KiokuDB'                          => '0.54',
        'KiokuDB::Backend::CouchDB'        => '0.16',
        'Crypt::SaltedHash'                => '0.09',
        'Mojolicious::Plugin::CSRFProtect' => '0.12',
		'MooseX::Singleton'				   => '0.29',
		'Mojolicious::Plugin::Authentication' => '1.26',
    },
    test => { TESTS => 't/*.t' }
);
