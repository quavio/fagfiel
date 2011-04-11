class ERP::Manager < ActiveRecord::Base
  set_table_name 'erp.managers'
  def self.load_from_file path
    map = {
      'codigo' => 'erp_id',
      'cnpj' => 'client_cnpj',
      'email' => 'email',
      'nome' => 'name'
    }
    ERP::Manager.pg_copy_from(File.open(path, 'r'), {
      :delimiter => ';', 
      :map => map
    })
  end

  def self.update_managers
    connection.execute "INSERT INTO public.users (email, name) SELECT trim(email), MAX(trim(name)) FROM erp.managers GROUP BY trim(email)"
  end
end
