require 'spec_helper'

describe ERP::Product do
  before(:each) do
    ERP::Product.connection.execute "TRUNCATE erp.products CASCADE;"
    @import_id = ERP::Import.create.id
  end

  it "should import erp products twice using different import_id" do
    ERP::Product.load_from_file("#{Rails.root}/spec/fixtures/products.csv", ERP::Import.create.id)
    count = ERP::Product.count
    ERP::Product.load_from_file("#{Rails.root}/spec/fixtures/products.csv", ERP::Import.create.id)
    ERP::Product.count.should == (count * 2)
  end

  it "should import products from file with suitable field mappings" do
    ERP::Product.load_from_file("#{Rails.root}/spec/fixtures/products.csv", @import_id)
    at = ERP::Product.first.attributes
    at.delete 'id'
    at.delete 'created_at'
    at.delete 'updated_at'
    at.should == {
      'reference' => '(NUSAR) 540733CA', 
      'brand' => 'FAG',
      'group' => 'ROLAMENTO',
      'import_id' => @import_id
    }
  end
  context "when we have one product in ERP::Product" do
    before(:each) do
      ERP::Product.create!({
        'reference' => 'test reference', 
        'brand' => 'INA',
        'group' => 'ROLAMENTOS', 
        'import_id' => @import_id
      })
    end

    it "should not transfer data from erp.users to public.users when we pass a non-existing import_id" do
      ERP::Manager.import @import_id + 1
      User.all.should be_empty
    end

    it "should transfer data from erp.products to public.products when we pass the right import_id" do
      ERP::Product.import @import_id
      p = Product.first
      p.reference.should == 'test reference'
      p.brand.should == 'INA'
      p.group.should == 'ROLAMENTOS' 
    end

    context "when we update an already imported product" do
      before(:each) do
        ERP::Product.import @import_id
        ERP::Product.first.update_attributes :brand => 'UPD', :group => 'NEW'
      end

      it "should not update product based on a non-existing import_id" do
        ERP::Product.import @import_id + 1
        p = Product.first
        p.brand.should == 'INA'
        p.group.should == 'ROLAMENTOS' 
      end

      it "should update product" do
        ERP::Product.import @import_id
        p = Product.first
        p.brand.should == 'UPD'
        p.group.should == 'NEW' 
      end
    end
  end

end
