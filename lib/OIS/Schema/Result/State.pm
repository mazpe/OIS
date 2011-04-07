package OIS::Schema::Result::State;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn", "Core");
__PACKAGE__->table("state");
__PACKAGE__->add_columns(
  "name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 128,
  },
  "abbr",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 128,
  },
);
__PACKAGE__->set_primary_key("abbr");
__PACKAGE__->has_many(
  "clients",
  "OIS::Schema::Result::Client",
  { "foreign.state" => "self.abbr" },
);
__PACKAGE__->has_many(
  "names",
  "OIS::Schema::Result::Name",
  { "foreign.state" => "self.abbr" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2011-04-02 11:43:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jU9AXe6EdRDN33BojgI0kw

# Set ResultSet Class
__PACKAGE__->resultset_class('OIS::Schema::ResultSet::State');

# You can replace this text with custom content, and it will be preserved on regeneration
1;
