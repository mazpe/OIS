package OIS::Schema::Result::TaxCode;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn", "Core");
__PACKAGE__->table("tax_code");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 128,
  },
  "percent",
  {
    data_type => "DECIMAL",
    default_value => undef,
    is_nullable => 0,
    size => 10,
  },
  "active",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "created",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 0,
    size => 19,
  },
  "updated",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 0,
    size => 19,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->has_many(
  "estimates",
  "OIS::Schema::Result::Estimate",
  { "foreign.tax_code_id" => "self.id" },
);
__PACKAGE__->has_many(
  "names",
  "OIS::Schema::Result::Name",
  { "foreign.tax_code_id" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2011-04-21 09:35:38
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XxPTw1mdhtHVmk/4C4z3YA

__PACKAGE__->add_columns(
    "created",
    { data_type => 'timestamp', set_on_create => 1 },
    "updated",
    { data_type => 'timestamp', set_on_create => 1, set_on_update => 1 },
);

# You can replace this text with custom content, and it will be preserved on regeneration
1;
