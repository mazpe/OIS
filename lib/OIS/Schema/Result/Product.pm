package OIS::Schema::Result::Product;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn", "Core");
__PACKAGE__->table("product");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "category_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "vendor_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "sku",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 24,
  },
  "name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 128,
  },
  "description",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "manufacture",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 10,
  },
  "cost",
  {
    data_type => "DECIMAL",
    default_value => undef,
    is_nullable => 1,
    size => 12,
  },
  "list",
  {
    data_type => "DECIMAL",
    default_value => undef,
    is_nullable => 1,
    size => 12,
  },
  "taxable",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "notes",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
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
  "estimate_products",
  "OIS::Schema::Result::EstimateProduct",
  { "foreign.product_id" => "self.id" },
);
__PACKAGE__->belongs_to(
  "category_id",
  "OIS::Schema::Result::Category",
  { id => "category_id" },
);
__PACKAGE__->belongs_to(
  "vendor_id",
  "OIS::Schema::Result::Vendor",
  { id => "vendor_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2011-04-02 11:43:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jfUt+qsfOI60fvrIbfsP8Q

__PACKAGE__->add_columns(
    "created",
    { data_type => 'timestamp', set_on_create => 1 },
    "updated",
    { data_type => 'timestamp', set_on_create => 1, set_on_update => 1 },
);

# You can replace this text with custom content, and it will be preserved on regeneration
1;
