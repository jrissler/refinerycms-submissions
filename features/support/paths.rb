module NavigationHelpers
  module Refinery
    module Submissions
      def path_to(page_name)
        case page_name
        when /the list of submissions/
          admin_submissions_path

         when /the new submission form/
          new_admin_submission_path
        else
          nil
        end
      end
    end
  end
end
