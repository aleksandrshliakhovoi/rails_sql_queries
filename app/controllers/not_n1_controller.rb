class NotN1Controller < ApplicationController
  def index
    @not_n1 = Branch.all.includes(:feedbacks).map {|br| br.feedbacks }
  end
end
