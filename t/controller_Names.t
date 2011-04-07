use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'OIS' }
BEGIN { use_ok 'OIS::Controller::Names' }

ok( request('/names')->is_success, 'Request should succeed' );
done_testing();
