class ERP::Import < ActiveRecord::Base
  IMPORT_MAP = {
    'clients' => ERP::Client,
    'managers' => ERP::Manager,
    'products' => ERP::Product
  }
  set_table_name 'erp.imports'

  def self.from_directory path
    previous_imports = ERP::Import.count
    last_import = ERP::Import.order(:created_at).last
    Dir["#{path}/*.csv"].each do |f|
      file_name = f.split('/').pop
      name = file_name.split('.')
      ext = name.pop.downcase
      if ext == 'csv'
        import_class = IMPORT_MAP[name.join('.').downcase]
        if import_class and (previous_imports == 0 or File.new(f).mtime > last_import.created_at)
          id = create!.id
          import_class.load_from_file(f, id)
          import_class.import(id)
        end
      end
    end
  end
end
