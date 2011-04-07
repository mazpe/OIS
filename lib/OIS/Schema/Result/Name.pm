package OIS::Schema::Result::Name;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn", "Core");
__PACKAGE__->table("name");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "belongs_to_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "referred_by_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "tax_code_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "identity",
  { data_type => "ENUM", default_value => "I", is_nullable => 0, size => 1 },
  "type",
  { data_type => "ENUM", default_value => "L", is_nullable => 0, size => 1 },
  "r_c",
  { data_type => "ENUM", default_value => "R", is_nullable => 0, size => 1 },
  "company_name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "first_name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 128,
  },
  "middle_name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 128,
  },
  "last_name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 128,
  },
  "email",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 128,
  },
  "phone",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "phone_2",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 32,
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
__PACKAGE__->has_many(
  "estimate_name_ids",
  "OIS::Schema::Result::Estimate",
  { "foreign.name_id" => "self.id" },
);
__PACKAGE__->has_many(
  "estimate_ship_to_ids",
  "OIS::Schema::Result::Estimate",
  { "foreign.ship_to_id" => "self.id" },
);
__PACKAGE__->has_many(
  "estimate_salesperson_id_1s",
  "OIS::Schema::Result::Estimate",
  { "foreign.salesperson_id_1" => "self.id" },
);
__PACKAGE__->has_many(
  "estimate_salesperson_id_2s",
  "OIS::Schema::Result::Estimate",
  { "foreign.salesperson_id_2" => "self.id" },
);
__PACKAGE__->belongs_to(
  "found_us",
  "OIS::Schema::Result::Advertising",
  { id => "found_us" },
);
__PACKAGE__->belongs_to(
  "tax_code_id",
  "OIS::Schema::Result::TaxCode",
  { id => "tax_code_id" },
);
__PACKAGE__->belongs_to(
  "belongs_to_id",
  "OIS::Schema::Result::Name",
  { id => "belongs_to_id" },
);
__PACKAGE__->has_many(
  "name_belongs_to_ids",
  "OIS::Schema::Result::Name",
  { "foreign.belongs_to_id" => "self.id" },
);
__PACKAGE__->belongs_to(
  "referred_by_id",
  "OIS::Schema::Result::Name",
  { id => "referred_by_id" },
);
__PACKAGE__->has_many(
  "name_referred_by_ids",
  "OIS::Schema::Result::Name",
  { "foreign.referred_by_id" => "self.id" },
);
__PACKAGE__->belongs_to("state", "OIS::Schema::Result::State", { abbr => "state" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2011-04-02 11:43:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:r+/TJ+9COnChWJMwVjCP+A

__PACKAGE__->add_columns(
    "created",
    { data_type => 'timestamp', set_on_create => 1 },
    "updated",
    { data_type => 'timestamp', set_on_create => 1, set_on_update => 1 },
);


# You can replace this text with custom content, and it will be preserved on regeneration
1;
