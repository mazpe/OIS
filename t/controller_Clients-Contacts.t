use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'OIS' }
BEGIN { use_ok 'OIS::Controller::Clients::Contacts' }

ok( request('/clients/contacts')->is_success, 'Request should succeed' );
done_testing();
