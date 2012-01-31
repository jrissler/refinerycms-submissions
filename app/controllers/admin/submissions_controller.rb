module Admin
  class SubmissionsController < Admin::BaseController

    crudify :submission,
            :title_attribute => 'first_name', :xhr_paging => true

  end
end
