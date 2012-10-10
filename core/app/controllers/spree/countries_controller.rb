module Spree
  class CountriesController < BaseController
    ssl_allowed :index

    respond_to :js

    def index
      @states_required = Spree::Country.states_required_by_country_id
      respond_with @states_required.to_json, :layout => nil
    end
  end
end

