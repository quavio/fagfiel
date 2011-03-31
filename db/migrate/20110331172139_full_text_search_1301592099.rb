class FullTextSearch1301592099 < ActiveRecord::Migration
  def self.up
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS products_fts_idx
    eosql
    execute(<<-'eosql'.strip)
      CREATE index products_fts_idx
      ON products
      USING gin((to_tsvector('english', coalesce("products"."reference", '') || ' ' || coalesce("products"."brand", '') || ' ' || coalesce("products"."group", ''))))
    eosql
  end

  def self.down
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS products_fts_idx
    eosql
  end
end
