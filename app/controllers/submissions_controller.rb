class SubmissionsController < ApplicationController

  before_filter :find_all_submissions
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @submission in the line below:
    present(@page)
  end

  def show
    @submission = Submission.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @submission in the line below:
    present(@page)
  end

protected

  def find_all_submissions
    @submissions = Submission.order('position ASC')
  end

  def find_page
    @page = Page.where(:link_url => "/submissions").first
  end

end
