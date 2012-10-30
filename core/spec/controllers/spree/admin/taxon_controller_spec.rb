require 'spec_helper'
describe Spree::Admin::TaxonsController do
  stub_authorization!
  
  let(:taxonomy) { create(:taxonomy, :name => "test") }
  let(:taxon) { create(:taxon, :permalink => "test") }
  let(:taxons) { [taxon] }
  
  describe 'after_filter set_flash_message on update' do
    
    before do
      Spree::Taxonomy.stub(:find).with("#{taxonomy.id}").and_return(taxonomy)
      taxonomy.stub(:taxons).and_return(taxons)
      taxons.stub(:find).with("#{taxon.id}").and_return(taxon)
    end

    def send_request(extra_params = {})
      spree_put :update, :id => taxon.id, :taxonomy_id => taxonomy.id, :taxon => {}
    end
    
    subject { flash[:error] }

    context 'taxon is not successfully updated' do
      before do
        taxon.name = ''
      end

      it 'should add flash error' do
        send_request
        should eq "Ruby on Rails taxon cannot be updated because<li>Name can't be blank</li>"
      end
    end

    context 'taxon is successfully updated' do
      it 'should not add any flash error' do
        send_request
        should eq nil
      end
    end
  end
end
  
