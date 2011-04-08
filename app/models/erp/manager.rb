class ERP::Manager < ActiveRecord::Base
  set_table_name 'erp.managers'

  def self.update_managers
    connection.execute "INSERT INTO public.users (email, name) SELECT trim(email), MAX(trim(name)) FROM erp.managers GROUP BY trim(email)"
  end
end
