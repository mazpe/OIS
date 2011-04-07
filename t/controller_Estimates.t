use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'OIS' }
BEGIN { use_ok 'OIS::Controller::Estimates' }

ok( request('/estimates')->is_success, 'Request should succeed' );
done_testing();
