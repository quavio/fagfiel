class ERP::Client < ActiveRecord::Base
  set_table_name 'erp.clients'
  def self.load_from_file path, import_id
    map = {
      'codigo_cliente' => 'erp_id',
      'nome_cliente' => 'name',
      'telefone_cliente' => 'phone',
      'mail_cliente' => 'mail',
      'gerente_cliente' => 'manager_id',
      'vendedor_cliente' => 'vendor',
      'faturamento_cliente' => 'expenditure',
      'cnpj_cliente' => 'cnpj'
    }
    ERP::Client.pg_copy_from(File.open(path, 'r'), {
      :delimiter => ';', 
      :columns => [
        'erp_id',
        'name',
        'phone',
        'mail',
        'manager_id',
        'vendor',
        'expenditure',
        'cnpj',
        'import_id']
    }) do |row|
      row[8] = import_id.to_s
    end
  end

  def self.update_resellers import_id
    ERP::Manager.load_from_file("#{Rails.root}/spec/fixtures/users.csv", import_id)
    ERP::Manager.update_managers import_id
    connection.execute "INSERT INTO public.users (email) SELECT DISTINCT trim(mail) FROM erp.clients"
    connection.execute "INSERT INTO public.resellers (user_id, manager_id, name, phone, credits) 
    SELECT DISTINCT 
      (SELECT u.id FROM public.users u WHERE u.email = trim(c.mail)),
      (SELECT u.id FROM public.users u JOIN erp.managers m ON trim(m.email) = u.email WHERE m.erp_id = c.manager_id LIMIT 1),
      trim(name), trim(phone), trim(expenditure)::numeric 
    FROM erp.clients c"
  end
end
