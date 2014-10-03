package OIS::Schema::Result::Client;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn", "Core");
__PACKAGE__->table("client");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "referred_by_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
  "type",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 1 },
  "phone",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "fax",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "address_1",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "address_2",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "city",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "state",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "zip_code",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "country",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "www",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "notes",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "found_us",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "status",
  { data_type => "ENUM", default_value => "P", is_nullable => 0, size => 1 },
  "active",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 1 },
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
__PACKAGE__->belongs_to(
  "found_us",
  "OIS::Schema::Result::Advertising",
  { id => "found_us" },
);
__PACKAGE__->belongs_to(
  "referred_by_id",
  "OIS::Schema::Result::Client",
  { id => "referred_by_id" },
);
__PACKAGE__->has_many(
  "clients",
  "OIS::Schema::Result::Client",
  { "foreign.referred_by_id" => "self.id" },
);
__PACKAGE__->belongs_to("state", "OIS::Schema::Result::State", { abbr => "state" });
__PACKAGE__->has_many(
  "client_contacts",
  "OIS::Schema::Result::ClientContact",
  { "foreign.client_id" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2011-04-21 09:35:38
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hkVR9Oj7ZMVfOmXSoGTKGg

__PACKAGE__->add_columns(
    "created",
    { data_type => 'timestamp', set_on_create => 1 },
    "updated",
    { data_type => 'timestamp', set_on_create => 1, set_on_update => 1 },
);

# You can replace this text with custom content, and it will be preserved on regeneration
1;
