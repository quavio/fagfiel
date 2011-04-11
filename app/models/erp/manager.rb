class ERP::Manager < ActiveRecord::Base
  set_table_name 'erp.managers'
  def self.load_from_file path, import_id
    ERP::Manager.pg_copy_from(File.open(path, 'r'), {
      :delimiter => ';', 
      :columns => [
        'erp_id',
        'client_cnpj',
        'email',
        'name',
        'import_id']
    }) do |row|
      row[4] = import_id
    end
  end

  def self.update_managers import_id
    connection.execute "INSERT INTO public.users (email, name) SELECT trim(email), MAX(trim(name)) FROM erp.managers GROUP BY trim(email)"
  end
end
