class SubmissionsController < ApplicationController
  before_filter :find_page, :only => [:create, :new]
  
  def thank_you
    @page = Page.find_by_link_url("/contact/thank_you", :include => [:parts, :slugs])
  end

  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(params[:submission])

    if @submission.save
      if @submission.ham?
        begin
          SubmissionMailer.notification(@submission, request).deliver
        rescue
          logger.warn "There was an error delivering an submission notification.\n#{$!}\n"
        end

        begin
          SubmissionMailer.confirmation(@submission, request).deliver
        rescue
          logger.warn "There was an error delivering an submission confirmation:\n#{$!}\n"
        end if Submission.send_confirmation?
      end

      redirect_to thank_you_submissions_url
    else
      render :action => 'new'
    end
  end

protected

  def find_page
    @page = Page.where(:link_url => "/submissions").first
  end

end



