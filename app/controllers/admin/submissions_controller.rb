class Admin::SubmissionsController < Admin::BaseController

  crudify :submission, :title_attribute => "name", :order => "created_at DESC"
  helper_method :group_by_date

  before_filter :find_all_ham, :only => [:index]
  before_filter :find_all_spam, :only => [:spam]
  before_filter :get_spam_count, :only => [:index, :spam]

  def index
    @submissions = @submissions.with_query(params[:search]) if searching?
    @submissions = @submissions.paginate({:page => params[:page]})
  end

  def spam
    self.index
    render :action => 'index'
  end

  def toggle_spam
    find_submission
    if params[:mark_as] == "ham"
      @submission.mark_as_ham!
    else
      @submission.mark_as_spam!
    end  

    redirect_to :back
  end

protected

  def find_all_ham
    @submissions = Submission.where(:spam => false)
  end

  def find_all_spam
    @submissions = Submission.where(:spam => true)
  end

  def get_spam_count
    @spam_count = Submission.count(:conditions => {:spam => true})
  end

end
