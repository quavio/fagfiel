class ERP::Product < ActiveRecord::Base
  set_table_name 'erp.products'
  def self.load_from_file path, import_id
    ERP::Product.pg_copy_from(File.open(path, 'r'), {
      :delimiter => ';', 
      :columns => [
        'reference',
        'brand',
        'group',
        'import_id']
    }) do |row|
      row[0] = row[0].strip
      row[1] = row[1].strip 
      row[2] = row[2].strip
      row[3] = import_id
    end
  end

  def self.import import_id
    # First we update existing products
    # the order matters so we wont update products inserted in the same import
    connection.execute <<SQL
      UPDATE public.products SET
        brand = trim(erp.products.brand), 
        "group" = trim(erp.products."group"),
        updated_at = current_timestamp
      FROM erp.products 
      WHERE
        trim(erp.products.reference) = trim(public.products.reference)
        AND erp.products.import_id = '#{import_id.to_i}'
SQL
    # then we insert new products
    connection.execute <<SQL
      INSERT INTO public.products (code, reference, brand, "group") 
        SELECT 
          id, trim(reference), trim(brand), trim("group")
        FROM erp.products
        WHERE 
          erp.products.import_id = '#{import_id.to_i}'
SQL
  end
end

