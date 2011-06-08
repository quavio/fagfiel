class ErpProducts < ActiveRecord::Migration
  def self.up
    execute '
    CREATE TABLE erp.products (
      id serial PRIMARY KEY,
      import_id integer NOT NULL REFERENCES erp.imports,
      reference text,
      brand text,
      "group" text
    );
    '
  end

  def self.down
    execute "
    DROP TABLE erp.products;
    "
  end
end
