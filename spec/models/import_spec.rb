require 'spec_helper'

describe ERP::Import do
  before(:each) do
    ERP::Import.connection.execute "TRUNCATE erp.imports CASCADE;"
    ERP::Import::IMPORT_MAP.each do |k,v|
      v.stub(:load_from_file).and_return(nil)
      v.stub(:import).and_return(nil)
    end
  end

  context "when we have no previous import and new files" do
    before(:each) do
      ERP::Import::IMPORT_MAP.each do |k,v|
        v.should_receive(:load_from_file)
        v.should_receive(:import)
      end
    end
    it "should call import methods" do
      ERP::Import.from_directory "#{Rails.root}/spec/fixtures"
    end
  end

  context "when the import dir is empty" do
    before(:each) do
      ERP::Import::IMPORT_MAP.each do |k,v|
        v.should_not_receive(:load_from_file)
        v.should_not_receive(:import)
      end
    end
    it "should not call import methods" do
      FileUtils.mkdir_p "#{Rails.root}/spec/fixtures/empty_dir"
      ERP::Import.from_directory "#{Rails.root}/spec/fixtures/empty_dir"
    end
  end

  context "when import files are older than last import" do
    before(:each) do
      ERP::Import::IMPORT_MAP.each do |k,v|
        v.should_not_receive(:load_from_file)
        v.should_not_receive(:import)
      end
    end
    it "should not call import methods" do
      i = ERP::Import.create!
      ERP::Import.from_directory "#{Rails.root}/spec/fixtures"
    end
  end

  context "when import files are newer than last import" do
    before(:each) do
      ERP::Import::IMPORT_MAP.each do |k,v|
        v.should_receive(:load_from_file)
        v.should_receive(:import)
      end
    end
    it "should call import methods" do
      i = ERP::Import.create! 
      i.update_attributes :created_at => Time.now - 100.year
      ERP::Import.from_directory "#{Rails.root}/spec/fixtures"
    end
  end
end
