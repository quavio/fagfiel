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

  def self.import import_id
    # First we update managers from the import
    ERP::Manager.import import_id
    # Then we update existing resellers
    # the order matters so we wont update resellers inserted in the same import
    subquery = "(
      SELECT 
        %{fields}
      FROM erp.clients
      WHERE 
        clients.import_id = '#{import_id.to_i}'
        AND clients.erp_id = users.erp_id
    )"
    connection.execute "
      UPDATE public.users SET
        email = #{subquery % {:fields => 'trim(clients.mail)'}},
        updated_at = current_timestamp
      WHERE
          EXISTS (
            SELECT 1 
            FROM erp.clients
            WHERE 
              users.erp_id = clients.erp_id 
              AND clients.import_id = '#{import_id.to_i}'
          )
    "
    connection.execute "
      UPDATE public.resellers SET
        name = #{subquery % {:fields => 'trim(clients.name)'}}, 
        phone = #{subquery % {:fields => 'trim(clients.phone)'}}, 
        credits = #{subquery % {:fields => '
          CASE 
            WHEN extract(year from current_timestamp) = extract(year from resellers.updated_at) THEN
              credits + trim(clients.expenditure)::numeric
            ELSE
              trim(clients.expenditure)::numeric
          END'}},
        updated_at = current_timestamp
      FROM public.users
      WHERE
        users.id = resellers.user_id
        AND EXISTS (
            SELECT 1 
            FROM erp.clients
            WHERE 
              users.erp_id = clients.erp_id 
              AND clients.import_id = '#{import_id.to_i}'
          )
    "
    # and finally we insert new ones
    connection.execute "
      INSERT INTO public.users (email, erp_id, created_at) 
        SELECT DISTINCT trim(mail), erp_id, current_timestamp
        FROM erp.clients
        WHERE 
          clients.import_id = '#{import_id.to_i}'
          AND NOT EXISTS (SELECT 1 FROM public.users u WHERE u.erp_id = clients.erp_id)
    "
    connection.execute "
      INSERT INTO public.resellers (user_id, manager_id, name, phone, credits, created_at, updated_at) 
        SELECT DISTINCT 
          u.id as user_id,
          m.id as manager_id,
          trim(c.name), trim(c.phone), trim(c.expenditure)::numeric,
          current_timestamp,
          current_timestamp
        FROM 
          erp.clients c 
          JOIN public.users u ON u.erp_id = c.erp_id
          JOIN public.users m ON m.erp_id = c.manager_id
        WHERE 
          c.import_id = '#{import_id.to_i}'
          AND NOT EXISTS (SELECT 1 FROM public.resellers r WHERE r.user_id = u.id)
    "
  end
end
