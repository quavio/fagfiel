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

  def self.import import_id
    # First we update existing managers
    # the order matters so we wont update managers inserted in the same import
    connection.execute "
      UPDATE public.users SET
        email = trim(managers.email), 
        name = trim(managers.name),
        updated_at = current_timestamp
      FROM erp.managers 
      WHERE
        users.erp_id = managers.erp_id 
        AND managers.import_id = '#{import_id.to_i}'
    "
    # then we insert new managers
    connection.execute "
      INSERT INTO public.users (email, name, erp_id, created_at, role) 
        SELECT 
          trim(email), MAX(trim(name)), min(erp_id), current_timestamp, 'm'
        FROM erp.managers 
        WHERE 
          managers.import_id = '#{import_id.to_i}'
          AND NOT EXISTS (SELECT 1 FROM public.users u WHERE u.erp_id = managers.erp_id)
        GROUP BY trim(email)
    "
  end
end
