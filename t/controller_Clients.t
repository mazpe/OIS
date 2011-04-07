use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'OIS' }
BEGIN { use_ok 'OIS::Controller::Clients' }

ok( request('/clients')->is_success, 'Request should succeed' );
done_testing();
